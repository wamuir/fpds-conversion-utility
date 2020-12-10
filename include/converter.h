#ifndef CONVERTER_H
#define CONVERTER_H

#include <libxml/xmlreader.h>
#include <sqlite3.h>

#include "progressbar.h"
#include "statusbar.h"

#ifdef __cplusplus
extern "C" {
#endif

int stream(xmlTextReaderPtr reader,  sqlite3 *conn, progressbar *progress);

#ifdef __cplusplus
}
#endif

#endif
