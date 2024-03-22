<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    exclude-result-prefixes="xs map" version="3.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    
    <!-- 
        <p:documentation>
            <h2>Initial TEI structure</h2>
            <p>In this step, the entries are transformed to fit the TEI model of the project. IDs are taken from existing entries.</p>
            <p>Whereas greek entries are exported in one file per category (5 lists), latin entries are exported in 
        a single file (1 list) and the respective category is recorded in one of the fields. This transformation
        thus applies slightly different templates to greek and latin entries.</p>
        </p:documentation>
    -->
    
    <xsl:param name="comparisonBase"/>
    <xsl:param name="schemaPath"/>
    <xsl:param name="quot">"</xsl:param>
    
    <xsl:strip-space elements="*"/>
    
    <!--<xsl:variable name="files" select="collection(concat('../../../',$comparisonBase,'/?recurse=yes;select=wl-*.xml'))"/>-->
    
    <xsl:template match="/">
        <xsl:message><xsl:value-of select="current-dateTime() || ' – ' || static-base-uri()"/></xsl:message>
        <!-- Processing instruction -->
        <xsl:processing-instruction name="xml-model"><xsl:value-of select="concat('href=',$quot,$schemaPath,'/papyri-wl.rng',$quot,' type=',$quot,'application/xml',$quot,' schematypens=',$quot,'http://relaxng.org/ns/structure/1.0',$quot)"/></xsl:processing-instruction>
        <!--<xsl:processing-instruction name="xml-model">href="papyri-wl.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>-->
        <xsl:apply-templates/>
    </xsl:template>
    
    <!--Identity template, kopiert Elemente und Attribute, wo keine spezifischere Regel folgt -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- previously in use: grouping key for latin lemmata by category -->
    <!--<xsl:key name="lateinisch-nach-kategorie" match="*:ROW" use="*:COL[6]/*:DATA" />-->
    
    <xsl:template match="*:FMPXMLRESULT">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="*:RESULTSET[preceding-sibling::*:DATABASE[not(contains(@NAME,'Lateinisch'))]]">
        <xsl:variable name="listType">
            <xsl:if test="preceding-sibling::*:DATABASE[contains(@NAME,'Monate')]">monthsDays</xsl:if>
            <xsl:if test="preceding-sibling::*:DATABASE[contains(@NAME,'Namen')]">persons</xsl:if>
            <xsl:if test="preceding-sibling::*:DATABASE[contains(@NAME,'Geographie')]">geography</xsl:if>
            <xsl:if test="preceding-sibling::*:DATABASE[contains(@NAME,'Religion')]">religion</xsl:if>
            <xsl:if test="preceding-sibling::*:DATABASE[contains(@NAME,'allgemein')]">general</xsl:if>
        </xsl:variable>
        
        <div>
            <xsl:attribute name="type" select="$listType"/>
            <head>
                <xsl:if test="$listType='monthsDays'">Monate und Tage</xsl:if>
                <xsl:if test="$listType='persons'">Personennamen</xsl:if>
                <xsl:if test="$listType='geography'">Geographie</xsl:if>
                <xsl:if test="$listType='religion'">Götter, Heiligtümer (s. auch unter Geographie)</xsl:if>
                <xsl:if test="$listType='general'">Allgemeines Wörterverzeichnis</xsl:if>
            </head>
            <xsl:apply-templates>
                <xsl:with-param name="language" select="'Griechisch'"/>
                <xsl:with-param name="listType" select="$listType"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    
    <xsl:template match="*:RESULTSET[preceding-sibling::*:DATABASE[contains(@NAME,'Lateinisch')]]">
        <!-- grouping latin lemmata by category -->
        <xsl:for-each-group select="*:ROW" group-by="*:COL[7]/*:DATA">
            
        <!-- previously in use: Muenchian grouping -->
        <!--<xsl:for-each select="*:ROW[generate-id() =
            generate-id(key('lateinisch-nach-kategorie', *:COL[6]/*:DATA)[1])]">-->
            <xsl:variable name="listType-la">
                <xsl:choose>
                    <xsl:when test="*:COL[7]/*:DATA='a'"><xsl:value-of select="'Monate'"/></xsl:when>
                    <xsl:when test="*:COL[7]/*:DATA='b'"><xsl:value-of select="'Namen'"/></xsl:when>
                    <xsl:when test="*:COL[7]/*:DATA='c'"><xsl:value-of select="'Geographie'"/></xsl:when>
                    <xsl:when test="*:COL[7]/*:DATA='d'"><xsl:value-of select="'Religion'"/></xsl:when>
                    <xsl:when test="*:COL[7]/*:DATA='e'"><xsl:value-of select="'allgemein'"/></xsl:when>
                    <!-- uncategorized/spurious -->
                    <xsl:otherwise>ohne Kategorie</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="listType">
                <xsl:if test="$listType-la='Monate'">monthsDays</xsl:if>
                <xsl:if test="$listType-la='Namen'">persons</xsl:if>
                <xsl:if test="$listType-la='Geographie'">geography</xsl:if>
                <xsl:if test="$listType-la='Religion'">religion</xsl:if>
                <xsl:if test="$listType-la='allgemein'">general</xsl:if>
                <xsl:if test="$listType-la='ohne Kategorie'">noCategory</xsl:if>
            </xsl:variable>
            <div>
                <xsl:attribute name="type" select="$listType"/>
                <head>
                    <xsl:if test="$listType-la='Monate'">Monate und Tage</xsl:if>
                    <xsl:if test="$listType-la='Namen'">Personennamen</xsl:if>
                    <xsl:if test="$listType-la='Geographie'">Geographie</xsl:if>
                    <xsl:if test="$listType-la='Religion'">Götter, Heiligtümer (s. auch unter Geographie)</xsl:if>
                    <xsl:if test="$listType-la='allgemein'">Allgemeines Wörterverzeichnis</xsl:if>
                    <!-- uncategorized/spurious -->
                    <xsl:if test="$listType-la='ohne Kategorie'">Ohne Kategorie</xsl:if>
                </head>
                <!-- previously in use: -->
                <!--<xsl:for-each select="key('lateinisch-nach-kategorie', *:COL[6]/*:DATA)">-->
                <xsl:for-each select="current-group()">
                    <xsl:apply-templates select=".">
                        <xsl:with-param name="language" select="'Lateinisch'"/>
                        <xsl:with-param name="listType" select="$listType"/>
                    </xsl:apply-templates>
                </xsl:for-each>
                <!--</xsl:for-each>-->
            </div>
        <!--</xsl:for-each>-->
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template match="*:RESULTSET/*:ROW[not(contains(*:COL[2]/*:DATA,'Leitkarte'))]">
        <xsl:param name="listType"/>
        <xsl:param name="language"/>
        <xsl:variable name="language-short">
            <xsl:if test="$language='Griechisch'">grc</xsl:if>
            <xsl:if test="$language='Lateinisch'">la</xsl:if>
        </xsl:variable>
        <entry>
            <xsl:variable name="compare" select="*:COL[3]/*:DATA/text()"/>
            <xsl:variable name="newEntry" select="if (*:COL[14]/*:DATA[matches(text(),'^wl-(grc|la)-\d{5}$')]) then 'false' else 'true'"/>
            <xsl:attribute name="type" select="'main'"/>
            <xsl:variable name="id">
                <!-- testing whether the entry exists (in the same category)
                    case entry exists: ID is recycled
                    case entry does not exist: temporary ID is assigned 
                    
                    NB: unicode normalization is used to control for composed/decomposed unicode representations -->
                <xsl:choose>
                    <xsl:when test="$newEntry = 'false'">
                        <xsl:value-of select="*:COL[14]/*:DATA => normalize-space()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat('wl_',$listType,'-',$language-short,'_',format-number(@RECORDID,'00000'),'_newEntry')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="xml:id" select="$id"/>
            <xsl:if test="$id != *:COL[14]/*:DATA and not(*:COL[14]/*:DATA='')" expand-text="true">
                <TEMPDATA id='id-check'>
                    <in-dataset>{$id}</in-dataset>
                    <in-input-file>{*:COL[14]/*:DATA}</in-input-file>
                </TEMPDATA>
            </xsl:if>
            <form type="lemma">
                <orth>
                    <xsl:attribute name="xml:lang" select="$language-short"/>
                    <xsl:attribute name="type" select="'original'"/>
                    <xsl:attribute name="extent">
                        <xsl:choose>
                            <xsl:when test="contains(*:COL[3],'[') or contains(*:COL[3],']') or contains(*:COL[3],'?')">part</xsl:when>
                            <xsl:otherwise>full</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:value-of select="*:COL[3]"/>
                </orth>
                <orth>
                    <xsl:attribute name="xml:lang">
                        <xsl:if test="$language='Griechisch'">grc</xsl:if>
                        <xsl:if test="$language='Lateinisch'">la</xsl:if>
                    </xsl:attribute>
                    <xsl:attribute name="type" select="'regularised'"/>
                    <xsl:attribute name="extent">
                        <xsl:choose>
                            <xsl:when test="contains(*:COL[3],'[') or contains(*:COL[3],']') or contains(*:COL[3],'?')">part</xsl:when>
                            <xsl:otherwise>full</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:value-of select="normalize-unicode(replace(normalize-unicode( *:COL[3], 'NFKD' ), '\p{Mn}', '' ),'NFKC')"/>
                </orth>
                <form type="derivative" value="reverse">
                    <orth>
                        <xsl:attribute name="xml:lang">
                            <xsl:if test="$language='Griechisch'">grc</xsl:if>
                            <xsl:if test="$language='Lateinisch'">la</xsl:if>
                        </xsl:attribute>
                        <xsl:attribute name="type" select="'original'"/>
                        <xsl:attribute name="extent">
                            <xsl:choose>
                                <xsl:when test="contains(*:COL[3],'[') or contains(*:COL[3],']') or contains(*:COL[3],'?')">part</xsl:when>
                                <xsl:otherwise>full</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:choose>
                            <!-- case: Lemma revers present -->
                            <xsl:when test="*:COL[5]/*:DATA/*"><xsl:value-of select="*:COL[5]/*:DATA"/></xsl:when>
                            <!-- case: Lemma revers missing -->
                            <xsl:otherwise>
                                <xsl:call-template name="reverse">
                                    <xsl:with-param name="input" select="*:COL[3]"/>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </orth>
                    <orth>
                        <xsl:attribute name="xml:lang">
                            <xsl:if test="$language='Griechisch'">grc</xsl:if>
                            <xsl:if test="$language='Lateinisch'">la</xsl:if>
                        </xsl:attribute>
                        <xsl:attribute name="type" select="'regularised'"/>
                        <xsl:attribute name="extent">
                            <xsl:choose>
                                <xsl:when test="contains(*:COL[3],'[') or contains(*:COL[3],']') or contains(*:COL[3],'?')">part</xsl:when>
                                <xsl:otherwise>full</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:call-template name="reverse">
                            <xsl:with-param name="input" select="normalize-unicode(replace(normalize-unicode( *:COL[3], 'NFKD' ), '\p{Mn}', '' ),'NFKC')"/>
                        </xsl:call-template>
                    </orth>
                </form>
                <xsl:choose>
                    <xsl:when test="$newEntry = 'false'">
                        <note type="resp">Anlage des Lemmas durch <name ref="../../corpus.xml#hagedorn_d">D. Hagedorn</name> <date type="creation" notAfter="2016">vor 2016</date>.</note>
                    </xsl:when>
                    <xsl:otherwise>
                        <note type="resp">Anlage des Lemmas am <date type="creation" when="{format-date(current-date(), '[Y0001]-[M01]-[D01]')}">
                            <xsl:value-of select="format-date(current-date(),'[D1o] [MNn] [Y0001]','de',null,'DE')"/></date>.</note>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="string-length(*:COL[1])&gt;0">
                    <!--<note type="ref"><xsl:value-of select="replace(replace(*:COL[1],'^\(',''),'\)$','')"/></note>-->
                    <xsl:variable name="vmap" as="map(xs:string, xs:string)">
                        <xsl:map>
                            <xsl:for-each select="*:COL[15]/*:DATA[text()]">
                                <xsl:if test="//*:ROW[*:COL[14]/*:DATA=current()]/*:COL[3]/*:DATA/text()">
                                    <xsl:map-entry
                                        key="xs:string(text())"
                                        select="xs:string(//*:ROW[*:COL[14]/*:DATA=current()]/*:COL[3]/*:DATA/text())"/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:map>
                    </xsl:variable>
                    <note type="ref">
                        <xsl:variable name="regex">
                            <xsl:for-each select="map:keys($vmap)">
                                <xsl:value-of select="$vmap(.)"/>
                                <xsl:if test="not(position()=last())">|</xsl:if>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="map:size($vmap) gt 0">
                                <xsl:analyze-string select="replace(replace(*:COL[1]/*:DATA/text() => normalize-space(),'^\(',''),'\)$','')" regex="{$regex}">
                                    <xsl:matching-substring>
                                        <xsl:variable name="match" select="."/>
                                        <ref target="#{map:for-each($vmap,
                                            function ($k, $v){
                                                if ($v = $match) then ($k)
                                                else ()
                                                })}">
                                            <xsl:copy-of select="."/>
                                        </ref>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring expand-text="true">
                                        <xsl:value-of select="."/>
                                    </xsl:non-matching-substring>
                                </xsl:analyze-string>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="replace(replace(*:COL[1]/*:DATA/text() => normalize-space(),'^\(',''),'\)$','')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </note>
                    <TEMPDATA id='see-also'>
                        <xsl:for-each select="map:keys($vmap)">
                            <relatedItem corresp="{map:get($vmap,.)}" target="#{.}"/>
                        </xsl:for-each>
                    </TEMPDATA>
                </xsl:if>
                <idno type="fp7"><xsl:value-of select="@RECORDID"/></idno>
            </form>
            <xsl:comment>Belegstellen</xsl:comment>
            <!-- Problem: einige werden nicht gefunden; stattdessen bestehende kopieren und neue ergänzen? dann wohl in eigener XSL-Datei -->
            <xr>
                <list>
                    <xsl:for-each select="tokenize(*:COL[8],';\s')">
                        <!-- Extract reference from literature.xml -->
                        <xsl:variable name="literature-xml" select="doc('../../../meta/literature.xml')"/>
                        <xsl:variable name="ref">
                            <!-- segmentation of different forms that occur in the field; cf. https://github.com/cceh/papyri-wl/issues/138 -->
                            <xsl:choose>
                                <xsl:when test="contains(.,'(') and not(contains(.,' + ('))">
                                    <xsl:value-of select="normalize-space(translate(substring-before(.,'('),'⁲','²'))"/><!-- U+2073: ³ -->
                                </xsl:when>
                                <xsl:when test="contains(.,', Index')">
                                    <xsl:value-of select="normalize-space(translate(substring-before(.,', Index'),'⁲','²'))"/>
                                </xsl:when>
                                <xsl:when test="contains(.,' Index')">
                                    <xsl:value-of select="normalize-space(translate(substring-before(.,' Index'),'⁲','²'))"/>
                                </xsl:when>
                                <xsl:when test="contains(.,', Abteilung')">
                                    <xsl:value-of select="normalize-space(translate(substring-before(.,', Abteilung'),'⁲','²'))"/>
                                </xsl:when>
                                <xsl:when test="contains(.,', S. ')">
                                    <xsl:value-of select="normalize-space(translate(substring-before(.,', S. '),'⁲','²'))"/>
                                </xsl:when>
                                <xsl:when test="contains(.,' + ')">
                                    <xsl:value-of select="normalize-space(translate(substring-before(.,' + '),'⁲','²'))"/>
                                </xsl:when>
                                <xsl:when test="ends-with(.,' A u. B')">
                                    <xsl:value-of select="normalize-space(translate(replace(.,'\sA u\. B$',''),'⁲','²'))"/>
                                </xsl:when>
                                <xsl:when test="ends-with(.,' B')">
                                    <xsl:value-of select="normalize-space(translate(replace(.,'\sB$',''),'⁲','²'))"/>
                                </xsl:when>
                                <xsl:when test="ends-with(.,' A')">
                                    <xsl:value-of select="normalize-space(translate(replace(.,'\sA$',''),'⁲','²'))"/>
                                </xsl:when>
                                <xsl:otherwise><xsl:value-of select="normalize-space(translate(.,'⁲','²'))"/></xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="litID">
                            <xsl:choose>
                                <xsl:when test="$literature-xml//*:title[@type='short'][text()=$ref]/parent::*:bibl/@xml:id">
                                    <xsl:value-of select="$literature-xml//*:title[@type='short'][text()=$ref]/parent::*:bibl/@xml:id"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$literature-xml//*:title[@type='short'][text()=$ref]/parent::*:bibl/@sameAs"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <item>
                            <ref target="https://papyri.uni-koeln.de/papyri-woerterlisten/quellen#{$litID}">
                                <xsl:choose>
                                    <xsl:when test="contains(.,'(')">		
                                        <xsl:value-of select="normalize-space(translate(substring-before(.,'('),'⁲','²'))"/><!-- U+2073: ³ -->		
                                    </xsl:when>		
                                    <xsl:otherwise><xsl:value-of select="normalize-space(translate(.,'⁲','²'))"/></xsl:otherwise>		
                                </xsl:choose>
                            </ref>
                            <xsl:if test="contains(.,'(')">
                                <note type="addInfo"><xsl:value-of select="normalize-space(translate(substring-after(substring-before(.,')'),'('),'⁲','²'))"/></note>
                            </xsl:if>
                        </item>
                    </xsl:for-each>
                </list>
            </xr>
        </entry>
    </xsl:template>
    
    <!-- no action templates -->
    <xsl:template match="*:ERRORCODE"/>
    <xsl:template match="*:PRODUCT"/>
    <xsl:template match="*:DATABASE"/>
    <xsl:template match="*:METADATA"/>
    <xsl:template match="*:RESULTSET/*:ROW[contains(*:COL[2]/*:DATA,'Leitkarte')]"/>
    
    <!-- functions -->
    <xsl:function name="ns:substring-after-last" as="xs:string" xmlns:ns="cceh">
        <xsl:param name="value" as="xs:string?"/>
        <xsl:param name="separator" as="xs:string"/>        
        <xsl:choose>
            <xsl:when test="contains($value, $separator)">
                <xsl:value-of select="ns:substring-after-last(substring-after($value, $separator), $separator)" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$value" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:template name="reverse">
        <xsl:param name="input"/>
        <xsl:variable name="len" select="string-length($input)"/>
        <xsl:choose>
            <!-- strings of length less than 2 are trivial to reverse -->
            <xsl:when test="$len &lt; 2">
                <xsl:value-of select="$input"/>
            </xsl:when>
            <!-- strings of length 2 are also trivial to reverse -->
            <xsl:when test="$len = 2">
                <xsl:value-of select="substring($input,2,1)"/>
                <xsl:value-of select="substring($input,1,1)"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- swap the recursive application of this template to 
               the first half and second half of input -->
                <xsl:variable name="mid" select="floor($len div 2)"/>
                <xsl:call-template name="reverse">
                    <xsl:with-param name="input"
                        select="substring($input,$mid+1,$mid+1)"/>
                </xsl:call-template>
                <xsl:call-template name="reverse">
                    <xsl:with-param name="input"
                        select="substring($input,1,$mid)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="wl-wrapper">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Warnings (element based) -->
    <!--<xsl:template match="*">
        <ERROR>
            <xsl:comment>
			<xsl:text>ERROR: element '</xsl:text>
			<xsl:value-of select="local-name()"/>
			<xsl:text>' not handled</xsl:text>
		</xsl:comment>
            <xsl:apply-templates/>
            <xsl:comment>
			<xsl:value-of select="local-name()"/>
		</xsl:comment>
        </ERROR>
    </xsl:template>-->
    
</xsl:stylesheet>
