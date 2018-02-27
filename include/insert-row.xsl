<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" version="1.0" encoding="UTF-8"/>
  <xsl:template match="/">
    <xsl:text>INSERT INTO </xsl:text>
    <xsl:value-of select="/table/@sqlname"/>
    <xsl:text> (id, </xsl:text>
    <xsl:for-each select="/table/column/@sqlname">
      <xsl:value-of select="."/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>) VALUES (?, </xsl:text>
    <xsl:for-each select="/table/column">
      <xsl:text>?</xsl:text>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>);</xsl:text>
  </xsl:template>
</xsl:stylesheet>
