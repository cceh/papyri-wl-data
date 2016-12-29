Papyri Wörterlisten – Data
===========================================================

Dieses Repositorium enthält die Ausgangsdaten der Papyri-Wörterlisten (vgl. [WL.pdf](http://www.zaw.uni-heidelberg.de/hps/pap/WL/WL.pdf) bzw. [WL.html](http://www.papy.uni-hd.de/WL/WL.html); Webanwendung in Entwicklung).

Über die Daten
-------------------------------------

Prof. Dr. D. Hagedorn erstellt seit 1996 (unter anfänglicher Mithilfe von Pia Breit, Wolfgang Habermann, Ursula Hagedorn, Bärbel Kramer, Gertrud Marohn und Jörn Salewski) Wörterlisten aus den Registern von Publikationen griechischer und lateinischer dokumentarischer Papyri und Ostraka. Zur Verwendung kam dafür eine selbst entwickelte [HyperCard](https://en.wikipedia.org/wiki/HyperCard)-Anwendung, die mit der Zeit auch parallel in [FileMaker](https://en.wikipedia.org/wiki/FileMaker) gepflegt wurde.
Dieses Repositorium umfasst einen Transformations-Workflow ab FileMaker-XML-Exporten sowie die daraus resultierenden Wörterlisten-Dateien in `TEI-XML`.

Datentransformation
-------------------------------------

### Duplikat-Check

Die Daten umfassen fünf unterschiedliche Kategorien. Jedes Lemma kann in einer bestimmten Schreibweise in jeder Kategorie nur einmal vorkommen.

Bevor die Import-Pipeline erfolgreich ausgeführt werden kann, sind problematische Duplikate mit `staging/check-current-data-for-duplicates.xsl` zu identifizieren und ggf. manuell zu bereinigen. Die resultierende Datei `duplicates.xml` kann nach der Bereinigung entfernt werden.

### Import-Pipeline

#### Kurzanleitung

1. Duplikat-Check ausführen (s.o.)
2. FileMaker-XML-Dateien in das Verzeichnis `staging/input` speichern.
3. `conversion.xpl` ausführen
4. Dateien in `staging/output` mit den bisherigen Dateien vergleichen (`current`)
5. Dateien in `current` durch Dateien in `staging/output` ersetzen
6. `git commit` bzw. Pull-Request erstellen

#### Ausführliche Anleitung

Der Datenabgleich/Import verläuft nur erfolgreich, wenn es innerhalb der Kategorien keine zeichen-identischen Lemmata gibt. Mit dem Duplikat-Check (s.o.) lässt sich das vor Beginn des Abgleichs leicht ermitteln.

Der eigentliche Abgleich ist als [XProc](http://www.w3.org/TR/xproc/)-Pipeline angelegt. Innerhalb der Pipeline werden verschiedene XSL-Transformationen ausgeführt und die einzelnen Einträge schließlich als Einzeldateien ins Output-Verzeichnis geschrieben. Die Transformationsschritte umfassen:

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
`task-newEntries` | aktueller Bearbeitungsschritt für Neuaufnahmen; dieser wird als `<change>`-Element in die `<revisionDesc>` aufgenommen
`task-existingEntries`| aktueller Bearbeitungsschritt für bestehende Einträge; dieser wird als `<change>`-Element in die `<revisionDesc>` aufgenommen
`schemaPath` | Pfad zum Verzeichnis, welches das XML-Schema (`.rng-Datei`) enthält
`comparisonBase`| aktuelles Datenverzeichnis; die FileMaker-Exportdateien werden mit den in diesem Verzeichnis liegenden Dateien abgeglichen; für Workflow-Tests lässt sich hier ein weniger umfangreiches Verzeichnis angeben
`outputScenario` | hier lässt sich für Workflow-Tests mit `'oneFile'` die Ausgabe in einer Einzeldatei festlegen; jeder andere Wert führt zur Standardausgabe (eine Datei pro Eintrag)

Die Werte müssen mit umschließenden einfachen Anführungszeichen eingetragen werden.

Kontakt/Mitarbeit
---------------------------

Kontaktadresse: `papyri-woerterlisten AT uni-koeln.de`

Institut für Altertumskunde, Universität zu Köln, Albertus-Magnus-Platz, D-50923 Köln

Cologne Center for eHumanities, Universität zu Köln, Albertus-Magnus-Platz, D-50923 Köln