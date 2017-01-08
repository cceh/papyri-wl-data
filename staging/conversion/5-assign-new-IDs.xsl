<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes"/>
    
    <!-- 
        <p:documentation>
            <h2>New IDs</h2>
            <p>Based on the highest xml:ids in use and on the position (number of preceding siblings), 
                this step assigns xml:ids to new entries in the dataset.</p>
        </p:documentation>
    -->
    
    <xsl:strip-space elements="*"/>
    
    <!-- find last/highest ID (based on previous xsl:sort) -->
    <xsl:variable name="entrypoint-grc">
        <xsl:value-of select="/*:wl-wrapper/*:grc/*:div[*:entry[starts-with(@xml:id,'wl-')]][last()]/*:entry/substring-after(@xml:id,'wl-grc-')"/>
    </xsl:variable>
    <xsl:variable name="entrypoint-la">
        <xsl:value-of select="/*:wl-wrapper/*:la/*:div[*:entry[starts-with(@xml:id,'wl-')]][last()]/*:entry/substring-after(@xml:id,'wl-la-')"/>
    </xsl:variable>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@xml:id[contains(.,'newEntry')]">
        <xsl:variable name="language">
            <xsl:if test="ancestor::*:grc">grc</xsl:if>
            <xsl:if test="ancestor::*:la">la</xsl:if>
        </xsl:variable>
        <xsl:variable name="counting" select="count(ancestor::*:div/preceding-sibling::*:div[*:entry[@xml:id[contains(.,'newEntry')]]]) + 1"/>
        <xsl:attribute name="xml:id">
            <xsl:if test="$language='grc'"><xsl:value-of select="concat('wl-',$language,'-',format-number($entrypoint-grc+$counting,'00000'))"/></xsl:if>
            <xsl:if test="$language='la'"><xsl:value-of select="concat('wl-',$language,'-',format-number($entrypoint-la+$counting,'00000'))"/></xsl:if>
        </xsl:attribute>
        <xsl:attribute name="NEW" select="'new'"/>
    </xsl:template>
    
</xsl:stylesheet>