<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- 
        <p:documentation>
            <h2>Navigation by category</h2>
            <p>This step generates a list containing counts of lemmata starting in the same two characters by category in a format expected by the webapp.</p>
        </p:documentation>
    -->
    
    <xsl:template match="/">
        <nav>
            <item id="grc">
                <xsl:comment><name>Griechisch</name></xsl:comment>
                <xsl:apply-templates select="/*/*:grc">
                    <xsl:with-param name="lang" select="'grc'"/>
                </xsl:apply-templates>
            </item>
            <item id="la">
                <xsl:comment><name>Lateinisch</name></xsl:comment>
                <xsl:apply-templates select="/*/*:la">
                    <xsl:with-param name="lang" select="'la'"/>                
                </xsl:apply-templates>
            </item>
        </nav>  
        
    </xsl:template>
    
    <xsl:template match="/*/*:grc">
        <xsl:for-each-group select="*:div" group-by="@type">
            <item id="{current-group()[1]/@type}">
                <amount><xsl:value-of select="count(current-group())"/></amount>
                <xsl:for-each-group select="current-group()" group-by="*:entry/*:form/*:orth[@type='regularised']/substring(translate(., 'αβγδεζηθικλμνξοπρσςτυφχψω', 'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΣΤΥΦΧΨΩ'),1,1)">
                    <xsl:sort select="current-group()[1]/*:entry/*:form/*:orth[@type='regularised']/substring(translate(., 'αβγδεζηθικλμνξοπρσςτυφχψω', 'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΣΤΥΦΧΨΩ'),1,1)"/>
                    <xsl:variable name="initial" select="current-group()[1]/*:entry/*:form/*:orth[@type='regularised']/substring(translate(., 'αβγδεζηθικλμνξοπρσςτυφχψω', 'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΣΤΥΦΧΨΩ'),1,1)"/>
                    <item id="{$initial}">
                        <name><xsl:value-of select="$initial"/></name>
                        <amount><xsl:value-of select="count(current-group())"/></amount>
                        <xsl:call-template name="initDuo">
                            <xsl:with-param name="lang" select="'grc'"/>
                        </xsl:call-template>
                    </item>    
                </xsl:for-each-group> 
            </item>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template match="/*/*:la">
        <xsl:for-each-group select="*:div" group-by="@type">
            <item id="{current-group()[1]/@type}">
                <amount><xsl:value-of select="count(current-group())"/></amount>
                <xsl:for-each-group select="current-group()" group-by="*:entry/*:form/*:orth[@type='regularised']/substring(translate(., 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1)">
                    <xsl:sort select="current-group()[1]/*:entry/*:form/*:orth[@type='regularised']/substring(translate(., 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1)"/>
                    <xsl:variable name="initial" select="current-group()[1]/*:entry/*:form/*:orth[@type='regularised']/substring(translate(., 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1)"/>
                    <item id="{$initial}">
                        <name><xsl:value-of select="$initial"/></name>
                        <amount><xsl:value-of select="count(current-group())"/></amount>
                        <xsl:call-template name="initDuo">
                            <xsl:with-param name="lang" select="'la'"/>
                        </xsl:call-template>
                    </item>    
                </xsl:for-each-group> 
            </item>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template name="initDuo">
        <xsl:param name="lang"/>
        <xsl:variable name="lower">
            <xsl:choose>
                <xsl:when test="$lang = 'grc'">
                    <xsl:value-of select="'αβγδεζηθικλμνξοπρσςτυφχψω'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'abcdefghijklmnopqrstuvwxyz'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="upper">
            <xsl:choose>
                <xsl:when test="$lang = 'grc'">
                    <xsl:value-of select="'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΣΤΥΦΧΨΩ'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:for-each-group select="current-group()/*" group-by="*:form/*:orth[@type='regularised']/substring(translate(., $lower, $upper),1,2)">
            <xsl:sort select="current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., $lower, $upper),1,2)"/>
            <item id="{concat(current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., $lower, $upper),1,1),current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., $upper, $lower),2,1))}">
                <name>
                    <xsl:value-of select="concat(current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., $lower, $upper),1,1),current-group()[1]/*:form/*:orth[@type='regularised']/substring(translate(., $upper, $lower),2,1))"/>
                </name>
                <amount>
                    <xsl:value-of select="count(current-group())"/>
                </amount>
            </item>
        </xsl:for-each-group>
    </xsl:template>

</xsl:stylesheet>