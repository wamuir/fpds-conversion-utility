/*
 * FPDS Archive Conversion Utility
 *
 * Copyright (c) 2018-2020 William Muir
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 */

#include <libxml/xmlreader.h>
#include <libxml/xmlstring.h>
#include <libxslt/transform.h>
#include <libxslt/xsltutils.h>
#include <pthread.h>
#include <sqlite3.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sysexits.h>
#include <unistd.h>
#include <uuid/uuid.h>

#include "create-table.h"
#include "create-view-document-id.h"
#include "create-view-fact.h"
#include "insert-row.h"
#include "normalize-record.h"
#include "progressbar.h"
#include "statusbar.h"
#include "threadpool.h"

threadpool_t *pool;
pthread_mutex_t lock;
int fetched, done;

enum FPDS { COUNT, AWARD, IDV, OTAWARD, OTIDV };

static char *xml_archive, *sqlite3_target;
static sqlite3 *db;
static progressbar *bar;
static xsltStylesheetPtr create_table, insert_row, normalize_record;
static void setup(void);
static void cleanup(void);
static xmlXPathObjectPtr getXPath(xmlDocPtr doc, xmlChar *xpath);
static void buildTable(xmlDocPtr parsedTableXML);
static void insertRecord(xmlDocPtr parsed_table_xml, char *uuid);
static xmlDocPtr normalizeXML(xmlChar *doc);
static void streamFile(const char *filename);
static void writeSQL(xmlDocPtr norm_xml);
static int getType(xmlChar *name);
static int getCount(xmlTextReaderPtr reader);
static void task(void *arg);

static void setup(void) {
  xmlDocPtr create_table_xsl_doc, insert_row_xsl_doc, normalize_record_xsl_doc;
  /* Parse stylesheets and create transformations */
  create_table_xsl_doc =
      xmlReadMemory((const char *)create_table_xsl, create_table_xsl_len,
                    "null.xml", "UTF-8", 0);
  create_table = xsltParseStylesheetDoc(create_table_xsl_doc);

  insert_row_xsl_doc = xmlReadMemory(
      (const char *)insert_row_xsl, insert_row_xsl_len, "null.xml", "UTF-8", 0);
  insert_row = xsltParseStylesheetDoc(insert_row_xsl_doc);

  normalize_record_xsl_doc =
      xmlReadMemory((const char *)normalize_record_xsl,
                    normalize_record_xsl_len, "null.xml", "UTF-8", 0);
  normalize_record = xsltParseStylesheetDoc(normalize_record_xsl_doc);
}

/*
 * Memory management prior to program exit
 */
static void cleanup(void) {
  xsltFreeStylesheet(normalize_record);
  xsltFreeStylesheet(create_table);
  xsltFreeStylesheet(insert_row);
  xsltCleanupGlobals();
  xmlCleanupParser();
}

/*
 * Return xpath object
 * @doc: xml
 * @xpath: xpath syntax
 */
static xmlXPathObjectPtr getXPath(xmlDocPtr doc, xmlChar *xpath) {
  xmlXPathContextPtr context;
  xmlXPathObjectPtr result;

  context = xmlXPathNewContext(doc);
  result = xmlXPathEvalExpression(xpath, context);
  xmlXPathFreeContext(context);

  return result;
}

/*
 * Create a table (if not exists) in the database
 * @parsed_table_xml: xml for the table
 */
static void buildTable(xmlDocPtr parsed_table_xml) {
  char *err_msg;
  int buffersize, rc;
  xmlDocPtr result;
  xmlChar *sql_text;

  /* Use the `create_table' xsl stylesheet to generate an SQL statement */
  result = xsltApplyStylesheet(create_table, parsed_table_xml, NULL);
  xsltSaveResultToString(&sql_text, &buffersize, result, create_table);
  xmlFreeDoc(result);

  /* Execute the statement */
  rc = sqlite3_exec(db, (char *)sql_text, 0, 0, &err_msg);
  if (rc != SQLITE_OK)
    printf("ERROR creating table: %s\n", sqlite3_errmsg(db));

  sqlite3_free(err_msg);
  xmlFree(sql_text);
}

/*
 * Create views in the database
 */
static void createViews() {
  char *err_msg;
  int rc;

  rc = sqlite3_exec(db, (char *)create_view_document_id_sql, 0, 0, &err_msg);
  if (rc != SQLITE_OK)
    printf("ERROR creating document view: %s\n", sqlite3_errmsg(db));

  rc = sqlite3_exec(db, (char *)create_view_fact_sql, 0, 0, &err_msg);
  if (rc != SQLITE_OK)
    printf("ERROR creating fact view: %s\n", sqlite3_errmsg(db));

  sqlite3_free(err_msg);
}

