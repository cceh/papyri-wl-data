# Hilfsskripte

## Bibliographie-IDs aktualisieren

Diese Skripte dienen dazu, die temporären `xml:id`-Attribute (z.B. `ohne_Verweis_...`) in den Meta-Dateien durch die offiziellen papyri.info-Bibliographie-IDs zu ersetzen.

### Workflow

1. **Eingabedatei erstellen**: TSV-Datei mit Kurztitel und neuer ID (Tab-getrennt):
   ```
   BGU 21	97090
   P.Oxy. 87	96837
   P.Köln 15	97105
   ```

   Die Liste kann ggf. direkt aus der Word-Begleitdatei der Datenlieferung kopiert werden.

2. **Aktuelle IDs nachschlagen**:
   ```bash
   ./lookup-biblio-ids.sh eingabe.tsv > ersetzungen.tsv
   ```
   Das Skript sucht in `meta/literature.xml` nach dem Kurztitel (Groß-/Kleinschreibung und Leerzeichen werden ignoriert) und gibt die gefundene `xml:id` zusammen mit der neuen ID aus.

3. **IDs ersetzen**:
   ```bash
   ./replace-biblio-ids.sh ersetzungen.tsv
   ```
   Ersetzt in allen XML-Dateien im `meta/`-Verzeichnis:
   - `xml:id="alte_id"` → `xml:id="neue_id"`
   - `target="alte_id"` → `target="neue_id"`
   - `target="#alte_id"` → `target="#neue_id"`

### Hinweise

- Bei nicht gefundenen Kurztiteln wird eine Warnung ausgegeben. Die IDs sollten dann manuell herausgesucht und ergänzt werden.
