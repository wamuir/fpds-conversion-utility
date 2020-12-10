<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns14="http://www.fpdsng.com/FPDS" xmlns:ns15="https://www.fpds.gov/FPDS" exclude-result-prefixes="ns14 ns15" version="1.0">
  <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
  <xsl:param name="lang"/>
  <xsl:param name="source"/>
  <xsl:template match="/">
    <xsl:apply-templates select="/ns14:award"/>
    <xsl:apply-templates select="/ns14:IDV"/>
    <xsl:apply-templates select="/ns14:OtherTransactionAward"/>
    <xsl:apply-templates select="/ns14:OtherTransactionIDV"/>
    <xsl:apply-templates select="/ns15:award"/>
    <xsl:apply-templates select="/ns15:IDV"/>
    <xsl:apply-templates select="/ns15:OtherTransactionAward"/>
    <xsl:apply-templates select="/ns15:OtherTransactionIDV"/>
  </xsl:template>
  <xsl:template match="/ns14:award|/ns14:IDV|/ns14:OtherTransactionAward|/ns14:OtherTransactionIDV|/ns15:award|/ns15:IDV|/ns15:OtherTransactionAward|/ns15:OtherTransactionIDV">
    <tables>
      <xsl:call-template name="ns15:dummy"/>
      <xsl:call-template name="ns15:meta"/>
      <xsl:call-template name="ns15:awardContractID"/>
      <xsl:call-template name="ns15:IDVID"/>
      <xsl:call-template name="ns15:referencedIDVID"/>
      <xsl:call-template name="ns15:OtherTransactionAwardContractID"/>
      <xsl:call-template name="ns15:OtherTransactionIDVID"/>
      <xsl:call-template name="ns15:solicitationID"/>
      <xsl:call-template name="ns15:dates"/>
      <xsl:call-template name="ns15:dollarValues"/>
      <xsl:call-template name="ns15:purchaserInformation"/>
      <xsl:call-template name="ns15:contractMarketingData"/>
      <xsl:call-template name="ns15:contractInformation"/>
      <xsl:call-template name="ns15:treasuryAccount"/>
      <xsl:call-template name="ns15:legislativeMandates"/>
      <xsl:call-template name="ns15:additionalReporting"/>
      <xsl:call-template name="ns15:productOrServiceInformation"/>
      <xsl:call-template name="ns15:contractorDataA"/>
      <xsl:call-template name="ns15:competitionInformation"/>
      <xsl:call-template name="ns15:preferencePrograms"/>
      <xsl:call-template name="ns15:transactionInformation"/>
      <xsl:call-template name="ns15:contractorDataB"/>
    </tables>
  </xsl:template>
  <xsl:template name="ns15:dummy">
    <!--- Begin dummy nodes for one-to-many tables to enforce table creation in database -->
    <table cardinality="otm" sqlname="additionalReporting">
      <column>
        <xsl:attribute name="elemNo">7G</xsl:attribute>
        <xsl:attribute name="sqlname">additionalReportingValue</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(10)</xsl:attribute>
      </column>
    </table>
    <table cardinality="otm" sqlname="treasuryAccount">
      <column>
        <xsl:attribute name="elemNo">6SC</xsl:attribute>
        <xsl:attribute name="sqlname">agencyIdentifier</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
      </column>
      <column>
        <xsl:attribute name="elemNo">6SG</xsl:attribute>
        <xsl:attribute name="sqlname">mainAccountCode</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
      </column>
      <column>
        <xsl:attribute name="elemNo">6SH</xsl:attribute>
        <xsl:attribute name="sqlname">subAccountCode</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(3)</xsl:attribute>
      </column>
      <column>
        <xsl:attribute name="elemNo">6SI</xsl:attribute>
        <xsl:attribute name="sqlname">initiative</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:meta">
    <table cardinality="oto" sqlname="meta">
      <column>
        <xsl:attribute name="sqlname">source</xsl:attribute>
        <xsl:choose>
          <xsl:when test="$lang = 'postgres'">
            <xsl:attribute name="datatype">UUID</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="datatype">CHAR(36)</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$source"/>
      </column>
      <column>
        <xsl:attribute name="sqlname">docType</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(21)</xsl:attribute>
        <xsl:choose>
          <xsl:when test="/ns14:award">
            <xsl:text>award</xsl:text>
          </xsl:when>
          <xsl:when test="/ns15:award">
            <xsl:text>award</xsl:text>
          </xsl:when>
          <xsl:when test="/ns14:IDV">
            <xsl:text>IDV</xsl:text>
          </xsl:when>
          <xsl:when test="/ns15:IDV">
            <xsl:text>IDV</xsl:text>
          </xsl:when>
          <xsl:when test="/ns14:OtherTransactionAward">
            <xsl:text>OtherTransactionAward</xsl:text>
          </xsl:when>
          <xsl:when test="/ns15:OtherTransactionAward">
            <xsl:text>OtherTransactionAward</xsl:text>
          </xsl:when>
          <xsl:when test="/ns14:OtherTransactionIDV">
            <xsl:text>OtherTransactionIDV</xsl:text>
          </xsl:when>
          <xsl:when test="/ns15:OtherTransactionIDV">
            <xsl:text>OtherTransactionIDV</xsl:text>
          </xsl:when>
        </xsl:choose>
      </column>
      <column>
        <xsl:attribute name="sqlname">fingerprint</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(4000)</xsl:attribute>
        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;?xml version="1.0" encoding="UTF-8"?&gt;</xsl:text>
        <fingerprint>
          <xsl:copy-of select="ns14:awardID"/>
          <xsl:copy-of select="ns14:contractID"/>
          <xsl:copy-of select="ns14:OtherTransactionAwardID"/>
          <xsl:copy-of select="ns14:OtherTransactionIDVID"/>
          <xsl:copy-of select="ns15:awardID"/>
          <xsl:copy-of select="ns15:contractID"/>
          <xsl:copy-of select="ns15:OtherTransactionAwardID"/>
          <xsl:copy-of select="ns15:OtherTransactionIDVID"/>
        </fingerprint>
        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
      </column>
      <column>
        <xsl:attribute name="sqlname">deleted</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:text>0</xsl:text>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:awardContractID">
    <table cardinality="oto" sqlname="awardContractID">
      <column>
        <xsl:attribute name="elemNo">1F</xsl:attribute>
        <xsl:attribute name="sqlname">agencyID</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
        <xsl:value-of select="ns14:awardID/ns14:awardContractID/ns14:agencyID"/>
        <xsl:value-of select="ns15:awardID/ns15:awardContractID/ns15:agencyID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1A</xsl:attribute>
        <xsl:attribute name="sqlname">PIID</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
        <xsl:value-of select="ns14:awardID/ns14:awardContractID/ns14:PIID"/>
        <xsl:value-of select="ns15:awardID/ns15:awardContractID/ns15:PIID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1B</xsl:attribute>
        <xsl:attribute name="sqlname">modNumber</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
        <xsl:value-of select="ns14:awardID/ns14:awardContractID/ns14:modNumber"/>
        <xsl:value-of select="ns15:awardID/ns15:awardContractID/ns15:modNumber"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1D</xsl:attribute>
        <xsl:attribute name="sqlname">transactionNumber</xsl:attribute>
        <xsl:attribute name="datatype">INTEGER</xsl:attribute>
        <xsl:value-of select="ns14:awardID/ns14:awardContractID/ns14:transactionNumber"/>
        <xsl:value-of select="ns15:awardID/ns15:awardContractID/ns15:transactionNumber"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:IDVID">
    <table cardinality="oto" sqlname="IDVID">
      <column>
        <xsl:attribute name="elemNo">1F</xsl:attribute>
        <xsl:attribute name="sqlname">agencyID</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
        <xsl:value-of select="ns14:contractID/ns14:IDVID/ns14:agencyID"/>
        <xsl:value-of select="ns15:contractID/ns15:IDVID/ns15:agencyID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1A</xsl:attribute>
        <xsl:attribute name="sqlname">PIID</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
        <xsl:value-of select="ns14:contractID/ns14:IDVID/ns14:PIID"/>
        <xsl:value-of select="ns15:contractID/ns15:IDVID/ns15:PIID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1B</xsl:attribute>
        <xsl:attribute name="sqlname">modNumber</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
        <xsl:value-of select="ns14:contractID/ns14:IDVID/ns14:modNumber"/>
        <xsl:value-of select="ns15:contractID/ns15:IDVID/ns15:modNumber"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:referencedIDVID">
    <table cardinality="oto" sqlname="referencedIDVID">
      <column>
        <xsl:attribute name="elemNo">1H</xsl:attribute>
        <xsl:attribute name="sqlname">agencyID</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
        <xsl:value-of select="ns14:awardID/ns14:referencedIDVID/ns14:agencyID"/>
        <xsl:value-of select="ns14:contractID/ns14:referencedIDVID/ns14:agencyID"/>
        <xsl:value-of select="ns14:otherTransactionAwardID/ns14:referencedIDVID/ns14:agencyID"/>
        <xsl:value-of select="ns15:awardID/ns15:referencedIDVID/ns15:agencyID"/>
        <xsl:value-of select="ns15:contractID/ns15:referencedIDVID/ns15:agencyID"/>
        <xsl:value-of select="ns15:otherTransactionAwardID/ns15:referencedIDVID/ns15:agencyID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1C</xsl:attribute>
        <xsl:attribute name="sqlname">PIID</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
        <xsl:value-of select="ns14:awardID/ns14:referencedIDVID/ns14:PIID"/>
        <xsl:value-of select="ns14:contractID/ns14:referencedIDVID/ns14:PIID"/>
        <xsl:value-of select="ns14:otherTransactionAwardID/ns14:referencedIDVID/ns14:PIID"/>
        <xsl:value-of select="ns15:awardID/ns15:referencedIDVID/ns15:PIID"/>
        <xsl:value-of select="ns15:contractID/ns15:referencedIDVID/ns15:PIID"/>
        <xsl:value-of select="ns15:otherTransactionAwardID/ns15:referencedIDVID/ns15:PIID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1G</xsl:attribute>
        <xsl:attribute name="sqlname">modNumber</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
        <xsl:value-of select="ns14:awardID/ns14:referencedIDVID/ns14:modNumber"/>
        <xsl:value-of select="ns14:contractID/ns14:referencedIDVID/ns14:modNumber"/>
        <xsl:value-of select="ns14:otherTransactionAwardID/ns14:referencedIDVID/ns14:modNumber"/>
        <xsl:value-of select="ns15:awardID/ns15:referencedIDVID/ns15:modNumber"/>
        <xsl:value-of select="ns15:contractID/ns15:referencedIDVID/ns15:modNumber"/>
        <xsl:value-of select="ns15:otherTransactionAwardID/ns15:referencedIDVID/ns15:modNumber"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:OtherTransactionAwardContractID">
    <table cardinality="oto" sqlname="OtherTransactionAwardContractID">
      <column>
        <xsl:attribute name="elemNo">1F</xsl:attribute>
        <xsl:attribute name="sqlname">agencyID</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
        <xsl:value-of select="ns14:OtherTransactionAwardID/ns14:agencyID"/>
        <xsl:value-of select="ns14:OtherTransactionAwardContractID/ns14:agencyID"/>
        <xsl:value-of select="ns15:OtherTransactionAwardID/ns15:agencyID"/>
        <xsl:value-of select="ns15:OtherTransactionAwardContractID/ns15:agencyID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1A</xsl:attribute>
        <xsl:attribute name="sqlname">PIID</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
        <xsl:value-of select="ns14:OtherTransactionAwardID/ns14:PIID"/>
        <xsl:value-of select="ns14:OtherTransactionAwardContractID/ns14:PIID"/>
        <xsl:value-of select="ns15:OtherTransactionAwardID/ns15:PIID"/>
        <xsl:value-of select="ns15:OtherTransactionAwardContractID/ns15:PIID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1B</xsl:attribute>
        <xsl:attribute name="sqlname">modNumber</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
        <xsl:value-of select="ns14:OtherTransactionAwardID/ns14:modNumber"/>
        <xsl:value-of select="ns14:OtherTransactionAwardContractID/ns14:modNumber"/>
        <xsl:value-of select="ns15:OtherTransactionAwardID/ns15:modNumber"/>
        <xsl:value-of select="ns15:OtherTransactionAwardContractID/ns15:modNumber"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:OtherTransactionIDVID">
    <table cardinality="oto" sqlname="OtherTransactionIDVID">
      <column>
        <xsl:attribute name="elemNo">1F</xsl:attribute>
        <xsl:attribute name="sqlname">agencyID</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
        <xsl:value-of select="ns14:OtherTransactionIDVID/ns14:OtherTransactionIDVContractID/ns14:agencyID"/>
        <xsl:value-of select="ns15:OtherTransactionIDVID/ns15:OtherTransactionIDVContractID/ns15:agencyID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1A</xsl:attribute>
        <xsl:attribute name="sqlname">PIID</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
        <xsl:value-of select="ns14:OtherTransactionIDVID/ns14:OtherTransactionIDVContractID/ns14:PIID"/>
        <xsl:value-of select="ns15:OtherTransactionIDVID/ns15:OtherTransactionIDVContractID/ns15:PIID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">1B</xsl:attribute>
        <xsl:attribute name="sqlname">modNumber</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
        <xsl:value-of select="ns14:OtherTransactionIDVID/ns14:OtherTransactionIDVContractID/ns14:modNumber"/>
        <xsl:value-of select="ns15:OtherTransactionIDVID/ns15:OtherTransactionIDVContractID/ns15:modNumber"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:solicitationID">
    <table cardinality="oto" sqlname="solicitationID">
      <column>
        <xsl:attribute name="elemNo">1E</xsl:attribute>
        <xsl:attribute name="sqlname">solicitationID</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:solicitationID"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:solicitationID"/>
        <xsl:value-of select="ns15:contractData/ns15:solicitationID"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:solicitationID"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:dates">
    <table cardinality="oto" sqlname="dates">
      <column>
        <xsl:attribute name="elemNo">2A</xsl:attribute>
        <xsl:attribute name="sqlname">signedDate</xsl:attribute>
        <xsl:attribute name="datatype">DATE</xsl:attribute>
        <xsl:value-of select="ns14:relevantContractDates/ns14:signedDate"/>
        <xsl:value-of select="ns14:contractDetail/ns14:relevantContractDates/ns14:signedDate"/>
        <xsl:value-of select="ns15:relevantContractDates/ns15:signedDate"/>
        <xsl:value-of select="ns15:contractDetail/ns15:relevantContractDates/ns15:signedDate"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">2B</xsl:attribute>
        <xsl:attribute name="sqlname">effectiveDate</xsl:attribute>
        <xsl:attribute name="datatype">DATE</xsl:attribute>
        <xsl:value-of select="ns14:relevantContractDates/ns14:effectiveDate"/>
        <xsl:value-of select="ns14:contractDetail/ns14:relevantContractDates/ns14:effectiveDate"/>
        <xsl:value-of select="ns15:relevantContractDates/ns15:effectiveDate"/>
        <xsl:value-of select="ns15:contractDetail/ns15:relevantContractDates/ns15:effectiveDate"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">2C</xsl:attribute>
        <xsl:attribute name="sqlname">currentCompletionDate</xsl:attribute>
        <xsl:attribute name="datatype">DATE</xsl:attribute>
        <xsl:value-of select="ns14:relevantContractDates/ns14:currentCompletionDate"/>
        <xsl:value-of select="ns14:contractDetail/ns14:relevantContractDates/ns14:currentCompletionDate"/>
        <xsl:value-of select="ns15:relevantContractDates/ns15:currentCompletionDate"/>
        <xsl:value-of select="ns15:contractDetail/ns15:relevantContractDates/ns15:currentCompletionDate"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">2D</xsl:attribute>
        <xsl:attribute name="sqlname">ultimateCompletionDate</xsl:attribute>
        <xsl:attribute name="datatype">DATE</xsl:attribute>
        <xsl:value-of select="ns14:relevantContractDates/ns14:ultimateCompletionDate"/>
        <xsl:value-of select="ns14:contractDetail/ns14:relevantContractDates/ns14:ultimateCompletionDate"/>
        <xsl:value-of select="ns15:relevantContractDates/ns15:ultimateCompletionDate"/>
        <xsl:value-of select="ns15:contractDetail/ns15:relevantContractDates/ns15:ultimateCompletionDate"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">2E</xsl:attribute>
        <xsl:attribute name="sqlname">lastDateToOrder</xsl:attribute>
        <xsl:attribute name="datatype">DATE</xsl:attribute>
        <xsl:value-of select="ns14:relevantContractDates/ns14:lastDateToOrder"/>
        <xsl:value-of select="ns14:contractDetail/ns14:relevantContractDates/ns14:lastDateToOrder"/>
        <xsl:value-of select="ns15:relevantContractDates/ns15:lastDateToOrder"/>
        <xsl:value-of select="ns15:contractDetail/ns15:relevantContractDates/ns15:lastDateToOrder"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">2F</xsl:attribute>
        <xsl:attribute name="sqlname">lastModifiedDate</xsl:attribute>
        <xsl:attribute name="datatype">DATE</xsl:attribute>
        <xsl:value-of select="ns14:relevantContractDates/ns14:lastModifiedDate"/>
        <xsl:value-of select="ns14:contractDetail/ns14:relevantContractDates/ns14:lastModifiedDate"/>
        <xsl:value-of select="ns15:relevantContractDates/ns15:lastModifiedDate"/>
        <xsl:value-of select="ns15:contractDetail/ns15:relevantContractDates/ns15:lastModifiedDate"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">2G</xsl:attribute>
        <xsl:attribute name="sqlname">fiscalYear</xsl:attribute>
        <xsl:attribute name="datatype">INTEGER</xsl:attribute>
        <xsl:value-of select="ns14:relevantContractDates/ns14:fiscalYear"/>
        <xsl:value-of select="ns14:contractDetail/ns14:relevantContractDates/ns14:fiscalYear"/>
        <xsl:value-of select="ns15:relevantContractDates/ns15:fiscalYear"/>
        <xsl:value-of select="ns15:contractDetail/ns15:relevantContractDates/ns15:fiscalYear"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">2H</xsl:attribute>
        <xsl:attribute name="sqlname">solicitationDate</xsl:attribute>
        <xsl:attribute name="datatype">DATE</xsl:attribute>
        <xsl:value-of select="ns14:relevantContractDates/ns14:solicitationDate"/>
        <xsl:value-of select="ns14:contractDetail/ns14:relevantContractDates/ns14:solicitationDate"/>
        <xsl:value-of select="ns15:relevantContractDates/ns15:solicitationDate"/>
        <xsl:value-of select="ns15:contractDetail/ns15:relevantContractDates/ns15:solicitationDate"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:dollarValues">
    <table cardinality="oto" sqlname="dollarValues">
      <column>
        <xsl:attribute name="elemNo">3A</xsl:attribute>
        <xsl:attribute name="sqlname">baseAndAllOptionsValue</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:dollarValues/ns14:baseAndAllOptionsValue"/>
        <xsl:value-of select="ns14:contractDetail/ns14:dollarValues/ns14:baseAndAllOptionsValue"/>
        <xsl:value-of select="ns15:dollarValues/ns15:baseAndAllOptionsValue"/>
        <xsl:value-of select="ns15:contractDetail/ns15:dollarValues/ns15:baseAndAllOptionsValue"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">3B</xsl:attribute>
        <xsl:attribute name="sqlname">baseAndExercisedOptionsValue</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:dollarValues/ns14:baseAndExerisedOptionsValue"/>
        <xsl:value-of select="ns14:contractDetail/ns14:dollarValues/ns14:baseAndExercisedOptionsValue"/>
        <xsl:value-of select="ns15:dollarValues/ns15:baseAndExercisedOptionsValue"/>
        <xsl:value-of select="ns15:contractDetail/ns15:dollarValues/ns15:baseAndExercisedOptionsValue"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">3C</xsl:attribute>
        <xsl:attribute name="sqlname">obligatedAmount</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:dollarValues/ns14:obligatedAmount"/>
        <xsl:value-of select="ns14:contractDetail/ns14:dollarValues/ns14:obligatedAmount"/>
        <xsl:value-of select="ns15:dollarValues/ns15:obligatedAmount"/>
        <xsl:value-of select="ns15:contractDetail/ns15:dollarValues/ns15:obligatedAmount"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">3D</xsl:attribute>
        <xsl:attribute name="sqlname">nonGovernmentalDollars</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:dollarValues/ns14:nonGovernmentalDollars"/>
        <xsl:value-of select="ns14:contractDetail/ns14:dollarValues/ns14:nonGovernmentalDollars"/>
        <xsl:value-of select="ns15:dollarValues/ns15:nonGovernmentalDollars"/>
        <xsl:value-of select="ns15:contractDetail/ns15:dollarValues/ns15:nonGovernmentalDollars"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">3E</xsl:attribute>
        <xsl:attribute name="sqlname">totalEstimatedOrderValue</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:dollarValues/ns14:totalEstimatedOrderValue"/>
        <xsl:value-of select="ns14:contractDetail/ns14:dollarValues/ns14:totalEstimatedOrderValue"/>
        <xsl:value-of select="ns15:dollarValues/ns15:totalEstimatedOrderValue"/>
        <xsl:value-of select="ns15:contractDetail/ns15:dollarValues/ns15:totalEstimatedOrderValue"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">3AT</xsl:attribute>
        <xsl:attribute name="sqlname">totalBaseAndAllOptionsValue</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:dollarValues/ns14:totalBaseAndAllOptionsValue"/>
        <xsl:value-of select="ns14:contractDetail/ns14:dollarValues/ns14:totalBaseAndAllOptionsValue"/>
        <xsl:value-of select="ns15:dollarValues/ns15:totalBaseAndAllOptionsValue"/>
        <xsl:value-of select="ns15:contractDetail/ns15:dollarValues/ns15:totalBaseAndAllOptionsValue"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">3BT</xsl:attribute>
        <xsl:attribute name="sqlname">totalBaseAndExercisedOptionsValue</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:dollarValues/ns14:totalBaseAndExercisedOptionsValue"/>
        <xsl:value-of select="ns14:contractDetail/ns14:dollarValues/ns14:totalBaseAndExercisedOptionsValue"/>
        <xsl:value-of select="ns15:dollarValues/ns15:totalBaseAndExercisedOptionsValue"/>
        <xsl:value-of select="ns15:contractDetail/ns15:dollarValues/ns15:totalBaseAndExcersiedOptionsValue"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">3CT</xsl:attribute>
        <xsl:attribute name="sqlname">totalObligatedAmount</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:dollarValues/ns14:totalObligatedAmount"/>
        <xsl:value-of select="ns14:contractDetail/ns14:dollarValues/ns14:totalObligatedAmount"/>
        <xsl:value-of select="ns15:dollarValues/ns15:totalObligatedAmount"/>
        <xsl:value-of select="ns15:contractDetail/ns15:dollarValues/ns15:totalObligatedAmount"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">3DT</xsl:attribute>
        <xsl:attribute name="sqlname">totalNonGovernmentalDollars</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:dollarValues/ns14:totalNonGovernmentalDollars"/>
        <xsl:value-of select="ns14:contractDetail/ns14:dollarValues/ns14:totalNonGovernmentalDollars"/>
        <xsl:value-of select="ns15:dollarValues/ns15:totalNonGovernmentalDollars"/>
        <xsl:value-of select="ns15:contractDetail/ns15:dollarValues/ns15:totalNonGovernmentalDollars"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:purchaserInformation">
    <table cardinality="oto" sqlname="purchaserInformation">
      <column>
        <xsl:attribute name="elemNo">4A</xsl:attribute>
        <xsl:attribute name="sqlname">contractingOfficeAgencyID</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
        <xsl:value-of select="ns14:purchaserInformation/ns14:contractingOfficeAgencyID"/>
        <xsl:value-of select="ns14:contractDetail/ns14:purchaserInformation/ns14:contractingOfficeAgencyID"/>
        <xsl:value-of select="ns15:purchaserInformation/ns15:contractingOfficeAgencyID"/>
        <xsl:value-of select="ns15:contractDetail/ns15:purchaserInformation/ns15:contractingOfficeAgencyID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">4B</xsl:attribute>
        <xsl:attribute name="sqlname">contractingOfficeID</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(6)</xsl:attribute>
        <xsl:value-of select="ns14:purchaserInformation/ns14:contractingOfficeID"/>
        <xsl:value-of select="ns14:contractDetail/ns14:purchaserInformation/ns14:contractingOfficeID"/>
        <xsl:value-of select="ns15:purchaserInformation/ns15:contractingOfficeID"/>
        <xsl:value-of select="ns15:contractDetail/ns15:purchaserInformation/ns15:contractingOfficeID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">4C</xsl:attribute>
        <xsl:attribute name="sqlname">fundingRequestingAgencyID</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
        <xsl:value-of select="ns14:purchaserInformation/ns14:fundingRequestingAgencyID"/>
        <xsl:value-of select="ns14:contractDetail/ns14:purchaserInformation/ns14:fundingRequestingAgencyID"/>
        <xsl:value-of select="ns15:purchaserInformation/ns15:fundingRequestingAgencyID"/>
        <xsl:value-of select="ns15:contractDetail/ns15:purchaserInformation/ns15:fundingRequestingAgencyID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">4D</xsl:attribute>
        <xsl:attribute name="sqlname">fundingRequestingOfficeID</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(6)</xsl:attribute>
        <xsl:value-of select="ns14:purchaserInformation/ns14:fundingRequestingOfficeID"/>
        <xsl:value-of select="ns14:contractDetail/ns14:purchaserInformation/ns14:fundingRequestingOfficeID"/>
        <xsl:value-of select="ns15:purchaserInformation/ns15:fundingRequestingOfficeID"/>
        <xsl:value-of select="ns15:contractDetail/ns15:purchaserInformation/ns15:fundingRequestingOfficeID"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">4F</xsl:attribute>
        <xsl:attribute name="sqlname">foreignFunding</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:purchaserInformation/ns14:foreignFunding"/>
        <xsl:value-of select="ns14:contractDetail/ns14:purchaserInformation/ns14:foreignFunding"/>
        <xsl:value-of select="ns15:purchaserInformation/ns15:foreignFunding"/>
        <xsl:value-of select="ns15:contractDetail/ns15:purchaserInformation/ns15:foreignFunding"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:contractMarketingData">
    <table cardinality="oto" sqlname="contractMarketingData">
      <column>
        <xsl:attribute name="elemNo">5A</xsl:attribute>
        <xsl:attribute name="sqlname">websiteURL</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(100)</xsl:attribute>
        <xsl:value-of select="ns14:contractMarketingData/ns14:websiteURL"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractMarketingData/ns14:websiteURL"/>
        <xsl:value-of select="ns15:contractMarketingData/ns15:websiteURL"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractMarketingData/ns15:websiteURL"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">5B</xsl:attribute>
        <xsl:attribute name="sqlname">whoCanUse</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(255)</xsl:attribute>
        <xsl:value-of select="ns14:contractMarketingData/ns14:whoCanUse"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractMarketingData/ns14:whoCanUse"/>
        <xsl:value-of select="ns15:contractMarketingData/ns15:whoCanUse"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractMarketingData/ns15:whoCanUse"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">5C</xsl:attribute>
        <xsl:attribute name="sqlname">individualOrderLimit</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:contractMarketingData/ns14:individualOrderLimit"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractMarketingData/ns14:individualOrderLimit"/>
        <xsl:value-of select="ns15:contractMarketingData/ns15:individualOrderLimit"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractMarketingData/ns15:individualOrderLimit"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">5D</xsl:attribute>
        <xsl:attribute name="sqlname">typeOfFeeForUseOrService</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(3)</xsl:attribute>
        <xsl:value-of select="ns14:contractMarketingData/ns14:typeOfFeeForUseOfService"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractMarketingData/ns14:typeOfFeeForUseOfService"/>
        <xsl:value-of select="ns15:contractMarketingData/ns15:typeOfFeeForUseOfService"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractMarketingData/ns15:typeOfFeeForUseOfService"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">5E</xsl:attribute>
        <xsl:attribute name="sqlname">fixedFeeValue</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:contractMarketingData/ns14:fixedFeeValue"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractMarketingData/ns14:fixedFeeValue"/>
        <xsl:value-of select="ns15:contractMarketingData/ns15:fixedFeeValue"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractMarketingData/ns15:fixedFeeValue"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">5F</xsl:attribute>
        <xsl:attribute name="sqlname">feeRangeLowerValue</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:contractMarketingData/ns14:feeRangeLowerValue"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractMarketingData/ns14:feeRangeLowerValue"/>
        <xsl:value-of select="ns15:contractMarketingData/ns15:feeRangeLowerValue"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractMarketingData/ns15:feeRangeLowerValue"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">5G</xsl:attribute>
        <xsl:attribute name="sqlname">feeRangeUpperValue</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:contractMarketingData/ns14:feeRangeUpperValue"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractMarketingData/ns14:feeRangeUpperValue"/>
        <xsl:value-of select="ns15:contractMarketingData/ns15:feeRangeUpperValue"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractMarketingData/ns15:feeRangeUpperValue"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">5H</xsl:attribute>
        <xsl:attribute name="sqlname">orderingProcedure</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(1000)</xsl:attribute>
        <xsl:value-of select="ns14:contractMarketingData/ns14:orderingProcedure"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractMarketingData/ns14:orderingProcedure"/>
        <xsl:value-of select="ns15:contractMarketingData/ns15:orderingProcedure"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractMarketingData/ns15:orderingProcedure"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">5J</xsl:attribute>
        <xsl:attribute name="sqlname">feePaidForUseOfService</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:contractMarketingData/ns14:feePaidForUseOfService"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractMarketingData/ns14:feePaidForUseOfService"/>
        <xsl:value-of select="ns15:contractMarketingData/ns15:feePaidForUseOfService"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractMarketingData/ns15:feePaidForUseOfService"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">5K</xsl:attribute>
        <xsl:attribute name="sqlname">emailAddress</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(80)</xsl:attribute>
        <xsl:value-of select="ns14:contractMarketingData/ns14:emailAddress"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractMarketingData/ns14:emailAddress"/>
        <xsl:value-of select="ns15:contractMarketingData/ns15:emailAddress"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractMarketingData/ns15:emailAddress"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:contractInformation">
    <table cardinality="oto" sqlname="contractInformation">
      <column>
        <xsl:attribute name="elemNo">6A</xsl:attribute>
        <xsl:attribute name="sqlname">typeOfContractPricing</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:typeOfContractPricing"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:typeOfContractPricing"/>
        <xsl:value-of select="ns15:contractData/ns15:typeOfContractPricing"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:typeOfContractPricing"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6B</xsl:attribute>
        <xsl:attribute name="sqlname">undefinitizedAction</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:undefinitizedAction"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:undefinitizedAction"/>
        <xsl:value-of select="ns15:contractData/ns15:undefinitizedAction"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:undefinitizedAction"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6C</xsl:attribute>
        <xsl:attribute name="sqlname">multiYearContract</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:multiYearContract"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:multiYearContract"/>
        <xsl:value-of select="ns15:contractData/ns15:multiYearContract"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:multiYearContract"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6D</xsl:attribute>
        <xsl:attribute name="sqlname">typeOfIDC</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:typeOfIDC"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:typeOfIDC"/>
        <xsl:value-of select="ns15:contractData/ns15:typeOfIDC"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:typeOfIDC"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6E</xsl:attribute>
        <xsl:attribute name="sqlname">multipleOrSingleAwardIDC</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:multipleOrSingleAwardIDC"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:multipleOrSingleAwardIDC"/>
        <xsl:value-of select="ns15:contractData/ns15:multipleOrSingleAwardIDC"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:multipleOrSingleAwardIDC"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6F</xsl:attribute>
        <xsl:attribute name="sqlname">performanceBasedServiceContract</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:performanceBasedServiceContract"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:performanceBasedServiceContract"/>
        <xsl:value-of select="ns15:contractData/ns15:performanceBasedServiceContract"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:performanceBasedServiceContract"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6G</xsl:attribute>
        <xsl:attribute name="sqlname">majorProgramCode</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(100)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:majorProgramCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:majorProgramCode"/>
        <xsl:value-of select="ns15:contractData/ns15:majorProgramCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:majorProgramCode"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6H</xsl:attribute>
        <xsl:attribute name="sqlname">contingencyHumanitarianPeacekeepingOperation</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:contingencyHumanitarianPeacekeepingOperation"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:contingencyHumanitarianPeacekeepingOperation"/>
        <xsl:value-of select="ns15:contractData/ns15:contingencyHumanitarianPeacekeepingOperation"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:contingencyHumanitarianPeacekeepingOperation"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6J</xsl:attribute>
        <xsl:attribute name="sqlname">costOrPricingData</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:costOrPricingData"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:costOrPricingData"/>
        <xsl:value-of select="ns15:contractData/ns15:costOrPricingData"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:costOrPricingData"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6K</xsl:attribute>
        <xsl:attribute name="sqlname">contractFinancing</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:contractingFinancing"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:contractFinancing"/>
        <xsl:value-of select="ns15:contractData/ns15:contractingFinancing"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:contractFinancing"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6L</xsl:attribute>
        <xsl:attribute name="sqlname">costAccountingStandardsClause</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:costAccountingStandardsClause"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:costAccountingStandardsClause"/>
        <xsl:value-of select="ns15:contractData/ns15:costAccountingStandardsClause"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:costAccountingStandardsClause"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6M</xsl:attribute>
        <xsl:attribute name="sqlname">descriptionOfContractRequirement</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(4000)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:descriptionOfContractRequirement"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:descriptionOfContractRequirement"/>
        <xsl:value-of select="ns15:contractData/ns15:descriptionOfContractRequirement"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:descriptionOfContractRequirement"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6N</xsl:attribute>
        <xsl:attribute name="sqlname">purchaseCardAsPaymentMethod</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:purchaseCardAsPaymentMethod"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:purchaseCardAsPaymentMethod"/>
        <xsl:value-of select="ns15:contractData/ns15:purchaseCardAsPaymentMethod"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:purchaseCardAsPaymentMethod"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6Q</xsl:attribute>
        <xsl:attribute name="sqlname">numberOfActions</xsl:attribute>
        <xsl:attribute name="datatype">INTEGER</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:numberOfActions"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:numberOfActions"/>
        <xsl:value-of select="ns15:contractData/ns15:numberOfActions"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:numberOfActions"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6R</xsl:attribute>
        <xsl:attribute name="sqlname">nationalInterestActionCode</xsl:attribute>
        <xsl:attribute name="datatype">CHAR(4)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:nationalInterestActionCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:nationalInterestActionCode"/>
        <xsl:value-of select="ns15:contractData/ns15:nationalInterestActionCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:nationalInterestActionCode"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">6T</xsl:attribute>
        <xsl:attribute name="sqlname">inherentlyGovernmentalFunction</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(1000)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:inherentlyGovernmentalFunction"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:inherentlyGovernmentalFunction"/>
        <xsl:value-of select="ns15:contractData/ns15:inherentlyGovernmentalFunction"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:inherentlyGovernmentalFunction"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:treasuryAccount">
    <xsl:for-each select="ns14:contractData/ns14:listOfTreasuryAccounts/ns14:treasuryAccount">
      <table cardinality="otm" sqlname="treasuryAccount">
        <column>
          <xsl:attribute name="elemNo">6SC</xsl:attribute>
          <xsl:attribute name="sqlname">agencyIdentifier</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:agencyIdentifier"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:agencyIdentifier"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SG</xsl:attribute>
          <xsl:attribute name="sqlname">mainAccountCode</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:mainAccountCode"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:mainAccountCode"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SH</xsl:attribute>
          <xsl:attribute name="sqlname">subAccountCode</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(3)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:subAccountCode"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:subAccountCode"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SI</xsl:attribute>
          <xsl:attribute name="sqlname">initiative</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
          <xsl:value-of select="ns14:initiative"/>
          <xsl:value-of select="ns15:initiative"/>
        </column>
      </table>
    </xsl:for-each>
    <xsl:for-each select="ns15:contractData/ns15:listOfTreasuryAccounts/ns15:treasuryAccount">
      <table cardinality="otm" sqlname="treasuryAccount">
        <column>
          <xsl:attribute name="elemNo">6SC</xsl:attribute>
          <xsl:attribute name="sqlname">agencyIdentifier</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:agencyIdentifier"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:agencyIdentifier"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SG</xsl:attribute>
          <xsl:attribute name="sqlname">mainAccountCode</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:mainAccountCode"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:mainAccountCode"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SH</xsl:attribute>
          <xsl:attribute name="sqlname">subAccountCode</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(3)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:subAccountCode"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:subAccountCode"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SI</xsl:attribute>
          <xsl:attribute name="sqlname">initiative</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
          <xsl:value-of select="ns14:initiative"/>
          <xsl:value-of select="ns15:initiative"/>
        </column>
      </table>
    </xsl:for-each>
    <xsl:for-each select="ns14:contractDetail/ns14:contractData/ns14:listOfTreasuryAccounts/ns14:treasuryAccount">
      <table cardinality="otm" sqlname="treasuryAccount">
        <column>
          <xsl:attribute name="elemNo">6SC</xsl:attribute>
          <xsl:attribute name="sqlname">agencyIdentifier</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:agencyIdentifier"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:agencyIdentifier"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SG</xsl:attribute>
          <xsl:attribute name="sqlname">mainAccountCode</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:mainAccountCode"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:mainAccountCode"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SH</xsl:attribute>
          <xsl:attribute name="sqlname">subAccountCode</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(3)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:subAccountCode"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:subAccountCode"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SI</xsl:attribute>
          <xsl:attribute name="sqlname">initiative</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
          <xsl:value-of select="ns14:initiative"/>
          <xsl:value-of select="ns15:initiative"/>
        </column>
      </table>
    </xsl:for-each>
    <xsl:for-each select="ns15:contractDetail/ns15:contractData/ns15:listOfTreasuryAccounts/ns15:treasuryAccount">
      <table cardinality="otm" sqlname="treasuryAccount">
        <column>
          <xsl:attribute name="elemNo">6SC</xsl:attribute>
          <xsl:attribute name="sqlname">agencyIdentifier</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:agencyIdentifier"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:agencyIdentifier"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SG</xsl:attribute>
          <xsl:attribute name="sqlname">mainAccountCode</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:mainAccountCode"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:mainAccountCode"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SH</xsl:attribute>
          <xsl:attribute name="sqlname">subAccountCode</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(3)</xsl:attribute>
          <xsl:value-of select="ns14:treasureAccountSymbol/ns14:subAccountCode"/>
          <xsl:value-of select="ns15:treasureAccountSymbol/ns15:subAccountCode"/>
        </column>
        <column>
          <xsl:attribute name="elemNo">6SI</xsl:attribute>
          <xsl:attribute name="sqlname">initiative</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
          <xsl:value-of select="ns14:initiative"/>
          <xsl:value-of select="ns15:initiative"/>
        </column>
      </table>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ns15:legislativeMandates">
    <table cardinality="oto" sqlname="legislativeMandates">
      <column>
        <xsl:attribute name="elemNo">7A</xsl:attribute>
        <xsl:attribute name="sqlname">ClingerCohenAct</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:legislativeMandates/ns14:ClingerCohenAct"/>
        <xsl:value-of select="ns14:contractDetail/ns14:legislativeMandates/ns14:ClingerCohenAct"/>
        <xsl:value-of select="ns15:legislativeMandates/ns15:ClingerCohenAct"/>
        <xsl:value-of select="ns15:contractDetail/ns15:legislativeMandates/ns15:ClingerCohenAct"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">7B</xsl:attribute>
        <xsl:attribute name="sqlname">materialsSuppliesArticlesEquipment</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:legislativeMandates/ns14:materialsSuppliesArticlesEquipment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:legislativeMandates/ns14:materialsSuppliesArticlesEquipment"/>
        <xsl:value-of select="ns15:legislativeMandates/ns15:materialsSuppliesArticlesEquipment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:legislativeMandates/ns15:materialsSuppliesArticlesEquipment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">7C</xsl:attribute>
        <xsl:attribute name="sqlname">laborStandards</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:legislativeMandates/ns14:laborStandards"/>
        <xsl:value-of select="ns14:contractDetail/ns14:legislativeMandates/ns14:laborStandards"/>
        <xsl:value-of select="ns15:legislativeMandates/ns15:laborStandards"/>
        <xsl:value-of select="ns15:contractDetail/ns15:legislativeMandates/ns15:laborStandards"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">7D</xsl:attribute>
        <xsl:attribute name="sqlname">constructionWageRateRequirements</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:legislativeMandates/ns14:constructionWageRateRequirements"/>
        <xsl:value-of select="ns14:contractDetail/ns14:legislativeMandates/ns14:constructionWageRateRequirements"/>
        <xsl:value-of select="ns15:legislativeMandates/ns15:constructionWageRateRequirements"/>
        <xsl:value-of select="ns15:contractDetail/ns15:legislativeMandates/ns15:constructionWageRateRequirements"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">7E</xsl:attribute>
        <xsl:attribute name="sqlname">interagencyContractingAuthority</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:legislativeMandates/ns14:interagencyContractingAuthority"/>
        <xsl:value-of select="ns14:contractDetail/ns14:legislativeMandates/ns14:interagencyContractingAuthority"/>
        <xsl:value-of select="ns15:legislativeMandates/ns15:interagencyContractingAuthority"/>
        <xsl:value-of select="ns15:contractDetail/ns15:legislativeMandates/ns15:interagencyContractingAuthority"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">7F</xsl:attribute>
        <xsl:attribute name="sqlname">otherStatutoryAuthority</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(1000)</xsl:attribute>
        <xsl:value-of select="ns14:legislativeMandates/ns14:otherStatutoryAuthority"/>
        <xsl:value-of select="ns14:contractDetail/ns14:legislativeMandates/ns14:otherStatutoryAuthority"/>
        <xsl:value-of select="ns15:legislativeMandates/ns15:otherStatutoryAuthority"/>
        <xsl:value-of select="ns15:contractDetail/ns15:legislativeMandates/ns15:otherStatutoryAuthority"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:additionalReporting">
    <xsl:for-each select="ns14:legislativeMandates/ns14:listOfAdditionalReportingValues/ns14:additionalReportingValue">
      <table cardinality="otm" sqlname="additionalReporting">
        <column>
          <xsl:attribute name="elemNo">7G</xsl:attribute>
          <xsl:attribute name="sqlname">additionalReportingValue</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(10)</xsl:attribute>
          <xsl:value-of select="."/>
        </column>
      </table>
    </xsl:for-each>
    <xsl:for-each select="ns15:legislativeMandates/ns15:listOfAdditionalReportingValues/ns15:additionalReportingValue">
      <table cardinality="otm" sqlname="additionalReporting">
        <column>
          <xsl:attribute name="elemNo">7G</xsl:attribute>
          <xsl:attribute name="sqlname">additionalReportingValue</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(10)</xsl:attribute>
          <xsl:value-of select="."/>
        </column>
      </table>
    </xsl:for-each>
    <xsl:for-each select="ns14:contractDetail/ns14:legislativeMandates/ns14:listOfAdditionalReportingValues/ns14:additionalReportingValue">
      <table cardinality="otm" sqlname="additionalReporting">
        <column>
          <xsl:attribute name="elemNo">7G</xsl:attribute>
          <xsl:attribute name="sqlname">additionalReportingValue</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(10)</xsl:attribute>
          <xsl:value-of select="."/>
        </column>
      </table>
    </xsl:for-each>
    <xsl:for-each select="ns15:contractDetail/ns15:legislativeMandates/ns15:listOfAdditionalReportingValues/ns15:additionalReportingValue">
      <table cardinality="otm" sqlname="additionalReporting">
        <column>
          <xsl:attribute name="elemNo">7G</xsl:attribute>
          <xsl:attribute name="sqlname">additionalReportingValue</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(10)</xsl:attribute>
          <xsl:value-of select="."/>
        </column>
      </table>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ns15:productOrServiceInformation">
    <table cardinality="oto" sqlname="productOrServiceInformation">
      <column>
        <xsl:attribute name="elemNo">8A</xsl:attribute>
        <xsl:attribute name="sqlname">productOrServiceCode</xsl:attribute>
        <xsl:attribute name="datatype">CHAR(4)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:productOrServiceCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:productOrServiceCode"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:productOrServiceCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:productOrServiceCode"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8B</xsl:attribute>
        <xsl:attribute name="sqlname">systemEquipmentCode</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(4)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:systemEquipmentCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:systemEquipmentCode"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:systemEquipmentCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:systemEquipmentCode"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8C</xsl:attribute>
        <xsl:attribute name="sqlname">productServiceDescription</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(100)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:productServiceDescription"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:productServiceDescription"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:productServiceDescription"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:productServiceDescription"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8F</xsl:attribute>
        <xsl:attribute name="sqlname">claimantProgramCode</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(3)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:claimantProgramCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:claimantProgramCode"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:claimantProgramCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:claimantProgramCode"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8G</xsl:attribute>
        <xsl:attribute name="sqlname">principalNAICSCode</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(6)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:principalNAICSCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:principalNAICSCode"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:principalNAICSCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:principalNAICSCode"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8H</xsl:attribute>
        <xsl:attribute name="sqlname">informationTechnologyCommercialItemCategory</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:informationTechnologyCommercialItemCategory"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:informationTechnologyCommercialItemCategory"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:informationTechnologyCommercialItemCategory"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:informationTechnologyCommercialItemCategory"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8J</xsl:attribute>
        <xsl:attribute name="sqlname">GFE_GFP</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:GFE-GFP"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:GFE-GFP"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:GFE-GFP"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:GFE-GFP"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8K</xsl:attribute>
        <xsl:attribute name="sqlname">useOfEPADesignatedProducts</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:useOfEPADesignatedProducts"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:useOfEPADesignatedProducts"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:useOfEPADesignatedProducts"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:useOfEPADesignatedProducts"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8L</xsl:attribute>
        <xsl:attribute name="sqlname">recoveredMaterialClauses</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:recoveredMaterialClauses"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:recoveredMaterialClauses"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:recoveredMaterialClauses"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:recoveredMaterialClauses"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8M</xsl:attribute>
        <xsl:attribute name="sqlname">seaTransportation</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:seaTransportation"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:seaTransportation"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:seaTransportation"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:seaTransportation"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8N</xsl:attribute>
        <xsl:attribute name="sqlname">contractBundling</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:contractBundling"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:contractBundling"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:contractBundling"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:contractBundling"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8P</xsl:attribute>
        <xsl:attribute name="sqlname">consolidatedContract</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:consolidatedContract"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:consolidatedContract"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:consolidatedContract"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:consolidatedContract"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">8Q</xsl:attribute>
        <xsl:attribute name="sqlname">manufacturingOrganizationType</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:manufacturingOrganizationType"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:manufacturingOrganizationType"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:manufacturingOrganizationType"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:manufacturingOrganizationType"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:contractorDataA">
    <table cardinality="oto" sqlname="contractorDataA">
      <column>
        <xsl:attribute name="elemNo">9A</xsl:attribute>
        <xsl:attribute name="sqlname">DUNSNumber</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(9)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorDUNSInformation/ns14:DUNSNumber"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorDUNSInformation/ns14:DUNSNumber"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorDUNSInformation/ns15:DUNSNumber"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorDUNSInformation/ns15:DUNSNumber"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">9C</xsl:attribute>
        <xsl:attribute name="sqlname">locationCodeStateCodeCountryCode</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(1000)</xsl:attribute>
        <xsl:variable name="locationCode">
          <xsl:value-of select="ns14:vendor/ns14:principalPlaceOfPerformance/ns14:locationCode"/>
          <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:principalPlaceOfPerformance/ns14:locationCode"/>
          <xsl:value-of select="ns15:vendor/ns15:principalPlaceOfPerformance/ns15:locationCode"/>
          <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:principalPlaceOfPerformance/ns15:locationCode"/>
        </xsl:variable>
        <xsl:variable name="stateCode">
          <xsl:value-of select="ns14:vendor/ns14:principalPlaceOfPerformance/ns14:stateCode"/>
          <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:principalPlaceOfPerformance/ns14:stateCode"/>
          <xsl:value-of select="ns15:vendor/ns15:principalPlaceOfPerformance/ns15:stateCode"/>
          <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:principalPlaceOfPerformance/ns15:stateCode"/>
        </xsl:variable>
        <xsl:variable name="countryCode">
          <xsl:value-of select="ns14:vendor/ns14:principalPlaceOfPerformance/ns14:countryCode"/>
          <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:principalPlaceOfPerformance/ns14:countryCode"/>
          <xsl:value-of select="ns15:vendor/ns15:principalPlaceOfPerformance/ns15:countryCode"/>
          <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:principalPlaceOfPerformance/ns15:countryCode"/>
        </xsl:variable>
        <!-- XSLT 2.0: <xsl:value-of select="string-join(($locationCode, $stateCode, $countryCode)[. != ''],' ')"/> -->
        <xsl:choose>
          <xsl:when test="$locationCode != '' and $stateCode !='' and $countryCode !=''">
            <xsl:value-of select="concat($locationCode, ', ', $stateCode, ', ', $countryCode)"/>
          </xsl:when>
          <xsl:when test="$locationCode != '' and $stateCode !=''">
            <xsl:value-of select="concat($locationCode, ', ', $stateCode)"/>
          </xsl:when>
          <xsl:when test="$locationCode != '' and $countryCode !=''">
            <xsl:value-of select="concat($locationCode, ', ', $countryCode)"/>
          </xsl:when>
          <xsl:when test="$stateCode != '' and $countryCode !=''">
            <xsl:value-of select="concat($stateCode, ', ', $countryCode)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($locationCode, $stateCode, $countryCode)"/>
          </xsl:otherwise>
        </xsl:choose>
      </column>
      <column>
        <xsl:attribute name="elemNo">9D</xsl:attribute>
        <xsl:attribute name="sqlname">principalPlaceOfPerformanceName</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(100)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:principalPlaceOfPerformance/ns14:placeOfPerformanceName"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:principalPlaceOfPerformance/ns14:placeOfPerformanceName"/>
        <xsl:value-of select="ns15:vendor/ns15:principalPlaceOfPerformance/ns15:placeOfPerformanceName"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:principalPlaceOfPerformance/ns15:placeOfPerformanceName"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">9E</xsl:attribute>
        <xsl:attribute name="sqlname">countryOfOrigin</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(3)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:countryOfOrigin"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:countryOfOrigin"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:countryOfOrigin"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:countryOfOrigin"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">9F</xsl:attribute>
        <xsl:attribute name="sqlname">congressionalDistrictContractor</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:congressionalDistrictCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:congressionalDistrictCode"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:congressionalDistrictCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:congressionalDistrictCode"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">9G</xsl:attribute>
        <xsl:attribute name="sqlname">congressionalDistrict</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
        <xsl:value-of select="ns14:placeOfPerformance/ns14:placeOfPerformanceCongressionalDistrict"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:placeOfPerformance/ns14:placeOfPerformanceCongressionalDistrict"/>
        <xsl:value-of select="ns15:placeOfPerformance/ns15:placeOfPerformanceCongressionalDistrict"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:placeOfPerformance/ns15:placeOfPerformanceCongressionalDistrict"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">9H</xsl:attribute>
        <xsl:attribute name="sqlname">placeOfManufacture</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:productOrServiceInformation/ns14:placeOfManufacture"/>
        <xsl:value-of select="ns14:contractDetail/ns14:productOrServiceInformation/ns14:placeOfManufacture"/>
        <xsl:value-of select="ns15:productOrServiceInformation/ns15:placeOfManufacture"/>
        <xsl:value-of select="ns15:contractDetail/ns15:productOrServiceInformation/ns15:placeOfManufacture"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">9J</xsl:attribute>
        <xsl:attribute name="sqlname">CCRException</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:CCRException"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:CCRException"/>
        <xsl:value-of select="ns15:vendor/ns15:CCRException"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:CCRException"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">9K</xsl:attribute>
        <xsl:attribute name="sqlname">placeOfPerformanceZIPCode</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(10)</xsl:attribute>
        <xsl:value-of select="ns14:placeOfPerformance/ns14:placeOfPerformanceZIPCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:placeOfPerformance/ns14:placeOfPerformanceZIPCode"/>
        <xsl:value-of select="ns15:placeOfPerformance/ns15:placeOfPerformanceZIPCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:placeOfPerformance/ns15:placeOfPerformanceZIPCode"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">9L</xsl:attribute>
        <xsl:attribute name="sqlname">cageCode</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(5)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorDUNSInformation/ns14:cageCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorDUNSInformation/ns14:cageCode"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorDUNSInformation/ns15:cageCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorDUNSInformation/ns15:cageCode"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:competitionInformation">
    <table cardinality="oto" sqlname="competitionInformation">
      <column>
        <xsl:attribute name="elemNo">10A</xsl:attribute>
        <xsl:attribute name="sqlname">extentCompeted</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(3)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:extentCompeted"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:extentCompeted"/>
        <xsl:value-of select="ns15:competition/ns15:extentCompeted"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:extentCompeted"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10C</xsl:attribute>
        <xsl:attribute name="sqlname">reasonNotCompeted</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(3)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:reasonNotCompeted"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:reasonNotCompeted"/>
        <xsl:value-of select="ns15:competition/ns15:reasonNotCompeted"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:reasonNotCompeted"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10D</xsl:attribute>
        <xsl:attribute name="sqlname">numberOfOffersReceived</xsl:attribute>
        <xsl:attribute name="datatype">INTEGER</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:numberOfOffersReceived"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:numberOfOffersReceived"/>
        <xsl:value-of select="ns15:competition/ns15:numberOfOffersReceived"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:numberOfOffersReceived"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10H</xsl:attribute>
        <xsl:attribute name="sqlname">commercialItemAcquisitionProcedures</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:commercialItemAcquisitionProcedures"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:commercialItemAcquisitionProcedures"/>
        <xsl:value-of select="ns15:competition/ns15:commercialItemAcquisitionProcedures"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:commercialItemAcquisitionProcedures"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10J</xsl:attribute>
        <xsl:attribute name="sqlname">commercialItemTestProgram</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:commercialItemTestProgram"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:commercialItemTestProgram"/>
        <xsl:value-of select="ns15:competition/ns15:commercialItemTestProgram"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:commercialItemTestProgram"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10K</xsl:attribute>
        <xsl:attribute name="sqlname">smallBusinessCompetitivenessDemonstrationProgram</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:smallBusinessCompetitivenessDemonstrationProgram"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:smallBusinessCompetitivenessDemonstrationProgram"/>
        <xsl:value-of select="ns15:competition/ns15:smallBusinessCompetitivenessDemonstrationProgram"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:smallBusinessCompetitivenessDemonstrationProgram"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10L</xsl:attribute>
        <xsl:attribute name="sqlname">A76Action</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:A76Action"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:A76Action"/>
        <xsl:value-of select="ns15:competition/ns15:A76Action"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:A76Action"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10M</xsl:attribute>
        <xsl:attribute name="sqlname">solicitationProcedures</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(5)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:solicitationProcedures"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:solicitationProcedures"/>
        <xsl:value-of select="ns15:competition/ns15:solicitationProcedures"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:solicitationProcedures"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10N</xsl:attribute>
        <xsl:attribute name="sqlname">typeOfSetAside</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(10)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:typeOfSetAside"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:typeOfSetAside"/>
        <xsl:value-of select="ns15:competition/ns15:typeOfSetAside"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:typeOfSetAside"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10P</xsl:attribute>
        <xsl:attribute name="sqlname">evaluatedPreference</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(6)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:evaluatedPreference"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:evaluatedPreference"/>
        <xsl:value-of select="ns15:competition/ns15:evaluatedPreference"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:evaluatedPreference"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10Q</xsl:attribute>
        <xsl:attribute name="sqlname">research</xsl:attribute>
        <xsl:attribute name="datatype">CHAR(3)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:research"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:research"/>
        <xsl:value-of select="ns15:competition/ns15:research"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:research"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10R</xsl:attribute>
        <xsl:attribute name="sqlname">statutoryExceptionToFairOpportunity</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(4)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:statutoryExceptionToFairOpportunity"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:statutoryExceptionToFairOpportunity"/>
        <xsl:value-of select="ns15:competition/ns15:statutoryExceptionToFairOpportunity"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:statutoryExceptionToFairOpportunity"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10S</xsl:attribute>
        <xsl:attribute name="sqlname">fedBizOpps</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:fedBizOpps"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:fedBizOpps"/>
        <xsl:value-of select="ns15:competition/ns15:fedBizOpps"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:fedBizOpps"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10T</xsl:attribute>
        <xsl:attribute name="sqlname">nonTraditionalGovernmentContractorParticipation</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(3)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:nonTraditionalGovernmentContractorParticipation"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:nonTraditionalGovernmentContractorParticipation"/>
        <xsl:value-of select="ns15:competition/ns15:nonTraditionalGovernmentContractorParticipation"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:nonTraditionalGovernmentContractorParticipation"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">10U</xsl:attribute>
        <xsl:attribute name="sqlname">localAreaSetAside</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:variable name="localAreaSetAside">
          <xsl:value-of select="ns14:competition/ns14:localAreaSetAside"/>
          <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:localAreaSetAside"/>
          <xsl:value-of select="ns15:competition/ns15:localAreaSetAside"/>
          <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:localAreaSetAside"/>
        </xsl:variable>
        <!-- 'BSDF' values can still be found in DHS data under LASA element but exceed CHAR(1); ref SPR# FPDSHD-64205 at https://www.fpds.gov/wiki/index.php/V1.4_SP12.0 -->
        <xsl:choose>
          <xsl:when test="$localAreaSetAside='BSDF'"/>
          <xsl:otherwise>
            <xsl:value-of select="$localAreaSetAside"/>
          </xsl:otherwise>
        </xsl:choose>
      </column>
      <column>
        <xsl:attribute name="elemNo">OT8C</xsl:attribute>
        <xsl:attribute name="sqlname">typeOfAgreement</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(64)</xsl:attribute>
        <xsl:value-of select="ns14:competition/ns14:typeOfAgreeement"/>
        <xsl:value-of select="ns14:contractDetail/ns14:competition/ns14:typeOfAgreement"/>
        <xsl:value-of select="ns15:competition/ns15:typeOfAgreeement"/>
        <xsl:value-of select="ns15:contractDetail/ns15:competition/ns15:typeOfAgreement"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:preferencePrograms">
    <table cardinality="oto" sqlname="preferencePrograms">
      <column>
        <xsl:attribute name="elemNo">11A</xsl:attribute>
        <xsl:attribute name="sqlname">contractingOfficerBusinessSizeDetermination</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:contractingOfficerBusinessSizeDetermination"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:contractingOfficerBusinessSizeDetermination"/>
        <xsl:value-of select="ns15:vendor/ns15:contractingOfficerBusinessSizeDetermination"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:contractingOfficerBusinessSizeDetermination"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">11B</xsl:attribute>
        <xsl:attribute name="sqlname">subcontractPlan</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:subcontractPlan"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:subcontractPlan"/>
        <xsl:value-of select="ns15:vendor/ns15:subcontractPlan"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:subcontractPlan"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">11C</xsl:attribute>
        <xsl:attribute name="sqlname">priceEvaluationPercentDifference</xsl:attribute>
        <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:priceEvaluationPercentDifference"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:priceEvaluationPercentDifference"/>
        <xsl:value-of select="ns15:vendor/ns15:priceEvaluationPercentDifference"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:priceEvaluationPercentDifference"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:transactionInformation">
    <table cardinality="oto" sqlname="transactionInformation">
      <column>
        <xsl:attribute name="elemNo">12B</xsl:attribute>
        <xsl:attribute name="sqlname">contractActionType</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:contractActionType"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:contractActionType"/>
        <xsl:value-of select="ns15:contractData/ns15:contractActionType"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:contractActionType"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">12C</xsl:attribute>
        <xsl:attribute name="sqlname">reasonForModification</xsl:attribute>
        <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
        <xsl:value-of select="ns14:contractData/ns14:reasonForModification"/>
        <xsl:value-of select="ns14:contractDetail/ns14:contractData/ns14:reasonForModification"/>
        <xsl:value-of select="ns15:contractData/ns15:reasonForModification"/>
        <xsl:value-of select="ns15:contractDetail/ns15:contractData/ns15:reasonForModification"/>
      </column>
    </table>
  </xsl:template>
  <xsl:template name="ns15:contractorDataB">
    <table cardinality="oto" sqlname="contractorDataB">
      <column>
        <xsl:attribute name="elemNo">13I</xsl:attribute>
        <xsl:attribute name="sqlname">isLocalGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isLocalGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isLocalGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isLocalGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isLocalGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13IA</xsl:attribute>
        <xsl:attribute name="sqlname">isCityLocalGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isCityLocalGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isCityLocalGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isCityLocalGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isCityLocalGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13IB</xsl:attribute>
        <xsl:attribute name="sqlname">isCountyLocalGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isCountyLocalGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isCountyLocalGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isCountyLocalGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isCountyLocalGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13IC</xsl:attribute>
        <xsl:attribute name="sqlname">isInterMunicipalLocalGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isInterMunicipalLocalGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isInterMunicipalLocalGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isInterMunicipalLocalGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isInterMunicipalLocalGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13ID</xsl:attribute>
        <xsl:attribute name="sqlname">isLocalGovernmentOwned</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isLocalGovernmentOwned"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isLocalGovernmentOwned"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isLocalGovernmentOwned"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isLocalGovernmentOwned"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13IE</xsl:attribute>
        <xsl:attribute name="sqlname">isMunicipalityLocalGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isMunicipalityLocalGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isMunicipalityLocalGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isMunicipalityLocalGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isMunicipalityLocalGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13IF</xsl:attribute>
        <xsl:attribute name="sqlname">isSchoolDistrictLocalGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isSchoolDistrictLocalGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isSchoolDistrictLocalGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isSchoolDistrictLocalGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isSchoolDistrictLocalGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13IG</xsl:attribute>
        <xsl:attribute name="sqlname">isTownshipLocalGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isTownshipLocalGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:localGovernment/ns14:isTownshipLocalGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isTownshipLocalGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:localGovernment/ns15:isTownshipLocalGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13J</xsl:attribute>
        <xsl:attribute name="sqlname">isStateGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:isStateGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:isStateGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:isStateGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:isStateGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13K</xsl:attribute>
        <xsl:attribute name="sqlname">isFederalGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:federalGovernment/ns14:isFederalGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:federalGovernment/ns14:isFederalGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:federalGovernment/ns15:isFederalGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:federalGovernment/ns15:isFederalGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13KA</xsl:attribute>
        <xsl:attribute name="sqlname">isFederalGovernmentAgency</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:federalGovernment/ns14:isFederalGovernmentAgency"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:federalGovernment/ns14:isFederalGovernmentAgency"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:federalGovernment/ns15:isFederalGovernmentAgency"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:federalGovernment/ns15:isFederalGovernmentAgency"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13KB</xsl:attribute>
        <xsl:attribute name="sqlname">isFederallyFundedResearchAndDevelopmentCorp</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:federalGovernment/ns14:isFederallyFundedResearchAndDevelopmentCorp"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:federalGovernment/ns14:isFederallyFundedResearchAndDevelopmentCorp"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:federalGovernment/ns15:isFederallyFundedResearchAndDevelopmentCorp"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:federalGovernment/ns15:isFederallyFundedResearchAndDevelopmentCorp"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13L</xsl:attribute>
        <xsl:attribute name="sqlname">isTribalGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:isTribalGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:isTribalGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:isTribalGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:isTribalGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LA</xsl:attribute>
        <xsl:attribute name="sqlname">isForeignGovernment</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:isForeignGovernment"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:isForeignGovernment"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:isForeignGovernment"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:isForeignGovernment"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LB</xsl:attribute>
        <xsl:attribute name="sqlname">isCommunityDevelopedCorporationOwnedFirm</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:isCommunityDevelopedCorporationOwnedFirm"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:isCommunityDevelopedCorporationOwnedFirm"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:isCommunityDevelopedCorporationOwnedFirm"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:isCommunityDevelopedCorporationOwnedFirm"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LC</xsl:attribute>
        <xsl:attribute name="sqlname">isLaborSurplusAreaFirm</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:isLaborSurplusAreaFirm"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:isLaborSurplusAreaFirm"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:isLaborSurplusAreaFirm"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:isLaborSurplusAreaFirm"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LD</xsl:attribute>
        <xsl:attribute name="sqlname">isCorporateEntityNotTaxExempt</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isCorporateEntityNotTaxExempt"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isCorporateEntityNotTaxExempt"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isCorporateEntityNotTaxExempt"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isCorporateEntityNotTaxExempt"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LE</xsl:attribute>
        <xsl:attribute name="sqlname">isCorporateEntityTaxExempt</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isCorporateEntityTaxExempt"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isCorporateEntityTaxExempt"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isCorporateEntityTaxExempt"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isCorporateEntityTaxExempt"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LF</xsl:attribute>
        <xsl:attribute name="sqlname">isPartnershipOrLimitedLiabilityPartnership</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isPartnershipOrLimitedLiabilityPartnership"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isPartnershipOrLimitedLiabilityPartnership"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isPartnershipOrLimitedLiabilityPartnership"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isPartnershipOrLimitedLiabilityPartnership"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LG</xsl:attribute>
        <xsl:attribute name="sqlname">isSoleProprietorship</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isSoleProprietorship"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isSoleProprietorship"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isSoleProprietorship"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isSoleProprietorship"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LH</xsl:attribute>
        <xsl:attribute name="sqlname">isSmallAgriculturalCooperative</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isSmallAgriculturalCooperative"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isSmallAgricultureCooperative"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isSmallAgriculturalCooperative"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isSmallAgricultureCooperative"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LI</xsl:attribute>
        <xsl:attribute name="sqlname">isInternationalOrganization</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isInternationalOrganization"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isInternationalOrganization"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isInternationalOrganization"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isInternationalOrganization"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LJ</xsl:attribute>
        <xsl:attribute name="sqlname">isUSGovernmentEntity</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isUSGovernmentEntity"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorBusinessTypes/ns14:businessOrOrganizationType/ns14:isUSGovernmentEntity"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isUSGovernmentEntity"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorBusinessTypes/ns15:businessOrOrganizationType/ns15:isUSGovernmentEntity"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13M</xsl:attribute>
        <xsl:attribute name="sqlname">isVerySmallBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isVerySmallBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isVerySmallBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isVerySmallBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isVerySmallBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13N</xsl:attribute>
        <xsl:attribute name="sqlname">isSBACertified8AProgramParticipant</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isSBACertified8AProgramParticipant"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isSBACertified8AProgramParticipant"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isSBACertified8AProgramParticipant"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isSBACertified8AProgramParticipant"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13NA</xsl:attribute>
        <xsl:attribute name="sqlname">isSBACertified8AJointVenture</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isSBACertified8AJointVenture"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isSBACertified8AJointVenture"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isSBACertified8AJointVenture"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isSBACertified8AJointVenture"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13NB</xsl:attribute>
        <xsl:attribute name="sqlname">isDOTCertifiedDisadvantagedBusinessEnterprise</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isDOTCertifiedDisadvantagedBusinessEnterprise"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isDOTCertifiedBusinessEnterprise"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isDOTCertifiedDisadvantagedBusinessEnterprise"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isDOTCertifiedBusinessEnterprise"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13NC</xsl:attribute>
        <xsl:attribute name="sqlname">isSelfCertifiedSmallDisadvantagedBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isSelfCertifiedSmallDisadvantagedBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isSelfCertifiedSmallCertifiedBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isSelfCertifiedSmallDisadvantagedBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isSelfCertifiedSmallCertifiedBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13O</xsl:attribute>
        <xsl:attribute name="sqlname">isSBACertifiedHUBZone</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isSBACertifiedHUBZone"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isSBACertifiedHUBZone"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isSBACertifiedHUBZone"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isSBACertifiedHUBZone"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13P</xsl:attribute>
        <xsl:attribute name="sqlname">isSBACertifiedSmallDisadvantagedBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isSBACertifiedSmallDisadvantedBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorCertifications/ns14:isSBACertifiedSmallDisadvantagedBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isSBACertifiedSmallDisadvantedBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorCertifications/ns15:isSBACertifiedSmallDisadvantagedBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13Q</xsl:attribute>
        <xsl:attribute name="sqlname">isShelteredWorkshop</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:isShelteredWorkshop"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:isShelteredWorkshop"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:isShelteredWorkshop"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:isShelteredWorkshop"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13R</xsl:attribute>
        <xsl:attribute name="sqlname">isHistoricallyBlackCollegeOrUniversity</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isHistoricallyBlackCollegeOrUniversity"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isHistoricallyBlackCollegeOrUniversity"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isHistoricallyBlackCollegeOrUniversity"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isHistoricallyBlackCollegeOrUniversity"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13RA</xsl:attribute>
        <xsl:attribute name="sqlname">is1862LandGrantCollege</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:is1862LandGrantCollege"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:is1862LandGrantCollege"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:is1862LandGrantCollege"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:is1862LandGrantCollege"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13RB</xsl:attribute>
        <xsl:attribute name="sqlname">is1890LandGrantCollege</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:is1890LandGrantCollege"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:is1890LandGrantCollege"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:is1890LandGrantCollege"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:is1890LandGrantCollege"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13RC</xsl:attribute>
        <xsl:attribute name="sqlname">is1994LandGrantCollege</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:is1994LandGrantCollege"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:is1994LandGrantCollege"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:is1994LandGrantCollege"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:is1994LandGrantCollege"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13S</xsl:attribute>
        <xsl:attribute name="sqlname">isMinorityInstitution</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isMinorityInstitution"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isMinorityInstitution"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isMinorityInstitution"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isMinorityInstitution"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13SA</xsl:attribute>
        <xsl:attribute name="sqlname">isPrivateUniversityOrCollege</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isPrivateUniversityOrCollege"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isPrivateUniversityOrCollege"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isPrivateUniversityOrCollege"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isPrivateUniversityOrCollege"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13SB</xsl:attribute>
        <xsl:attribute name="sqlname">isSchoolOfForestry</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isSchoolOfForestry"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isSchoolOfForestry"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isSchoolOfForestry"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isSchoolOfForestry"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13SC</xsl:attribute>
        <xsl:attribute name="sqlname">isStateControlledInstitutionOfHigherlearning</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isStateControlledInstitutionOfHigherLearning"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isStateControlledInstitutionOfHigherLearning"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isStateControlledInstitutionOfHigherLearning"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isStateControlledInstitutionOfHigherLearning"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13SD</xsl:attribute>
        <xsl:attribute name="sqlname">isTribalCollege</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isTribalCollege"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isTribalCollege"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isTribalCollege"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isTribalCollege"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13SE</xsl:attribute>
        <xsl:attribute name="sqlname">isVeterinaryCollege</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isVeterinaryCollege"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfEducationalEntity/ns14:isVeterinaryCollege"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isVeterinaryCollege"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfEducationalEntity/ns15:isVeterinaryCollege"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13T</xsl:attribute>
        <xsl:attribute name="sqlname">isEducationalInstitution</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isEducationalInstitution"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isEducationalInstitution"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isEducationalInstitution"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isEducationalInstitution"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13SF</xsl:attribute>
        <xsl:attribute name="sqlname">isAlaskanNativeServicingInstitution</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isAlaskanNativeServicingInstitution"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isAlaskanNativeServicingInstitution"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isAlaskanNativeServicingInstitution"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isAlaskanNativeServicingInstitution"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13TB</xsl:attribute>
        <xsl:attribute name="sqlname">isCommunityDevelopmentCorporation</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isCommunityDevelopmentCorporation"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isCommunityDevelopmentCorporation"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isCommunityDevelopmentCorporation"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isCommunityDevelopmentCorporation"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13SG</xsl:attribute>
        <xsl:attribute name="sqlname">isNativeHawaiianServicingInstitution</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isNativeHawaiianServicingInstitution"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isNativeHawaiianServicingInstitution"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isNativeHawaiianServicingInstitution"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isNativeHawaiianServicingInstitution"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13TD</xsl:attribute>
        <xsl:attribute name="sqlname">isDomesticShelter</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isDomesticShelter"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isDomesticShelter"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isDomesticShelter"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isDomesticShelter"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13TE</xsl:attribute>
        <xsl:attribute name="sqlname">isManufacturerOfGoods</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isManufacturerOfGoods"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isManufacturerOfGoods"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isManufacturerOfGoods"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isManufacturerOfGoods"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13VV</xsl:attribute>
        <xsl:attribute name="sqlname">isHospital</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isHospital"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isHospital"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isHospital"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isHospital"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13TH</xsl:attribute>
        <xsl:attribute name="sqlname">isVeterinaryHospital</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isVeterinaryHospital"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isVeterinaryHospital"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isVeterinaryHospital"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isVeterinaryHospital"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13TI</xsl:attribute>
        <xsl:attribute name="sqlname">isHispanicServicingInstitution</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isHispanicServicingInstitution"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isHispanicServicingInstitution"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isHispanicServicingInstitution"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isHispanicServicingInstitution"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13TJ</xsl:attribute>
        <xsl:attribute name="sqlname">isFoundation</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isFoundation"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLineOfBusiness/ns14:isFoundation"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isFoundation"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLineOfBusiness/ns15:isFoundation"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13U</xsl:attribute>
        <xsl:attribute name="sqlname">isWomenOwned</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isWomenOwned"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isWomenOwned"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isWomenOwned"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isWomenOwned"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13UA</xsl:attribute>
        <xsl:attribute name="sqlname">isMinorityOwned</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isMinorityOwned"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isMinorityOwned"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isMinorityOwned"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isMinorityOwned"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13UB</xsl:attribute>
        <xsl:attribute name="sqlname">isWomenOwnedSmallBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isWomenOwnedSmallBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13UC</xsl:attribute>
        <xsl:attribute name="sqlname">isEconomicallyDisadvantagedWomenOwnedSmallBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isEconomicallyDisadvantagedWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isEconomicallyDisadvantagedWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isEconomicallyDisadvantagedWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isEconomicallyDisadvantagedWomenOwnedSmallBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13UD</xsl:attribute>
        <xsl:attribute name="sqlname">isJointVentureWomenOwnedSmallBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isJointVentureWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isJointVentureWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isJointVentureWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isJointVentureWomenOwnedSmallBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13UE</xsl:attribute>
        <xsl:attribute name="sqlname">isJointVentureEconomicallyDisadvantagedWomenOwnedSmallBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isJointVentureEconomicallyDisadvantagedWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isJointVentureEconomicallyDisadvantagedWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isJointVentureEconomicallyDisadvantagedWomenOwnedSmallBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isJointVentureEconomicallyDisadvantagedWomenOwnedSmallBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13V</xsl:attribute>
        <xsl:attribute name="sqlname">isVeteranOwned</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isVeteranOwned"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isVeteranOwned"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isVeteranOwned"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isVeteranOwned"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13W</xsl:attribute>
        <xsl:attribute name="sqlname">isServiceRelatedDisabledVeteranOwnedBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isServiceRelatedDisabledVeteranOwnedBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isServiceRelatedDisabledVeteranOwnedBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isServiceRelatedDisabledVeteranOwnedBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isServiceRelatedDisabledVeteranOwnedBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13X</xsl:attribute>
        <xsl:attribute name="sqlname">receivesContracts</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorRelationshipWithFederalGovernment/ns14:receivesContracts"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorRelationshipWithFederalGovernment/ns14:receivesContracts"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorRelationshipWithFederalGovernment/ns15:receivesContracts"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorRelationshipWithFederalGovernment/ns15:receivesContracts"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XA</xsl:attribute>
        <xsl:attribute name="sqlname">receivesGrants</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorRelationshipWithFederalGovernment/ns14:receivesGrants"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorRelationshipWithFederalGovernment/ns14:receivesGrants"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorRelationshipWithFederalGovernment/ns15:receivesGrants"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorRelationshipWithFederalGovernment/ns15:receivesGrants"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XB</xsl:attribute>
        <xsl:attribute name="sqlname">receivesContractsAndGrants</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorRelationshipWithFederalGovernment/ns14:receivesContractsAndGrants"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorRelationshipWithFederalGovernment/ns14:receivesContractsAndGrants"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorRelationshipWithFederalGovernment/ns15:receivesContractsAndGrants"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorRelationshipWithFederalGovernment/ns15:receivesContractsAndGrants"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XC</xsl:attribute>
        <xsl:attribute name="sqlname">isAirportAuthority</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isAirportAuthority"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isAirportAuthority"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isAirportAuthority"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isAirportAuthority"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XD</xsl:attribute>
        <xsl:attribute name="sqlname">isCouncilOfGovernments</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isCouncilOfGovernments"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isCouncilOfGovernments"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isCouncilOfGovernments"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isCouncilOfGovernments"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XE</xsl:attribute>
        <xsl:attribute name="sqlname">isHousingAuthoritiesPublicOrTribal</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isHousingAuthoritiesPublicOrTribal"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isHousingAuthoritiesPublicOrTribal"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isHousingAuthoritiesPublicOrTribal"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isHousingAuthoritiesPublicOrTribal"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XF</xsl:attribute>
        <xsl:attribute name="sqlname">isInterstateEntity</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isInterstateEntity"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isInterstateEntity"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isInterstateEntity"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isInterstateEntity"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XG</xsl:attribute>
        <xsl:attribute name="sqlname">isPlanningCommission</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isPlanningCommission"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isPlanningCommission"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isPlanningCommission"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isPlanningCommission"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XH</xsl:attribute>
        <xsl:attribute name="sqlname">isPortAuthority</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isPortAuthority"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isPortAuthority"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isPortAuthority"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isPortAuthority"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XI</xsl:attribute>
        <xsl:attribute name="sqlname">isTransitAuthority</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isTransitAuthority"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:typeOfGovernmentEntity/ns14:isTransitAuthority"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isTransitAuthority"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:typeOfGovernmentEntity/ns15:isTransitAuthority"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XJ</xsl:attribute>
        <xsl:attribute name="sqlname">isSubchapterSCorporation</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:isSubchapterSCorporation"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:isSubchapterSCorporation"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:isSubchapterSCorporation"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:isSubchapterSCorporation"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XK</xsl:attribute>
        <xsl:attribute name="sqlname">isLimitedLiabilityCorporation</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:isLimitedLiabilityCorporation"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:isLimitedLiabilityCorporation"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:isLimitedLiabilityCorporation"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:isLimitedLiabilityCorporation"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13XL</xsl:attribute>
        <xsl:attribute name="sqlname">isForeignOwnedAndLocated</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:isForeignOwnedAndLocated"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:isForeignOwnedAndLocated"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:isForeignOwnedAndLocated"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:isForeignOwnedAndLocated"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13Y</xsl:attribute>
        <xsl:attribute name="sqlname">isAmericanIndianOwned</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isAmericanIndianOwned"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isAmericanIndianOwned"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isAmericanIndianOwned"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isAmericanIndianOwned"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13YA</xsl:attribute>
        <xsl:attribute name="sqlname">isAlaskanNativeOwnedCorporationOrFirm</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isAlaskanNativeOwnedCorporationOrFirm"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isAlaskanNativeOwnedCorporationOrFirm"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isAlaskanNativeOwnedCorporationOrFirm"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isAlaskanNativeOwnedCorporationOrFirm"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13YB</xsl:attribute>
        <xsl:attribute name="sqlname">isIndianTribe</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isIndianTribe"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isIndianTribe"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isIndianTribe"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isIndianTribe"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13YC</xsl:attribute>
        <xsl:attribute name="sqlname">isNativeHawaiianOwnedOrganizationOrFirm</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isNativeHawaiianOwnedOrganizationOrFirm"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isNativeHawaiianOwnedOrganizationOrFirm"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isNativeHawaiianOwnedOrganizationOrFirm"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isNativeHawaiianOwnedOrganizationOrFirm"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13YD</xsl:attribute>
        <xsl:attribute name="sqlname">isTriballyOwnedFirm</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isTriballyOwnedFirm"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:isTriballyOwnedFirm"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isTriballyOwnedFirm"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:isTriballyOwnedFirm"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13Z</xsl:attribute>
        <xsl:attribute name="sqlname">isAsianPacificAmericanOwnedBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isAsianPacificAmericanOwnedBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isAsianPacificAmericanOwnedBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isAsianPacificAmericanOwnedBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isAsianPacificAmericanOwnedBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13AA</xsl:attribute>
        <xsl:attribute name="sqlname">isBlackAmericanOwnedBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isBlackAmericanOwnedBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isBlackAmericanOwnedBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isBlackAmericanOwnedBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isBlackAmericanOwnedBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13BB</xsl:attribute>
        <xsl:attribute name="sqlname">isHispanicAmericanOwnedBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isHispanicAmericanOwnedBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isHispanicAmericanOwnedBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isHispanicAmericanOwnedBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isHispanicAmericanOwnedBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13CC</xsl:attribute>
        <xsl:attribute name="sqlname">isNativeAmericanOwnedBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isNativeAmericanOwnedBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isNativeAmericanOwnedBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isNativeAmericanOwnedBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isNativeAmericanOwnedBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13DD</xsl:attribute>
        <xsl:attribute name="sqlname">isSubcontinentAsianAmericanOwnedBusiness</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isSubcontinentAsianAmericanOwnedBusiness"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isSubcontinentAsianAmericanOwnedBusiness"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isSubcontinentAsianAmericanOwnedBusiness"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isSubcontinentAsianAmericanOwnedBusiness"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13DE</xsl:attribute>
        <xsl:attribute name="sqlname">isOtherMinorityOwned</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isOtherMinorityOwned"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorSocioEconomicIndicators/ns14:minorityOwned/ns14:isOtherMinorityOwned"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isOtherMinorityOwned"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorSocioEconomicIndicators/ns15:minorityOwned/ns15:isOtherMinorityOwned"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13EA</xsl:attribute>
        <xsl:attribute name="sqlname">isForProfitOrganization</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:profitStructure/ns14:isForProfitOrganization"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:profitStructure/ns14:isForProfitOrganization"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:profitStructure/ns15:isForProfitOrganization"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:profitStructure/ns15:isForProfitOrganization"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13EE</xsl:attribute>
        <xsl:attribute name="sqlname">isNonProfitOrganization</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:profitStructure/ns14:isNonProfitOrganization"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:profitStructure/ns14:isNonProfitOrganization"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:profitStructure/ns15:isNonProfitOrganization"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:profitStructure/ns15:isNonProfitOrganization"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13EF</xsl:attribute>
        <xsl:attribute name="sqlname">isOtherNotForProfitOrganization</xsl:attribute>
        <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:profitStructure/ns14:isOtherNotForProfitOrganization"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorOrganizationFactors/ns14:profitStructure/ns14:isOtherNotForProfitOrganization"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:profitStructure/ns15:isOtherNotForProfitOrganization"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorOrganizationFactors/ns15:profitStructure/ns15:isOtherNotForProfitOrganization"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13GG</xsl:attribute>
        <xsl:attribute name="sqlname">vendorName</xsl:attribute>
        <!-- is VARCHAR(100) in data dict v1.5 but longer entries exist -->
        <xsl:attribute name="datatype">VARCHAR(400)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorHeader/ns14:vendorName"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorHeader/ns14:vendorName"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorHeader/ns15:vendorName"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorHeader/ns15:vendorName"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13HH</xsl:attribute>
        <xsl:attribute name="sqlname">vendorDoingAsBusinessName</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(400)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorHeader/ns14:vendorDoingAsBusinessName"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorHeader/ns14:vendorDoingAsBusinessName"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorHeader/ns15:vendorDoingAsBusinessName"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorHeader/ns15:vendorDoingAsBusinessName"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13JJ</xsl:attribute>
        <xsl:attribute name="sqlname">streetAddress</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(150)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:streetAddress"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:streetAddress"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:streetAddress"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:streetAddress"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13KK</xsl:attribute>
        <xsl:attribute name="sqlname">streetAddress2</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(150)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:streetAddress2"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:streetAddress2"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:streetAddress2"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:streetAddress2"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13LL</xsl:attribute>
        <xsl:attribute name="sqlname">streetAddress3</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(150)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:streetAddress3"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:streetAddress3"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:streetAddress3"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:streetAddress3"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13MM</xsl:attribute>
        <xsl:attribute name="sqlname">city</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(40)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:city"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:city"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:city"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:city"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13NN</xsl:attribute>
        <xsl:attribute name="sqlname">state</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(55)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:state"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:state"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:state"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:state"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13PP</xsl:attribute>
        <xsl:attribute name="sqlname">ZIPCode</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:ZIPCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:ZIPCode"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:ZIPCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:ZIPCode"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13QQ</xsl:attribute>
        <xsl:attribute name="sqlname">countryCode</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(3)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:countryCode"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:countryCode"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:countryCode"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:countryCode"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13RR</xsl:attribute>
        <xsl:attribute name="sqlname">phoneNo</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(30)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:phoneNo"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:phoneNo"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:phoneNo"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:phoneNo"/>
      </column>
      <column>
        <xsl:attribute name="elemNo">13SS</xsl:attribute>
        <xsl:attribute name="sqlname">faxNo</xsl:attribute>
        <xsl:attribute name="datatype">VARCHAR(30)</xsl:attribute>
        <xsl:value-of select="ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:faxNo"/>
        <xsl:value-of select="ns14:contractDetail/ns14:vendor/ns14:vendorSiteDetails/ns14:vendorLocation/ns14:faxNo"/>
        <xsl:value-of select="ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:faxNo"/>
        <xsl:value-of select="ns15:contractDetail/ns15:vendor/ns15:vendorSiteDetails/ns15:vendorLocation/ns15:faxNo"/>
      </column>
    </table>
  </xsl:template>
</xsl:stylesheet>
