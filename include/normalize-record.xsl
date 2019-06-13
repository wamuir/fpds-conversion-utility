<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns14="http://www.fpdsng.com/FPDS" xmlns:ns15="https://www.fpds.gov/FPDS" exclude-result-prefixes="ns14 ns15" version="1.0">
  <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="/ns14:award|/ns14:IDV|/ns14:OtherTransactionAward|/ns14:OtherTransactionIDV">
        <xsl:call-template name="main">
          <xsl:with-param name="ns1">http://www.fpdsng.com/FPDS</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="/ns15:award|/ns15:IDV|/ns15:OtherTransactionAward|/ns15:OtherTransactionIDV">
        <xsl:call-template name="main">
          <xsl:with-param name="ns1">https://www.fpds.gov/FPDS</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="content">
    <xsl:element name="{local-name()}">
      <xsl:for-each select="*">
        <xsl:element name="{local-name()}">
          <xsl:for-each select="*">
            <xsl:element name="{local-name()}">
              <xsl:value-of select="."/>
            </xsl:element>
          </xsl:for-each>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
  <xsl:template name="main">
    <xsl:param name="ns1"/>
    <tables>
      <table cardinality="oto" sqlname="meta">
        <column>
          <xsl:attribute name="sqlname">docType</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(21)</xsl:attribute>
          <xsl:choose>
            <xsl:when test="/*[namespace-uri()=$ns1 and local-name()='award']">
              <xsl:text>award</xsl:text>
            </xsl:when>
            <xsl:when test="/*[namespace-uri()=$ns1 and local-name()='IDV']">
              <xsl:text>IDV</xsl:text>
            </xsl:when>
            <xsl:when test="/*[namespace-uri()=$ns1 and local-name()='OtherTransactionAward']">
              <xsl:text>OtherTransactionAward</xsl:text>
            </xsl:when>
            <xsl:when test="/*[namespace-uri()=$ns1 and local-name()='OtherTransactionIDV']">
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
            <xsl:for-each select="/*[namespace-uri()=$ns1 and local-name()='award']/*[namespace-uri()=$ns1 and local-name()='awardID']">
              <xsl:call-template name="content"/>
            </xsl:for-each>
            <xsl:for-each select="/*[namespace-uri()=$ns1 and local-name()='IDV']/*[namespace-uri()=$ns1 and local-name()='contractID']">
              <xsl:call-template name="content"/>
            </xsl:for-each>
            <xsl:for-each select="/*[namespace-uri()=$ns1 and local-name()='OtherTransactionAward']/*[namespace-uri()=$ns1 and local-name()='OtherTransactionAwardID']">
              <xsl:call-template name="content"/>
            </xsl:for-each>
            <xsl:for-each select="/*[namespace-uri()=$ns1 and local-name()='OtherTransactionIDV']/*[namespace-uri()=$ns1 and local-name()='OtherTransactionIDVID']">
              <xsl:call-template name="content"/>
            </xsl:for-each>
          </fingerprint>
          <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
        </column>
        <column>
          <xsl:attribute name="sqlname">deleted</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:text>0</xsl:text>
        </column>
      </table>
      <table cardinality="oto" sqlname="awardContractID">
        <column>
          <xsl:attribute name="elemNo">1F</xsl:attribute>
          <xsl:attribute name="sqlname">agencyID</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='awardID']/*[namespace-uri()=$ns1 and local-name()='awardContractID']/*[namespace-uri()=$ns1 and local-name()='agencyID']"/>
          <!-- /ns1:award/ns1:awardID/ns1:awardContractID/ns1:agencyID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1A</xsl:attribute>
          <xsl:attribute name="sqlname">PIID</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='awardID']/*[namespace-uri()=$ns1 and local-name()='awardContractID']/*[namespace-uri()=$ns1 and local-name()='PIID']"/>
          <!-- /ns1:award/ns1:awardID/ns1:awardContractID/ns1:PIID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1B</xsl:attribute>
          <xsl:attribute name="sqlname">modNumber</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='awardID']/*[namespace-uri()=$ns1 and local-name()='awardContractID']/*[namespace-uri()=$ns1 and local-name()='modNumber']"/>
          <!-- /ns1:award/ns1:awardID/ns1:awardContractID/ns1:modNumber -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1D</xsl:attribute>
          <xsl:attribute name="sqlname">transactionNumber</xsl:attribute>
          <xsl:attribute name="datatype">INTEGER</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='awardID']/*[namespace-uri()=$ns1 and local-name()='awardContractID']/*[namespace-uri()=$ns1 and local-name()='transactionNumber']"/>
          <!-- /ns1:award/ns1:awardID/ns1:awardContractID/ns1:transactionNumber -->
        </column>
      </table>
      <table cardinality="oto" sqlname="IDVID">
        <column>
          <xsl:attribute name="elemNo">1F</xsl:attribute>
          <xsl:attribute name="sqlname">agencyID</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractID']/*[namespace-uri()=$ns1 and local-name()='IDVID']/*[namespace-uri()=$ns1 and local-name()='agencyID']"/>
          <!-- /ns1:award/ns1:contractID/ns1:IDVID/ns1:agencyID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1A</xsl:attribute>
          <xsl:attribute name="sqlname">PIID</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractID']/*[namespace-uri()=$ns1 and local-name()='IDVID']/*[namespace-uri()=$ns1 and local-name()='PIID']"/>
          <!-- /ns1:award/ns1:contractID/ns1:IDVID/ns1:PIID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1B</xsl:attribute>
          <xsl:attribute name="sqlname">modNumber</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractID']/*[namespace-uri()=$ns1 and local-name()='IDVID']/*[namespace-uri()=$ns1 and local-name()='modNumber']"/>
          <!-- /ns1:award/ns1:contractID/ns1:IDVID/ns1:modNumber -->
        </column>
      </table>
      <table cardinality="oto" sqlname="OtherTransactionAwardContractID">
        <column>
          <xsl:attribute name="elemNo">1F</xsl:attribute>
          <xsl:attribute name="sqlname">agencyID</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='OtherTransactionAwardID']/*[namespace-uri()=$ns1 and local-name()='OtherTransactionAwardContractID']/*[namespace-uri()=$ns1 and local-name()='agencyID']"/>
          <!-- /ns1:award/ns1:awardID/ns1:awardContractID/ns1:agencyID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1A</xsl:attribute>
          <xsl:attribute name="sqlname">PIID</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='OtherTransactionAwardID']/*[namespace-uri()=$ns1 and local-name()='OtherTransactionAwardContractID']/*[namespace-uri()=$ns1 and local-name()='PIID']"/>
          <!-- /ns1:award/ns1:awardID/ns1:awardContractID/ns1:PIID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1B</xsl:attribute>
          <xsl:attribute name="sqlname">modNumber</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='OtherTransactionAwardID']/*[namespace-uri()=$ns1 and local-name()='OtherTransactionAwardContractID']/*[namespace-uri()=$ns1 and local-name()='modNumber']"/>
          <!-- /ns1:award/ns1:awardID/ns1:awardContractID/ns1:modNumber -->
        </column>
      </table>
      <table cardinality="oto" sqlname="referencedIDVID">
        <column>
          <xsl:attribute name="elemNo">1H</xsl:attribute>
          <xsl:attribute name="sqlname">agencyID</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and (local-name()='awardID' or local-name='contractID' or local-name()='OtherTransactionAwardID')]/*[namespace-uri()=$ns1 and local-name()='referencedIDVID']/*[namespace-uri()=$ns1 and local-name()='agencyID']"/>
          <!-- /ns1:award/ns1:awardID/ns1:referencedIDVID/ns1:agencyID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1C</xsl:attribute>
          <xsl:attribute name="sqlname">PIID</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and (local-name()='awardID' or local-name='contractID' or local-name()='OtherTransactionAwardID')]/*[namespace-uri()=$ns1 and local-name()='referencedIDVID']/*[namespace-uri()=$ns1 and local-name()='PIID']"/>
          <!-- /ns1:award/ns1:awardID/ns1:referencedIDVID/ns1:PIID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1G</xsl:attribute>
          <xsl:attribute name="sqlname">modNumber</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and (local-name()='awardID' or local-name='contractID' or local-name()='OtherTransactionAwardID')]/*[namespace-uri()=$ns1 and local-name()='referencedIDVID']/*[namespace-uri()=$ns1 and local-name()='modNumber']"/>
          <!-- /ns1:award/ns1:awardID/ns1:referencedIDVID/ns1:modNumber -->
        </column>
      </table>
      <table cardinality="oto" sqlname="OtherTransactionIDVID">
        <column>
          <xsl:attribute name="elemNo">1F</xsl:attribute>
          <xsl:attribute name="sqlname">agencyID</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='OtherTransactionIDVID']/*[namespace-uri()=$ns1 and local-name()='OtherTransactionIDVContractID']/*[namespace-uri()=$ns1 and local-name()='agencyID']"/>
          <!-- /ns1:award/ns1:contractID/ns1:IDVID/ns1:agencyID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1A</xsl:attribute>
          <xsl:attribute name="sqlname">PIID</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='OtherTransactionIDVID']/*[namespace-uri()=$ns1 and local-name()='OtherTransactionIDVContractID']/*[namespace-uri()=$ns1 and local-name()='PIID']"/>
          <!-- /ns1:award/ns1:contractID/ns1:IDVID/ns1:PIID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">1B</xsl:attribute>
          <xsl:attribute name="sqlname">modNumber</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
          <xsl:value-of select="/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV' or local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='OtherTransactionIDVID']/*[namespace-uri()=$ns1 and local-name()='OtherTransactionIDVContractID']/*[namespace-uri()=$ns1 and local-name()='modNumber']"/>
          <!-- /ns1:award/ns1:contractID/ns1:IDVID/ns1:modNumber -->
        </column>
      </table>
      <table cardinality="oto" sqlname="solicitationID">
        <column>
          <xsl:attribute name="elemNo">1E</xsl:attribute>
          <xsl:attribute name="sqlname">solicitationID</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(25)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='solicitationID']"/>
          <!-- /ns1:award/ns1:contractData/ns1:solicitationID -->
        </column>
      </table>
      <table cardinality="oto" sqlname="dates">
        <column>
          <xsl:attribute name="elemNo">2A</xsl:attribute>
          <xsl:attribute name="sqlname">signedDate</xsl:attribute>
          <xsl:attribute name="datatype">DATE</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='relevantContractDates']/*[namespace-uri()=$ns1 and local-name()='signedDate']"/>
          <!-- /ns1:award/ns1:relevantContractDates/ns1:signedDate -->
        </column>
        <column>
          <xsl:attribute name="elemNo">2B</xsl:attribute>
          <xsl:attribute name="sqlname">effectiveDate</xsl:attribute>
          <xsl:attribute name="datatype">DATE</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='relevantContractDates']/*[namespace-uri()=$ns1 and local-name()='effectiveDate']"/>
          <!-- /ns1:award/ns1:relevantContractDates/ns1:effectiveDate -->
        </column>
        <column>
          <xsl:attribute name="elemNo">2C</xsl:attribute>
          <xsl:attribute name="sqlname">currentCompletionDate</xsl:attribute>
          <xsl:attribute name="datatype">DATE</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='relevantContractDates']/*[namespace-uri()=$ns1 and local-name()='currentCompletionDate']"/>
          <!-- /ns1:award/ns1:relevantContractDates/ns1:currentCompletionDate -->
        </column>
        <column>
          <xsl:attribute name="elemNo">2D</xsl:attribute>
          <xsl:attribute name="sqlname">ultimateCompletionDate</xsl:attribute>
          <xsl:attribute name="datatype">DATE</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='relevantContractDates']/*[namespace-uri()=$ns1 and local-name()='ultimateCompletionDate']"/>
          <!-- /ns1:award/ns1:relevantContractDates/ns1:ultimateCompletionDate -->
        </column>
        <column>
          <xsl:attribute name="elemNo">2E</xsl:attribute>
          <xsl:attribute name="sqlname">lastDateToOrder</xsl:attribute>
          <xsl:attribute name="datatype">DATE</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='relevantContractDates']/*[namespace-uri()=$ns1 and local-name()='lastDateToOrder']"/>
          <!-- /ns1:award/ns1:relevantContractDates/ns1:lastDateToOrder -->
        </column>
        <column>
          <xsl:attribute name="elemNo">2F</xsl:attribute>
          <xsl:attribute name="sqlname">lastModifiedDate</xsl:attribute>
          <xsl:attribute name="datatype">DATE</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='relevantContractDates']/*[namespace-uri()=$ns1 and local-name()='lastModifiedDate']"/>
          <!-- /ns1:award/ns1:relevantContractDates/ns1:lastModifiedDate -->
        </column>
        <column>
          <xsl:attribute name="elemNo">2G</xsl:attribute>
          <xsl:attribute name="sqlname">fiscalYear</xsl:attribute>
          <xsl:attribute name="datatype">INTEGER</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='relevantContractDates']/*[namespace-uri()=$ns1 and local-name()='fiscalYear']"/>
          <!-- /ns1:award/ns1:relevantContractDates/ns1:fiscalYear -->
        </column>
        <column>
          <xsl:attribute name="elemNo">2H</xsl:attribute>
          <xsl:attribute name="sqlname">solicitationDate</xsl:attribute>
          <xsl:attribute name="datatype">DATE</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='relevantContractDates']/*[namespace-uri()=$ns1 and local-name()='solicitationDate']"/>
          <!-- /ns1:award/ns1:relevantContractDates/ns1:solicitationDate -->
        </column>
      </table>
      <table cardinality="oto" sqlname="dollarValues">
        <column>
          <xsl:attribute name="elemNo">3A</xsl:attribute>
          <xsl:attribute name="sqlname">baseAndAllOptionsValue</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='dollarValues']/*[namespace-uri()=$ns1 and local-name()='baseAndAllOptionsValue']"/>
          <!-- /ns1:award/ns1:dollarValues/ns1:baseAndAllOptionsValue -->
        </column>
        <column>
          <xsl:attribute name="elemNo">3B</xsl:attribute>
          <xsl:attribute name="sqlname">baseAndExercisedOptionsValue</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='dollarValues']/*[namespace-uri()=$ns1 and local-name()='baseAndExercisedOptionsValue']"/>
          <!-- /ns1:award/ns1:dollarValues/ns1:baseAndExercisedOptionsValue -->
        </column>
        <column>
          <xsl:attribute name="elemNo">3C</xsl:attribute>
          <xsl:attribute name="sqlname">obligatedAmount</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='dollarValues']/*[namespace-uri()=$ns1 and local-name()='obligatedAmount']"/>
          <!-- /ns1:award/ns1:dollarValues/ns1:obligatedAmount -->
        </column>
        <column>
          <xsl:attribute name="elemNo">3D</xsl:attribute>
          <xsl:attribute name="sqlname">nonGovernmentalDollars</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='dollarValues']/*[namespace-uri()=$ns1 and local-name()='nonGovernmentalDollars']"/>
          <!-- /ns1:award/ns1:dollarValues/ns1:nonGovernmentalDollars -->
        </column>
        <column>
          <xsl:attribute name="elemNo">3E</xsl:attribute>
          <xsl:attribute name="sqlname">totalEstimatedOrderValue</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='dollarValues']/*[namespace-uri()=$ns1 and local-name()='totalEstimatedOrderValue']"/>
          <!-- /ns1:award/ns1:dollarValues/ns1:totalEstimatedOrderValue -->
        </column>
        <column>
          <xsl:attribute name="elemNo">3AT</xsl:attribute>
          <xsl:attribute name="sqlname">totalBaseAndAllOptionsValue</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='totalDollarValues']/*[namespace-uri()=$ns1 and local-name()='totalBaseAndAllOptionsValue']"/>
          <!-- /ns1:award/ns1:totalDollarValues/ns1:totalBaseAndAllOptionsValue -->
        </column>
        <column>
          <xsl:attribute name="elemNo">3BT</xsl:attribute>
          <xsl:attribute name="sqlname">totalBaseAndExercisedOptionsValue</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='totalDollarValues']/*[namespace-uri()=$ns1 and local-name()='totalBaseAndExercisedOptionsValue']"/>
          <!-- /ns1:award/ns1:totalDollarValues/ns1:totalBaseAndExercisedOptionsValue -->
        </column>
        <column>
          <xsl:attribute name="elemNo">3CT</xsl:attribute>
          <xsl:attribute name="sqlname">totalObligatedAmount</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='totalDollarValues']/*[namespace-uri()=$ns1 and local-name()='totalObligatedAmount']"/>
          <!-- /ns1:award/ns1:totalDollarValues/ns1:totalObligatedAmount -->
        </column>
        <column>
          <xsl:attribute name="elemNo">3DT</xsl:attribute>
          <xsl:attribute name="sqlname">totalNonGovernmentalDollars</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='totalDollarValues']/*[namespace-uri()=$ns1 and local-name()='totalNonGovernmentalDollars']"/>
          <!-- /ns1:award/ns1:totalDollarValues/ns1:totalNonGovernmentalDollars -->
        </column>
      </table>
      <table cardinality="oto" sqlname="purchaserInformation">
        <column>
          <xsl:attribute name="elemNo">4A</xsl:attribute>
          <xsl:attribute name="sqlname">contractingOfficeAgencyID</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='purchaserInformation']/*[namespace-uri()=$ns1 and local-name()='contractingOfficeAgencyID']"/>
          <!-- /ns1:award/ns1:purchaserInformation/ns1:contractingOfficeAgencyID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">4B</xsl:attribute>
          <xsl:attribute name="sqlname">contractingOfficeID</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(6)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='purchaserInformation']/*[namespace-uri()=$ns1 and local-name()='contractingOfficeID']"/>
          <!-- /ns1:award/ns1:purchaserInformation/ns1:contractingOfficeID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">4C</xsl:attribute>
          <xsl:attribute name="sqlname">fundingRequestingAgencyID</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(4)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='purchaserInformation']/*[namespace-uri()=$ns1 and local-name()='fundingRequestingAgencyID']"/>
          <!-- /ns1:award/ns1:purchaserInformation/ns1:fundingRequestingAgencyID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">4D</xsl:attribute>
          <xsl:attribute name="sqlname">fundingRequestingOfficeID</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(6)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='purchaserInformation']/*[namespace-uri()=$ns1 and local-name()='fundingRequestingOfficeID']"/>
          <!-- /ns1:award/ns1:purchaserInformation/ns1:fundingRequestingOfficeID -->
        </column>
        <column>
          <xsl:attribute name="elemNo">4F</xsl:attribute>
          <xsl:attribute name="sqlname">foreignFunding</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='purchaserInformation']/*[namespace-uri()=$ns1 and local-name()='foreignFunding']"/>
          <!-- /ns1:award/ns1:purchaserInformation/ns1:foreignFunding -->
        </column>
      </table>
      <table cardinality="oto" sqlname="contractMarketingData">
        <column>
          <xsl:attribute name="elemNo">5A</xsl:attribute>
          <xsl:attribute name="sqlname">websiteURL</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(100)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractMarketingData']/*[namespace-uri()=$ns1 and local-name()='websiteURL']"/>
          <!-- /ns1:award/ns1:contractMarketingData/ns1:websiteURL -->
        </column>
        <column>
          <xsl:attribute name="elemNo">5B</xsl:attribute>
          <xsl:attribute name="sqlname">whoCanUse</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(255)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractMarketingData']/*[namespace-uri()=$ns1 and local-name()='whoCanUse']"/>
          <!-- /ns1:award/ns1:contractMarketingData/ns1:whoCanUse -->
        </column>
        <column>
          <xsl:attribute name="elemNo">5C</xsl:attribute>
          <xsl:attribute name="sqlname">individualOrderLimit</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractMarketingData']/*[namespace-uri()=$ns1 and local-name()='individualOrderLimit']"/>
          <!-- /ns1:award/ns1:contractMarketingData/ns1:individualOrderLimit -->
        </column>
        <column>
          <xsl:attribute name="elemNo">5D</xsl:attribute>
          <xsl:attribute name="sqlname">typeOfFeeForUseOrService</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(3)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractMarketingData']/*[namespace-uri()=$ns1 and local-name()='typeOfFeeForUseOfService']"/>
          <!-- /ns1:award/ns1:contractMarketingData/ns1:typeOfFeeForUseOfService -->
        </column>
        <column>
          <xsl:attribute name="elemNo">5E</xsl:attribute>
          <xsl:attribute name="sqlname">fixedFeeValue</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractMarketingData']/*[namespace-uri()=$ns1 and local-name()='fixedFeeValue']"/>
          <!-- /ns1:award/ns1:contractMarketingData/ns1:fixedFeeValue -->
        </column>
        <column>
          <xsl:attribute name="elemNo">5F</xsl:attribute>
          <xsl:attribute name="sqlname">feeRangeLowerValue</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractMarketingData']/*[namespace-uri()=$ns1 and local-name()='feeRangeLowerValue']"/>
          <!-- /ns1:award/ns1:contractMarketingData/ns1:feeRangeLowerValue -->
        </column>
        <column>
          <xsl:attribute name="elemNo">5G</xsl:attribute>
          <xsl:attribute name="sqlname">feeRangeUpperValue</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractMarketingData']/*[namespace-uri()=$ns1 and local-name()='feeRangeUpperValue']"/>
          <!-- /ns1:award/ns1:contractMarketingData/ns1:feeRangeUpperValue -->
        </column>
        <column>
          <xsl:attribute name="elemNo">5H</xsl:attribute>
          <xsl:attribute name="sqlname">orderingProcedure</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(1000)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractMarketingData']/*[namespace-uri()=$ns1 and local-name()='orderingProcedure']"/>
          <!-- /ns1:award/ns1:contractMarketingData/ns1:orderingProcedure -->
        </column>
        <column>
          <xsl:attribute name="elemNo">5J</xsl:attribute>
          <xsl:attribute name="sqlname">feePaidForUseOfService</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractMarketingData']/*[namespace-uri()=$ns1 and local-name()='feePaidForUseOfService']"/>
          <!-- /ns1:award/ns1:contractMarketingData/ns1:feePaidForUseOfService -->
        </column>
        <column>
          <xsl:attribute name="elemNo">5K</xsl:attribute>
          <xsl:attribute name="sqlname">emailEddress</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(80)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractMarketingData']/*[namespace-uri()=$ns1 and local-name()='emailAddress']"/>
          <!-- /ns1:award/ns1:contractMarketingData/ns1:emailAddress -->
        </column>
      </table>
      <table cardinality="oto" sqlname="contractInformation">
        <column>
          <xsl:attribute name="elemNo">6A</xsl:attribute>
          <xsl:attribute name="sqlname">typeOfContractPricing</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='typeOfContractPricing']"/>
          <!-- /ns1:award/ns1:contractData/ns1:typeOfContractPricing -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6B</xsl:attribute>
          <xsl:attribute name="sqlname">undefinitizedAction</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='undefinitizedAction']"/>
          <!-- /ns1:award/ns1:contractData/ns1:undefinitizedAction -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6C</xsl:attribute>
          <xsl:attribute name="sqlname">multiYearContract</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='multiYearContract']"/>
          <!-- /ns1:award/ns1:contractData/ns1:multiYearContract -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6D</xsl:attribute>
          <xsl:attribute name="sqlname">typeOfIDC</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='typeOfIDC']"/>
          <!-- /ns1:award/ns1:contractData/ns1:typeOfIDC -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6E</xsl:attribute>
          <xsl:attribute name="sqlname">multipleOrSingleAwardIDC</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='multipleOrSingleAwardIDC']"/>
          <!-- /ns1:award/ns1:contractData/ns1:multipleOrSingleAwardIDC -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6F</xsl:attribute>
          <xsl:attribute name="sqlname">performanceBasedServiceContract</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='performanceBasedServiceContract']"/>
          <!-- /ns1:award/ns1:contractData/ns1:performanceBasedServiceContract -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6G</xsl:attribute>
          <xsl:attribute name="sqlname">majorProgramCode</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(100)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='majorProgramCode']"/>
          <!-- /ns1:award/ns1:contractData/ns1:majorProgramCode -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6H</xsl:attribute>
          <xsl:attribute name="sqlname">contingencyHumanitarianPeacekeepingOperation</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='contingencyHumanitarianPeacekeepingOperation']"/>
          <!-- /ns1:award/ns1:contractData/ns1:contingencyHumanitarianPeacekeepingOperation -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6J</xsl:attribute>
          <xsl:attribute name="sqlname">costOrPricingData</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='costOrPricingData']"/>
          <!-- /ns1:award/ns1:contractData/ns1:costOrPricingData -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6K</xsl:attribute>
          <xsl:attribute name="sqlname">contractFinancing</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='contractFinancing']"/>
          <!-- /ns1:award/ns1:contractData/ns1:contractFinancing -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6L</xsl:attribute>
          <xsl:attribute name="sqlname">costAccountingStandardsClause</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='costAccountingStandardsClause']"/>
          <!-- /ns1:award/ns1:contractData/ns1:costAccountingStandardsClause -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6M</xsl:attribute>
          <xsl:attribute name="sqlname">descriptionOfContractRequirement</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(4000)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='descriptionOfContractRequirement']"/>
          <!-- /ns1:award/ns1:contractData/ns1:descriptionOfContractRequirement -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6N</xsl:attribute>
          <xsl:attribute name="sqlname">purchaseCardAsPaymentMethod</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='purchaseCardAsPaymentMethod']"/>
          <!-- /ns1:award/ns1:contractData/ns1:purchaseCardAsPaymentMethod -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6Q</xsl:attribute>
          <xsl:attribute name="sqlname">numberOfActions</xsl:attribute>
          <xsl:attribute name="datatype">INTEGER</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='numberOfActions']"/>
          <!-- /ns1:award/ns1:contractData/ns1:numberOfActions -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6R</xsl:attribute>
          <xsl:attribute name="sqlname">nationalInterestActioncode</xsl:attribute>
          <xsl:attribute name="datatype">CHAR(4)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='nationalInterestActionCode']"/>
          <!-- /ns1:award/ns1:contractData/ns1:nationalInterestActionCode -->
        </column>
        <column>
          <xsl:attribute name="elemNo">6T</xsl:attribute>
          <xsl:attribute name="sqlname">inherentlyGovernmentalFunction</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(1000)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='inherentlyGovernmentalFunction']"/>
          <!-- /ns1:award/ns1:contractData/ns1:inherentlyGovernmentalFunction -->
        </column>
      </table>
      <xsl:for-each select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='listOfTreasuryAccounts']/*[namespace-uri()=$ns1 and local-name()='treasuryAccount']">
        <!-- /ns1:award/ns1:contractData/ns1:listOfTreasuryAccounts/ns1:treasuryAccount" -->
        <table cardinality="otm" sqlname="treasuryAccount">
          <column>
            <xsl:attribute name="elemNo">6SC</xsl:attribute>
            <xsl:attribute name="sqlname">agencyIdentifier</xsl:attribute>
            <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
            <xsl:value-of select="*[namespace-uri()=$ns1 and local-name()='treasuryAccountSymbol']/*[namespace-uri()=$ns1 and local-name()='agencyIdentifier']"/>
            <!-- ns1:treasuryAccountSymbol/ns1:agencyIdentifier -->
          </column>
          <column>
            <xsl:attribute name="elemNo">6SG</xsl:attribute>
            <xsl:attribute name="sqlname">mainAccountCode</xsl:attribute>
            <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
            <xsl:value-of select="*[namespace-uri()=$ns1 and local-name()='listOfTreasuryAccounts']/*[namespace-uri()=$ns1 and local-name()='treasuryAccount']/*[namespace-uri()=$ns1 and local-name()='treasuryAccountSymbol']/*[namespace-uri()=$ns1 and local-name()='mainAccountCode']"/>
            <!-- ns1:listOfTreasuryAccounts/ns1:treasuryAccount/ns1:treasuryAccountSymbol/ns1:mainAccountCode -->
          </column>
          <column>
            <xsl:attribute name="elemNo">6SH</xsl:attribute>
            <xsl:attribute name="sqlname">subAccountCode</xsl:attribute>
            <xsl:attribute name="datatype">CHARACTER(3)</xsl:attribute>
            <xsl:value-of select="*[namespace-uri()=$ns1 and local-name()='listOfTreasuryAccounts']/*[namespace-uri()=$ns1 and local-name()='treasuryAccount']/*[namespace-uri()=$ns1 and local-name()='treasuryAccountSymbol']/*[namespace-uri()=$ns1 and local-name()='subAccountCode']"/>
            <!-- ns1:listOfTreasuryAccounts/ns1:treasuryAccount/ns1:treasuryAccountSymbol/ns1:subAccountCode -->
          </column>
          <column>
            <xsl:attribute name="elemNo">6SI</xsl:attribute>
            <xsl:attribute name="sqlname">initiative</xsl:attribute>
            <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
            <xsl:value-of select="*[namespace-uri()=$ns1 and local-name()='listOfTreasuryAccounts']/*[namespace-uri()=$ns1 and local-name()='treasuryAccount']/*[namespace-uri()=$ns1 and local-name()='initiative']"/>
            <!-- ns1:listOfTreasuryAccounts/ns1:treasuryAccount/ns1:initiative -->
          </column>
        </table>
      </xsl:for-each>
      <table cardinality="oto" sqlname="legislativeMandates">
        <column>
          <xsl:attribute name="elemNo">7A</xsl:attribute>
          <xsl:attribute name="sqlname">ClingerCohenAct</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='legislativeMandates']/*[namespace-uri()=$ns1 and local-name()='ClingerCohenAct']"/>
          <!-- /ns1:award/ns1:legislativeMandates/ns1:ClingerCohenAct -->
        </column>
        <column>
          <xsl:attribute name="elemNo">7B</xsl:attribute>
          <xsl:attribute name="sqlname">materialsSuppliesArticlesEquipment</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='legislativeMandates']/*[namespace-uri()=$ns1 and (local-name()='materialsSuppliesArticlesEquipment' or local-name()='WalshHealyAct')]"/>
          <!-- /ns1:award/ns1:legislativeMandates/ns1:materialsSuppliesArticlesEquipment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">7C</xsl:attribute>
          <xsl:attribute name="sqlname">laborStandards</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='legislativeMandates']/*[namespace-uri()=$ns1 and (local-name()='laborStandards' or local-name()='serviceContractAct')]"/>
          <!-- /ns1:award/ns1:legislativeMandates/ns1:laborStandards -->
        </column>
        <column>
          <xsl:attribute name="elemNo">7D</xsl:attribute>
          <xsl:attribute name="sqlname">constructionWageRateRequirements</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='legislativeMandates']/*[namespace-uri()=$ns1 and (local-name()='constructionWageRateRequirements' or local-name()='DavisBaconAct')]"/>
          <!-- /ns1:award/ns1:legislativeMandates/ns1:constructionWageRateRequirements -->
        </column>
        <column>
          <xsl:attribute name="elemNo">7E</xsl:attribute>
          <xsl:attribute name="sqlname">interagencyContractingAuthority</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='legislativeMandates']/*[namespace-uri()=$ns1 and local-name()='interagencyContractingAuthority']"/>
          <!-- /ns1:award/ns1:legislativeMandates/ns1:interagencyContractingAuthority -->
        </column>
        <column>
          <xsl:attribute name="elemNo">7F</xsl:attribute>
          <xsl:attribute name="sqlname">otherStatutoryAuthority</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(1000)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='legislativeMandates']/*[namespace-uri()=$ns1 and local-name()='otherStatutoryAuthority']"/>
          <!-- /ns1:award/ns1:legislativeMandates/ns1:otherStatutoryAuthority -->
        </column>
      </table>
      <xsl:for-each select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='legislativeMandates']/*[namespace-uri()=$ns1 and local-name()='listOfAdditionalReportingValues']/*[namespace-uri()=$ns1 and local-name()='additionalReportingValue']">
        <!-- /ns1:award/ns1:legislativeMandates/ns1:listOfAdditionalReportingValues/ns1:additionalReportingValue -->
        <table cardinality="otm" sqlname="additionalReporting">
          <column>
            <xsl:attribute name="elemNo">7G</xsl:attribute>
            <xsl:attribute name="sqlname">additionalReportingValue</xsl:attribute>
            <xsl:attribute name="datatype">VARCHAR(10)</xsl:attribute>
            <xsl:value-of select="."/>
            <!-- . -->
          </column>
        </table>
      </xsl:for-each>
      <table cardinality="oto" sqlname="productOrServiceInformation">
        <column>
          <xsl:attribute name="elemNo">8A</xsl:attribute>
          <xsl:attribute name="sqlname">productorServiceCode</xsl:attribute>
          <xsl:attribute name="datatype">CHAR(4)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='productOrServiceCode']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:productOrServiceCode -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8B</xsl:attribute>
          <xsl:attribute name="sqlname">systemEquipmentCode</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(4)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='systemEquipmentCode']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:systemEquipmentCode -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8C</xsl:attribute>
          <xsl:attribute name="sqlname">productServiceDescription</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(100)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='productOrServiceCode']/@description"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:productOrServiceCode/@description -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8F</xsl:attribute>
          <xsl:attribute name="sqlname">claimantProgramCode</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(3)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='claimantProgramCode']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:claimantProgramCode -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8G</xsl:attribute>
          <xsl:attribute name="sqlname">principalNAICSCode</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(6)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='principalNAICSCode']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:principalNAICSCode -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8H</xsl:attribute>
          <xsl:attribute name="sqlname">informationTechnologyCommercialItemCategory</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='informationTechnologyCommercialItemCategory']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:informationTechnologyCommercialItemCategory -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8J</xsl:attribute>
          <xsl:attribute name="sqlname">GFE_GFP</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='GFE-GFP']"/>
          <!-- /ns1:award/ns1:contractData/ns1:GFE-GFP -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8K</xsl:attribute>
          <xsl:attribute name="sqlname">useOfEPADesignatePproducts</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='useOfEPADesignatedProducts']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:useOfEPADesignatedProducts -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8L</xsl:attribute>
          <xsl:attribute name="sqlname">recoveredMaterialClauses</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='recoveredMaterialClauses']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:recoveredMaterialClauses -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8M</xsl:attribute>
          <xsl:attribute name="sqlname">seaTransportation</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='seaTransportation']"/>
          <!-- /ns1:award/ns1:contractData/ns1:seaTransportation -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8N</xsl:attribute>
          <xsl:attribute name="sqlname">contractBundling</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='contractBundling']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:contractBundling -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8P</xsl:attribute>
          <xsl:attribute name="sqlname">consolidatedContract</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='consolidatedContract']"/>
          <!-- /ns1:award/ns1:contractData/ns1:consolidatedContract -->
        </column>
        <column>
          <xsl:attribute name="elemNo">8Q</xsl:attribute>
          <xsl:attribute name="sqlname">manufacturingOrganizationType</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='manufacturingOrganizationType']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:manufacturingOrganizationType -->
        </column>
      </table>
      <table cardinality="oto" sqlname="contractorDataA">
        <column>
          <xsl:attribute name="elemNo">9A</xsl:attribute>
          <xsl:attribute name="sqlname">DUNSNumber</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(9)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorDUNSInformation']/*[namespace-uri()=$ns1 and local-name()='DUNSNumber']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorDUNSInformation/ns1:DUNSNumber -->
        </column>
        <column>
          <xsl:attribute name="elemNo">9C</xsl:attribute>
          <xsl:attribute name="sqlname">locationCodeStateCodeCountryCode</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(1000)</xsl:attribute>
          <xsl:variable name="locationcode" select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='placeOfPerformance']/*[namespace-uri()=$ns1 and local-name()='principalPlaceOfPerformance']/*[namespace-uri()=$ns1 and local-name()='locationCode']"/>
          <xsl:variable name="statecode" select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='placeOfPerformance']/*[namespace-uri()=$ns1 and local-name()='principalPlaceOfPerformance']/*[namespace-uri()=$ns1 and local-name()='stateCode']"/>
          <xsl:variable name="countrycode" select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='placeOfPerformance']/*[namespace-uri()=$ns1 and local-name()='principalPlaceOfPerformance']/*[namespace-uri()=$ns1 and local-name()='countryCode']"/>
          <!-- XSLT 2.0: <xsl:value-of select="string-join(($locationcode, $statecode, $countrycode)[. != ''],' ')"/> -->
          <xsl:choose>
            <xsl:when test="$locationcode != '' and $statecode !='' and $countrycode !=''">
              <xsl:value-of select="concat($locationcode, ', ', $statecode, ', ', $countrycode)"/>
            </xsl:when>
            <xsl:when test="$locationcode != '' and $statecode !=''">
              <xsl:value-of select="concat($locationcode, ', ', $statecode)"/>
            </xsl:when>
            <xsl:when test="$locationcode != '' and $countrycode !=''">
              <xsl:value-of select="concat($locationcode, ', ', $countrycode)"/>
            </xsl:when>
            <xsl:when test="$statecode != '' and $countrycode !=''">
              <xsl:value-of select="concat($statecode, ', ', $countrycode)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat($locationcode, $statecode, $countrycode)"/>
            </xsl:otherwise>
          </xsl:choose>
          <!-- concatenation -->
        </column>
        <column>
          <xsl:attribute name="elemNo">9D</xsl:attribute>
          <xsl:attribute name="sqlname">principalPlaceOfPerformanceName</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(100)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='placeOfPerformance']/*[namespace-uri()=$ns1 and local-name()='placeOfPerformanceName']"/>
          <!-- /ns1:award/ns1:placeOfPerformance/placeOfPerformanceName -->
        </column>
        <column>
          <xsl:attribute name="elemNo">9E</xsl:attribute>
          <xsl:attribute name="sqlname">countryOfOrigin</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(3)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='countryOfOrigin']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:countryOfOrigin -->
        </column>
        <column>
          <xsl:attribute name="elemNo">9F</xsl:attribute>
          <xsl:attribute name="sqlname">congressionalDistrictContractor</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLocation']/*[namespace-uri()=$ns1 and local-name()='congressionalDistrictCode']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLocation/congressionalDistrictCode -->
        </column>
        <column>
          <xsl:attribute name="elemNo">9G</xsl:attribute>
          <xsl:attribute name="sqlname">congressionalDistrict</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='placeOfPerformance']/*[namespace-uri()=$ns1 and local-name()='placeOfPerformanceCongressionalDistrict']"/>
          <!-- /ns1:award/ns1:placeOfPerformance/placeOfPerformanceCongressionalDistrict -->
        </column>
        <column>
          <xsl:attribute name="elemNo">9H</xsl:attribute>
          <xsl:attribute name="sqlname">placeOfManufacture</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='productOrServiceInformation']/*[namespace-uri()=$ns1 and local-name()='placeOfManufacture']"/>
          <!-- /ns1:award/ns1:productOrServiceInformation/ns1:placeOfManufacture -->
        </column>
        <column>
          <xsl:attribute name="elemNo">9J</xsl:attribute>
          <xsl:attribute name="sqlname">CCRException</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='CCRException']"/>
          <!-- /ns1:award/ns1:vendor/ns1:CCRException -->
        </column>
        <column>
          <xsl:attribute name="elemNo">9K</xsl:attribute>
          <xsl:attribute name="sqlname">placeOfPerformanceZIPCode</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(10)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='placeOfPerformance']/*[namespace-uri()=$ns1 and local-name()='placeOfPerformanceZIPCode']"/>
          <!-- /ns1:award/ns1:placeOfPerformance/placeOfPerformanceZIPCode -->
        </column>
        <column>
          <xsl:attribute name="elemNo">9L</xsl:attribute>
          <xsl:attribute name="sqlname">cageCode</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(5)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorDUNSInformation']/*[namespace-uri()=$ns1 and local-name()='cageCode']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorDUNSInformation/ns1:cageCode -->
        </column>
      </table>
      <table cardinality="oto" sqlname="competitionInformation">
        <column>
          <xsl:attribute name="elemNo">10A</xsl:attribute>
          <xsl:attribute name="sqlname">extentCompeted</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(3)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='extentCompeted']"/>
          <!-- /ns1:award/ns1:competition/ns1:extentCompeted -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10C</xsl:attribute>
          <xsl:attribute name="sqlname">reasonNotCompeted</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(3)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='reasonNotCompeted']"/>
          <!-- /ns1:award/ns1:competition/ns1:reasonNotCompeted -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10D</xsl:attribute>
          <xsl:attribute name="sqlname">numberOfOffersReceived</xsl:attribute>
          <xsl:attribute name="datatype">INTEGER</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='numberOfOffersReceived']"/>
          <!-- /ns1:award/ns1:competition/ns1:numberOfOffersReceived -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10H</xsl:attribute>
          <xsl:attribute name="sqlname">commercialItemAcquisitionProcedures</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='commercialItemAcquisitionProcedures']"/>
          <!-- /ns1:award/ns1:competition/ns1:commercialItemAcquisitionProcedures -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10J</xsl:attribute>
          <xsl:attribute name="sqlname">commercialItemTestProgram</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='commercialItemTestProgram']"/>
          <!-- /ns1:award/ns1:competition/ns1:commercialItemTestProgram -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10K</xsl:attribute>
          <xsl:attribute name="sqlname">smallBusinessCompetitivenessDemonstrationProgram</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='smallBusinessCompetitivenessDemonstrationProgram']"/>
          <!-- /ns1:award/ns1:competition/ns1:smallBusinessCompetitivenessDemonstrationProgram -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10L</xsl:attribute>
          <xsl:attribute name="sqlname">A76Action</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='A76Action']"/>
          <!-- /ns1:award/ns1:competition/ns1:A76Action -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10M</xsl:attribute>
          <xsl:attribute name="sqlname">solicitationProcedures</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(5)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='solicitationProcedures']"/>
          <!-- /ns1:award/ns1:competition/ns1:solicitationProcedures -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10N</xsl:attribute>
          <xsl:attribute name="sqlname">typeOfSetAside</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(10)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='typeOfSetAside']"/>
          <!-- /ns1:award/ns1:competition/ns1:typeOfSetAside -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10P</xsl:attribute>
          <xsl:attribute name="sqlname">evaluatedPreference</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(6)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='evaluatedPreference']"/>
          <!-- /ns1:award/ns1:competition/ns1:evaluatedPreference -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10Q</xsl:attribute>
          <xsl:attribute name="sqlname">research</xsl:attribute>
          <xsl:attribute name="datatype">CHAR(3)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='research']"/>
          <!-- /ns1:award/ns1:competition/ns1:research -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10R</xsl:attribute>
          <xsl:attribute name="sqlname">statutoryExceptionToFairOpportunity</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(4)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='statutoryExceptionToFairOpportunity']"/>
          <!-- /ns1:award/ns1:competition/ns1:statutoryExceptionToFairOpportunity -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10S</xsl:attribute>
          <xsl:attribute name="sqlname">fedBizOpps</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='fedBizOpps']"/>
          <!-- /ns1:award/ns1:competition/ns1:fedBizOpps -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10T</xsl:attribute>
          <xsl:attribute name="sqlname">nonTraditionalGovernmentContractorParticipation</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(3)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='nonTraditionalGovernmentContractorParticipation']"/>
          <!-- /ns1:award/ns1:competition/ns1:nonTraditionalGovernmentContractorParticipation -->
        </column>
        <column>
          <xsl:attribute name="elemNo">10U</xsl:attribute>
          <xsl:attribute name="sqlname">localAreaSetAside</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <!-- 'BSDF' values can still be found in DHS data under LASA element but exceed CHAR(1); ref SPR# FPDSHD-64205 at https://www.fpds.gov/wiki/index.php/V1.4_SP12.0 -->
          <xsl:variable name="lasa" select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='localAreaSetAside']"/>
          <xsl:choose>
            <xsl:when test="$lasa='BSDF'"/>
            <xsl:otherwise>
              <xsl:value-of select="$lasa"/>
            </xsl:otherwise>
          </xsl:choose>
          <!-- /ns1:award/ns1:competition/ns1:localAreaSetAside -->
        </column>
        <column>
          <xsl:attribute name="elemNo">OT8C</xsl:attribute>
          <xsl:attribute name="sqlname">typeOfAgreement</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(64)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='typeOfAgreement']"/>
          <!-- /ns1:award/ns1:competition/ns1:typeOfAgreement -->
        </column>
      </table>
      <table cardinality="oto" sqlname="preferencePrograms">
        <column>
          <xsl:attribute name="elemNo">11A</xsl:attribute>
          <xsl:attribute name="sqlname">contractingOfficerBusinessSizeDetermination</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='contractingOfficerBusinessSizeDetermination']"/>
          <!-- /ns1:award/ns1:vendor/ns1:contractingOfficerBusinessSizeDetermination -->
        </column>
        <column>
          <xsl:attribute name="elemNo">11B</xsl:attribute>
          <xsl:attribute name="sqlname">subcontractPlan</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='preferencePrograms']/*[namespace-uri()=$ns1 and local-name()='subcontractPlan']"/>
          <!-- /ns1:award/ns1:preferencePrograms/ns1:subcontractPlan -->
        </column>
        <column>
          <xsl:attribute name="elemNo">11C</xsl:attribute>
          <xsl:attribute name="sqlname">priceEvaluationPercentDifference</xsl:attribute>
          <xsl:attribute name="datatype">NUMERIC</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='competition']/*[namespace-uri()=$ns1 and local-name()='priceEvaluationPercentDifference']"/>
          <!-- /ns1:award/ns1:competition/ns1:priceEvaluationPercentDifference -->
        </column>
      </table>
      <table cardinality="oto" sqlname="transactionInformation">
        <column>
          <xsl:attribute name="elemNo">12B</xsl:attribute>
          <xsl:attribute name="sqlname">contractActionType</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='contractActionType']"/>
          <!-- /ns1:award/ns1:contractData/ns1:contractActionType -->
        </column>
        <column>
          <xsl:attribute name="elemNo">12C</xsl:attribute>
          <xsl:attribute name="sqlname">reasonForModification</xsl:attribute>
          <xsl:attribute name="datatype">CHARACTER(1)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='contractData']/*[namespace-uri()=$ns1 and local-name()='reasonForModification']"/>
          <!-- /ns1:award/ns1:contractData/ns1:reasonForModification -->
        </column>
      </table>
      <table cardinality="oto" sqlname="contractorDataB">
        <column>
          <xsl:attribute name="elemNo">13I</xsl:attribute>
          <xsl:attribute name="sqlname">isLocalGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='localGovernment']/*[namespace-uri()=$ns1 and local-name()='isLocalGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:localGovernment/ns1:isLocalGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13IA</xsl:attribute>
          <xsl:attribute name="sqlname">isCityLocalGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='localGovernment']/*[namespace-uri()=$ns1 and local-name()='isCityLocalGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:localGovernment/ns1:isCityLocalGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13IB</xsl:attribute>
          <xsl:attribute name="sqlname">isCountyLocalGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='localGovernment']/*[namespace-uri()=$ns1 and local-name()='isCountyLocalGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:localGovernment/ns1:isCountyLocalGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13IC</xsl:attribute>
          <xsl:attribute name="sqlname">isInterMunicipalLocalGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='localGovernment']/*[namespace-uri()=$ns1 and local-name()='isInterMunicipalLocalGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:localGovernment/ns1:isInterMunicipalLocalGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13ID</xsl:attribute>
          <xsl:attribute name="sqlname">isLocalGovernmentOwned</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='localGovernment']/*[namespace-uri()=$ns1 and local-name()='isLocalGovernmentOwned']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:localGovernment/ns1:isLocalGovernmentOwned -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13IE</xsl:attribute>
          <xsl:attribute name="sqlname">isMunicipalityLocalGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='localGovernment']/*[namespace-uri()=$ns1 and local-name()='isMunicipalityLocalGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:localGovernment/ns1:isMunicipalityLocalGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13IF</xsl:attribute>
          <xsl:attribute name="sqlname">isSchoolDistrictLocalGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='localGovernment']/*[namespace-uri()=$ns1 and local-name()='isSchoolDistrictLocalGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:localGovernment/ns1:isSchoolDistrictLocalGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13IG</xsl:attribute>
          <xsl:attribute name="sqlname">isTownshipLocalGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='localGovernment']/*[namespace-uri()=$ns1 and local-name()='isTownshipLocalGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:localGovernment/ns1:isTownshipLocalGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13J</xsl:attribute>
          <xsl:attribute name="sqlname">isStateGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='isStateGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:isStateGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13K</xsl:attribute>
          <xsl:attribute name="sqlname">isFederalGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='federalGovernment']/*[namespace-uri()=$ns1 and local-name()='isFederalGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:federalGovernment/ns1:isFederalGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13KA</xsl:attribute>
          <xsl:attribute name="sqlname">isFederalGovernmentAgency</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='federalGovernment']/*[namespace-uri()=$ns1 and local-name()='isFederalGovernmentAgency']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:federalGovernment/ns1:isFederalGovernmentAgency -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13KB</xsl:attribute>
          <xsl:attribute name="sqlname">isFederallyFundedResearchAndDevelopmentCorp</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='federalGovernment']/*[namespace-uri()=$ns1 and local-name()='isFederallyFundedResearchAndDevelopmentCorp']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:federalGovernment/ns1:isFederallyFundedResearchAndDevelopmentCorp -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13L</xsl:attribute>
          <xsl:attribute name="sqlname">isTribalGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='isTribalGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:isTribalGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LA</xsl:attribute>
          <xsl:attribute name="sqlname">isForeignGovernment</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='isForeignGovernment']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:isForeignGovernment -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LB</xsl:attribute>
          <xsl:attribute name="sqlname">isCommunityDevelopedCorporationOwnedFirm</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='isCommunityDevelopedCorporationOwnedFirm']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:isCommunityDevelopedCorporationOwnedFirm -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LC</xsl:attribute>
          <xsl:attribute name="sqlname">isLaborSurplusAreaFirm</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='isLaborSurplusAreaFirm']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:isLaborSurplusAreaFirm -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LD</xsl:attribute>
          <xsl:attribute name="sqlname">isCorporateEntityNotTaxExempt</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='businessOrOrganizationType']/*[namespace-uri()=$ns1 and local-name()='isCorporateEntityNotTaxExempt']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:businessOrOrganizationType/ns1:isCorporateEntityNotTaxExempt -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LE</xsl:attribute>
          <xsl:attribute name="sqlname">isCorporateEntityTaxExempt</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='businessOrOrganizationType']/*[namespace-uri()=$ns1 and local-name()='isCorporateEntityTaxExempt']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:businessOrOrganizationType/ns1:isCorporateEntityTaxExempt -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LF</xsl:attribute>
          <xsl:attribute name="sqlname">isPartnershipOrLimitedLiabilityPartnership</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='businessOrOrganizationType']/*[namespace-uri()=$ns1 and local-name()='isPartnershipOrLimitedLiabilityPartnership']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:businessOrOrganizationType/ns1:isPartnershipOrLimitedLiabilityPartnership -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LG</xsl:attribute>
          <xsl:attribute name="sqlname">isSolePropreitorship</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='businessOrOrganizationType']/*[namespace-uri()=$ns1 and local-name()='isSolePropreitorship']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:businessOrOrganizationType/ns1:isSolePropreitorship -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LH</xsl:attribute>
          <xsl:attribute name="sqlname">isSmallAgriculturalCooperative</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='businessOrOrganizationType']/*[namespace-uri()=$ns1 and local-name()='isSmallAgriculturalCooperative']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:businessOrOrganizationType/ns1:isSmallAgriculturalCooperative -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LI</xsl:attribute>
          <xsl:attribute name="sqlname">isInternationalOrganization</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='businessOrOrganizationType']/*[namespace-uri()=$ns1 and local-name()='isInternationalOrganization']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:businessOrOrganizationType/ns1:isInternationalOrganization -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LJ</xsl:attribute>
          <xsl:attribute name="sqlname">isUSGovernmentEntity</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorBusinessTypes']/*[namespace-uri()=$ns1 and local-name()='businessOrOrganizationType']/*[namespace-uri()=$ns1 and local-name()='isUSGovernmentEntity']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorBusinessTypes/ns1:businessOrOrganizationType/ns1:isUSGovernmentEntity -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13M</xsl:attribute>
          <xsl:attribute name="sqlname">isVerySmallBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isVerySmallBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isVerySmallBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13N</xsl:attribute>
          <xsl:attribute name="sqlname">isSBACertified8AProgramParticipant</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorCertifications']/*[namespace-uri()=$ns1 and local-name()='isSBACertified8AProgramParticipant']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorCertifications/ns1:isSBACertified8AProgramParticipant -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13NA</xsl:attribute>
          <xsl:attribute name="sqlname">isSBACertified8AJointVenture</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorCertifications']/*[namespace-uri()=$ns1 and local-name()='isSBACertified8AJointVenture']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorCertifications/ns1:isSBACertified8AJointVenture -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13NB</xsl:attribute>
          <xsl:attribute name="sqlname">isDOTCertifiedDisadvantagedBusinessEnterprise</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorCertifications']/*[namespace-uri()=$ns1 and local-name()='isDOTCertifiedDisadvantagedBusinessEnterprise']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorCertifications/ns1:isDOTCertifiedDisadvantagedBusinessEnterprise -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13NC</xsl:attribute>
          <xsl:attribute name="sqlname">isSelfCertifiedSmallDisadvantagedBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorCertifications']/*[namespace-uri()=$ns1 and local-name()='isSelfCertifiedSmallDisadvantagedBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorCertifications/ns1:isSelfCertifiedSmallDisadvantagedBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13O</xsl:attribute>
          <xsl:attribute name="sqlname">isSBACertifiedHUBZone</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorCertifications']/*[namespace-uri()=$ns1 and local-name()='isSBACertifiedHUBZone']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorCertifications/ns1:isSBACertifiedHUBZone -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13P</xsl:attribute>
          <xsl:attribute name="sqlname">isSBACertifiedSmallDisadvantagedBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorCertifications']/*[namespace-uri()=$ns1 and local-name()='isSBACertifiedSmallDisadvantagedBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorCertifications/ns1:isSBACertifiedSmallDisadvantagedBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13Q</xsl:attribute>
          <xsl:attribute name="sqlname">isShelteredWorkshop</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorOrganizationFactors']/*[namespace-uri()=$ns1 and local-name()='isShelteredWorkshop']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorOrganizationFactors/ns1:isShelteredWorkshop -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13R</xsl:attribute>
          <xsl:attribute name="sqlname">isHistoricallyBlackCollegeOrUniversity</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='isHistoricallyBlackCollegeOrUniversity']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:isHistoricallyBlackCollegeOrUniversity -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13RA</xsl:attribute>
          <xsl:attribute name="sqlname">is1862LandGrantCollege</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='is1862LandGrantCollege']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:is1862LandGrantCollege -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13RB</xsl:attribute>
          <xsl:attribute name="sqlname">is1890LandGrantCollege</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='is1890LandGrantCollege']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:is1890LandGrantCollege -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13RC</xsl:attribute>
          <xsl:attribute name="sqlname">is1994LandGrantCollege</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='is1994LandGrantCollege']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:is1994LandGrantCollege -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13S</xsl:attribute>
          <xsl:attribute name="sqlname">isMinorityInstitution</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='isMinorityInstitution']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:isMinorityInstitution -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13SA</xsl:attribute>
          <xsl:attribute name="sqlname">isPrivateUniversityOrCollege</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='isPrivateUniversityOrCollege']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:isPrivateUniversityOrCollege -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13SB</xsl:attribute>
          <xsl:attribute name="sqlname">isSchoolOfForestry</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='isSchoolOfForestry']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:isSchoolOfForestry -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13SC</xsl:attribute>
          <xsl:attribute name="sqlname">isStateControlledInstitutionOfHigherlearning</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='isStateControlledInstitutionofHigherLearning']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:isStateControlledInstitutionofHigherLearning -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13SD</xsl:attribute>
          <xsl:attribute name="sqlname">isTribalCollege</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='isTribalCollege']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:isTribalCollege -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13SE</xsl:attribute>
          <xsl:attribute name="sqlname">isVeterinaryCollege</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='isVeterinaryCollege']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:isVeterinaryCollege -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13T</xsl:attribute>
          <xsl:attribute name="sqlname">isEducationalInstitution</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLineOfBusiness']/*[namespace-uri()=$ns1 and local-name()='isEducationalInstitution']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLineOfBusiness/ns1:isEducationalInstitution -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13SF</xsl:attribute>
          <xsl:attribute name="sqlname">isAlaskanNativeServicingInstitution</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='isAlaskanNativeServicingInstitution']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:isAlaskanNativeServicingInstitution -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13TB</xsl:attribute>
          <xsl:attribute name="sqlname">isCommunityDevelopmentCorporation</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLineOfBusiness']/*[namespace-uri()=$ns1 and local-name()='isCommunityDevelopmentCorporation']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLineOfBusiness/ns1:isCommunityDevelopmentCorporation -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13SG</xsl:attribute>
          <xsl:attribute name="sqlname">isNativeHawaiianServicingInstitution</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfEducationalEntity']/*[namespace-uri()=$ns1 and local-name()='isNativeHawaiianServicingInstitution']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfEducationalEntity/ns1:isNativeHawaiianServicingInstitution -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13TD</xsl:attribute>
          <xsl:attribute name="sqlname">isDomesticShelter</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLineOfBusiness']/*[namespace-uri()=$ns1 and local-name()='isDomesticShelter']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLineOfBusiness/ns1:isDomesticShelter -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13TE</xsl:attribute>
          <xsl:attribute name="sqlname">isManufacturerOfGoods</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLineOfBusiness']/*[namespace-uri()=$ns1 and local-name()='isManufacturerOfGoods']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLineOfBusiness/ns1:isManufacturerOfGoods -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13VV</xsl:attribute>
          <xsl:attribute name="sqlname">isHospital</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLineOfBusiness']/*[namespace-uri()=$ns1 and local-name()='isHospital']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLineOfBusiness/ns1:isHospital -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13TH</xsl:attribute>
          <xsl:attribute name="sqlname">isVeterinaryHospital</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLineOfBusiness']/*[namespace-uri()=$ns1 and local-name()='isVeterinaryHospital']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLineOfBusiness/ns1:isVeterinaryHospital -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13TI</xsl:attribute>
          <xsl:attribute name="sqlname">isHispanicServicingInstitution</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLineOfBusiness']/*[namespace-uri()=$ns1 and local-name()='isHispanicServicingInstitution']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLineOfBusiness/ns1:isHispanicServicingInstitution -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13TJ</xsl:attribute>
          <xsl:attribute name="sqlname">isFoundation</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLineOfBusiness']/*[namespace-uri()=$ns1 and local-name()='isFoundation']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLineOfBusiness/ns1:isFoundation -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13U</xsl:attribute>
          <xsl:attribute name="sqlname">isWomenOwned</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isWomenOwned']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isWomenOwned -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13UA</xsl:attribute>
          <xsl:attribute name="sqlname">isMinorityOwned</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='minorityOwned']/*[namespace-uri()=$ns1 and local-name()='isMinorityOwned']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:minorityOwned/ns1:isMinorityOwned -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13UB</xsl:attribute>
          <xsl:attribute name="sqlname">isWomenOwnedSmallBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isWomenOwnedSmallBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isWomenOwnedSmallBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13UC</xsl:attribute>
          <xsl:attribute name="sqlname">isEconomicallyDisadvantagedWomenOwnedSmallBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isEconomicallyDisadvantagedWomenOwnedSmallBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isEconomicallyDisadvantagedWomenOwnedSmallBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13UD</xsl:attribute>
          <xsl:attribute name="sqlname">isJointVentureWomenOwnedSmallBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isJointVentureWomenOwnedSmallBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isJointVentureWomenOwnedSmallBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13UE</xsl:attribute>
          <xsl:attribute name="sqlname">isJointVentureEconomicallyDisadvantagedWomenownedSmallBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isJointVentureEconomicallyDisadvantagedWomenOwnedSmallBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isJointVentureEconomicallyDisadvantagedWomenOwnedSmallBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13V</xsl:attribute>
          <xsl:attribute name="sqlname">isVeteranOwned</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isVeteranOwned']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isVeteranOwned -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13W</xsl:attribute>
          <xsl:attribute name="sqlname">isServiceRelatedDisabledVeteranOwnedBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isServiceRelatedDisabledVeteranOwnedBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isServiceRelatedDisabledVeteranOwnedBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13X</xsl:attribute>
          <xsl:attribute name="sqlname">receivesContracts</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorRelationshipWithFederalGovernment']/*[namespace-uri()=$ns1 and local-name()='receivesContracts']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorRelationshipWithFederalGovernment/ns1:receivesContracts -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XA</xsl:attribute>
          <xsl:attribute name="sqlname">receivesGrants</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorRelationshipWithFederalGovernment']/*[namespace-uri()=$ns1 and local-name()='receivesGrants']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorRelationshipWithFederalGovernment/ns1:receivesGrants -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XB</xsl:attribute>
          <xsl:attribute name="sqlname">receivesContractsAndGrants</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorRelationshipWithFederalGovernment']/*[namespace-uri()=$ns1 and local-name()='receivesContractsAndGrants']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorRelationshipWithFederalGovernment/ns1:receivesContractsAndGrants -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XC</xsl:attribute>
          <xsl:attribute name="sqlname">isAirportAuthority</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfGovernmentEntity']/*[namespace-uri()=$ns1 and local-name()='isAirportAuthority']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfGovernmentEntity/ns1:isAirportAuthority -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XD</xsl:attribute>
          <xsl:attribute name="sqlname">isCouncilOfGovernments</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfGovernmentEntity']/*[namespace-uri()=$ns1 and local-name()='isCouncilOfGovernments']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfGovernmentEntity/ns1:isCouncilOfGovernments -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XE</xsl:attribute>
          <xsl:attribute name="sqlname">isHousingAuthoritiesPublicOrTribal</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfGovernmentEntity']/*[namespace-uri()=$ns1 and local-name()='isHousingAuthoritiesPublicOrTribal']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfGovernmentEntity/ns1:isHousingAuthoritiesPublicOrTribal -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XF</xsl:attribute>
          <xsl:attribute name="sqlname">isInterstateEntity</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfGovernmentEntity']/*[namespace-uri()=$ns1 and local-name()='isInterstateEntity']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfGovernmentEntity/ns1:isInterstateEntity -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XG</xsl:attribute>
          <xsl:attribute name="sqlname">isPlanningCommission</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfGovernmentEntity']/*[namespace-uri()=$ns1 and local-name()='isPlanningCommission']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfGovernmentEntity/ns1:isPlanningCommission -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XH</xsl:attribute>
          <xsl:attribute name="sqlname">isPortAuthority</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfGovernmentEntity']/*[namespace-uri()=$ns1 and local-name()='isPortAuthority']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfGovernmentEntity/ns1:isPortAuthority -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XI</xsl:attribute>
          <xsl:attribute name="sqlname">isTransitAuthority</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='typeOfGovernmentEntity']/*[namespace-uri()=$ns1 and local-name()='isTransitAuthority']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:typeOfGovernmentEntity/ns1:isTransitAuthority -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XJ</xsl:attribute>
          <xsl:attribute name="sqlname">isSubchapterSCorporation</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorOrganizationFactors']/*[namespace-uri()=$ns1 and local-name()='isSubchapterSCorporation']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorOrganizationFactors/ns1:isSubchapterSCorporation -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XK</xsl:attribute>
          <xsl:attribute name="sqlname">isLimitedLiabilityCorporation</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorOrganizationFactors']/*[namespace-uri()=$ns1 and local-name()='isLimitedLiabilityCorporation']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorOrganizationFactors/ns1:isLimitedLiabilityCorporation -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13XL</xsl:attribute>
          <xsl:attribute name="sqlname">isForeignOwnedAndLocated</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorOrganizationFactors']/*[namespace-uri()=$ns1 and local-name()='isForeignOwnedAndLocated']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorOrganizationFactors/ns1:isForeignOwnedAndLocated -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13Y</xsl:attribute>
          <xsl:attribute name="sqlname">isAmericanIndianOwned</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isAmericanIndianOwned']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isAmericanIndianOwned -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13YA</xsl:attribute>
          <xsl:attribute name="sqlname">isAlaskanNativeOwnedCorporationOrFirm</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isAlaskanNativeOwnedCorporationOrFirm']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isAlaskanNativeOwnedCorporationOrFirm -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13YB</xsl:attribute>
          <xsl:attribute name="sqlname">isIndianTribe</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isIndianTribe']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isIndianTribe -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13YC</xsl:attribute>
          <xsl:attribute name="sqlname">isNativeHawaiianOwnedOrganizationOrFirm</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isNativeHawaiianOwnedOrganizationOrFirm']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isNativeHawaiianOwnedOrganizationOrFirm -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13YD</xsl:attribute>
          <xsl:attribute name="sqlname">isTriballyOwnedFirm</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='isTriballyOwnedFirm']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:isTriballyOwnedFirm -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13Z</xsl:attribute>
          <xsl:attribute name="sqlname">isAsianPacificAmericanOwnedBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='minorityOwned']/*[namespace-uri()=$ns1 and local-name()='isAsianPacificAmericanOwnedBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:minorityOwned/ns1:isAsianPacificAmericanOwnedBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13AA</xsl:attribute>
          <xsl:attribute name="sqlname">isBlackAmericanOwnedBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='minorityOwned']/*[namespace-uri()=$ns1 and local-name()='isBlackAmericanOwnedBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:minorityOwned/ns1:isBlackAmericanOwnedBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13BB</xsl:attribute>
          <xsl:attribute name="sqlname">isHispanicAmericanOwnedBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='minorityOwned']/*[namespace-uri()=$ns1 and local-name()='isHispanicAmericanOwnedBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:minorityOwned/ns1:isHispanicAmericanOwnedBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13CC</xsl:attribute>
          <xsl:attribute name="sqlname">isNativeAmericanOwnedBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='minorityOwned']/*[namespace-uri()=$ns1 and local-name()='isNativeAmericanOwnedBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:minorityOwned/ns1:isNativeAmericanOwnedBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13DD</xsl:attribute>
          <xsl:attribute name="sqlname">isSubcontinentAsianAmericanOwnedBusiness</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='minorityOwned']/*[namespace-uri()=$ns1 and local-name()='isSubContinentAsianAmericanOwnedBusiness']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:minorityOwned/ns1:isSubContinentAsianAmericanOwnedBusiness -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13DE</xsl:attribute>
          <xsl:attribute name="sqlname">isOtherMinorityOwned</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorSocioEconomicIndicators']/*[namespace-uri()=$ns1 and local-name()='minorityOwned']/*[namespace-uri()=$ns1 and local-name()='isOtherMinorityOwned']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorSocioEconomicIndicators/ns1:minorityOwned/ns1:isOtherMinorityOwned -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13EA</xsl:attribute>
          <xsl:attribute name="sqlname">isForProfitOrganization</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorOrganizationFactors']/*[namespace-uri()=$ns1 and local-name()='profitStructure']/*[namespace-uri()=$ns1 and local-name()='isForProfitOrganization']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorOrganizationFactors/ns1:profitStructure/ns1:isForProfitOrganization -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13EE</xsl:attribute>
          <xsl:attribute name="sqlname">isNonProfitOrganization</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorOrganizationFactors']/*[namespace-uri()=$ns1 and local-name()='profitStructure']/*[namespace-uri()=$ns1 and local-name()='isNonprofitOrganization']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorOrganizationFactors/ns1:profitStructure/ns1:isNonprofitOrganization -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13EF</xsl:attribute>
          <xsl:attribute name="sqlname">isOtherNotForProfitOrganization</xsl:attribute>
          <xsl:attribute name="datatype">BOOLEAN</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorOrganizationFactors']/*[namespace-uri()=$ns1 and local-name()='profitStructure']/*[namespace-uri()=$ns1 and local-name()='isOtherNotForProfitOrganization']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorOrganizationFactors/ns1:profitStructure/ns1:isOtherNotForProfitOrganization -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13GG</xsl:attribute>
          <xsl:attribute name="sqlname">vendorName</xsl:attribute>
          <!-- is VARCHAR(100) in data dict v1.5 but longer data exist -->
          <xsl:attribute name="datatype">VARCHAR(400)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorHeader']/*[namespace-uri()=$ns1 and local-name()='vendorName']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorHeader/ns1:vendorName -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13HH</xsl:attribute>
          <xsl:attribute name="sqlname">vendorDoingAsBusinessName</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(400)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorHeader']/*[namespace-uri()=$ns1 and local-name()='vendorDoingAsBusinessName']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorHeader/ns1:vendorDoingAsBusinessName -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13JJ</xsl:attribute>
          <xsl:attribute name="sqlname">streetAddress</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(150)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLocation']/*[namespace-uri()=$ns1 and local-name()='streetAddress']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLocation/ns1:streetAddress -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13KK</xsl:attribute>
          <xsl:attribute name="sqlname">streetAddress2</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(150)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLocation']/*[namespace-uri()=$ns1 and local-name()='streetAddress2']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLocation/ns1:streetAddress2 -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13LL</xsl:attribute>
          <xsl:attribute name="sqlname">streetAddress3</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(150)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLocation']/*[namespace-uri()=$ns1 and local-name()='streetAddress3']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLocation/ns1:streetAddress3 -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13MM</xsl:attribute>
          <xsl:attribute name="sqlname">city</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(40)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLocation']/*[namespace-uri()=$ns1 and local-name()='city']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLocation/ns1:city -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13NN</xsl:attribute>
          <xsl:attribute name="sqlname">state</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(55)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLocation']/*[namespace-uri()=$ns1 and local-name()='state']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLocation/ns1:state -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13PP</xsl:attribute>
          <xsl:attribute name="sqlname">ZIPCode</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(50)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLocation']/*[namespace-uri()=$ns1 and local-name()='ZIPCode']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLocation/ns1:ZIPCode -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13QQ</xsl:attribute>
          <xsl:attribute name="sqlname">countryCode</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(3)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLocation']/*[namespace-uri()=$ns1 and local-name()='countryCode']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLocation/ns1:countryCode -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13RR</xsl:attribute>
          <xsl:attribute name="sqlname">phoneNo</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(30)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLocation']/*[namespace-uri()=$ns1 and local-name()='phoneNo']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLocation/ns1:phoneNo -->
        </column>
        <column>
          <xsl:attribute name="elemNo">13SS</xsl:attribute>
          <xsl:attribute name="sqlname">faxNo</xsl:attribute>
          <xsl:attribute name="datatype">VARCHAR(30)</xsl:attribute>
          <xsl:value-of select="(/*[namespace-uri()=$ns1 and (local-name()='award' or local-name()='IDV')]|(/*[namespace-uri()=$ns1 and (local-name()='OtherTransactionAward' or local-name()='OtherTransactionIDV')]/*[namespace-uri()=$ns1 and local-name()='contractDetail']))/*[namespace-uri()=$ns1 and local-name()='vendor']/*[namespace-uri()=$ns1 and local-name()='vendorSiteDetails']/*[namespace-uri()=$ns1 and local-name()='vendorLocation']/*[namespace-uri()=$ns1 and local-name()='faxNo']"/>
          <!-- /ns1:award/ns1:vendor/ns1:vendorSiteDetails/ns1:vendorLocation/ns1:faxNo -->
        </column>
      </table>
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
          <xsl:attribute name="datatype">CHARACTER(2)</xsl:attribute>
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
      <!-- End dummy nodes -->
    </tables>
  </xsl:template>
</xsl:stylesheet>
