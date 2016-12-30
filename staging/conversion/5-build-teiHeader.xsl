<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- 
        <p:documentation>
            <h2>Chop data to atomic files</h2>
            <p>This steps supplies each entry with a metdata section (teiHeader) and creates a file containing this header and content.</p>
        </p:documentation>
    -->
    
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="editor"/>
    <xsl:param name="task-newEntries"/>
    <xsl:param name="task-existingEntries"/>
    <xsl:param name="schemaPath"/>
    <xsl:param name="comparisonBase"/>
    <xsl:param name="quot">"</xsl:param>
    
    <xsl:variable name="files" select="collection(concat('../../',$comparisonBase,'/?select=wl-*.xml'))"/>
    
    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model"><xsl:value-of select="concat('href=',$quot,$schemaPath,'/papyri-wl.rng',$quot,' type=',$quot,'application/xml',$quot,' schematypens=',$quot,'http://relaxng.org/ns/structure/1.0',$quot)"/></xsl:processing-instruction>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*:div">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader type="text" xml:lang="de">
                <fileDesc>
                    <titleStmt>
                        <title>Papyri-Wörterliste: <xsl:value-of select="*:entry/*:form/*:orth[@type='original']"/></title>
                    </titleStmt>
                    <publicationStmt>
                        <publisher>Universität zu Köln, Dieter Hagedorn</publisher>
                        <availability>
                            <licence target="http://creativecommons.org/licenses/by/4.0/" notBefore="2017-01-01">
                                <p>Dieses Dokument wurde unter der <ref type="license" target="http://choosealicense.com/licenses/cc-by-4.0/">Creative Commons Attribution 4.0 Unported-Lizenz (CC BY 4.0)</ref> veröffentlicht.</p>
                                <p>Die Lizenz wurde per 1. Januar 2017 hinzugefügt.</p>
                            </licence>
                        </availability>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Die in dieser Datei aufgezeichneten Daten entstammen Hypercard- und Filmakerdatenbanken von Prof. D. Hagedorn.</p>
                        <p>Für jedes Lemma sind jene papyrologischen Werke aufgeführt, in denen das jeweilige Lemma vorkommt. Eine Gesamtliste aller berücksichtigten Werke ist unter <ref target="/quellen">Quellen</ref> verfügbar.</p>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <langUsage>
                        <language ident="de">Deutsch</language>
                        <language ident="en">English</language>
                        <language ident="grc">Greek</language>
                        <language ident="la">Latin</language>
                    </langUsage>
                </profileDesc>
                <revisionDesc>
                    <xsl:choose>
                        <xsl:when test="*:entry/@NEW">
                            <change>
                                <xsl:attribute name="when" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
                                <xsl:attribute name="who" select="$editor"/>
                                <xsl:value-of select="$task-newEntries"/>
                            </change>
                        </xsl:when>
                        <xsl:otherwise>
                            <change>
                                <xsl:attribute name="when" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
                                <xsl:attribute name="who" select="$editor"/>
                                <xsl:value-of select="$task-existingEntries"/>
                            </change>
                            <!-- inherit existing changes -->
                            <xsl:variable name="currentID" select="*:entry/@xml:id"/>
                            <!--<xsl:apply-templates select="$files//*:TEI[*:text//*:entry[@xml:id = $currentID]]/*:teiHeader/*:revisionDesc/*:change"/>-->
                            
                            <!-- initial changes; remove after first run -->
                            <change when="2016-09-15" who="http://github.com/pdaengeli">Erstvergabe von xml:ids</change>
                            <change when="2016-06-24" who="http://github.com/pdaengeli">Anpassung TEI-Modell; inkl. Literatur</change>
                            <change when="2016-05-03" who="http://github.com/pdaengeli">Einführung des TEI-Modells</change>
                            <change when="2016-04-22" who="http://github.com/pdaengeli">Ergänzung einer regularisierten Form</change>
                            <change when="2016-02-11" who="http://github.com/pdaengeli">Initialtransformation</change>
                        </xsl:otherwise>
                    </xsl:choose>
                </revisionDesc>
            </teiHeader>
            <text xml:lang="en">
                <body>
                    <div>
                        <xsl:copy-of select="@*"/>
                        <xsl:apply-templates/>
                    </div>
                </body>
            </text>
        </TEI>
    </xsl:template>
    
    <xsl:template match="*:entry/@NEW"/>
    
</xsl:stylesheet>