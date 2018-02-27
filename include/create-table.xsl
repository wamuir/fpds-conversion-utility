<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" version="1.0" encoding="UTF-8"/>
  <xsl:template match="/">
    <xsl:text>CREATE TABLE IF NOT EXISTS </xsl:text>
    <xsl:value-of select="/table/@sqlname"/>
    <xsl:choose>
      <xsl:when test="/table/@cardinality = 'oto'">
        <xsl:text> (id INTEGER PRIMARY KEY</xsl:text>
      </xsl:when>
      <xsl:when test="/table/@cardinality = 'otm'">
        <xsl:text> (id INTEGER</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:for-each select="/table/column/@sqlname">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="."/>
      <!--<xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>-->
    </xsl:for-each>
    <xsl:text>);</xsl:text>
  </xsl:template>
</xsl:stylesheet>
