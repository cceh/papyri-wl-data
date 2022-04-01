<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>

    <!-- 
        <p:documentation>
            <h2>Duplicate check</h2>
            <p>This step checks for identical lemmata that occur within the same category. Such cases are not handled 
        by the ingest pipeline and if they indeed should be part of the dataset, they need to be added manually.</p>
        </p:documentation>
    -->

    <xsl:param name="input-folder"/>

    <xsl:strip-space elements="*"/>

    <!-- languages -->
    <xsl:variable name="latin-short" select="'la'"/>
    <xsl:variable name="greece-short" select="'grc'"/>

    <!-- categories -->
    <xsl:variable name="monthDays" select="'monthsDays'"/>
    <xsl:variable name="persons" select="'persons'"/>
    <xsl:variable name="geography" select="'geography'"/>
    <xsl:variable name="religion" select="'religion'"/>
    <xsl:variable name="general" select="'general'"/>
    <xsl:variable name="ohne_Kategorie" select="'ohne Kategorie'"/>

    <!-- column position -->
    <xsl:variable name="lemma-position" select="number(1)"/>
    <xsl:variable name="anmerkung-position" select="number(2)"/>
    <xsl:variable name="stellen-position" select="number(3)"/>
    <xsl:variable name="sortierhilfe-position" select="number(4)"/>
    <xsl:variable name="wl_id-position" select="number(5)"/>
    <xsl:variable name="wl_verweise-position" select="number(6)"/>


    <xsl:variable name="input-lemmata">
        <input>
            <xsl:for-each select="collection(concat('../../../',$input-folder,'/?recurse=no;select=*.xml'))//*:ROW">
                <xsl:variable name="lemma" select="*:COL[$lemma-position]/*:DATA[text()]"/>
                <xsl:variable name="language">
                        <xsl:choose>
                            <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:DATABASE[contains(@NAME,'Lateinisch')]">
                                <xsl:value-of select="$latin-short"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$greece-short"/>
                            </xsl:otherwise>
                        </xsl:choose>
                </xsl:variable>
                <xsl:variable name="wl_id" select="*:COL[$wl_id-position]/*:DATA[text()]"/>
                <xsl:variable name="filemaker_id" select="@RECORDID"/>
                <xsl:variable name="references">
                    <xsl:for-each select="*:COL[$wl_verweise-position]/*:DATA[text()]">
                        <xsl:text>`</xsl:text><xsl:value-of select="."/><xsl:text>` </xsl:text>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:variable name="category">
                    <xsl:choose>
                        <!-- sortierhilfe is only used for latin because there is only one document for all 5 categories (unlike greece) -->
                        <xsl:when test="$language = $latin-short">
                            <xsl:choose>
                                <xsl:when test="*:COL[$sortierhilfe-position]/*:DATA='a'"><xsl:value-of select="$monthDays"/></xsl:when>
                                <xsl:when test="*:COL[$sortierhilfe-position]/*:DATA='b'"><xsl:value-of select="$persons"/></xsl:when>
                                <xsl:when test="*:COL[$sortierhilfe-position]/*:DATA='c'"><xsl:value-of select="$geography"/></xsl:when>
                                <xsl:when test="*:COL[$sortierhilfe-position]/*:DATA='d'"><xsl:value-of select="$religion"/></xsl:when>
                                <xsl:when test="*:COL[$sortierhilfe-position]/*:DATA='e'"><xsl:value-of select="$general"/></xsl:when>
                                <!-- uncategorized/spurious -->
                                <xsl:otherwise><xsl:value-of select="$ohne_Kategorie"/></xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:if test="parent::*:RESULTSET/preceding-sibling::*:DATABASE[contains(@NAME,'Monate')]"><xsl:value-of select="$monthDays"/></xsl:if>
                            <xsl:if test="parent::*:RESULTSET/preceding-sibling::*:DATABASE[contains(@NAME,'Namen')]"><xsl:value-of select="$persons"/></xsl:if>
                            <xsl:if test="parent::*:RESULTSET/preceding-sibling::*:DATABASE[contains(@NAME,'Geographie')]"><xsl:value-of select="$geography"/></xsl:if>
                            <xsl:if test="parent::*:RESULTSET/preceding-sibling::*:DATABASE[contains(@NAME,'Religion')]"><xsl:value-of select="$religion"/></xsl:if>
                            <xsl:if test="parent::*:RESULTSET/preceding-sibling::*:DATABASE[contains(@NAME,'allgemein')]"><xsl:value-of select="$general"/></xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <orth>
                    <xsl:attribute name="xml:lang" select="$language"/>
                    <xsl:attribute name="xml:id" select="$wl_id"/>
                    <xsl:attribute name="filemaker_id" select="$filemaker_id"/>
                    <xsl:attribute name="category" select="$category"/>
                    <xsl:attribute name="references" select="$references"/>
                    <xsl:value-of select="$lemma"/>
                </orth>
            </xsl:for-each>
        </input>
    </xsl:variable>

    <xsl:template match="/">
        <!--<xsl:result-document href="duplicates.xml">-->
            <xsl:variable name="duplicates">
                <!-- grouping all lemma elements by category -->
                <xsl:for-each-group select="$input-lemmata//*:orth" group-by="@category">
                     <!-- looking for duplicates (identical text nodes) within categories;
                         groups with two (or more) members – as identified by [current-group()[2]] – are duplicates -->
                     <xsl:for-each-group select="current-group()" group-by="text()">
                         <xsl:if test="current-group()[current-group()[2]]">
                             <xsl:sequence select="current-group()[current-group()[2]]"/>
                         </xsl:if>
                     </xsl:for-each-group>
                </xsl:for-each-group>
            </xsl:variable>
            <input>
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
            </input>
        <!--</xsl:result-document>-->
    </xsl:template>

</xsl:stylesheet>