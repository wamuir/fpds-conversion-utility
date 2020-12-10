[![Build Status](https://travis-ci.org/wamuir/fpds-conversion-utility.svg?branch=master)](https://travis-ci.org/wamuir/fpds-conversion-utility)

# FPDS XML Conversion Utility

An unofficial replacement for the (now defunct) official FPDS XML conversion
utility.  Converts one or more FPDS data archives to a SQLite3 database.

## About this project

This project intends to provide an unofficial replacement to the FPDS XML
archive conversion utility.  It addresses several of the issues/limitations
(identified below) with the existing, but now discontinued, utility . This
conversion utility will convert one or more FPDS XML archives to a SQLite3
database and provides support for FPDS Specifications Versions 1.4 and 1.5.

#### Background

The [Federal Procurement Data System (FPDS)](https://www.fpds.gov/) houses
procurement/spend data for the U.S. Government.  Archives of annual spend data
are available in XML format for each Federal agency.  Previously, the General
Services Administration (GSA; the Federal agency who manages FPDS) published an
XML conversion utility for converting an FPDS data archive into a
pipe-separated [flat] file. The conversion utility was useful since the
converted data could easily be imported into spreadsheet software and
statistical packages, which increases the accessibility of Federal procurement
data to taxpayers, agencies, suppliers and other parties.<sup
id="a1">[1](#f1)</sup>

Support for the GSA's XML conversion utility was discontinued in 2009/2010 and
no official replacement has been published.  While the utility is still
available for download, several issues preclude its use:

- Data complexity has increased such that a single flat file may no longer
  properly and efficiently represent relationships between data elements
  (_e.g._, in cardinality)

- For several agencies, the quantity of data may exceed the limits of
  commonly-used spreadsheet software (_e.g._, Microsoft Excel, LibreOffice
  Calc) and/or preclude usability of pivot tables and other tools for
  summarizing/aggregating data.

- Support for conversion of XML archives ended with FPDS Specification Version
  1.3.  Archives are no longer posted in this version.  Version 1.3 was
  deprecated on December 31, 2010, and replaced with Version 1.4.  Version 1.4
  was deprecated on September 30, 2017, and replaced with Version 1.5


## Compiling and running the utility

#### Compiling

This utility can be built using CMake >= 3.14. Obtain the necessary depedencies,
for example on **Debian/Ubuntu**:

```shell
$ sudo apt-get -y install \
        build-essential \
        cmake \
        liblzma-dev \
        libncurses-dev \
        libsqlite3-dev \
        libxml2 \
        libxslt1-dev \
        uuid-dev \
        xxd \
        zlib1g-dev
```

Verify that you have CMake >= 3.14 using `cmake --version` and then build:

```shell
$ git clone --recurse-submodules https://github.com/wamuir/fpds-conversion-utility
$ mkdir build && cmake -S fpds-conversion-utility -B build && cmake --build build
```

The compiled executable will be at `build/app/conversion-utility`.

#### Running

Given an FPDS XML archive `archive.xml` the utility can be run as:

```shell
conversion-utility xml_archive sqlite3_target
```

Multiple XML archives can be combined into a single SQLite database by invoking
the append (`-a`) flag:

```shell
./conversion-utility archive1.xml bundle.sqlite3
./conversion-utility -a archive2.xml bundle.sqlite3
./conversion-utility -a archive3.xml bundle.sqlite3
```

And an existing database can be overwritten by invoking the overwrite (`-o`)
flag:

```shell
./conversion-utility -o archive.xml db.sqlite3
``` 

#### Performance

This utility implements a streaming XML parser to limit memory usage, which is
especially useful for converting large archives.  The conversion rate is
generally greater than 100 records per second (machine dependent).

## Database schema

#### Tables

| SQLite3 Table               | Cardinality | FPDS Element Group                  | FPDS Elements         |
| --------------------------- | ----------- | ----------------------------------- | --------------------- |
| additionalReporting         | one-to-many | Legislative Mandates                | 7G                    |
| documentID                  | one-to-one  | Contract Identification Information | 1A-1D 1F-1H           |
| competitionInformation      | one-to-one  | Competition Information             | 10*                   |
| contractInformation         | one-to-one  | Contract Information                | 6A-6H 6J-6N 6P-6R 6T  |
| contractMarketingData       | one-to-one  | Contract Marketing Data             | 5*                    |
| contractorDataA             | one-to-one  | Contractor Data                     | 9*                    | 
| contractorDataB             | one-to-one  | Contractor Data                     | 13*                   |
| dates                       | one-to-one  | Dates                               | 2*                    |
| dollarValues                | one-to-one  | Dollar Values, Total Dollar Values  | 3* 3T*                |
| legislativeMandates         | one-to-one  | Legislative Mandates                | 7A-7F                 |
| preferencePrograms          | one-to-one  | Preference Programs                 | 11*                   |
| productOrServiceInformation | one-to-one  | Product or Service Information      | 8*                    |
| purchaserInformation        | one-to-one  | Purchaser Information               | 4*                    |
| soliciationID               | one-to-one  | Contract Identification Information | 1E                    |
| transactionInformation      | one-to-one  | Transaction Information             | 12*                   |
| treasuryAccount             | one-to-many | Contract Information                | 6SC, 6SG, 6SH, 6SI    |

#### Data elements

- Information on data elements can be found within the FPDS data dictionary, 
available at [fpds.gov](https://www.fpds.gov).  For each element, the 
corresponding column name in the Sqlite3 database is identical to the `XML Tag 
Name` within the data dictionary.


#### Views

- Two views are provided for ease of working with the data

###### `documentID` view

- Identifies document id (integer and primary key), document type (award, IDV) 
and contract identifiers (Agency ID, PIID, Modification Number, Transaction 
Number, etc.)  

- This view is created by the conversion utility, as:

```sql
CREATE VIEW IF NOT EXISTS documentID AS
 SELECT record.id AS id, record.docType as docType,
    awardContractID.agencyID AS awardContractAgencyID,
    awardContractID.PIID AS awardContractPIID,
    awardContractID.modNumber AS awardContractModNumber,
    awardContractID.transactionNumber AS awardContractTransactionNumber,
    IDVID.agencyID AS IDVAgencyID,
    IDVID.PIID AS IDVPIID,
    IDVID.modNumber AS IDVModNumber,
    referencedIDVID.agencyID AS referencedIDVagencyID,
    referencedIDVID.PIID AS referencedIDVPIID,
    referencedIDVID.modNumber AS referencedIDVmodNumber
  FROM record
  LEFT JOIN awardContractID ON record.id = awardContractID.id
  LEFT JOIN IDVID ON record.id = IDVID.id
  LEFT JOIN referencedIDVID ON record.id = referencedIDVID.id;
```

###### `fact` view

- For potential use when 
[importing](#importing-archive-data-into-a-statistical-package-from-sqlite3), 
[exporting](#exporting-archive-data-from-sqlite3-to-a-flat-file) or other 
instances where a fact table might come in handy

- This view is created by the conversion utility, as:

```sql
CREATE VIEW fact AS
  SELECT *
  FROM documentID
  LEFT JOIN competitionInformation on documentID.id = competitionInformation.id
  LEFT JOIN contractInformation on documentID.id = contractInformation.id
  LEFT JOIN contractMarketingData on documentID.id = contractMarketingdata.id
  LEFT JOIN contractorDataA on documentID.id = contractorDataA.id
  LEFT JOIN contractorDataB on documentID.id = contractorDataB.id
  LEFT JOIN dates on documentID.id = dates.id
  LEFT JOIN dollarValues on documentID.id = dollarValues.id
  LEFT JOIN legislativeMandates on documentID.id = legislativeMandates.id
  LEFT JOIN preferencePrograms on documentID.id = preferencePrograms.id
  LEFT JOIN productOrServiceInformation on documentID.id = productOrServiceInformation.id
  LEFT JOIN purchaserInformation on documentID.id = purchaserInformation.id
  LEFT JOIN solicitationID on documentID.id = solicitationID.id
  LEFT JOIN transactionInformation on documentID.id = transactionInformation.id;
```


## Importing and exporting data

#### Importing archive data into a statistical package from SQLite3

A simple example is given below for importing data into _R_:

```r
#!/usr/bin/env Rscript

conn <-  DBI::dbConnect(RSQLite::SQLite(), dbname="archive.sqlite3")
query <- DBI::dbSendQuery(conn, "SELECT documentID.*, dollarValues.obligatedAmount
                                 FROM documentID
                                 LEFT JOIN dollarValues ON documentID.id = dollarValues.id
                                 WHERE documentID.docType = 'award';")
df <- DBI::dbFetch(query, n = -1)
DBI::dbClearResult(query)
DBI::dbDisconnect(conn)
```

And, for importing the same data into Python:

```python
#!/usr/bin/env python3

import sqlite3

conn = sqlite3.connect("archive.sqlite3")
c = conn.cursor()
c.execute('''SELECT documentID.*, dollarValues.obligatedAmount
             FROM documentID
             LEFT JOIN dollarValues ON documentID.id = dollarValues.id
             WHERE documentID.docType = 'award';''')
df = c.fetchall()
conn.close()
```

#### Exporting archive data from SQLite3 to a flat file

Ideally, don't do this.  For those still wishing to flatten and export data, a
fact table view is provided of one-to-one relationships and can be exported as
follows:

```sql
.open archive.sqlite3
.headers on
.mode csv
.output exported.csv
SELECT * FROM fact;
```

## Limitations

- ~~Currently, no support for `other transactions`~~ (Other Transaction supported added 2019-05-19)

- Currently, no support for agency-specific (_e.g._, NASA) data elements


<br/><br/> <b id="f1">1</b> Specifically, this refers to the accessibility of
sets of data for analyses. Individual transactions can be searched/queried at
[fpds.gov](https://www.fpds.gov/). Data is also available via ATOM Feed as well
as aggregator sites (_e.g._, [usaspending.gov](https://www.usaspending.gov))
but do not resolve one or more of the issues identified or present additional
issues.[↩](#a1)
 

