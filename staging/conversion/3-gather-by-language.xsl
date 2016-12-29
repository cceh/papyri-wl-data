<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes"/>
    
    <!-- 
        <p:documentation>
            <h2>Group entries by language</h2>
            <p>This step groups greek and latin entries in a flat structure in respective elements. 
                This structure prepares the assignment of new IDs.</p>
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
            <xsl:for-each-group select="*:wl-wrapper/*:div" group-by="*:entry[1]/*:form[1]/*:orth[1]/@xml:lang">
                <xsl:element name="{*:entry[1]/*:form[1]/*:orth[1]/@xml:lang}">
                    <xsl:apply-templates select="current-group()//*:entry[*:xr/*:list/*:item]">
                        <xsl:sort select="@xml:id" />
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:for-each-group>
        </wl-wrapper>
    </xsl:template>
   
    <xsl:template match="*:entry">
        <div type="{parent::*:div/@type}">
          <xsl:copy>
              <xsl:copy-of select="@*"/>
              <xsl:apply-templates/>
          </xsl:copy>
        </div>
    </xsl:template>
    
</xsl:stylesheet>