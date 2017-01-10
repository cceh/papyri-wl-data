Papyri Wörterlisten – Data
===========================================================

Dieses Repositorium enthält die Ausgangsdaten der Papyri-Wörterlisten (vgl. [WL.pdf](http://www.zaw.uni-heidelberg.de/hps/pap/WL/WL.pdf) bzw. [WL.html](http://www.papy.uni-hd.de/WL/WL.html); Webanwendung in Entwicklung).

Über die Daten
-------------------------------------

Prof. Dr. D. Hagedorn erstellt seit 1996 (unter anfänglicher Mithilfe von Pia Breit, Wolfgang Habermann, Ursula Hagedorn, Bärbel Kramer, Gertrud Marohn und Jörn Salewski) Wörterlisten aus den Registern von Publikationen griechischer und lateinischer dokumentarischer Papyri und Ostraka. Zur Verwendung kam dafür eine selbst entwickelte [HyperCard](https://en.wikipedia.org/wiki/HyperCard)-Anwendung, die mit der Zeit auch parallel in [FileMaker](https://en.wikipedia.org/wiki/FileMaker) gepflegt wurde.
Dieses Repositorium umfasst einen Transformations-Workflow ab FileMaker-XML-Exporten sowie die daraus resultierenden Wörterlisten-Dateien in `TEI-XML`.

Datentransformation
-------------------------------------

### Import-Pipeline

#### Kurzanleitung

1. FileMaker-XML-Dateien in das Verzeichnis `staging/input` speichern.
2. `conversion.xpl` ausführen
3. Reporting auswerten bzw. Dateien in `staging/output` mit den bisherigen Dateien vergleichen (`current`)
4. Dateien in `current` durch Dateien in `staging/output` ersetzen
5. `git commit` bzw. Pull-Request erstellen

#### Ausführliche Anleitung

Der eigentliche Abgleich ist als [XProc](http://www.w3.org/TR/xproc/)-Pipeline angelegt. Innerhalb der Pipeline werden verschiedene XSL-Transformationen ausgeführt und die einzelnen Einträge schließlich als Einzeldateien ins Output-Verzeichnis geschrieben. Die Transformationsschritte umfassen:

- Überprüfung des `Output`-Verzeichnis
- Duplikat-Check
- Vereinigung der Importdateien
- Strukturangleichung der Importdateien
- Erstellung der TEI-Struktur mit Übernahme bestehender Identifikatoren
- Vergabe neuer Identifikatoren für neue Einträge (sprachweise)
- Aufbau des Metadaten-Abschnitts (`teiHeader`) inkl. Übernahme der Metadaten zu früheren Bearbeitungsschritten

Die XProc-Pipeline (`staging/conversion.xpl`) muss einmal angestossen werden, der Prozess läuft dann selbständig durch. Dieser Prozess kann sowohl in oXygen XML Editor (unter Nutzung des integrierten Calabash-Prozessors; vlg. [Anleitung](http://oxygenxml.com/doc/ug-editor/topics/xproc-transformation-scenario.html)) oder auf der Kommandozeile erfolgen (ebenfalls unter Nutzung des [Calabash](http://xmlcalabash.com/)-Prozessors oder eines anderen XProc-Prozessors.

Der Vorgang ist relativ speicherintensiv und dauert für einen Voll-Abgleich je nach System/Konfiguration eine halbe Stunde oder länger.

In der Datei `staging/conversion.xpl` lassen sich mehrere Parameter konfigurieren (direkt in der Datei oder im oXygen-XProc-Transformationsszenario im Tab `Optionen`):

Parameter | Beschreibung
------------ | -------------
`editor` | Bearbeiter; z.B. als Github-Konto, Verweis auf eine `xml:id` oder als Klarnamen
`task-newEntries` | aktueller Bearbeitungsschritt für Neuaufnahmen (z.B. Auflistung der neuen Kurztitel); dieser wird als `<change>`-Element in die `<revisionDesc>` aufgenommen
`task-existingEntries`| aktueller Bearbeitungsschritt für bestehende Einträge; dieser wird als `<change>`-Element in die `<revisionDesc>` aufgenommen
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