
Dieses Readme wird automatisch generiert; [README bearbeiten](https://github.com/cceh/papyri-wl-data/edit/master/staging/library/readme/1-writeReadme.xsl)
    
---
            
Papyri Wörterlisten – Data
===========================================================
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.836158.svg)](https://doi.org/10.5281/zenodo.836158)

Dieses Repositorium enthält die Ausgangsdaten der Papyri-Wörterlisten (vgl. [WL.pdf](http://www.zaw.uni-heidelberg.de/hps/pap/WL/WL.pdf) bzw. [WL.html](http://www.papy.uni-hd.de/WL/WL.html); Webanwendung verfügbar unter [https://papyri.uni-koeln.de/papyri-woerterlisten](https://papyri.uni-koeln.de/papyri-woerterlisten)).

Über die Daten
-------------------------------------

Prof. Dr. D. Hagedorn erstellt seit 1996 (unter anfänglicher Mithilfe von Pia Breit, Wolfgang Habermann, Ursula Hagedorn, Bärbel Kramer, Gertrud Marohn und Jörn Salewski; seit 2017 in Zusammenarbeit mit Klaus Maresch) Wörterlisten aus den Registern von Publikationen griechischer und lateinischer dokumentarischer Papyri und Ostraka. Zur Verwendung kam dafür eine selbst entwickelte [HyperCard](https://en.wikipedia.org/wiki/HyperCard)-Anwendung, die mit der Zeit auch parallel in [FileMaker](https://en.wikipedia.org/wiki/FileMaker) gepflegt wurde.
Dieses Repositorium umfasst einen Transformations-Workflow ab FileMaker-XML-Exporten sowie die daraus resultierenden Wörterlisten-Dateien in `TEI-XML`.


### Datenumfang

Die Wörterlisten umfassen 36903 Einträge, wovon 34623 in griechischer und 2280 in lateinischer Sprache (Stand 14. November 2023, 26. Fassung). Die Verteilung auf die Kategorien ist nachstehend illustriert.

**Sprachübergreifend**

```txt
general:      ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||16548
geography:    |||||||||||||||||||||||4639
persons:      |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||15093
monthsDays:   121
religion:     ||502
```

**Griechisch**

```txt
general:      |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||15045
geography:    ||||||||||||||||||||||4572
persons:      ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||14416
monthsDays:   99
religion:     ||491
```

**Lateinisch**

```txt
monthsDays:   22
persons:      |||677
geography:    67
religion:     11
general:      |||||||1503
            
| = 200 Einträge            
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
`version` | Fassung; `Versionsnummer`, `Versionsname`, `Datum`, jeweils getrennt durch `¦` (`'21¦21. Version¦27.07.2017'`) 
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

Der Datenabgleich/Import verläuft nur erfolgreich bzw. die Datenkonversion wird erst angestoßen, wenn es innerhalb der Kategorien keine zeichen-identischen Lemmata gibt. Dieser Sachverhalt wird in einem der ersten Schritte der Pipeline überprüft. Dabei werden problematische Duplikate identifiziert und in einer Liste ausgegeben (Markdown-Format). Nach manueller Bereinigung der Duplikate kann die Konversion neu gestartet werden.

##### PWL-IDs

Jedem Lemma wird im Zuge der Datenübernahme eine sog. PWL-ID zugewiesen. Seit Juli 2019 basiert die Datenkonversion nicht mehr auf einem zeichenidentischen Lemma-Abgleich, sondern auf dieser ID.

Als Konsequenz daraus müssen neu zugewiesene PWL-IDs für jede neue Fassung/Version in FileMaker importiert werden. Die Konversionsroutine legt dazu im Verzeichnis `output/return` für jede Inputdatei eine um die IDs erweiterte Datei an, die sich in FileMaker importieren lässt. 

Kontakt/Mitarbeit
---------------------------

Kontaktadresse: `papyri-woerterlisten AT uni-koeln.de`

Institut für Altertumskunde, Universität zu Köln, Albertus-Magnus-Platz, D-50923 Köln

Cologne Center for eHumanities, Universität zu Köln, Albertus-Magnus-Platz, D-50923 Köln

*Daten und README zuletzt generiert am 
14. November 2023 mit XML Calabash 1.5.3 (for Saxon 11.4/EE) von [Norman Walsh](http://xmlcalabash.com/) und SAXON EE 11.4 von [Saxonica](http://www.saxonica.com/) (XSL 3.0).*