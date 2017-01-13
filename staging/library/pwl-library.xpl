<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:pwl="http://papyri.uni-koeln.de/papyri-woerterlisten" version="1.0">

    <p:declare-step type="pwl:corpus" name="wl-input-corpus">
        
        <p:input port="source"/>
        <p:input port="parameters" kind="parameter"/>
        
        <p:option name="result-path" select="$result-path"/>
        <p:option name="result-url" select="$result-url"/>
        <p:option name="editor" select="$editor"/>
        <p:variable name="filename" select="concat($result-path,'/','corpus.xml')"/>
        
        <p:documentation>
            <h2>TEI Corpus</h2>
            <p>This steps creates a corpus file with xi:include references to all entries/files.</p>
        </p:documentation>
        
        <p:xslt>
            <p:input port="stylesheet">
                <p:document href="corpus/1-corpus.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:store>
            <p:with-option name="href" select="$filename"/>
            <p:with-option name="indent" select="'true'"/>
        </p:store>
        
    </p:declare-step>
    
    <p:declare-step type="pwl:log" name="wl-input-reporting">
        
        <p:input port="source"/>
        <p:input port="parameters" kind="parameter"/>
        
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
    
    <p:declare-step type="pwl:readme" name="wl-input-readme">
        
        <p:input port="source"/>
        <p:input port="parameters" kind="parameter"/>
        
        <p:documentation>
            <h2>Generate README</h2>
            <p>This step generates the README file for the repository. Conseqently, the README file should never be edited in the root directory, but in the xsl file that is referenced here.</p>
        </p:documentation>
        
        <p:xslt>
            <p:input port="stylesheet">
                <p:document href="stats/9-writeReadme.xsl"/>
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
                    <p:variable name="filename" select="concat($result-path,'/',//*:entry/@xml:id, '.xml')"/>
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