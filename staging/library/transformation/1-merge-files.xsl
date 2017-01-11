<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!--
    <p:documentation>
        <h2>Merging input files</h2>
        <p>This step combines all XML files in the input directory for further processing.</p>
    </p:documentation>
    -->
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <wl-wrapper>
            <!-- global rule -->
            <xsl:apply-templates select="collection('../../input/?select=*.xml')/*:FMPXMLRESULT"/>
            
            <!-- individual rules -->
            <!--
            <xsl:apply-templates select="document('../input/1%20Monate.xml')/*"/>
            <xsl:apply-templates select="document('../input/2%20Namen.xml')/*"/>
            <xsl:apply-templates select="document('../input/3%20Geographie.xml')/*"/>
            <xsl:apply-templates select="document('../input/4%20Religion.xml')/*"/>
            <xsl:apply-templates select="document('../input/5%20Allgemein.xml')/*"/>
            <xsl:apply-templates select="document('../input/6%20Lateinisch.xml')/*"/>
            -->
        </wl-wrapper>
    </xsl:template>
    
</xsl:stylesheet>