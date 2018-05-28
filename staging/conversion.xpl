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
    <p:option name="version" select="'22¦22. Version¦14.05.2018'"/><!-- Version: leer lassen, wenn es sich nicht um eine neue Version handelt -->
    <p:option name="editor" select="'http://github.com/pdaengeli'"/><!-- Bearbeiter -->
    <p:option name="task-newEntries" select="'22. Fassung vom 14.05.2018: Neuanlage des Eintrags und Vergabe der xml:id (XProc-Workflow)'"/><!-- Bearbeitungsschritt (Neuaufnahmen) -->
    <p:option name="task-existingEntries" select="'22. Fassung vom 14.05.2018: Anpassung des bestehenden Eintrags (XProc-Workflow)'"/><!-- Bearbeitungsschritt (bestehende Einträge) -->
    <p:option name="schemaPath" select="'../validation'"/>
    <p:option name="comparisonBase" select="'current'"/><!-- current -->
    <p:option name="outputScenario" select="'manyFiles'"/><!-- oneFile / manyFiles -->
    <p:option name="result-path" select="'../output'"/>
    
    <p:documentation>
        <p>Output definition for alternative output scenario (cf. below)</p>
    </p:documentation>
    <p:option name="result-url" select="concat($result-path,'/output.xml')"/>
    
    <p:input port="source" primary="true">
        <p:document href="conversion.xpl"/>
    </p:input>
    
    <p:input port="parameters" kind="parameter"/>
    
    <p:output port="result" sequence="true"/>

    <p:output port="result-secondary" primary="false"/>
    
    <p:import href="library/pwl-library.xpl"/>
    
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
            <p:document href="library/transformation/0-check-current-data-for-duplicates.xsl"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="library/transformation/0-check-current-data-for-duplicates.xsl"/>
        </p:input>
    </p:xslt>
    <p:choose>
        <!-- case: duplicates in 'current' -->
        <p:when test="*:current/*:orth">
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="library/transformation/0-check-current-data-for-duplicates-md.xsl"/>
                </p:input>
            </p:xslt>
        </p:when>
        <!-- case: no duplicates in 'current' -->
        <p:otherwise>
            <!-- run the main transformation -->
            <pwl:transform>
                <p:with-param name="version" select="$version"/>
                <p:with-param name="editor" select="$editor"/>
                <p:with-param name="task-newEntries" select="$task-newEntries"/>
                <p:with-param name="task-existingEntries" select="$task-existingEntries"/>
                <p:with-param name="comparisonBase" select="$comparisonBase"/>
                <p:with-param name="schemaPath" select="$schemaPath"/>
                <p:with-param name="outputScenario" select="$outputScenario"/>
                <p:with-param name="result-path" select="$result-path"/>
                <p:with-param name="result-url" select="$result-url"/>
            </pwl:transform>
        </p:otherwise>
    </p:choose>
    
    <!-- generation of import reporting -->
    <p:documentation>
        <h2>Import reporting</h2>
        <p>This step generates a report in markdown format showing the proportion between previously existing and newly added entries.</p>
    </p:documentation>
    <p:identity name="wrapped-transformation-result">
        <p:input port="source"/>
    </p:identity>
    <pwl:log>
        <p:with-param name="comparisonBase" select="$comparisonBase"/>
    </pwl:log>
    
    <!-- generation of TEI corpus (including statistical data) -->
    <p:documentation>
        <h2>TEI Corpus</h2>
        <p>This steps creates a corpus file with xi:include references to all entries/files.</p>
    </p:documentation>
    <p:identity>
        <p:input port="source">
            <p:pipe port="result" step="wrapped-transformation-result"/>
        </p:input>
    </p:identity>
    <pwl:corpus name="corpus">
        <p:with-param name="version" select="$version"/>
        <p:with-param name="editor" select="$editor"/>
        <p:with-param name="comparisonBase" select="$comparisonBase"/>
    </pwl:corpus>
    
    <!-- generation of the README -->
    <p:documentation>
        <h2>Import reporting</h2>
        <p>This step generates a report in markdown format showing the proportion between previously existing and newly added entries.</p>
    </p:documentation>
    <p:identity>
        <p:input port="source">
            <p:pipe port="result" step="corpus"/>
        </p:input>
    </p:identity>
    <pwl:readme>
        <p:with-param name="version" select="$version"/>
    </pwl:readme>
    
    <!-- generate util output (data used in webapp) -->
    <p:documentation>
        <h2>Webapp output</h2>
        <p>This step generates files that are used in the webapp. They are written to the 'util' directory.</p>
    </p:documentation>
    <p:identity>
        <p:input port="source">
            <p:pipe port="result" step="wrapped-transformation-result"/>
            <p:pipe port="result" step="corpus"/>
        </p:input>
    </p:identity>
    <pwl:util/>
    
    <!--<p:sink/>-->
    
</p:declare-step>