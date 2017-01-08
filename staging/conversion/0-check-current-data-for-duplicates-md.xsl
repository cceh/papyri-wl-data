<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xsl:template match="/">
        <md-wrapper>
            <xsl:text>
# WL Import Report </xsl:text><xsl:value-of select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/><xsl:text>

**The directory 'current' contains duplicates!**

Please make sure that each lemma is unique within its category.

## Duplicate lemmata


| Lemma   | language     | WL ID | FileMaker RecordId | category |
| -----------|-----------|-------------|-------------|-------------|
</xsl:text>
            <xsl:for-each select="*:current/*:orth">
                <xsl:sort select="text()"/>
                <xsl:text>| </xsl:text>
                <xsl:value-of select="text()"/>
                <xsl:text>| </xsl:text>
                <xsl:value-of select="@xml:lang"/>
                <xsl:text>| </xsl:text>
                <xsl:value-of select="@xml:id"/>
                <xsl:text>| </xsl:text>
                <xsl:value-of select="@filemakerID"/>
                <xsl:text>| </xsl:text>
                <xsl:value-of select="@category"/>
                <xsl:text>| </xsl:text>
                <xsl:text>|
</xsl:text>
                
            </xsl:for-each>
            <xsl:text>Please remove these duplicates and relaunch the conversion.</xsl:text>
        </md-wrapper>
    </xsl:template>
</xsl:stylesheet>