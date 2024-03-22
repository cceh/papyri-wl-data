<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:pwl="http://papyri.uni-koeln.de/papyri-woerterlisten"
    xmlns:ckbk="http://www.oreilly.com/xsltckbk"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    
    <!-- 
        <p:documentation>
            <h2>TEI Corpus</h2>
            <p>This steps creates a corpus file with xi:include references to all entries/files.</p>
        </p:documentation>
    -->
    
    <xsl:param name="version"/>
    <xsl:param name="editor"/>
    <xsl:param name="comparisonBase"/>
    
    <xsl:variable name="changes" select="document(concat('../../../',$comparisonBase,'/corpus.xml'))//*:revisionDesc[not(ancestor::*:TEI)]/*:listChange[@type='pipelineRuns']/*:change"/>
    <xsl:variable name="literature" select="document('../../../meta/literature.xml')//*:bibl"/>
    <xsl:variable name="editors" select="document('../../../meta/editors.xml')//*:editionStmt/*:respStmt"/>
    <xsl:variable name="versions" select="document('../../../meta/versions.xml')//*:revisionDesc/*:listChange[@type='versions']"/>
    <xsl:variable name="wrapped-transformation-result" select="/"/>
    
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
                            <name><persName>Dieter Hagedorn†</persName> und <persName>Klaus Maresch</persName></name>
                        </respStmt>
                    </titleStmt>
                    <editionStmt>
                        <edition n="v{tokenize($version,'¦')[1]}">
                            <name>
                                <xsl:value-of select="tokenize($version,'¦')[2]"/>
                            </name>
                            <date>
                                <xsl:value-of select="tokenize($version,'¦')[3]"/>
                            </date>
                        </edition>
                        <xsl:copy-of select="$editors"/>
                    </editionStmt>
                    <publicationStmt>
                        <publisher>Universität zu Köln, Klaus Maresch</publisher>
                        <pubPlace>Köln</pubPlace>
                        <date>
                            <xsl:attribute name="when" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
                            <xsl:value-of select="format-date(current-date(),'[D1o] [MNn] [Y0001]','de','AD','DE')"/>
                        </date>
                        <availability>
                            <licence target="https://creativecommons.org/licenses/by/4.0/" notBefore="2017-01-01">
                                <p>Dieses Dokument wurde unter der <ref type="license" target="https://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 Unported-Lizenz (CC BY 4.0)</ref> veröffentlicht.</p>
                                <p>Die Lizenz wurde per 1. Januar 2017 hinzugefügt.</p>
                            </licence>
                        </availability>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Die in dieser Datei referenzierten Daten entstammen Hypercard- und Filemakerdatenbanken von Prof. D. Hagedorn. Bis 2016 wurde aus diesen Daten periodisch eine Vorgängerpublikation als PDF-Datei erzeugt. Seit 2017 werden die Daten unter <ref target="https://papyri.uni-koeln.de/papyri-woerterlisten">https://papyri.uni-koeln.de/papyri-woerterlisten"</ref> bereitgestellt.</p>
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
                        <p>
                            <list type="index" subtype="words-by-frequency">
                                <!-- counting and listing the number of editions, in which a word occurs -->
                                <head>Anzahl der Belegstellen pro Wort</head>
                                <xsl:for-each-group select="/*//*:entry" group-by="count(*:xr/*:list/*:item)">
                                    <xsl:sort select="current-grouping-key()" order="descending"/>
                                    <item>
                                        <label><xsl:copy-of select="current-grouping-key()"/></label>
                                        <num><xsl:value-of select="count(current-group())"/></num>
                                        <linkGrp>
                                            <xsl:for-each select="current-group()/@xml:id">
                                                <ptr target="{.}"/>
                                            </xsl:for-each>
                                        </linkGrp>
                                    </item>
                                </xsl:for-each-group>
                            </list>
                        </p>
                        <p>
                            <list type="index" subtype="words-by-edition">
                                <head>Anzahl Wörter pro Edition</head>
                                <xsl:for-each select="$literature/*:title[@type='short']">
                                    <xsl:sort select="."/>
                                    <item>
                                        <label corresp="{parent::*:bibl/@xml:id}">
                                            <xsl:copy-of select="text()"/>
                                        </label>
                                        <num>
                                            <xsl:value-of select="count($wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]])"/>
                                        </num>
                                        <linkGrp>
                                            <xsl:for-each select="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/@xml:id">
                                                <ptr target="{.}"/>
                                            </xsl:for-each>
                                        </linkGrp>
                                    </item>
                                    <!--<xsl:value-of select="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item)"/>-->
                                </xsl:for-each> 
                            </list>
                        </p>
                        <p>
                            <list type="index" subtype="uniqueness-by-edition">
                                <head>Relative Einmaligkeit der Wörter pro Edition</head>
                                <xsl:for-each select="$literature/*:title[@type='short']">
                                    <xsl:sort select="."/>
                                    <!-- storing the ratio 1 : total number of references in a variable as a basis for statistical calculation -->
                                    <xsl:variable name="quots">
                                        <xsl:for-each select="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]">
                                            <quot id="{@xml:id}">
                                                <!--                                                            <xsl:value-of select="count(.//*:xr/*:list/*:item)"/>-->
                                                <xsl:value-of select="1 div count(.//*:xr/*:list/*:item)"/>
                                            </quot>
                                        </xsl:for-each>
                                    </xsl:variable>
                                    <item>
                                        <label corresp="{parent::*:bibl/@xml:id}">
                                            <xsl:copy-of select="text()"/>
                                        </label>
                                        <num type="count">
                                            <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                                <xsl:value-of select="count($quots/*:quot)"/>
                                            </xsl:if>
                                        </num>
                                        <num type="mean">
                                            <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                                <xsl:value-of select="round(sum($quots/*:quot) div count($quots/*:quot) * 10000) div 10000"/>
                                            </xsl:if>
                                        </num>
                                        <num type="median">
                                            <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                                <xsl:value-of select="round(ckbk:median($quots/*:quot) * 10000) div 10000"/>
                                            </xsl:if>
                                        </num>
                                        <num type="mode">
                                            <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                                <xsl:value-of select="for $i in ckbk:mode($quots/*:quot) return round($i * 10000) div 10000"/>
                                            </xsl:if>
                                        </num>
                                        <num type="variance">
                                            <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                                <xsl:value-of select="round(pwl:variance($quots/*:quot) * 10000) div 10000"/>
                                            </xsl:if>
                                        </num>
                                        <num type="standard-deviation">
                                            <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                                <xsl:value-of select="round(ckbk:sqrt(pwl:variance($quots/*:quot)) * 10000) div 10000"/>
                                            </xsl:if>
                                        </num>
                                    </item>
                                </xsl:for-each> 
                            </list>
                        </p>
                    </projectDesc>
                </encodingDesc>
                <xenoData>
                <!-- statistics as json in xenodata -->
                    <pwl:json>
                        <pwl:json type="categories" lang="la">
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
                        <pwl:json type="categories" lang="grc">
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
                        <pwl:json type="word-frequencies">
                            <xsl:text>{&#10;    "name" : "frequencies",&#10;    "items" : [</xsl:text>
                            <xsl:for-each-group select="/*//*:entry" group-by="count(*:xr/*:list/*:item)">
                                <xsl:sort select="current-grouping-key()" order="descending"/>
                                <xsl:text>{"name": "</xsl:text>
                                <xsl:copy-of select="current-grouping-key()"/>
                                <xsl:text>","count":"</xsl:text>
                                <xsl:value-of select="count(current-group())"/>
                                <xsl:text>","words": [</xsl:text>
                                <xsl:for-each select="current-group()/@xml:id">
                                    <xsl:text>"</xsl:text>
                                    <xsl:value-of select="."/>
                                    <xsl:text>"</xsl:text>
                                    <xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
                                </xsl:for-each>
                                <xsl:text>]}</xsl:text><xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
                            </xsl:for-each-group>
                            <xsl:text>]}</xsl:text>
                        </pwl:json>
                        <pwl:json type="words-by-edition">
                            <xsl:text>{&#10;    "name" : "words-by-edition",&#10;    "items" : [</xsl:text>
                            <xsl:for-each select="$literature/*:title[@type='short']">
                                <xsl:sort select="."/>
                                <xsl:text>{"name": "</xsl:text>
                                <xsl:copy-of select="text()"/>
                                <xsl:text>","id":"</xsl:text>
                                <xsl:value-of select="parent::*:bibl/@xml:id"/>
                                <xsl:text>","count":"</xsl:text>
                                <xsl:value-of select="count($wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]])"/>
                                <xsl:text>","words": [</xsl:text>
                                <xsl:for-each select="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/@xml:id">
                                    <xsl:text>"</xsl:text>
                                    <xsl:value-of select="."/>
                                    <xsl:text>"</xsl:text>
                                    <xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
                                </xsl:for-each>
                                <xsl:text>]}</xsl:text><xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
                            </xsl:for-each>
                            <xsl:text>]}</xsl:text>
                        </pwl:json>
                        <pwl:json type="uniqueness-by-edition">
                            <xsl:text>{&#10;    "name" : "uniqueness-by-edition",&#10;    "items" : [</xsl:text>
                            <xsl:for-each select="$literature/*:title[@type='short']">
                                <xsl:sort select="."/>
                                <xsl:variable name="quots">
                                    <xsl:for-each select="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]">
                                        <quot id="{@xml:id}">
                                            <!--                                                            <xsl:value-of select="count(.//*:xr/*:list/*:item)"/>-->
                                            <xsl:value-of select="1 div count(.//*:xr/*:list/*:item)"/>
                                        </quot>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:text>{"name": "</xsl:text>
                                <xsl:copy-of select="text()"/>
                                <xsl:text>","id":"</xsl:text>
                                <xsl:value-of select="parent::*:bibl/@xml:id"/>
                                <xsl:text>","count":"</xsl:text>
                                <xsl:value-of select="count($quots/*:quot)"/>
                                <xsl:text>","mean":"</xsl:text>
                                <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                    <xsl:value-of select="round(sum($quots/*:quot) div count($quots/*:quot) * 10000) div 10000"/>
                                </xsl:if>
                                <xsl:text>","median":"</xsl:text>
                                <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                    <xsl:value-of select="round(ckbk:median($quots/*:quot) * 10000) div 10000"/>
                                </xsl:if>
                                <xsl:text>","mode":"</xsl:text>
                                <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                    <xsl:value-of select="for $i in ckbk:mode($quots/*:quot) return round($i * 10000) div 10000"/>
                                </xsl:if>
                                <xsl:text>","variance":"</xsl:text>
                                <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                    <xsl:value-of select="round(pwl:variance($quots/*:quot) * 10000) div 10000"/>
                                </xsl:if>
                                <xsl:text>","standard-deviation":"</xsl:text>
                                <xsl:if test="$wrapped-transformation-result//*:entry[.//*:ref[matches(.,current()/text())]]/count(.//*:xr/*:list/*:item) != 0">
                                    <xsl:value-of select="round(ckbk:sqrt(pwl:variance($quots/*:quot)) * 10000) div 10000"/>
                                </xsl:if>
                                <xsl:text>"}</xsl:text><xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
                            </xsl:for-each>
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
                            <xsl:copy-of select="$changes"/>
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
    
    <xsl:function name="ckbk:median">
        <xsl:param name="nodes" as="xs:double*" />
        <xsl:variable name="count" select="count($nodes)"/>
        <xsl:variable name="middle" select="ceiling($count div 2)"/>
        <xsl:variable name="sorted" as="xs:double*">
            <xsl:perform-sort select="$nodes">
                <xsl:sort data-type="number"/>
            </xsl:perform-sort>
        </xsl:variable>
        <xsl:sequence select="if (ceiling($count mod 2)=0) then ($sorted[$middle] + $sorted[$middle - 1]) div 2 else $sorted[$middle]"/>
    </xsl:function>

    <xsl:function name="ckbk:mode" as="item()*">
        <xsl:param name="nodes" as="item()*"/>
        <!-- First locate the distinct values -->
        <xsl:variable name="distinct" select="distinct-values($nodes)" as="item()*"/> 
        <!--Get a sequence of occurrence counts of the distinct values --> 
        <xsl:variable name="counts"
            select="for $i in $distinct return count($nodes[. = $i])"
            as="xs:integer*"/>
        <!--Find the max of the counts -->
        <xsl:variable name="max" select="max($counts)" as="xs:integer?"/>
        <!-- Now return those values that have the max count -->
        <xsl:sequence select="$distinct[position() = index-of($counts,$max)]"/>
    </xsl:function>
    
    <xsl:function name="pwl:variance" as="xs:double">
        <xsl:param name="nodes" as="xs:double*"/>
        <xsl:variable name="sum" select="sum($nodes)"/>
        <xsl:variable name="count" select="count($nodes)"/>
        <xsl:variable name="mean" select="$sum div $count"/>
        <xsl:sequence select="if ($count lt 2)
            then 0
            else sum(for $i in $nodes return ($i - $mean) * ($i - $mean)) div $count"/>
    </xsl:function>
    
    <!-- square root -->
    <xsl:function name="ckbk:sqrt">
        <xsl:param name="number" as="xs:double"/>
        <xsl:variable name="try" select="if ($number lt 100.0) then 1.0
            else if ($number gt 100.0 and $number lt
            1000.0) then 10.0
            else if ($number gt 1000.0 and $number lt
            10000.0) then 31.0
            else 100.00" as="xs:decimal"/>
        <xsl:sequence select="if ($number ge 0) then ckbk:sqrt($number,$try,1,20)
            else 'NaN'"/>
    </xsl:function>
    
    <xsl:function name="ckbk:sqrt" as="xs:double">
        <xsl:param name="number" as="xs:double"/>
        <xsl:param name="try" as="xs:double"/>
        <xsl:param name="iter" as="xs:integer"/>
        <xsl:param name="maxiter" as="xs:integer"/>
        <xsl:variable name="result" select="$try * $try" as="xs:double"/>
        <xsl:sequence select="if ($result eq $number or $iter gt $maxiter)
            then $try
            else ckbk:sqrt($number, ($try - (($result - $number)
            div (2 * $try))), $iter + 1, $maxiter)"/>
    </xsl:function>
        
</xsl:stylesheet>
