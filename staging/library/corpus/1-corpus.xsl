<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:pwl="http://papyri.uni-koeln.de/papyri-woerterlisten"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    
    <!-- 
        <p:documentation>
            <h2>TEI Corpus</h2>
            <p>This steps creates a corpus file with xi:include references to all entries/files.</p>
        </p:documentation>
    -->
    
    <xsl:param name="editor"/>
    <xsl:param name="comparisonBase"/>
    
    <xsl:variable name="changes" select="document(concat('../../../',$comparisonBase,'/corpus.xml'))//*:revisionDesc[not(ancestor::*:TEI)]/*:change"/>
    <xsl:variable name="literature" select="document('../../../meta/literature.xml')//*:bibl"/>
    <xsl:variable name="editors" select="document('../../../meta/editors.xml')//*:editionStmt"/>
    <xsl:variable name="versions" select="document('../../../meta/versions.xml')//*:revisionDesc/*:listChange[@type='versions']"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <teiCorpus xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader type="text" xml:lang="de">
                <fileDesc>
                    <titleStmt>
                        <title>Papyri-Wörterlisten</title>
                        <respStmt>
                            <resp>kompiliert von</resp>
                            <name>Dieter Hagedorn</name>
                        </respStmt>
                    </titleStmt>
                    <xsl:copy-of select="$editors"/>
                    <publicationStmt>
                        <publisher>Universität zu Köln, Dieter Hagedorn</publisher>
                        <pubPlace>Köln</pubPlace>
                        <date>
                            <xsl:attribute name="when" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
                            <xsl:value-of select="format-date(current-date(),'[D1o] [MNn] [Y0001]','de','AD','DE')"/>
                        </date>
                        <availability>
                            <licence target="http://creativecommons.org/licenses/by/4.0/" notBefore="2017-01-01">
                                <p>Dieses Dokument wurde unter der <ref type="license" target="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 Unported-Lizenz (CC BY 4.0)</ref> veröffentlicht.</p>
                                <p>Die Lizenz wurde per 1. Januar 2017 hinzugefügt.</p>
                            </licence>
                        </availability>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Die in dieser Datei referenzierten Daten entstammen Hypercard- und Filemakerdatenbanken von Prof. D. Hagedorn. Bis 2016 wurde aus diesen Daten periodisch eine Vorgängerpublikation als PDF-Datei erzeugt. Seit 2017 werden die Daten unter <ref target="http://papyri.uni-koeln.de/papyri-woerterlisten">http://papyri.uni-koeln.de/papyri-woerterlisten"</ref> bereitgestellt.</p>
                        <p>
                            <listBibl>
                                <head>Berücksichtigte Publikationen</head>
                                <xsl:for-each select="$literature">
                                    <xsl:sort select="*:title[@type='short']"/>
                                    <xsl:copy-of select="."/>
                                </xsl:for-each>
                            </listBibl>
                        </p>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <appInfo>
                        <application version="{format-date(current-date(), '[Y0001][M01][D01]')}" ident="pwl-XProc">
                            <label>XProc-Pipeline</label>
                        </application>
                    </appInfo>
                    <projectDesc>
                        <p>Die folgenden Listen enthalten statistische Angaben zum Korpusinhalt.</p>
                        <p>
                            <list type="index" subtype="total_grc_la">
                                <head>Einträge insgesamt</head>
                                <item>
                                    <label>Sprachübergreifend</label>
                                    <num><xsl:value-of select="count(/*/*/*:div)"/></num>
                                </item>
                                <item>
                                    <label>Griechisch</label>
                                    <num><xsl:value-of select="count(/*/*:grc/*:div)"/></num>
                                </item>
                                <item>
                                    <label>Lateinisch</label>
                                    <num><xsl:value-of select="count(/*/*:la/*:div)"/></num>
                                </item>
                            </list>
                        </p>
                        <p>
                            <list type="index" subtype="cat_grc_la">
                                <head>Einträge pro Kategorie (sprachübergreifend)</head>
                                <xsl:for-each-group select="/*/*/*:div" group-by="@type">
                                    <item>
                                        <label><xsl:copy-of select="current-group()/@type"/></label>
                                        <num><xsl:value-of select="count(current-group())"/></num>
                                    </item>
                                </xsl:for-each-group>
                            </list>
                        </p>
                        <p>
                            <list type="index" subtype="cat_grc">
                                <head>Einträge pro Kategorie (griechisch)</head>
                                <xsl:for-each-group select="/*/*:grc/*:div" group-by="@type">
                                    <item>
                                        <label><xsl:copy-of select="current-group()/@type"/></label>
                                        <num><xsl:value-of select="count(current-group())"/></num>
                                    </item>
                                </xsl:for-each-group>
                            </list>
                        </p>
                        <p>
                            <list type="index" subtype="cat_la">
                                <head>Einträge pro Kategorie (lateinisch)</head>
                                <xsl:for-each-group select="/*/*:la/*:div" group-by="@type">
                                    <item>
                                        <label><xsl:copy-of select="current-group()/@type"/></label>
                                        <num><xsl:value-of select="count(current-group())"/></num>
                                    </item>
                                </xsl:for-each-group>
                            </list>
                        </p>
                        <p>
                            <list type="index" subtype="cat_abc_grc">
                                <head>Einträge pro Kategorie und Initial (griechisch)</head>
                                <xsl:for-each-group select="/*/*:grc/*:div" group-by="@type">
                                    <item>
                                        <label><xsl:copy-of select="current-group()/@type"/></label>
                                        <num><xsl:value-of select="count(current-group())"/></num>
                                    </item>
                                    <item>
                                        <list type="index" subtype="{current-group()[1]/@type}">
                                            <xsl:for-each-group select="current-group()/*:entry" group-by="*:form/*:orth[@type='regularised']/substring(translate(., 'αβγδεζηθικλμνξοπρσςτυφχψω', 'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΣΤΥΦΧΨΩ'),1,1)">
                                                <xsl:sort select="current-group()/*:entry/*:form/*:orth[@type='regularised']"/>
                                                <item>
                                                    <label><xsl:value-of select="current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., 'αβγδεζηθικλμνξοπρσςτυφχψω', 'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΣΤΥΦΧΨΩ'),1,1)"/></label>
                                                    <num><xsl:value-of select="count(current-group())"/></num>
                                                </item>    
                                            </xsl:for-each-group>
                                        </list>
                                    </item>
                                </xsl:for-each-group>
                            </list>
                        </p>
                        <p>
                            <list type="index" subtype="cat_abc_la">
                                <head>Einträge pro Kategorie und Initial (lateinisch)</head>
                                <xsl:for-each-group select="/*/*:la/*:div" group-by="@type">
                                    <item>
                                        <label><xsl:copy-of select="current-group()/@type"/></label>
                                        <num><xsl:value-of select="count(current-group())"/></num>
                                    </item>
                                    <item>
                                        <list type="index" subtype="{current-group()[1]/@type}">
                                            <xsl:for-each-group select="current-group()/*:entry" group-by="*:form/*:orth[@type='regularised']/substring(translate(., 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1)">
                                                <xsl:sort select="current-group()/*:entry/*:form/*:orth[@type='regularised']"/>
                                                <item>
                                                    <label><xsl:value-of select="current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1)"/></label>
                                                    <num><xsl:value-of select="count(current-group())"/></num>
                                                </item>    
                                            </xsl:for-each-group>
                                        </list>
                                    </item>
                                </xsl:for-each-group>
                            </list>
                        </p>
                    </projectDesc>
                </encodingDesc>
                <xenoData>
                <!-- statistics as json in xenodata -->
                    <pwl:json>
                        <pwl:json lang="la">
                            <xsl:text>{&#10;    "name" : "categories",&#10;    "items" : [</xsl:text>
                            <xsl:for-each-group select="/*/*:la/*:div" group-by="@type">
                                <xsl:text>{&#10;        "name" : "</xsl:text><xsl:value-of select="@type"/><xsl:text>",&#10;        "items" : [</xsl:text>
                                <xsl:for-each-group select="current-group()/*:entry" group-by="*:form/*:orth[@type='regularised']/substring(translate(., 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1)">
                                    <xsl:sort select="current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1)"/>
                                    <xsl:text>{"name": "</xsl:text>
                                    <xsl:value-of select="current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1)"/>
                                    <xsl:text>","count":</xsl:text>
                                    <xsl:value-of select="count(current-group())"/>
                                    <xsl:text>}</xsl:text><xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
                                </xsl:for-each-group>
                                <xsl:text>]&#10;        }</xsl:text><xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
                            </xsl:for-each-group>
                            <xsl:text>]}</xsl:text>
                        </pwl:json>
                        <pwl:json lang="grc">
                            <xsl:text>{&#10;    "name" : "categories",&#10;    "items" : [</xsl:text>
                            <xsl:for-each-group select="/*/*:grc/*:div" group-by="@type">
                                <xsl:text>{&#10;        "name" : "</xsl:text><xsl:value-of select="@type"/><xsl:text>",&#10;        "items" : [</xsl:text>
                                <xsl:for-each-group select="current-group()/*:entry" group-by="*:form/*:orth[@type='regularised']/substring(translate(., 'αβγδεζηθικλμνξοπρσςτυφχψω', 'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΣΤΥΦΧΨΩ'),1,1)">
                                    <xsl:sort select="current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., 'αβγδεζηθικλμνξοπρσςτυφχψω', 'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΣΤΥΦΧΨΩ'),1,1)"/>
                                    <xsl:text>{"name": "</xsl:text>
                                    <xsl:value-of select="current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., 'αβγδεζηθικλμνξοπρσςτυφχψω', 'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΣΤΥΦΧΨΩ'),1,1)"/>
                                    <xsl:text>","count":</xsl:text>
                                    <xsl:value-of select="count(current-group())"/>
                                    <xsl:text>}</xsl:text><xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
                                </xsl:for-each-group>
                                <xsl:text>]&#10;        }</xsl:text><xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
                            </xsl:for-each-group>
                            <xsl:text>]}</xsl:text>
                        </pwl:json>
                    </pwl:json>
                </xenoData>
                <profileDesc>
                    <langUsage>
                        <language ident="de">Deutsch</language>
                        <language ident="en">English</language>
                        <language ident="grc">Greek</language>
                        <language ident="la">Latin</language>
                    </langUsage>
                </profileDesc>
                <revisionDesc>
                    <listChange>
                        <listChange type="pipelineRuns">
                            <change>
                                <xsl:attribute name="when" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
                                <xsl:attribute name="who" select="$editor"/>
                                <xsl:text>Datenkorpus neu generiert</xsl:text>
                            </change>
                            <!-- inherit existing changes -->
                            <xsl:apply-templates select="$changes"/>
                        </listChange>
                        <xsl:copy-of select="$versions"/>
                    </listChange>
                </revisionDesc>
            </teiHeader>
            <xsl:copy-of select="document('../../../meta/about.xml')//*:text"/>
            <xsl:for-each select="/*/*/*:div">
                <xsl:element name="xi:include">
                    <!-- concat language + category + xml:id -->
                    <xsl:attribute name="href" select="concat(tokenize(*:entry/@xml:id,'-')[2],'/',@type,'/',*:entry/@xml:id,'.xml')"/>
                </xsl:element>
            </xsl:for-each>
        </teiCorpus>
    </xsl:template>
    
</xsl:stylesheet>