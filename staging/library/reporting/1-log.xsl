<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:pwl="http://papyri.uni-koeln.de/papyri-woerterlisten"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <!-- 
        <p:documentation>
            <h2>Import reporting</h2>
            <p>This step generates a report in markdown format showing the proportion between previously existing and newly added entries.</p>
        </p:documentation>
    -->
    
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="comparisonBase"/>
    
    <!-- Character exceptions: intended greek chars in latin lemmata, intended latin chars in greek lemmata -->
    <xsl:variable name="knownExceptions">
        <word>Agaθo</word><!-- wl-la-03572; mitgeteilt am 29.05.2018 -->
    </xsl:variable>
    
    <xsl:variable name="current-lemmata">
        <current>
            <xsl:for-each select="collection(concat('../../../',$comparisonBase,'/?recurse=yes;select=wl-*.xml'))//*:entry/*:form/*:orth[@type='original'][text()]">
                <xsl:copy>
                    <xsl:copy-of select="@xml:lang"/>
                    <xsl:copy-of select="ancestor::*:entry/@xml:id"/>
                    <xsl:attribute name="category" select="ancestor::*:div/@type"/>
                    <xsl:attribute name="filemakerID" select="following-sibling::*:idno"/>
                    <xsl:copy-of select="text()"/>
                </xsl:copy>
            </xsl:for-each>
        </current>
    </xsl:variable>
    
    <xsl:variable name="categories">
        <category>general</category>
        <category>monthsDays</category>
        <category>geography</category>
        <category>persons</category>
        <category>religion</category>
    </xsl:variable>
    <xsl:variable name="rootNode" select="/"/>
    <xsl:variable name="versions" select="document('../../../meta/versions.xml')//*:listChange[@type='versions']//*:change[preceding-sibling::*:change/*:note]"/>
    
    <xsl:template match="/">
        <md-wrapper>
<xsl:text>
# WL Import Report </xsl:text><xsl:value-of select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/><xsl:text>

*Check this report for sanity. If all looks good replace `current` directory by `output` directory and create a commit.*
</xsl:text>
            <xsl:if test="not($comparisonBase = 'current')">
<xsl:text>

**CAUTION: Reporting based on test dataset**

</xsl:text>
            </xsl:if>
            
<xsl:text>
## Number of files/lemmata before and after import

</xsl:text>
<xsl:text>
### Greek 

</xsl:text>
            <xsl:call-template name="count-table-by-category">
                <xsl:with-param name="language" select="'grc'"/>
            </xsl:call-template>
            <xsl:text>
</xsl:text>
<xsl:text>
### Latin 

</xsl:text>
            <xsl:call-template name="count-table-by-category">
                <xsl:with-param name="language" select="'la'"/>
            </xsl:call-template>
            <xsl:text>
</xsl:text>
<xsl:text>
### Total 

</xsl:text>
<xsl:text>
| category        | count before import | count after import | difference | difference (%) |
| :-----------: |-------------:|-------------:|-------------:|-------------:|
</xsl:text>
<xsl:text>| **Total**     |</xsl:text>
        <xsl:value-of select="count($current-lemmata//*:orth)"/>
<xsl:text>| **</xsl:text>
        <xsl:value-of select="count(*:wl-wrapper/*/*:div)"/>
<xsl:text>** |</xsl:text>
        <xsl:value-of select="count(*:wl-wrapper/*/*:div) - count($current-lemmata//*:orth)"/>
<xsl:text>|</xsl:text> 
        <xsl:choose>
            <xsl:when test="count($current-lemmata//*:orth) gt 0">
                <xsl:variable name="difference" select="count(*:wl-wrapper/*/*:div) div count($current-lemmata//*:orth) * 100"/>
                <xsl:if test="$difference gt 100"><xsl:text>+</xsl:text></xsl:if>
                <xsl:value-of select="format-number($difference - 100,'##.00')"/>         
            </xsl:when>
            <xsl:otherwise>(infinite)</xsl:otherwise>
        </xsl:choose>
<xsl:text>|</xsl:text>
            
<xsl:text>
## New files/lemmata

</xsl:text>
            <xsl:if test="not($comparisonBase = 'current')">
<xsl:text>

**CAUTION: Reporting based on test dataset (restricted input, restricted base for comparison) – many of the following entries are not new**

</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
            
<xsl:text>## Control section
    
#### Entries that already existed before the import, but were not recognized

