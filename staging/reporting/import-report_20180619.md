
# WL Import Report 2018-06-19

*Check this report for sanity. If all looks good replace `current` directory by `output` directory and create a commit.*

## Number of files/lemmata before and after import


### Greek 


| category        | count before import | count after import | difference | difference (%) |
| :-----------: |-------------:|-------------:|-------------:|-------------:|
| general| 13956| 13956| 0| .00| 
| monthsDays| 97| 97| 0| .00| 
| geography| 4080| 4080| 0| .00| 
| persons| 13331| 13331| 0| .00| 
| religion| 393| 393| 0| .00| 
| **Total**     |31857| **31857** |0|.00|

### Latin 


| category        | count before import | count after import | difference | difference (%) |
| :-----------: |-------------:|-------------:|-------------:|-------------:|
| general| 1439| 1439| 0| .00| 
| monthsDays| 22| 22| 0| .00| 
| geography| 66| 66| 0| .00| 
| persons| 647| 647| 0| .00| 
| religion| 10| 10| 0| .00| 
| **Total**     |2184| **2184** |0|.00|

### Total 


| category        | count before import | count after import | difference | difference (%) |
| :-----------: |-------------:|-------------:|-------------:|-------------:|
| **Total**     |34041| **34041** |0|.00|
## New files/lemmata


### Greek 

#### Type: general

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
#### Type: geography

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
#### Type: monthsDays

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
#### Type: persons

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
#### Type: religion

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|

### Latin 

#### Type: monthsDays

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
#### Type: persons

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
#### Type: geography

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
#### Type: religion

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
#### Type: general

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
## Control section
    
#### Entries that already existed before the import, but were not recognized

This section is empty unless there are lemmata, that were changed in FileMaker since the last export. In that case, the changes (most often these are regularisations on character level) should be ported to the `current` data and the transformation re-run until this section is empty.

### Greek 

##### Type: general

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
##### Type: geography

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
##### Type: monthsDays

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
##### Type: persons

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
##### Type: religion

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|

### Latin 

##### Type: monthsDays

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
##### Type: persons

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
##### Type: geography

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
##### Type: religion

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
##### Type: general

| Lemma        | WL ID | FileMaker RecordId | references |
| -----------|-------------|-------------|-------------|
## Unmatched IDs
    
#### Comparison of identifiers as assigned during the conversion and identifiers as stored in the working environment

Identifiers (`pwl_id`) are assigned during the conversion, but they are also stored in the work environment (FileMaker). This list hints to mismatching identifiers in the two environments. This list should only ever contain new lemmata that were not assigned an identifier yet. Any other instance (printed below in bold face) should be resolved, generally by updating the identifier in the working environment.



## Unmatched references

#### The conversion tries to find strings in the "see also" notes, that refer to other lemmata. This is only successful if the values of `pwl_verweis` and the string in the "see also" note are identical.

This tables lists cases where the number of "see also" references as defined in `pwl_verweis` does not match the number of referenced strings. It also contains cases with "see also" notes, for which no values were supplied in `pwl_verweis`.

Note that the spelling must be exactly identical for successful matches.

|Lemma|PWL-ID|`pwl_verweis`|"see also" note|
|---|---|---|---|
|ἄν 2|wl-grc-00652||= ἐάν|
|γράμμα 2|wl-grc-02416||„Gramm"|
|ἐξοδιάζω|wl-grc-04097|`ἐξωδιάζω` |s. auch ἐξωδιάζω|
|θεῖος 2|wl-grc-05220||„Onkel"|
|καρπός 2|wl-grc-05868||„Handgelenk"|
|μήν 2|wl-grc-07602||Partikel|
|ναύβιον|wl-grc-07853|`νάουϊον` |s. auch νάουϊον|
|οἶδα|wl-grc-08093||oft s.v. εἰδέναι|
|οὐ|wl-grc-08484||oft unter οὐκ und οὐχ|
|πεντηκοστή|wl-grc-09081|`ν̅` |s. auch ν᾽|
|περίειμι|wl-grc-09114||εἰμί|
|περίειμι 2|wl-grc-09115||εἶμι|
|τεσσαράριος|wl-grc-11542|`τεσσεράριος` `τεσσαλάριος` `tesserarius` `θασσαλάριος` |s. auch θασσάλαριος, `τεσσαλάριος`, `τεσσεράριος` und Lateinisch `tesserarius`|
|Νέα Ἰουστίνου πόλις|wl-grc-14974||s. auch Ἰουστίνου πόλις|
|Ἄπα Ὧρ|wl-grc-17845|`Ἀπαωρ` |s. auch Ἀπαώρ|
|Ammonius|wl-la-00051|`Ἀμμώνιος` `Ἀμώνιος` |s. auch `Ἀμμώνιος`|
|Equitius|wl-la-00220||s. auch Ἐκύτιος|
|Pompeia|wl-la-00438|`Πομπηΐα` |s. auch Πομπηΐα|
|di|wl-la-01076||= Griechisch δι᾽|
|emu|wl-la-01131||= Griechisch ἐμοῦ|
|princeps|wl-la-01659|`princeps` `πρίγκεψ` |s. auch `πρίγκεψ` und πρίγκιψ|
|semiaphorus|wl-la-01815|`σημειαφόρος` `σημειοφόρος` `σημεαφόρος` |s. auch `σημειαφόρος` und `σημειοφόρος`|
|sum|wl-la-01889||oft s.v. esse|
|adelpos|wl-la-02065||= Griechisch ἀδελφός|
|ce|wl-la-02068||= Griechisch καί ?|
|cero|wl-la-02069||= Griechisch χαίρω|
|crite|wl-la-02070||= Griechisch κριθή|
|dyon|wl-la-02072||= Griechisch δυῶν|
|etelesth|wl-la-02073||= Griechisch ἐτελέσθη|
|exsun|wl-la-02075||= Griechisch ἐξ ὧν|
|lambano|wl-la-02080||= Griechisch λαμβάνω|
|obule|wl-la-02081||= Griechisch ὀβολός|
|obulun|wl-la-02082||= Griechisch ὀβολός|
|pempo|wl-la-02083||= Griechisch πέμπω|


## Character test
    
#### Entries that contain suspicious Unicode characters

This section is empty unless there are Greek lemmata that contain Latin characters (except punctuation and numbers) or Latin lemmata that contain Greek characters. The entries should be fixed in the input and the transformation re-run until this section is empty or the characters are judged correct (this should be recorded as known exception in [/papyri-wl-data-master/staging/library/reporting/1-log.xsl](https://github.com/cceh/papyri-wl-data/edit/master-master/staging/library/reporting/1-log.xsl).).

|Lemma|PWL-ID|FM number|offending character(s)|note|
|---|---|---|---|---|
|Agaθo|wl-la-00036|38 (la, persons)|θ|known exception|
