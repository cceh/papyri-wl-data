<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- 
        <p:documentation>
            <h2>Generate README</h2>
            <p>This step generates the README file for the repository. Conseqently, the README file should never be edited in the root directory, but in the xsl file that is referenced here.</p>
        </p:documentation>
    -->
    
    <!-- set the scale of the chart; 1 chart unit represents {$divisor} entries; some 80 units should fit the viewport comfortably -->
    <xsl:variable name="divisor" select="200"/>

<xsl:template match="/">
    <wrapper>
        <!-- The README file is generated in the conversion process. Thus it should not be edited in the root directory but here in this file. -->
        <xsl:text>
Dieses Readme wird automatisch generiert; [README bearbeiten](https://github.com/cceh/papyri-wl-data/edit/master/staging/library/readme/</xsl:text><xsl:value-of select="tokenize(base-uri(document('')),'/')[last()]"/><xsl:text>)            
            
Papyri Wörterlisten – Data
===========================================================

Dieses Repositorium enthält die Ausgangsdaten der Papyri-Wörterlisten (vgl. [WL.pdf](http://www.zaw.uni-heidelberg.de/hps/pap/WL/WL.pdf) bzw. [WL.html](http://www.papy.uni-hd.de/WL/WL.html); Webanwendung in Entwicklung).

Über die Daten
-------------------------------------

Prof. Dr. D. Hagedorn erstellt seit 1996 (unter anfänglicher Mithilfe von Pia Breit, Wolfgang Habermann, Ursula Hagedorn, Bärbel Kramer, Gertrud Marohn und Jörn Salewski) Wörterlisten aus den Registern von Publikationen griechischer und lateinischer dokumentarischer Papyri und Ostraka. Zur Verwendung kam dafür eine selbst entwickelte [HyperCard](https://en.wikipedia.org/wiki/HyperCard)-Anwendung, die mit der Zeit auch parallel in [FileMaker](https://en.wikipedia.org/wiki/FileMaker) gepflegt wurde.
Dieses Repositorium umfasst einen Transformations-Workflow ab FileMaker-XML-Exporten sowie die daraus resultierenden Wörterlisten-Dateien in `TEI-XML`.

</xsl:text>
        <xsl:text>
### Datenumfang

Die Wörterlisten umfassen  </xsl:text>
        <xsl:value-of select="//*:projectDesc//*:list[@subtype='total_grc_la']/*:item[1]/*:num"/>
        <xsl:text> Einträge, wovon </xsl:text>
        <xsl:value-of select="//*:projectDesc//*:list[@subtype='total_grc_la']/*:item[2]/*:num"/>
        <xsl:text> in griechischer und </xsl:text>
        <xsl:value-of select="//*:projectDesc//*:list[@subtype='total_grc_la']/*:item[3]/*:num"/>
        <xsl:text> in lateinischer Sprache (Stand </xsl:text><xsl:value-of select="format-date(current-date(),'[D1o] [MNn] [Y0001]','de','AD','DE')"/>
        <xsl:text>). Die Verteilung auf die Kategorien ist nachstehend illustriert.

**Sprachübergreifend**

```txt</xsl:text>

        <xsl:call-template name="stats">
            <xsl:with-param name="subtype" select="'cat_grc_la'"/>
            <xsl:with-param name="divisor" select="$divisor"/>
        </xsl:call-template>
        
        <xsl:text>
```

**Griechisch**

```txt</xsl:text>
        
        <xsl:call-template name="stats">
            <xsl:with-param name="subtype" select="'cat_grc'"/>
            <xsl:with-param name="divisor" select="$divisor"/>
        </xsl:call-template>
        
        <xsl:text>
```

**Lateinisch**

```txt</xsl:text>
        
        <xsl:call-template name="stats">
            <xsl:with-param name="subtype" select="'cat_la'"/>
            <xsl:with-param name="divisor" select="$divisor"/>
        </xsl:call-template>
        
        <xsl:text>
            
| = </xsl:text><xsl:value-of select="$divisor"/><xsl:text> Einträge            
```


Datentransformation
-------------------------------------

### Import-Pipeline

#### Kurzanleitung

1. Versions- und Literaturangaben aktualisieren (`meta/literature.xml`, `meta/versions.xml`, `meta/editors.xml`)
2. FileMaker-XML-Dateien in das Verzeichnis `staging/input` speichern.
3. [`conversion.xpl`](/staging/conversion.xpl) ausführen
4. Reporting auswerten bzw. Dateien in `staging/output` mit den bisherigen Dateien vergleichen ([`current`](/current))
5. Dateien in [`current`](/current) durch Dateien in `staging/output` ersetzen
6. `git commit` bzw. Pull-Request erstellen
7. Version taggen bzw. Release erstellen

#### Ausführliche Anleitung
        
Vor jeder Datenübernahme sind die Meta-Dateien `literature.xml`, `versions.xml` und ggf. `editors.xml` zu aktualisieren bzw. ergänzen.

Der eigentliche Abgleich ist als [XProc](http://www.w3.org/TR/xproc/)-Pipeline angelegt. Innerhalb der Pipeline werden verschiedene XSL-Transformationen ausgeführt und die einzelnen Einträge schließlich als Einzeldateien ins Output-Verzeichnis geschrieben. Die Transformationsschritte umfassen:

- Überprüfung des `Output`-Verzeichnis
- Duplikat-Check
- Vereinigung der Importdateien
- Strukturangleichung der Importdateien
- Erstellung der TEI-Struktur mit Übernahme bestehender Identifikatoren
- Vergabe neuer Identifikatoren für neue Einträge (sprachweise)
- Aufbau des Metadaten-Abschnitts (`teiHeader`) inkl. Übernahme der Metadaten zu früheren Bearbeitungsschritten
- Ausgabe von Behelfsdateien für die Webanwendung
- Ausgabe einer aktuellen README-Datei

Die XProc-Pipeline (`staging/conversion.xpl`) muss einmal angestossen werden, der Prozess läuft dann selbständig durch. Dieser Prozess kann sowohl in oXygen XML Editor (unter Nutzung des integrierten Calabash-Prozessors; vlg. [Anleitung](http://oxygenxml.com/doc/ug-editor/topics/xproc-transformation-scenario.html)) oder auf der Kommandozeile erfolgen (ebenfalls unter Nutzung des [Calabash](http://xmlcalabash.com/)-Prozessors oder eines anderen XProc-Prozessors.

Der Vorgang ist relativ speicherintensiv und dauert für einen Voll-Abgleich je nach System/Konfiguration eine gute Stunde oder länger.

In der Datei [`staging/conversion.xpl`](/staging/conversion.xpl) lassen sich mehrere Parameter konfigurieren (direkt in der Datei oder im oXygen-XProc-Transformationsszenario im Tab `Optionen`):

Parameter | Beschreibung
------------ | -------------
`editor` | Bearbeiter; z.B. als Github-Konto, Verweis auf eine `xml:id` oder als Klarnamen
`task-newEntries` | aktueller Bearbeitungsschritt für Neuaufnahmen (z.B. Auflistung der neuen Kurztitel); dieser wird als `&lt;change>`-Element in die `&lt;revisionDesc>` aufgenommen
`task-existingEntries`| aktueller Bearbeitungsschritt für bestehende Einträge; dieser wird als `&lt;change>`-Element in die `&lt;revisionDesc>` aufgenommen
`schemaPath` | Pfad zum Verzeichnis, welches das XML-Schema (`.rng-Datei`) enthält
`comparisonBase`| aktuelles Datenverzeichnis; die FileMaker-Exportdateien werden mit den in diesem Verzeichnis liegenden Dateien abgeglichen; für Workflow-Tests lässt sich hier ein weniger umfangreiches Verzeichnis angeben
`outputScenario` | hier lässt sich für Workflow-Tests mit `'oneFile'` die Ausgabe in einer Einzeldatei festlegen; jeder andere Wert führt zur Standardausgabe (eine Datei pro Eintrag)
`resultPath` | Pfad zum Verzeichnis, in welches die generierten Dateien geschrieben werden
`result-url` | bei der Generierung einer Einzeldatei kann der Dateinamen als Zusatz zu `resultPath` angegeben werden

Die Werte müssen mit umschließenden einfachen Anführungszeichen eingetragen werden.

##### Zum Duplikat-Check (Teil der Konversion)

Die Daten umfassen fünf unterschiedliche Kategorien. Jedes Lemma kann in einer bestimmten Schreibweise in jeder Kategorie nur einmal vorkommen.

Der Datenabgleich/Import verläuft nur erfolgreich, wenn es innerhalb der Kategorien keine zeichen-identischen Lemmata gibt. Dieser Sachverhalt wird in einem der ersten Schritte der Pipeline überprüft. Dabei werden problematische Duplikate identifiziert und in einer Liste ausgegeben (Markdown-Format). Nach manueller Bereinigung der Duplikate kann die Konversion neu gestartet werden.

Kontakt/Mitarbeit
---------------------------

Kontaktadresse: `papyri-woerterlisten AT uni-koeln.de`

Institut für Altertumskunde, Universität zu Köln, Albertus-Magnus-Platz, D-50923 Köln

Cologne Center for eHumanities, Universität zu Köln, Albertus-Magnus-Platz, D-50923 Köln
</xsl:text>
    </wrapper>
</xsl:template>
    
    <xsl:template name="stats">
        <xsl:param name="divisor"/>
        <xsl:param name="subtype"/>
        <xsl:for-each select="//*:projectDesc//*:p[*:list[@subtype=$subtype]][1]/*:list[@subtype=$subtype]//*:item">
            <xsl:variable name="fill" select="12 - string-length(*:label/@type)"/>
            <xsl:variable name="chart" select="round(*:num idiv $divisor)"/>
            <xsl:text>&#10;</xsl:text>
            <xsl:value-of select="*:label/@type"/>
            <xsl:text>: </xsl:text>
            <xsl:for-each select="1 to $fill">
                <xsl:text> </xsl:text>
            </xsl:for-each>
            <xsl:for-each select="1 to $chart">
                <xsl:text>|</xsl:text>
            </xsl:for-each>
            <xsl:value-of select="*:num"/>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