This section is empty unless there are lemmata, that were changed in FileMaker since the last export. In that case, the changes (most often these are regularisations on character level) should be ported to the `current` data and the transformation re-run until this section is empty.
</xsl:text>
            <xsl:apply-templates mode="control"/>

            <xsl:text expand-text="true">## Character test
    
#### Entries that contain suspicious Unicode characters

This section is empty unless there are Greek lemmata that contain Latin characters (except punctuation and numbers) or Latin lemmata that contain Greek characters. The entries should be fixed in the input and the transformation re-run until this section is empty or the characters are judged correct (this should be recorded as known exception in [{replace(base-uri(document('')),'.+/papyri-wl-data','/papyri-wl-data')}](https://github.com/cceh/papyri-wl-data/edit/master{replace(base-uri(document('')),'.+/papyri-wl-data','')}).).

</xsl:text>
            <xsl:text>|Lemma|PWL-ID|FM number|offending character(s)|note|&#10;</xsl:text>
            <xsl:text>|---|---|---|---|---|&#10;</xsl:text>
            <!-- greek lemmata may contain some latin characters; these are ignored ('') -->
            <xsl:apply-templates select="//grc//*:entry[*:form/*:orth[@type='regularised']
                [pwl:skip(.) => matches('\p{IsBasicLatin}')][not(matches(.,'\((Gen|Dat|Akk)\.\)'))]]" mode="characterTesting"/>
            <xsl:apply-templates select="//la//*:entry[*:form/*:orth[@type='regularised'][matches(.,'\p{IsGreek}')]]" mode="characterTesting"/>

        </md-wrapper>
    </xsl:template>
    
    <xsl:template match="*:entry" expand-text="1" mode="characterTesting">
        <xsl:text>|{*:form/*:orth[@type='regularised']}|{@xml:id}|{*:form/*:idno[@type='fp7']}{if (matches(@xml:id,'-la-')) then ' (la, '||parent::*:div/@type||')' else ' (grc, '||parent::*:div/@type||')'}|</xsl:text>
        <xsl:variable name="regex" select="if (matches(@xml:id,'-la-')) then '\p{IsGreek}' else '\p{IsBasicLatin}'"/>
        <xsl:analyze-string select="*:form/*:orth[@type='regularised']" regex="{$regex}">
            <xsl:matching-substring><xsl:value-of select="pwl:skip(.)"/></xsl:matching-substring>
        </xsl:analyze-string>
        <xsl:text>|{if (*:form/*:orth[@type='regularised'] = $knownExceptions/*) then 'known exception' else ''}|&#10;</xsl:text>
    </xsl:template>
    
    <xsl:function name="pwl:skip">
        <!-- this function removes some latin characters that occur frequently in greek lemmata -->
        <xsl:param name="input"/>
        <xsl:value-of select="replace($input,' ','') => replace('[1-9]+','') => replace(',','') => replace('\.','') => replace('\[','') => replace('\]','') => replace('\(','') => replace('\)','') => replace('-','') => replace('\?','') => replace('/','') => replace('`','') => replace('´','')"/>
    </xsl:function>
    
    <xsl:template match="*:grc">
<xsl:text>
### Greek 

</xsl:text>
        <xsl:call-template name="entry-table-by-category"/>
    </xsl:template>
    
    <xsl:template match="*:la">
<xsl:text>
### Latin 

</xsl:text>
        <xsl:call-template name="entry-table-by-category"/>
    </xsl:template>
    
    <xsl:template match="*:grc" mode="control">
        <xsl:text>
### Greek 

</xsl:text>
        <xsl:call-template name="version-check"/>
    </xsl:template>
    
    <xsl:template match="*:la" mode="control">
        <xsl:text>
### Latin 

</xsl:text>
        <xsl:call-template name="version-check"/>
    </xsl:template>
    
    <xsl:template name="entry-table-by-category">
        <xsl:for-each-group select="*:div" group-by="@type">
<xsl:text>#### Type: </xsl:text><xsl:value-of select="@type"/><xsl:text>
</xsl:text>
<xsl:text>
| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
</xsl:text>
            <xsl:for-each select="current-group()/*:entry[@NEW='new']">
                <xsl:sort select="*:form/*:orth[@type='original']"/>
<xsl:text>| </xsl:text>
                <xsl:value-of select="*:form/*:orth[@type='original']"/>
<xsl:text>| </xsl:text>
                <xsl:value-of select="@xml:id"/>
<xsl:text>| </xsl:text>
                <xsl:value-of select="*:form/*:idno[@type='fp7']"/>
<xsl:text>| </xsl:text>
                <xsl:for-each select="*:xr/*:list/*:item">
<xsl:text>`</xsl:text><xsl:value-of select="*:ref"/><xsl:text>` </xsl:text>                    
                </xsl:for-each>
<xsl:text>|
</xsl:text>
            </xsl:for-each>            
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template name="version-check">
        <xsl:for-each-group select="*:div" group-by="@type">
<xsl:text>##### Type: </xsl:text><xsl:value-of select="@type"/><xsl:text>
</xsl:text>            
<xsl:text>
| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
</xsl:text>
            <xsl:for-each select="current-group()/*:entry[@NEW='new'][*:xr/*:list/*:item/*:ref/substring-after(@target,'/quellen#') = $versions//*:ref/tokenize(@target,'/')[last()]]">
                <xsl:sort select="*:form/*:orth[@type='original']"/>
                <xsl:text>| </xsl:text>
                <xsl:value-of select="*:form/*:orth[@type='original']"/>
                <xsl:text>| </xsl:text>
                <xsl:value-of select="@xml:id"/>
                <xsl:text>| </xsl:text>
                <xsl:value-of select="*:form/*:idno[@type='fp7']"/>
                <xsl:text>| </xsl:text>
                <xsl:for-each select="*:xr/*:list/*:item">
                    <xsl:text>`</xsl:text><xsl:value-of select="*:ref"/><xsl:text>` </xsl:text>                    
                </xsl:for-each>
                <xsl:text>|
</xsl:text>
            </xsl:for-each>            
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template name="count-table-by-category">
        <xsl:param name="language"/>
<xsl:text>
| category        | count before import | count after import | difference | difference (%) |
| :-----------: |-------------:|-------------:|-------------:|-------------:|
</xsl:text>
        <xsl:for-each select="$categories/*:category">
            <xsl:variable name="count-old" select="count($current-lemmata//*:orth[@xml:lang=$language][@category=current()])"/>
            <xsl:variable name="count-new" select="count($rootNode/*:wl-wrapper/*[local-name()=$language]/*:div[@type=current()])"/>
<xsl:text>| </xsl:text>
            <xsl:value-of select="current()"/>
<xsl:text>| </xsl:text>
            <xsl:value-of select="$count-old"/>
<xsl:text>| </xsl:text>
            <xsl:value-of select="$count-new"/>
<xsl:text>| </xsl:text>
            <xsl:value-of select="$count-new - $count-old"/>
<xsl:text>| </xsl:text>
            <xsl:choose>
                <xsl:when test="$count-old gt 0">
                    <xsl:variable name="difference" select="$count-new div $count-old * 100"/>
                    <xsl:if test="$difference gt 100"><xsl:text>+</xsl:text></xsl:if>
                    <xsl:value-of select="format-number($difference - 100,'##.00')"/>         
                </xsl:when>
                <xsl:otherwise>(infinite)</xsl:otherwise>
            </xsl:choose>
<xsl:text>| 
</xsl:text>
        </xsl:for-each>
<xsl:text>| **Total**     |</xsl:text>
        <xsl:value-of select="count($current-lemmata//*:orth[@xml:lang=$language])"/>
<xsl:text>| **</xsl:text>
        <xsl:value-of select="count(*:wl-wrapper/*[local-name()=$language]/*:div)"/>
<xsl:text>** |</xsl:text>
        <xsl:value-of select="count(*:wl-wrapper/*[local-name()=$language]/*:div) - count($current-lemmata//*:orth[@xml:lang=$language])"/>
<xsl:text>|</xsl:text> 
        <xsl:choose>
            <xsl:when test="count($current-lemmata//*:orth) gt 0">
                <xsl:variable name="difference" select="count(*:wl-wrapper/*[local-name()=$language]/*:div) div count($current-lemmata//*:orth[@xml:lang=$language]) * 100"/>
                <xsl:if test="$difference gt 100"><xsl:text>+</xsl:text></xsl:if>
                <xsl:value-of select="format-number($difference - 100,'##.00')"/>         
            </xsl:when>
            <xsl:otherwise>(infinite)</xsl:otherwise>
        </xsl:choose>
<xsl:text>|</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
