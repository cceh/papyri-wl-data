<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xi="http://www.w3.org/2003/XInclude"
    xmlns:pwl="http://papyri.uni-koeln.de/papyri-woerterlisten"
    exclude-result-prefixes="#default xs xi pwl" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    
    <!-- 
        <p:documentation>
            <h2></h2>
            <p>...</p>
        </p:documentation>
    -->
    
    <xsl:template match="text()"/>
    
    <xsl:template match="*:list[@subtype='cat_grc']">
        <xsl:copy-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>