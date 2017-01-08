<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.filemaker.com/fmpxmlresult"
    exclude-result-prefixes="xs #default" version="2.0">
    
    <!--
    <p:documentation>
        <h2>Creating a generic structure</h2>
        <p>This step assimilates differing export formats in a generic manner to a homogeneous data structure.</p>
    </p:documentation>
    -->
    
    <!-- based on the following structure (export format February 2016):
    
    <METADATA>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Anmerkung" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Datensatz_Markierung" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Lemma" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Lemma_gefiltert" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="LemmaRevers" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Markierung" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Sortierhilfe" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Stellen" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="StellenListe" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Such_Edition" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Var1" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Var2" TYPE="TEXT"/>
        <FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Var3" TYPE="TEXT"/>
    </METADATA>
    -->
    
    <xsl:strip-space elements="*"/>
    
    <!-- Identity template -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*:ROW">
        <xsl:variable name="position-anmerkung">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Anmerkung']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Anmerkung']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-datensatz_markierung">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Datensatz_Markierung']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Datensatz_Markierung']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-lemma">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Lemma']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Lemma']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-lemma_gefiltert">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Lemma_gefiltert']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Lemma_gefiltert']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-lemmaRevers">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='LemmaRevers']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='LemmaRevers']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-Markierung">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Markierung']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Markierung']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-Sortierhilfe">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Sortierhilfe']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Sortierhilfe']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-Stellen">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Stellen']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Stellen']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-StellenListe">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='StellenListe']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='StellenListe']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-SuchEdition">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='SuchEdition']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='SuchEdition']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-Var1">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Var1']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Var1']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-Var2">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Var2']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Var2']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="position-Var3">
            <xsl:choose>
                <xsl:when test="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Var3']">
                    <xsl:number select="parent::*:RESULTSET/preceding-sibling::*:METADATA/*:FIELD[@NAME='Var3']"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <COL>
                <DATA>
                    <xsl:if test="number($position-anmerkung) gt 0"><xsl:value-of select="*:COL[number($position-anmerkung)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; Anmerkung (<xsl:value-of select="$position-anmerkung"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-datensatz_markierung) gt 0"><xsl:value-of select="*:COL[number($position-datensatz_markierung)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; Datensatz_Markierung (<xsl:value-of select="$position-datensatz_markierung"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-lemma) gt 0"><xsl:value-of select="*:COL[number($position-lemma)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; Lemma (<xsl:value-of select="$position-lemma"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-lemma_gefiltert) gt 0"><xsl:value-of select="*:COL[number($position-lemma_gefiltert)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; Lemma_gefiltert (<xsl:value-of select="$position-lemma_gefiltert"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-lemmaRevers) gt 0"><xsl:value-of select="*:COL[number($position-lemmaRevers)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; LemmaRevers (<xsl:value-of select="$position-lemmaRevers"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-Markierung) gt 0"><xsl:value-of select="*:COL[number($position-Markierung)]/*:DATA"/></xsl:if>
                    <!-- fallback if category is not exported; take the short form of the category of the last preceding category entry (but not for the category entries themselves) -->
                    <xsl:if test="number($position-Markierung) = 0 and *:COL[number($position-anmerkung)]/*:DATA[not(matches(.,'^(a.|b.|c.|d.|e.)'))] and ancestor::*:RESULTSET/preceding-sibling::*:DATABASE[contains(@NAME,'Lateinisch')]">
                        <xsl:value-of select="preceding-sibling::*:ROW[*:COL[number($position-anmerkung)][*:DATA[text() and not(starts-with(.,'('))]]][1]/*:COL[number($position-anmerkung)]/*:DATA/substring-before(.,'.')"/>
                    </xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; Markierung (<xsl:value-of select="$position-Markierung"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-Sortierhilfe) gt 0"><xsl:value-of select="*:COL[number($position-Sortierhilfe)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; Sortierhilfe (<xsl:value-of select="$position-Sortierhilfe"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-Stellen) gt 0"><xsl:value-of select="*:COL[number($position-Stellen)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; Stellen (<xsl:value-of select="$position-Stellen"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-StellenListe) gt 0"><xsl:value-of select="*:COL[number($position-StellenListe)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; StellenListe (<xsl:value-of select="$position-StellenListe"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-SuchEdition) gt 0"><xsl:value-of select="*:COL[number($position-SuchEdition)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; SuchEdition (<xsl:value-of select="$position-SuchEdition"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-Var1) gt 0"><xsl:value-of select="*:COL[number($position-Var1)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; Var1 (<xsl:value-of select="$position-Var1"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-Var2) gt 0"><xsl:value-of select="*:COL[number($position-Var2)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; Var2 (<xsl:value-of select="$position-Var2"/>)</xsl:comment>
            <COL>
                <DATA>
                    <xsl:if test="number($position-Var3) gt 0"><xsl:value-of select="*:COL[number($position-Var3)]/*:DATA"/></xsl:if>
                </DATA>
            </COL><xsl:comment> &#x25B2; Var3 (<xsl:value-of select="$position-Var3"/>)</xsl:comment>
            
        </xsl:copy>
    </xsl:template>
    
    
</xsl:stylesheet>