/*
 * Insert a record into the database
 * @parsed_table_xml: xml for the table
 * @uuid: id field for database
 */
static void insertRecord(xmlDocPtr parsed_table_xml, char *uuid) {
  int buffersize, i, rowdata;
  sqlite3_stmt *stmt;
  xmlChar *sql_text;
  xmlDocPtr result;
  xmlNodeSetPtr column_nodeset;
  xmlXPathObjectPtr columns;

  /* Store a prepared statement for inserting the record */
  result = xsltApplyStylesheet(insert_row, parsed_table_xml, NULL);
  xsltSaveResultToString(&sql_text, &buffersize, result, insert_row);
  xmlFreeDoc(result);

  /* Use XPath to find the columns (fields) */
  columns = getXPath(parsed_table_xml, (xmlChar *)"/table/column");
  column_nodeset = columns->nodesetval;

  rowdata = 0; /* A flag since we will not want to commit an all(null) row */

  // Iterate through columns and issue apprporiate bind SQL statements
  for (i = 0; i < column_nodeset->nodeNr; i++) {
    xmlChar *value;

    // Obtain column value from xml
    value = xmlNodeGetContent(column_nodeset->nodeTab[i]);

    // Check if some non-null data exists for the row
    if (rowdata == 0 && xmlStrncmp(value, (xmlChar *)"", 1) != 0) {
      int j;

      // Alter the flag
      rowdata = 1;

      // Issue prepared stmt as some non-null data exists for the row
      sqlite3_prepare_v2(db, (char *)sql_text, -1, &stmt, NULL);

      // First column `id' is the uuid
      sqlite3_bind_text(stmt, 1, uuid, -1, SQLITE_TRANSIENT);

      // Go back and bind previously skipped columns of nulls
      for (j = 0; j < i; j++)
        sqlite3_bind_null(stmt, j + 2);
    }

    /// If rowData flag, bind data to prepared stmt as appropriate
    if (rowdata == 1 && xmlStrncmp(value, (xmlChar *)"", 1) == 0)
      sqlite3_bind_null(stmt, i + 2);
    else if (rowdata == 1 && xmlStrncmp(value, (xmlChar *)"", 1) != 0)
      sqlite3_bind_text(stmt, i + 2, (char *)value, -1, SQLITE_TRANSIENT);

    free(value);
  }

  if (rowdata == 1) {
    int rc;

    rc = sqlite3_step(stmt);
    if (rc != SQLITE_DONE)
      fprintf(stderr, "ERROR inserting data: %s\n", sqlite3_errmsg(db));

    sqlite3_finalize(stmt);
  }

  xmlXPathFreeObject(columns);
  xmlFree(sql_text);
}

/*
 * Return a normalized record
 * @reader: an xmlReader
 */
static xmlDocPtr normalizeXML(xmlChar *doc) {
  xmlDocPtr result, xml;

  xml = xmlParseDoc(doc);
  result = xsltApplyStylesheet(normalize_record, xml, NULL);
  xmlFreeDoc(xml);

  return result;
}

/*
 * Write xml record to database
 * @norm_xml: a normalized xml document
 */
static void writeSQL(xmlDocPtr norm_xml) {
  int i;
  xmlNodeSetPtr table_nodeset;
  xmlXPathObjectPtr tables;
  uuid_t binuuid;
  char *uuid;

  uuid_generate_random(binuuid);
  uuid = malloc(33);
  uuid_unparse(binuuid, uuid);

  tables = getXPath(norm_xml, (xmlChar *)"/tables/table");
  table_nodeset = tables->nodesetval;

  for (i = 0; i < table_nodeset->nodeNr; i++) {
    xmlChar *raw_table_xml;
    xmlBufferPtr buffer;
    xmlDocPtr parsed_table_xml;

    /*
     * For each table, dump XML into a buffer and then parse
     * ? Better way to get from xmlNodePtr --> xmlDocPtr ?
     */
    buffer = xmlBufferCreate();
    xmlNodeDump(buffer, norm_xml, table_nodeset->nodeTab[i], 2, 1);
    raw_table_xml = buffer->content;
    xmlFree(buffer);

    parsed_table_xml = xmlParseDoc(raw_table_xml);
    xmlFree(raw_table_xml);

    /* Create the table in the database */
    if (done < 1) {
      buildTable(parsed_table_xml);
    }

    /* Insert the record into the database */
    insertRecord(parsed_table_xml, uuid);

    xmlFreeDoc(parsed_table_xml);
  }

  free(uuid);
  xmlXPathFreeObject(tables);
}

