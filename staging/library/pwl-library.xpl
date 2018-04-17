<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:pwl="http://papyri.uni-koeln.de/papyri-woerterlisten" version="1.0">

    <p:declare-step type="pwl:corpus" name="wl-input-corpus">
        
        <p:input port="source"/>
        <p:input port="parameters" kind="parameter"/>
        <p:output port="result"/>
        
        <p:option name="result-path" select="$result-path"/>
        <p:option name="result-url" select="$result-url"/>
        <p:option name="version" select="$version"/>
        <p:option name="editor" select="$editor"/>
        <p:variable name="filename" select="concat($result-path,'/','corpus.xml')"/>
        
        <p:documentation>
            <h2>TEI Corpus</h2>
            <p>This steps creates a corpus file with xi:include references to all entries/files.</p>
        </p:documentation>
        
        <p:xslt name="create-corpus">
            <p:input port="stylesheet">
                <p:document href="corpus/1-corpus.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:store>
            <p:with-option name="href" select="$filename"/>
            <p:with-option name="indent" select="'true'"/>
        </p:store>
        
        <p:identity>
            <p:input port="source">
                <p:pipe port="result" step="create-corpus"/>
            </p:input>    
        </p:identity>
        
    </p:declare-step>
    
    <p:declare-step type="pwl:log" name="wl-input-reporting">
        
        <p:input port="source"/>
        <p:input port="parameters" kind="parameter"/>

        <p:option name="comparisonBase" select="$comparisonBase"/>
        <p:option name="version" select="$version"/>
        
        <p:documentation>
            <h2>Import reporting</h2>
            <p>This step generates a report in markdown format showing the proportion between previously existing and newly added entries.</p>
        </p:documentation>
        
        <p:xslt>
            <p:input port="stylesheet">
                <p:document href="reporting/1-log.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:store method="text">
            <p:with-option name="href" select="concat('../reporting/import-report_',format-date(current-date(), '[Y0001][M01][D01]'),'.md')"/>
        </p:store>
        
    </p:declare-step>
    
    <p:declare-step type="pwl:util" name="wl-util">
        
        <p:input port="source" sequence="true"/>
        <p:input port="parameters" kind="parameter"/>
        <!--<p:output port="result"/>-->
        
        <p:option name="filepath" select="'../util/'"/>
        
        <p:documentation>
            <h2>Webapp output</h2>
            <p>This step generates files that are used in the webapp. They are written to the 'util' directory.</p>
        </p:documentation>
        
        <p:split-sequence test="/*:wl-wrapper" name="Split"/>
        
        <!--    matched: wrapped-transformation-result
                not-matched: corpus  
        -->
        
        <p:identity name="corpus">
            <p:input port="source">
                <p:pipe port="not-matched" step="Split"/>
            </p:input>
        </p:identity>
        
        <p:group name="st-grc-cat">
            
            <p:documentation>
                <h2>Statistical listing: by category (XML)</h2>
                <p>This step saves statistical information contained in the corpus file in an XML file (as understood by the webapp).</p>
            </p:documentation>
            
            <p:variable name="filepath" select="$filepath"/>
            
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="util/1-st-grc-cat.xsl"/>
                </p:input>
            </p:xslt>
            
            <p:namespace-rename from="http://www.tei-c.org/ns/1.0" to=""/>
            <p:namespace-rename from="http://papyri.uni-koeln.de/papyri-woerterlisten" to=""/>
            <p:namespace-rename from="http://www.w3.org/2003/XInclude" to=""/>
            
            <p:store>
                <p:with-option name="href" select="concat($filepath,'st-grc-cat.xml')"/>
                <p:with-option name="omit-xml-declaration" select="'false'"/>
                <p:with-option name="indent" select="'true'"/>
            </p:store>
            
        </p:group>
        
        <p:identity>
            <p:input port="source">
                <p:pipe port="not-matched" step="Split"/>
            </p:input>
        </p:identity>
        
        <p:group name="st-la-cat">
            
            <p:documentation>
                <h2>Statistical listing: by category (XML)</h2>
                <p>This step saves statistical information contained in the corpus file in an XML file (as understood by the webapp).</p>
            </p:documentation>
            
            <p:variable name="filepath" select="$filepath"/>
            
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="util/2-st-la-cat.xsl"/>
                </p:input>
            </p:xslt>
            
            <p:namespace-rename from="http://www.tei-c.org/ns/1.0" to=""/>
            <p:namespace-rename from="http://papyri.uni-koeln.de/papyri-woerterlisten" to=""/>
            <p:namespace-rename from="http://www.w3.org/2003/XInclude" to=""/>
            
            <p:store>
                <p:with-option name="href" select="concat($filepath,'st-la-cat.xml')"/>
                <p:with-option name="omit-xml-declaration" select="'false'"/>
                <p:with-option name="indent" select="'true'"/>
            </p:store>
            
        </p:group>
        
        <p:identity>
            <p:input port="source">
                <p:pipe port="not-matched" step="Split"/>
            </p:input>
        </p:identity>
        
        <p:group name="st-grc-cat-abc">
            
            <p:documentation>
                <h2>Statistical listing: by category and initials (XML)</h2>
                <p>This step saves statistical information contained in the corpus file in an XML file (as understood by the webapp).</p>
            </p:documentation>
            
            <p:variable name="filepath" select="$filepath"/>
            
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="util/3-st-grc-cat-abc.xsl"/>
                </p:input>
            </p:xslt>
            
            <p:namespace-rename from="http://www.tei-c.org/ns/1.0" to=""/>
            <p:namespace-rename from="http://papyri.uni-koeln.de/papyri-woerterlisten" to=""/>
            <p:namespace-rename from="http://www.w3.org/2003/XInclude" to=""/>
            
            <p:store>
                <p:with-option name="href" select="concat($filepath,'st-grc-cat-abc.xml')"/>
                <p:with-option name="omit-xml-declaration" select="'false'"/>
                <p:with-option name="indent" select="'true'"/>
            </p:store>
            
        </p:group>
        
        <p:identity>
            <p:input port="source">
                <p:pipe port="not-matched" step="Split"/>
            </p:input>
        </p:identity>
        
        <p:group name="st-la-cat-abc">
            
            <p:documentation>
                <h2>Statistical listing: by category and initials (XML)</h2>
                <p>This step saves statistical information contained in the corpus file in an XML file (as understood by the webapp).</p>
            </p:documentation>
            
            <p:variable name="filepath" select="$filepath"/>
            
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="util/4-st-la-cat-abc.xsl"/>
                </p:input>
            </p:xslt>
            
            <p:namespace-rename from="http://www.tei-c.org/ns/1.0" to=""/>
            <p:namespace-rename from="http://papyri.uni-koeln.de/papyri-woerterlisten" to=""/>
            <p:namespace-rename from="http://www.w3.org/2003/XInclude" to=""/>
            
            <p:store>
                <p:with-option name="href" select="concat($filepath,'st-la-cat-abc.xml')"/>
                <p:with-option name="omit-xml-declaration" select="'false'"/>
                <p:with-option name="indent" select="'true'"/>
            </p:store>
            
        </p:group>
        
        <p:identity>
            <p:input port="source">
                <p:pipe port="not-matched" step="Split"/>
            </p:input>
        </p:identity>
        
        <p:group name="st-grc-cat-json">
            
            <p:documentation>
                <h2>Statistical listing: by category (JSON)</h2>
                <p>This step saves statistical information contained in the corpus file in a JSON file (as understood by the webapp).</p>
            </p:documentation>
            
            <p:variable name="filepath" select="$filepath"/>
            
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="util/5-st-grc-cat-abc-json.xsl"/>
                </p:input>
            </p:xslt>
            
            <p:store method="text">
                <p:with-option name="href" select="concat($filepath,'st-grc-cat-abc.json')"/>
                <p:with-option name="omit-xml-declaration" select="'true'"/>
                <p:with-option name="indent" select="'false'"/>
            </p:store>
            
        </p:group>
        
        <p:identity>
            <p:input port="source">
                <p:pipe port="not-matched" step="Split"/>
            </p:input>
        </p:identity>
        
        <p:group name="st-la-cat-json">
            
            <p:documentation>
                <h2>Statistical listing: by category (JSON)</h2>
                <p>This step saves statistical information contained in the corpus file in a JSON file (as understood by the webapp).</p>
            </p:documentation>
            
            <p:variable name="filepath" select="$filepath"/>
            
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="util/6-st-la-cat-abc-json.xsl"/>
                </p:input>
            </p:xslt>
            
            <p:store method="text">
                <p:with-option name="href" select="concat($filepath,'st-la-cat-abc.json')"/>
                <p:with-option name="omit-xml-declaration" select="'true'"/>
                <p:with-option name="indent" select="'false'"/>
            </p:store>
            
        </p:group>
        
        <p:identity name="wrapped-transformation-result">
            <p:input port="source">
                <p:pipe port="matched" step="Split"/>
            </p:input>
        </p:identity>
        
        <p:group name="nav">
            
            <p:documentation>
                <h2>Navigation by initials</h2>
                <p>This step generates a list containing counts of lemmata starting in the same two characters by initials in a format expected by the webapp.</p>
            </p:documentation>
            
            <p:variable name="filepath" select="$filepath"/>
            
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="util/7-nav.xsl"/>
                </p:input>
            </p:xslt>
            
            <p:store>
                <p:with-option name="href" select="concat($filepath,'nav.xml')"/>
                <p:with-option name="omit-xml-declaration" select="'false'"/>
                <p:with-option name="indent" select="'true'"/>
            </p:store>
            
        </p:group>
        
        <p:identity>
            <p:input port="source">
                <p:pipe port="matched" step="Split"/>
            </p:input>
        </p:identity>
        
        <p:group name="nav-cat">
            
            <p:documentation>
                <h2>Navigation by category</h2>
                <p>This step generates a list containing counts of lemmata starting in the same two characters by category in a format expected by the webapp.</p>
            </p:documentation>
            
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="util/8-nav-cat.xsl"/>
                </p:input>
            </p:xslt>
            
            <p:store>
                <p:with-option name="href" select="concat($filepath,'nav-cat.xml')"/>
                <p:with-option name="omit-xml-declaration" select="'false'"/>
                <p:with-option name="indent" select="'true'"/>
            </p:store>
            
        </p:group>
        
        <p:identity>
            <p:input port="source">
                <p:pipe port="not-matched" step="Split"/>
            </p:input>
        </p:identity>
        
        <p:group name="words-by-frequency">
            
            <p:documentation>
                <h2>Words by frequency</h2>
                <p>This step saves statistical information contained in the corpus file in an XML file (as understood by the webapp).</p>
            </p:documentation>
            
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="util/9-st-words-frequency.xsl"/>
                </p:input>
            </p:xslt>
            
            <p:store>
                <p:with-option name="href" select="concat($filepath,'st-words-by-frequency.xml')"/>
                <p:with-option name="omit-xml-declaration" select="'false'"/>
                <p:with-option name="indent" select="'true'"/>
            </p:store>
            
        </p:group>
        
        <p:identity>
            <p:input port="source">
                <p:pipe port="not-matched" step="Split"/>
            </p:input>
        </p:identity>
        
        <p:group name="words-by-frequency-json">
            
            <p:documentation>
                <h2>Statistical listing: words by frequency (JSON)</h2>
                <p>This step saves statistical information contained in the corpus file in a JSON file (as understood by the webapp).</p>
            </p:documentation>
            
            <p:variable name="filepath" select="$filepath"/>
            
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="util/10-st-words-frequency-json.xsl"/>
                </p:input>
            </p:xslt>
            
            <p:store method="text">
                <p:with-option name="href" select="concat($filepath,'st-words-frequency.json')"/>
                <p:with-option name="omit-xml-declaration" select="'true'"/>
                <p:with-option name="indent" select="'false'"/>
            </p:store>
            
        </p:group>
        
    </p:declare-step>
    
    <p:declare-step type="pwl:readme" name="wl-input-readme">
        
        <p:input port="source"/>
        <p:input port="parameters" kind="parameter"/>
        
        <p:option name="version" select="$version"/>

        <p:documentation>
            <h2>Generate README</h2>
            <p>This step generates the README file for the repository. Conseqently, the README file should never be edited in the root directory, but in the xsl file that is referenced here.</p>
        </p:documentation>
        
        <p:xslt>
            <p:with-param name="version" select="$version"/>
            <p:input port="stylesheet">
                <p:document href="readme/1-writeReadme.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:store method="text">
            <p:with-option name="href" select="'../../README.md'"/>
        </p:store>
        
    </p:declare-step>
    
    <p:declare-step type="pwl:transform" name="wl-input-transformation">
        
        <p:input port="source"/>
        <p:input port="parameters" kind="parameter"/>
        <p:output port="result" sequence="true"/>
        
        <p:option name="version" select="$version"/>
        <p:option name="editor" select="$editor"/>
        <p:option name="task-newEntries" select="$task-newEntries"/>
        <p:option name="task-existingEntries" select="$task-existingEntries"/>
        <p:option name="schemaPath" select="$schemaPath"/>
        <p:option name="comparisonBase" select="$comparisonBase"/>
        <p:option name="outputScenario" select="$outputScenario"/>
        <p:option name="result-path" select="$result-path"/>
        <p:option name="result-url" select="$result-url"/>
        
        <p:documentation>
            <h2>Transformation sub pipeline</h2>
            <p>This sub pipeline takes care of the actual data transformation and the generation of the contents of the report file.</p>
        </p:documentation>
        
        <p:documentation>
            <h2>Merging input files</h2>
            <p>This step combines all XML files in the input directory for further processing.</p>
        </p:documentation>
        <p:xslt name="merge-files">
            <p:input port="stylesheet">
                <p:document href="transformation/1-merge-files.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:documentation>
            <h2>Creating a generic structure</h2>
            <p>This step assimilates differing export formats in a generic manner to a homogeneous data structure.</p>
        </p:documentation>
        <p:xslt name="create-generic-structure">
            <p:input port="stylesheet">
                <p:document href="transformation/2-create-generic-structure.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:documentation>
            <h2>Initial TEI structure</h2>
            <p>In this step, the entries are transformed to fit the TEI model of the project. IDs are taken from existing entries.</p>
        </p:documentation>
        <p:xslt name="build-up-TEI">
            <p:with-param name="comparisonBase" select="$comparisonBase"/>
            <p:with-param name="schemaPath" select="$schemaPath"/>
            <p:input port="stylesheet">
                <p:document href="transformation/3-build-up-TEI.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:documentation>
            <h2>Group entries by language</h2>
            <p>This step groups greek and latin entries in a flat structure in respective elements. This structure prepares the assignment of new IDs.</p>
        </p:documentation>
        <p:xslt name="gather-by-language">
            <p:input port="stylesheet">
                <p:document href="transformation/4-gather-by-language.xsl"/>
            </p:input>
        </p:xslt>

        <p:documentation>
            <h2>New IDs</h2>
            <p>Based on the highest xml:ids in use and on the position (number of preceding siblings), this step assigns xml:ids to new entries in the dataset.</p>
        </p:documentation>
        <p:xslt name="assign-new-IDs">
            <p:input port="stylesheet">
                <p:document href="transformation/5-assign-new-IDs.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:documentation>
            <h2>Metadata / teiHeader</h2>
            <p>This step builds up a teiHeader from the parameter values defined above and the change elements present in the current data.</p>
        </p:documentation>
        <p:xslt name="build-teiHeader">
            <p:with-param name="version" select="$version"/>
            <p:with-param name="editor" select="$editor"/>
            <p:with-param name="task-newEntries" select="$task-newEntries"/>
            <p:with-param name="task-existingEntries" select="$task-existingEntries"/>
            <p:with-param name="schemaPath" select="$schemaPath"/>
            <p:with-param name="comparisonBase" select="$comparisonBase"/>
            <p:input port="stylesheet">
                <p:document href="transformation/6-build-teiHeader.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:choose>
            <p:when test="$outputScenario='oneFile'">
                <p:documentation>
                    <h2>Alternative output (global)</h2>
                    <p>Use this instead of the chopping step to output a file containing all entries (without metadata).</p>
                </p:documentation>
                <p:store>
                    <p:with-option name="href" select="$result-url"/>
                    <p:with-option name="indent" select="'true'"/>
                </p:store>
                <!-- reroute previous result (at a stage where new entries are easily and reliably detectable) -->
                <p:identity>
                    <p:input port="source">
                        <p:pipe port="result" step="assign-new-IDs"/>
                    </p:input>
                </p:identity>
            </p:when>
            <p:otherwise>
                <p:documentation>
                    <h2>Chop data to atomic files</h2>
                    <p>This steps supplies each entry with a metdata section (teiHeader) and creates a file containing this header and content.</p>
                </p:documentation>
                <p:for-each>
                    <p:iteration-source select="/*//*:TEI"/>
                    <!-- concat $result-path + language + category + xml:id -->
                    <p:variable name="filename" select="concat($result-path,'/',tokenize(//*:entry/@xml:id,'-')[2],'/',//*:text/*:body/*:div/@type,'/',//*:entry/@xml:id, '.xml')"/>
                    <!--
                       <p:validate-with-relax-ng assert-valid="true" name="relaxng">
                           <p:input port="schema">
                               <p:document href="../validation/papyri-wl.rng"/>
                           </p:input>
                       </p:validate-with-relax-ng>
                       -->
                    <p:store>
                        <p:with-option name="href" select="$filename"/>
                        <p:with-option name="indent" select="'true'"/>
                    </p:store>
                    <!-- reroute previous result (at a stage where new entries are easily and reliably detectable) -->
                </p:for-each>
                <p:identity>
                    <p:input port="source">
                        <p:pipe port="result" step="assign-new-IDs"/>
                    </p:input>
                </p:identity>
            </p:otherwise>
        </p:choose>
        
    </p:declare-step>
    
</p:library>