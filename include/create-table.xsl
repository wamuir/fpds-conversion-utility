<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" version="1.0" encoding="UTF-8"/>
  <xsl:param name="lang"/>
  <xsl:template match="/">
    <xsl:text>CREATE TABLE IF NOT EXISTS </xsl:text>
    <xsl:value-of select="/table/@sqlname"/>
    <xsl:text> (</xsl:text>
    <xsl:choose>
      <xsl:when test="$lang = 'postgres'">
        <xsl:text>id UUID</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>id CHAR(36)</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="/table/@cardinality = 'oto'">
        <xsl:text> PRIMARY KEY</xsl:text>
      </xsl:when>
      <xsl:when test="/table/@cardinality = 'otm'">
        <xsl:text/>
      </xsl:when>
    </xsl:choose>
    <xsl:if test="(/table/@sqlname != 'meta') and ($lang = 'postgres')">
      <xsl:text> REFERENCES meta(id) ON DELETE CASCADE</xsl:text>
    </xsl:if>
    <xsl:for-each select="/table/column">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="@sqlname"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="@datatype"/>
      <!--
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
      -->
    </xsl:for-each>
    <xsl:text>);</xsl:text>
  </xsl:template>
</xsl:stylesheet>
