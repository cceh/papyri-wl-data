<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    
    <!-- This is a check for identical lemmata that occur within the same category. These cases are not handled 
        by the ingest pipeline and if they indeed should be part of the dataset, they need to be added manually. -->
    
    <!-- This step should be incorporated in the main pipeline (secondary output). -->
    
    <xsl:param name="comparisonBase" select="'current'"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="files" select="collection(concat('../',$comparisonBase,'/?select=wl-*.xml'))"/>
    
    <xsl:variable name="current-lemmata">
        <current>
            <xsl:for-each select="$files//*:entry/*:form/*:orth[@type='original'][text()]">
                <xsl:copy>
                    <xsl:copy-of select="@xml:lang"/>
                    <xsl:copy-of select="ancestor::*:entry/@xml:id"/>
                    <xsl:attribute name="category" select="ancestor::*:div/@type"/>
                    <xsl:attribute name="filemakerID" select="following-sibling::*:idno"/>
                    <xsl:copy-of select="text()"/>
                </xsl:copy>
            </xsl:for-each>
        </current>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:result-document href="duplicates.xml">
            <xsl:variable name="duplicates">
                <!-- grouping all orth elements by category -->
                <xsl:for-each-group select="$current-lemmata//*:orth" group-by="@category">
                     <!-- looking for duplicates (identical text nodes) within categories; 
                         groups with two (or more) members – as identified by [current-group()[2]] – are duplicates -->
                     <xsl:for-each-group select="current-group()" group-by="text()">
                         <xsl:if test="current-group()[current-group()[2]]">
                             <xsl:sequence select="current-group()[current-group()[2]]"/>
                         </xsl:if>
                     </xsl:for-each-group>
                </xsl:for-each-group>
            </xsl:variable>
            <current>
                <h2>Mehrfach vorkommende Lemmata:</h2>
                <xsl:choose>
                    <xsl:when test="$duplicates/*">
                        <xsl:copy-of select="$duplicates"/>
                        <p>Empfohlenes Vorgehen: Duplikate beheben (zumindest für die Transformation); dann diese Datei entfernen (ggf. nach erneutem Testen).</p>
                    </xsl:when>
                    <xsl:otherwise>
                        <p>Alle Lemmata sind innerhalb der Kategorien einmalig. Diese Datei kann entfernt werden.</p>
                    </xsl:otherwise>
                </xsl:choose>
            </current>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>