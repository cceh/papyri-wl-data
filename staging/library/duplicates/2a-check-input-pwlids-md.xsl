<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xsl:template match="/">
        <xsl:message><xsl:value-of select="current-dateTime() || ' – ' || static-base-uri()"/></xsl:message>
        <xsl:message>CAUTION: PWL-ID mismatches detected in input.</xsl:message>
        <md-wrapper>
            <xsl:text>
# PWL-ID Consistency Check Failed </xsl:text><xsl:value-of select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/><xsl:text>

**PWL-IDs in input don't match the entries in current/!**

The following records have PWL-IDs that point to different lemmata or categories in current/.
This usually indicates a FileMaker import error where the wrong ID was assigned.

## Mismatched PWL-IDs

| RecordID | Lemma | Category | ID in Input | ID belongs to | Correct ID |
|----------|-------|----------|-------------|---------------|------------|
</xsl:text>
            <xsl:for-each select="*:input/*:orth">
                <xsl:sort select="@xml:id"/>
                <xsl:text>| </xsl:text>
                <xsl:value-of select="@filemaker_id"/>
                <xsl:text> | </xsl:text>
                <xsl:value-of select="text()"/>
                <xsl:text> | </xsl:text>
                <xsl:value-of select="@category"/>
                <xsl:text> | </xsl:text>
                <xsl:value-of select="@xml:id"/>
                <xsl:text> | </xsl:text>
                <xsl:value-of select="@id-points-to-lemma"/>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="@id-points-to-category"/>
                <xsl:text>) | </xsl:text>
                <xsl:value-of select="@correct-id"/>
                <xsl:text> |
</xsl:text>
            </xsl:for-each>
            <xsl:text>
Please fix these PWL-IDs in FileMaker and re-export before relaunching the conversion.</xsl:text>
        </md-wrapper>
    </xsl:template>
</xsl:stylesheet>
