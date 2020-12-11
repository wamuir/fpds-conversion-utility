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

#include <errno.h>
#include <getopt.h>
#include <libxml/xmlreader.h>
#include <libxml/xmlstring.h>
#include <sqlite3.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sysexits.h>
#include <unistd.h>

#include "converter.h"
#include "progressbar.h"
#include "statusbar.h"

progressbar *progress;
static int aflg, oflg, hflg;
static void usage(void);
static void cleanup(void);

/*
 * Print command line usage
 */
static void usage(void) {
  fprintf(stderr, "Usage:\n");
  fprintf(stderr, "       conversion-utility [flags] archive database\n");
  fprintf(stderr, "Flags:\n");
  fprintf(stderr, "    -a          append to existing database.\n");
  fprintf(stderr, "    -o          overwrite existing database.\n");
  fprintf(stderr, "    -t          number of threads use (default = 1).\n");
}

/*
 * Memory management prior to program exit
 */
static void cleanup(void) { xmlCleanupParser(); }

int main(int argc, char **argv) {
  char *cval, *endptr, *err_msg, *sqlite3_target, *str, *xml_archive;
  int ch, option_index = 0, rc = 0;
  long threads = 1;
  sqlite3 *db;
  xmlTextReaderPtr reader;

  static struct option o[] = {{"append", no_argument, NULL, 'a'},
                              {"overwrite", no_argument, NULL, 'o'},
                              {"help", no_argument, NULL, 'h'},
                              {"threads", required_argument, NULL, 't'},
                              {NULL, 0, NULL, 0}};

  /* Parse command line args */
  while ((ch = getopt_long(argc, argv, "t:aoh", o, &option_index)) != -1) {

    switch (ch) {

    case 'a':
      aflg = 1;
      break;

    case 'o':
      oflg = 1;
      break;

    case 'h':
      hflg = 1;
      break;

    case 't':
      errno = 0;
      threads = strtol(optarg, &endptr, 10);

      if ((errno == ERANGE && (threads == LONG_MAX || threads == LONG_MIN)) ||
          (errno != 0 && threads == 0)) {
        perror("strtol");
        cleanup();
        exit(EX_USAGE);
      }

      if (*endptr != 0 || threads <= 0) {
        fprintf(stderr, "Error: the number of threads must be passed as a "
                        "positive integer\n");
        cleanup();
        exit(EX_USAGE);
      }
      break;

    default:
      usage();
      cleanup();
      exit(EX_USAGE);
    }
  }

  /* Perform some checking on command line arguments */
  if (aflg && oflg) {
    /* Append and overwrite are mutually exclusive */
    fprintf(stderr, "-[a]ppend and -[o]verwrite cannot be used together\n");
    usage();
    cleanup();
    exit(EX_USAGE);
  } else if (hflg) {
    /* If --[h]elp is requested */
    usage();
    cleanup();
    exit(EX_USAGE);
  } else if ((argc - optind) != 2) {
    /* We must have exactly two remaining args: input and output files */
    usage();
    cleanup();
    exit(EX_USAGE);
  }

  /* Perform some checking on our input file */
  xml_archive = argv[optind++];
  if (access(xml_archive, F_OK) != 0 || access(xml_archive, R_OK) != 0) {
    /* If file does not exist or exists but is not readable */
    fprintf(stderr, "Error: input file cannot be read\n");
    cleanup();
    exit(EX_NOINPUT);
  }

  /* Check for ABI mismatches between compiled and shared libraries */
  LIBXML_TEST_VERSION

  /* Open file in xmlReader */
  reader = xmlReaderForFile(xml_archive, "UTF-8", 0);
  if (reader == NULL) {
    fprintf(stderr, "Failed to open %s\n", xml_archive);
    exit(EX_IOERR);
  }

  /* Perform some checking on our target file and truncate if requested */
  sqlite3_target = argv[optind++];
  if (access(sqlite3_target, F_OK) == 0 && !aflg && !oflg) {
    /* If file exists but no option is selected to append or overwrite */
    fprintf(stderr, "Error: output file exists, use -a or -o\n");
    cleanup();
    exit(EX_CANTCREAT);
  } else if (access(sqlite3_target, F_OK) == 0 &&
             access(sqlite3_target, W_OK) != 0) {
    /* If file exists but is not writable */
    fprintf(stderr, "Error: unable to open the output file for writing\n");
    cleanup();
    exit(EX_IOERR);
  } else if (access(sqlite3_target, F_OK) == 0 &&
             access(sqlite3_target, W_OK) == 0 && oflg &&
             truncate(sqlite3_target, 0) != 0) {
    /* If recv'd overwrite flag & file exists but os can't truncate */
    fprintf(stderr, "Failed to overwrite output file.\n");
    cleanup();
    exit(EX_IOERR);
  }

  // NEED TO CHECK FOR THREADSAFETY
  // fprintf(stderr, "SQLITE3 is threadsafe: %d; CONFIG FAILED: %d",
  // sqlite3_threadsafe(), sqlite3_config(SQLITE_CONFIG_SERIALIZED));

  /* Set up a sqlite3 connection to the target file / database */
  rc = sqlite3_open_v2(
      sqlite3_target, &db,
      SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX, NULL);
  if (rc != SQLITE_OK) {
    fprintf(stderr, "Failed to open database: %s\n", sqlite3_errmsg(db));
    sqlite3_close(db);
    cleanup();
    exit(EX_IOERR);
  }

  progress = progressbar_new("Processing", 0);

  if (stream(reader, db, threads, progress) != 0) {
    fprintf(stderr, "Conversion Failed");
  }

  progressbar_finish(progress);
  xmlFreeTextReader(reader);

  sqlite3_free(err_msg);
  sqlite3_close(db);
  cleanup();
  exit(0);
}