/*
 * Test if the node is an FPDS record
 * @name: the xml node name
 */
static int getType(xmlChar *name) {

  if (xmlStrncmp(name, (xmlChar *)"ns1:count", 10) == 0) {
    return COUNT;
  }

  if (xmlStrncmp(name, (xmlChar *)"ns1:award", 10) == 0) {
    return AWARD;
  }

  if (xmlStrncmp(name, (xmlChar *)"ns1:IDV", 8) == 0) {
    return IDV;
  }

  if (xmlStrncmp(name, (xmlChar *)"ns1:OtherTransactionAward", 26) == 0) {
    return OTAWARD;
  }

  if (xmlStrncmp(name, (xmlChar *)"ns1:OtherTransactionIDV", 24) == 0) {
    return OTIDV;
  }

  return -1;
}

/*
 * Get the count of fetched documents via XPATH
 * @reader: an xmlReader
 */
static int getCount(xmlTextReaderPtr reader) {
  int ret;
  xmlChar *content, *doc, *xpath;
  xmlDocPtr xml;
  xmlNodeSetPtr column_nodeset;
  xmlXPathObjectPtr columns;

  doc = xmlTextReaderReadOuterXml(reader);
  xml = xmlParseDoc(doc);
  xmlFree(doc);

  xpath = (xmlChar *)"/*[local-name() = 'count']/*[local-name() = 'fetched']";
  columns = getXPath(xml, xpath);
  column_nodeset = columns->nodesetval;

  content = xmlNodeGetContent(column_nodeset->nodeTab[0]);
  if (content != NULL) {
    ret = atoi((char *)content);
    xmlFree(content);
  }

  xmlXPathFreeObject(columns);

  return ret;
}

/*
 * Run xml and sql tasks on a thread
 * @arg: an FPDS record as xmlChar ptr
 */
void task(void *arg) {
  xmlChar *doc = (xmlChar *)arg;
  xmlDocPtr norm;

  norm = normalizeXML(doc);
  writeSQL(norm);
  xmlFreeDoc(norm);
  xmlFree(doc);

  pthread_mutex_lock(&lock);
  done++;
  if (bar != NULL && done % 512 == 0) {
    progressbar_update(bar, done);
  }
  pthread_mutex_unlock(&lock);
}

/*
 * Parse and process xml
 * @filename: name of the xml file to parse
 */
int stream(xmlTextReaderPtr reader, sqlite3 *conn, int threads,
           progressbar *progress) {
  char *err_msg = 0;
  int queue = threads * 12;
  int rc = 0;
  int ret = 1;
  int tasks = 0;

  db = conn;
  bar = progress;

  /* Obtain exclusive transaction with sqlite3 */
  rc = sqlite3_exec(db, "BEGIN EXCLUSIVE TRANSACTION", NULL, NULL, &err_msg);
  if (rc != SQLITE_OK) {
    fprintf(stderr, "Failed to begin transaction.");
    return ret;
  }

  setup();

  pthread_mutex_init(&lock, NULL);
  pool = threadpool_create(threads, queue, 0);

  while (xmlTextReaderRead(reader)) {

    if (xmlTextReaderNodeType(reader) != 1) {
      continue;
    }

    xmlChar *name = xmlTextReaderName(reader);

    switch (getType(name)) {

    case COUNT:
      fetched = getCount(reader);
      if (bar != NULL) {
        bar = progressbar_new("Processing", fetched);
      }
      break;

    case AWARD:
    case IDV:
    case OTAWARD:
    case OTIDV:
      while ((tasks - done) >= queue) {
        usleep(10);
      }

      if (threadpool_add(pool, &task, xmlTextReaderReadOuterXml(reader), 0) !=
          0) {
        fprintf(stderr, "ERROR: record transformation failed.\n");
        goto end;
      };

      tasks++;
      break;
    }

    xmlFree(name);
  }

  while (done < tasks) {
    usleep(10);
  }

  createViews();
  ret = 0;

end:
  sqlite3_exec(db, "END TRANSACTION", NULL, NULL, &err_msg);
  threadpool_destroy(pool, 0);
  pthread_mutex_destroy(&lock);
  cleanup();
  return ret;
}
