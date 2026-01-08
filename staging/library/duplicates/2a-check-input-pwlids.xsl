<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>

    <!--
        <p:documentation>
            <h2>PWL-ID consistency check</h2>
            <p>This step verifies that PWL-IDs in input files match the corresponding entries in current/.
            It catches swapped IDs, duplicated IDs, and wrong ID assignments.</p>
        </p:documentation>
    -->

    <xsl:param name="input-folder"/>
    <xsl:param name="comparisonBase"/>

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

    <!-- Load current data for comparison -->
    <xsl:variable name="current-lemmata">
        <current>
            <xsl:for-each select="collection(concat('../../../',$comparisonBase,'/?recurse=yes;select=wl-*.xml'))//tei:entry">
                <xsl:variable name="path" select="base-uri()"/>
                <xsl:variable name="category" select="tokenize($path, '/')[last()-1]"/>
                <entry id="{@xml:id}" lemma="{tei:form[@type='lemma']/tei:orth[@type='original']}" category="{$category}"/>
            </xsl:for-each>
        </current>
    </xsl:variable>

    <!-- Build input lemmata (same structure as 1-check-input-data-for-duplicates.xsl) -->
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
                    <xsl:value-of select="$lemma"/>
                </orth>
            </xsl:for-each>
        </input>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:message><xsl:value-of select="current-dateTime() || ' – ' || static-base-uri()"/></xsl:message>
        <xsl:variable name="mismatches">
            <!-- For each input record with a PWL-ID, check if it matches current/ -->
            <xsl:for-each select="$input-lemmata//*:orth[@xml:id != '']">
                <xsl:variable name="input-id" select="@xml:id"/>
                <xsl:variable name="input-lemma" select="text()"/>
                <xsl:variable name="input-category" select="@category"/>
                <xsl:variable name="input-lang" select="@xml:lang"/>
                <!-- What entry does this ID point to in current/? -->
                <xsl:variable name="current-entry-by-id" select="$current-lemmata//*:entry[@id = $input-id]"/>
                <!-- What ID should this lemma+category have in current/? -->
                <xsl:variable name="current-entry-by-lemma" select="$current-lemmata//*:entry[@lemma = $input-lemma and @category = $input-category]"/>

                <!-- Check if ID exists in current and BOTH lemma and category match -->
                <!-- Only report if we can determine the correct ID (i.e., lemma+category exists in current/) -->
                <xsl:if test="$current-entry-by-id and $current-entry-by-lemma and
                              ($current-entry-by-id/@lemma != $input-lemma or $current-entry-by-id/@category != $input-category)">
                    <!-- Mismatch! Input has wrong ID but we know what the correct one should be -->
                    <orth>
                        <xsl:copy-of select="@*"/>
                        <!-- What the input ID actually points to in current/ -->
                        <xsl:attribute name="id-points-to-lemma" select="$current-entry-by-id/@lemma"/>
                        <xsl:attribute name="id-points-to-category" select="$current-entry-by-id/@category"/>
                        <!-- What ID this lemma+category should have -->
                        <xsl:attribute name="correct-id" select="$current-entry-by-lemma/@id"/>
                        <xsl:value-of select="."/>
                    </orth>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <input>
            <h2>PWL-ID Konsistenzprüfung:</h2>
            <xsl:choose>
                <xsl:when test="$mismatches/*">
                    <xsl:copy-of select="$mismatches"/>
                    <p>Empfohlenes Vorgehen: PWL-IDs in FileMaker korrigieren; dann Konversion neu starten.</p>
                </xsl:when>
                <xsl:otherwise>
                    <p>Alle PWL-IDs in den Eingabedateien stimmen mit current/ überein.</p>
                </xsl:otherwise>
            </xsl:choose>
        </input>
    </xsl:template>

</xsl:stylesheet>
