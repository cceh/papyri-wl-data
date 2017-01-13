<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xi="http://www.w3.org/2003/XInclude"
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
    
    <xsl:variable name="changes" select="document(concat('../../../',$comparisonBase,'/corpus.xml'))//*:revisionDesc/*:change"/>
    
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
                    <change>
                        <xsl:attribute name="when" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
                        <xsl:attribute name="who" select="$editor"/>
                        <xsl:text>Datenkorpus neu generiert</xsl:text>
                    </change>
                    <!-- inherit existing changes -->
                    <xsl:apply-templates select="$changes"/>
                </revisionDesc>
            </teiHeader>
            <xsl:for-each select="/*/*/*:div">
                <xi:include href="{*:entry/@xml:id}"/>
            </xsl:for-each>
        </teiCorpus>
    </xsl:template>
    
</xsl:stylesheet>