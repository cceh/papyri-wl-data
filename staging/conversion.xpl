<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0" name="wl-input-pipeline">
    
    <p:documentation>
        <h1>Papyri Wörterlisten: Data ingest pipeline</h1>
        <p>Please update the transformation parameters before committing the output.</p>
    </p:documentation>
    
    <p:documentation>
        <h2>Transformation parameters</h2>
        <p>Specify the editor and the current step here; the date will be added automatically.</p>
        <p>The option 'comparisonBase' allows to select a smaller data set to facilitate testing/development.</p>
        <p>For testing purposes, it is possible to output a single file using the outputScenario 'oneFile'.</p>
    </p:documentation>
    <p:option name="editor" select="'http://github.com/pdaengeli'"/><!-- Bearbeiter -->
    <p:option name="task-newEntries" select="'XProc-Workflow; Neuanlage des Eintrags und Vergabe der xml:id'"/><!-- Bearbeitungsschritt (Neuaufnahmen) -->
    <p:option name="task-existingEntries" select="'XProc-Workflow; Anpassung des bestehenden Eintrags'"/><!-- Bearbeitungsschritt (bestehende Einträge) -->
    <p:option name="schemaPath" select="'../validation'"/>
    <p:option name="comparisonBase" select="'current-test'"/><!-- current -->
    <p:option name="outputScenario" select="'manyFiles'"/><!-- oneFile / manyFiles -->
    
    <p:documentation>
        <p>Output definition for alternative output scenario (cf. below)</p>
    </p:documentation>
    <p:option name="result-url" select="'output/output.xml'"/>
    
    <p:input port="source" primary="true">
        <p:document href="conversion.xpl"/>
    </p:input>
    
    <p:input port="parameters" kind="parameter"/>
    
    <p:output port="result" sequence="true">
        <!--<p:empty/>-->
    </p:output>
    
    <p:output port="result-secondary" primary="false"/>
    
    <!-- wrap conditionally: only if no duplicates exist; else tell raise error -->
    
    <p:documentation>
        <h2>Merging input files</h2>
        <p>This step combines all XML files in the input directory for further processing.</p>
    </p:documentation>
    <p:xslt name="merge-files">
        <p:input port="stylesheet">
            <p:document href="conversion/0-merge-files.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:documentation>
        <h2>Creating a generic structure</h2>
        <p>This step assimilates differing export formats in a generic manner to a homogeneous data structure.</p>
    </p:documentation>
    <p:xslt name="create-generic-structure">
        <p:input port="stylesheet">
            <p:document href="conversion/1-create-generic-structure.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:documentation>
        <h2>Initial TEI structure</h2>
        <p>In this step, the entries are transformed to fit the TEI model of the project. 
            IDs are taken from existing entries.</p>
    </p:documentation>
    <p:xslt name="build-up-TEI">
        <p:with-param name="comparisonBase" select="$comparisonBase"/>
        <p:with-param name="schemaPath" select="$schemaPath"/>
        <p:input port="stylesheet">
            <p:document href="conversion/2-build-up-TEI.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:documentation>
        <h2>Group entries by language</h2>
        <p>This step groups greek and latin entries in a flat structure in respective elements. 
            This structure prepares the assignment of new IDs.</p>
    </p:documentation>
    <p:xslt name="gather-by-language">
        <p:input port="stylesheet">
            <p:document href="conversion/3-gather-by-language.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:documentation>
        <h2>New IDs</h2>
        <p>Based on the highest xml:ids in use and on the position (number of preceding siblings), 
            this step assigns xml:ids to new entries in the dataset.</p>
    </p:documentation>
    <p:xslt name="assign-new-IDs">
        <p:input port="stylesheet">
            <p:document href="conversion/4-assign-new-IDs.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:documentation>
        <h2>Metadata / teiHeader</h2>
        <p>This step builds up a teiHeader from the parameter values defined above and the change 
            elements present in the current data.</p>
    </p:documentation>
    <p:xslt name="build-teiHeader">
        <p:with-param name="editor" select="$editor"/>
        <p:with-param name="task-newEntries" select="$task-newEntries"/>
        <p:with-param name="task-existingEntries" select="$task-existingEntries"/>
        <p:with-param name="schemaPath" select="$schemaPath"/>
        <p:with-param name="comparisonBase" select="$comparisonBase"/>
        <p:input port="stylesheet">
            <p:document href="conversion/5-build-teiHeader.xsl"/>
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
            <!-- reroute previous result -->
            <p:identity>
                <p:input port="source">
                    <p:pipe port="result" step="build-teiHeader"/>
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
                <p:variable name="filename" select="concat('output/',//*:entry/@xml:id, '.xml')"/>
                <!--<p:validate-with-relax-ng assert-valid="true" name="relaxng">
                    <!-\-<p:log port="report" href="relaxng_reports.log"></p:log>-\->
                    <p:input port="schema">
                        <p:document href="../validation/papyri-wl.rng"/>
                    </p:input>
                </p:validate-with-relax-ng>-->
                <p:store>
                    <p:with-option name="href" select="$filename"/>
                    <p:with-option name="indent" select="'true'"/>
                </p:store>
                <!-- reroute previous result -->
                <p:identity>
                    <p:input port="source">
                        <p:pipe port="result" step="build-teiHeader"/>
                    </p:input>
                </p:identity>
            </p:for-each>
        </p:otherwise>
    </p:choose>
    
    <!-- just temporary: store the whole XML file -->
            <p:sink/>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="result" step="build-teiHeader"/>
                </p:input>
            </p:identity>
            <p:store>
                <p:with-option name="href" select="$result-url"/>
                <p:with-option name="indent" select="'true'"/>
            </p:store>
            <!-- reroute previous result -->
            <p:identity>
                <p:input port="source">
                    <p:pipe port="result" step="build-teiHeader"/>
                </p:input>
            </p:identity>
    
    
     <p:documentation>
        <h2>...</h2>
        <p>...</p>
    </p:documentation>
    <p:xslt>
        <p:with-param name="comparisonBase" select="$comparisonBase"/>
        <p:input port="stylesheet">
            <p:document href="conversion/6-log.xsl"/>
        </p:input>
    </p:xslt>
    
 
    
    <!--<p:sink/>-->
    
    <p:store method="text">
        <p:with-option name="href" select="concat('reporting/import-report_',format-date(current-date(), '[Y0001][M01][D01]'),'.txt')"/>
    </p:store>
    
</p:declare-step>