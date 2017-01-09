<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:pwl="http://papyri.uni-koeln.de/papyri-woerterlisten" version="1.0" name="wl-input-pipeline-main">
    
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
    <p:option name="task-existingEntries" select="'XProc-Workflow; Anpassung des bestehenden Eintrags TEST'"/><!-- Bearbeitungsschritt (bestehende Einträge) -->
    <p:option name="schemaPath" select="'../validation'"/>
    <p:option name="comparisonBase" select="'current'"/><!-- current -->
    <p:option name="outputScenario" select="'manyFiles'"/><!-- oneFile / manyFiles -->
    
    <p:documentation>
        <p>Output definition for alternative output scenario (cf. below)</p>
    </p:documentation>
    <p:option name="result-url" select="'output/output.xml'"/>
    
    <p:input port="source" primary="true">
        <p:document href="conversion.xpl"/>
    </p:input>
    
    <p:input port="parameters" kind="parameter"/>
    
    <p:output port="result" sequence="true"/>

    <p:output port="result-secondary" primary="false"/>
    
    <p:documentation>
        <h2>Assert empty output directory</h2>
        <p>This step checks if there is an output directory and if xml files are present in the output directory. Such files could lead to corruption (duplicates).</p>
    </p:documentation>
    <p:directory-list path="."/>
    <p:choose>
        <p:when test="c:directory/c:directory[@name='output']">
            <p:directory-list path="output"/>
            <p:choose>
                <p:when test="c:directory/c:file[starts-with(@name,'wl-')][ends-with(@name,'.xml')]">
                <p:error code="output-not-empty">
                    <p:input port="source">
                        <p:inline>
                            <doc>XML files present in the output folder. Remove XML files.</doc>
                        </p:inline>
                    </p:input>
                </p:error>
                </p:when>
                <p:otherwise>
                    <p:identity/>
                </p:otherwise>
            </p:choose>
        </p:when>
        <p:otherwise>
            <p:error code="no-output-directory">
                <p:input port="source">
                    <p:inline>
                        <doc>No output directory exists. Create a directory named 'output'.</doc>
                    </p:inline>
                </p:input>
            </p:error>
        </p:otherwise>
    </p:choose>
    <p:sink/>
    
    <p:documentation>
        <h2>Duplicate check</h2>
        <p>This step checks for identical lemmata that occur within the same category. Such cases are not handled by the ingest pipeline and if they indeed should be part of the dataset, they need to be added manually.</p>
    </p:documentation>
    <p:xslt name="duplicate-check">
        <p:with-param name="comparisonBase" select="$comparisonBase"/>
        <p:input port="source">
            <p:document href="conversion/0-check-current-data-for-duplicates.xsl"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="conversion/0-check-current-data-for-duplicates.xsl"/>
        </p:input>
    </p:xslt>
    <p:choose>
        <!-- case: duplicates in 'current' -->
        <p:when test="*:current/*:orth">
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="conversion/0-check-current-data-for-duplicates-md.xsl"/>
                </p:input>
            </p:xslt>
        </p:when>
        <!-- case: no duplicates in 'current' -->
        <p:otherwise>
            <pwl:transform>
                <p:with-param name="editor" select="$editor"/>
                <p:with-param name="task-newEntries" select="$task-newEntries"/>
                <p:with-param name="task-existingEntries" select="$task-existingEntries"/>
                <p:with-param name="comparisonBase" select="$comparisonBase"/>
                <p:with-param name="schemaPath" select="$schemaPath"/>
                <p:with-param name="outputScenario" select="$outputScenario"/>
            </pwl:transform>
        </p:otherwise>
    </p:choose>
    
    <!--<p:sink/>-->
    
    <p:store method="text">
        <p:with-option name="href" select="concat('reporting/import-report_',format-date(current-date(), '[Y0001][M01][D01]'),'.md')"/>
    </p:store>
    
    <p:declare-step type="pwl:transform" name="wl-input-subpipeline">
        <p:input port="source"/>
        <p:input port="parameters" kind="parameter"/>
        <p:output port="result"/>
        
        <p:option name="editor" select="$editor"/>
        <p:option name="task-newEntries" select="$task-newEntries"/>
        <p:option name="task-existingEntries" select="$task-existingEntries"/>
        <p:option name="schemaPath" select="$schemaPath"/>
        <p:option name="comparisonBase" select="$comparisonBase"/>
        <p:option name="outputScenario" select="$outputScenario"/>
        
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
                <p:document href="conversion/1-merge-files.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:documentation>
            <h2>Creating a generic structure</h2>
            <p>This step assimilates differing export formats in a generic manner to a homogeneous data structure.</p>
        </p:documentation>
        <p:xslt name="create-generic-structure">
            <p:input port="stylesheet">
                <p:document href="conversion/2-create-generic-structure.xsl"/>
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
                <p:document href="conversion/3-build-up-TEI.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:documentation>
            <h2>Group entries by language</h2>
            <p>This step groups greek and latin entries in a flat structure in respective elements. This structure prepares the assignment of new IDs.</p>
        </p:documentation>
        <p:xslt name="gather-by-language">
            <p:input port="stylesheet">
                <p:document href="conversion/4-gather-by-language.xsl"/>
            </p:input>
        </p:xslt>
        
        <p:documentation>
            <h2>New IDs</h2>
            <p>Based on the highest xml:ids in use and on the position (number of preceding siblings), this step assigns xml:ids to new entries in the dataset.</p>
        </p:documentation>
        <p:xslt name="assign-new-IDs">
            <p:input port="stylesheet">
                <p:document href="conversion/5-assign-new-IDs.xsl"/>
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
                <p:document href="conversion/6-build-teiHeader.xsl"/>
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
                    <p:variable name="filename" select="concat('output/',//*:entry/@xml:id, '.xml')"/>
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
                    <p:identity>
                        <p:input port="source">
                            <p:pipe port="result" step="assign-new-IDs"/>
                        </p:input>
                    </p:identity>
                </p:for-each>
            </p:otherwise>
        </p:choose>
        
        <p:documentation>
            <h2>Import reporting</h2>
            <p>This step generates a report in markdown format showing the proportion between previously existing and newly added entries.</p>
        </p:documentation>
        <p:xslt>
            <p:input port="stylesheet">
                <p:document href="conversion/7-log.xsl"/>
            </p:input>
        </p:xslt>
    </p:declare-step>
    
</p:declare-step>