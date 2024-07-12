<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fmpxml="http://www.filemaker.com/fmpxmlresult"
    xmlns:pwl="http://papyri.uni-koeln.de/papyri-woerterlisten"
    xmlns="http://www.filemaker.com/fmpxmlresult"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs fmpxml"
    version="3.0">
    
    <!-- Adding new pwl-id values for re-import to FileMaker. -->
    
    <xsl:output indent="true"/>
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:variable name="map" as="map(xs:string, xs:string)">
        <xsl:map>
            <xsl:for-each select="//entry">
                <xsl:map-entry key="(if (matches(@xml:id,'wl-grc')) then parent::*:div/@type else 'la') || '-' || form/idno[@type='fp7'] => string()" select="@xml:id => string()"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:message><xsl:value-of select="current-dateTime() || ' – ' || static-base-uri()"/></xsl:message>
        <xsl:for-each select="collection('../../input?select=*.xml')">
            <xsl:result-document href="{concat(base-uri() => substring-before('input'),'return/',tokenize(base-uri(),'/')[last()])}">
                <!-- for an alternative approach to set @href see: https://lists.w3.org/Archives/Public/xproc-dev/2011Nov/0011.html -->
                <xsl:apply-templates/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="fmpxml:ROW/fmpxml:COL[5]/fmpxml:DATA[not(matches(.,'\S'))]">
        <xsl:copy expand-text="true">{$map(pwl:type(//fmpxml:DATABASE/@NAME => substring-before('.')) || '-' || ancestor::fmpxml:ROW[1]/@RECORDID)}</xsl:copy>
    </xsl:template>
    
    <!-- Add Datensatz id to METADATA -->
    <xsl:template match="fmpxml:METADATA">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
            <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Datensatz id" TYPE="TEXT"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Apppend Datensatz id to each row-->
    <xsl:template match="fmpxml:ROW">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
            <COL>
                <DATA><xsl:value-of select="@RECORDID"/></DATA>
            </COL>
        </xsl:copy>
    </xsl:template>
    
    <xsl:function name="pwl:type">
        <xsl:param name="input" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="matches($input,'allgemein','i')">general</xsl:when>
            <xsl:when test="matches($input,'geographie','i')">geography</xsl:when>
            <xsl:when test="matches($input,'monate','i')">monthsDays</xsl:when>
            <xsl:when test="matches($input,'namen','i')">persons</xsl:when>
            <xsl:when test="matches($input,'religion','i')">religion</xsl:when>
            <xsl:when test="matches($input,'latein','i')">la</xsl:when>
        </xsl:choose>
    </xsl:function>
    
</xsl:transform>