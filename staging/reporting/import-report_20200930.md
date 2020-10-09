
# WL Import Report 2020-09-30

*Check this report for sanity. If all looks good replace `current` directory by `output` directory and create a commit.*

## Number of files/lemmata before and after import


### Greek 


| category        | count before import | count after import | difference | difference (%) |
| :-----------: |-------------:|-------------:|-------------:|-------------:|
| general| 14084| 14359| 275| +1.95| 
| monthsDays| 97| 98| 1| +1.03| 
| geography| 4178| 4352| 174| +4.16| 
| persons| 13489| 13607| 118| +.87| 
| religion| 424| 427| 3| +.71| 
| **Total**     |32272| **32843** |571|+1.77|

### Latin 


| category        | count before import | count after import | difference | difference (%) |
| :-----------: |-------------:|-------------:|-------------:|-------------:|
| general| 1461| 1476| 15| +1.03| 
| monthsDays| 22| 22| 0| .00| 
| geography| 67| 67| 0| .00| 
| persons| 652| 652| 0| .00| 
| religion| 10| 11| 1| +10.00| 
| **Total**     |2212| **2228** |16|+.72|

### Total 


| category        | count before import | count after import | difference | difference (%) |
| :-----------: |-------------:|-------------:|-------------:|-------------:|
| **Total**     |34484| **35071** |587|+1.70|
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
    
### Differing spelling of previously existing and currently imported lemmata

This section lists entries for which the spelling of the lemma has changed since the last data conversion. With the final run of the conversion `Lemma (old)` will be replaced by `Lemma (new)`.  

| Lemma (new) | Lemma (old) | PWL ID | FileMaker RecordId |
| :-----------: |:------------:|:------------:|:------------:|
|ἀλέτης|ἀλετής|wl-grc-00441|482|                            
|ἀρχιίατρος|ἀρχιιατρός|wl-grc-01643|1770|                            
|Μεγάλης Παρορίου ἐποίκιον|Μεγάλη Παρορίου ἐποίκιον|wl-grc-14809|1970|                            
|Φατεμῆντ χωρίον|Φατεμὴντ χωρίον|wl-grc-16454|3790|                            
|Μεσιγῆσις|Μεσίγησις|wl-grc-22568|6139|                            
|Οὐαλερᾶς|Οὐαλ̣ερᾶς|wl-grc-23356|7000|                            
|Σοκνῶπις|Σόκνωπις|wl-grc-26794|10623|                            


    
### Entries that already existed before the import, but were not recognized (deprecated)

This section is empty unless there are lemmata, that were changed in FileMaker since the last export. In that case, the changes (most often these are regularisations on character level) should be ported to the `current` data and the transformation re-run until this section is empty.

#### Greek 

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

#### Latin 

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
### Unmatched IDs (deprecated)
    
#### Comparison of identifiers as assigned during the conversion and identifiers as stored in the working environment

Identifiers (`pwl_id`) are assigned during the conversion, but they are also stored in the work environment (FileMaker). This list hints to mismatching identifiers in the two environments. This list contains new lemmata that were not assigned an identifier yet and should normally be empty. If mismatches do occur they should generally be resolved by updating the identifier in the working environment.



### Unmatched references

#### The conversion tries to find strings in the "see also" notes, that refer to other lemmata. This is only successful if the values of `pwl_verweis` and the string in the "see also" note are identical.

This tables lists cases where the number of "see also" references as defined in `pwl_verweis` does not match the number of referenced strings. It also contains cases with "see also" notes, for which no values were supplied in `pwl_verweis`.

Note that the spelling must be exactly identical for successful matches.

|Lemma|PWL-ID|`pwl_verweis`|"see also" note|
|---|---|---|---|
|ἄν 2|wl-grc-00652||= ἐάν|
|ἀρχιατρός|wl-grc-01630||s. auch ἀρχιίατρος|
|ἀρχιίατρος|wl-grc-01643||s. auch ἀρχιατρός|
|γράμμα 2|wl-grc-02416||„Gramm"|
|θεῖος 2|wl-grc-05220||„Onkel"|
|καρπός 2|wl-grc-05868||„Handgelenk"|
|μήν 2|wl-grc-07602||Partikel|
|οἶδα|wl-grc-08093||oft s.v. εἰδέναι|
|οὐ|wl-grc-08484||oft unter οὐκ und οὐχ|
|περίειμι|wl-grc-09114||εἰμί|
|περίειμι 2|wl-grc-09115||εἶμι|
|Νέα Ἰουστίνου πόλις|wl-grc-14974||s. auch Ἰουστίνου πόλις|
|Equitius|wl-la-00220||s. auch Ἐκύτιος|
|di|wl-la-01076||= Griechisch δι᾽|
|emu|wl-la-01131||= Griechisch ἐμοῦ|
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


### Character test
    
#### Entries that contain suspicious Unicode characters

This section is empty unless there are Greek lemmata that contain Latin characters (except punctuation and numbers) or Latin lemmata that contain Greek characters. The entries should be fixed in the input and the transformation re-run until this section is empty or the characters are judged correct (this should be recorded as known exception in [/papyri-wl-data/staging/library/reporting/1-log.xsl](https://github.com/cceh/papyri-wl-data/edit/master/staging/library/reporting/1-log.xsl).).

|Lemma|PWL-ID|FM number|offending character(s)|note|
|---|---|---|---|---|
|Agaθo|wl-la-00036|38 (la, persons)|θ|known exception|
