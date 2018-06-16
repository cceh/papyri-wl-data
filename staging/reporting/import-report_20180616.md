
# WL Import Report 2018-06-16

*Check this report for sanity. If all looks good replace `current` directory by `output` directory and create a commit.*

## Number of files/lemmata before and after import


### Greek 


| category        | count before import | count after import | difference | difference (%) |
| :-----------: |-------------:|-------------:|-------------:|-------------:|
| general| 13956| 13956| 0| .00| 
| monthsDays| 97| 97| 0| .00| 
| geography| 4080| 4080| 0| .00| 
| persons| 13331| 13332| 1| +.01| 
| religion| 393| 393| 0| .00| 
| **Total**     |31857| **31858** |1|+.00|

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
| **Total**     |34041| **34042** |1|+.00|
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

* **`Βοΐσκος`: mismatch between `wl-grc-18884` (previously recorded identifier) and `` (identifier given in import datase)**


## Unmatched references

#### The conversion tries to find strings in the "see also" notes, that refer to other lemmata. This is only successful if the values of `pwl_verweis` and the string in the "see also" note are identical.

This tables lists cases where the number of "see also" references as defined in `pwl_verweis` does not match the number of referenced strings. It also contains cases with "see also" notes, for which no values were supplied in `pwl_verweis`.

Note that the spelling must be exactly identical for successful matches.

|Lemma|PWL-ID|`pwl_verweis`|"see also" note|
|---|---|---|---|
|ἁγιοσύνη|wl-grc-00066|`ἁγιωσύνη` |s. auch ἁγιωσύνη|
|ἁγιωσύνη|wl-grc-00068|`ἁγιοσύνη` |s. auch ἁγιοσύνη|
|ἀδιούτωρ|wl-grc-00181|`adiutor` `ἀιούτωρ` |s. auch ἀιούτωρ und Lateinisch `adiutor`|
|ἀεί|wl-grc-00202|`αἰεί` |s. auch αἰεί|
|αἰεί|wl-grc-00266|`ἀεί` |s. auch ἀεί|
|ἄν 2|wl-grc-00652||= ἐάν|
|ἀπόδωσις|wl-grc-01254|`ἀπόδοσις` |s. auch ἀπόδοσις|
|βιβλίον|wl-grc-02082|`βυβλίον` |s. auch βυβλίον|
|βοοστάσιον|wl-grc-02140|`βουστάσιον` |s. auch βουστάσιον|
|βουστάσιον|wl-grc-02181|`βοοστάσιον` |s. auch βοοστάσιον|
|βρέβειον|wl-grc-02198|`βρέουιον` `βρέυιον` `brevis` |s. auch βρέουιον, `βρέυιον` und Lateinisch `brevis`|
|βρέυιον|wl-grc-02202|`βρέβειον` `βρέουιον` `brevis` |s. auch `βρέβειον`, βρέουιον und Lateinisch `brevis`|
|βυβλιοθήκη|wl-grc-02211|`βιβλιοθήκη` |s. auch βιβλιοθήκη|
|βυβλίον|wl-grc-02212|`βιβλίον` |s. auch βιβλίον|
|βυβλιοφύλαξ|wl-grc-02214|`βιβλιοφύλαξ` |s. auch βιβλιοφύλαξ|
|γράμμα 2|wl-grc-02416||„Gramm"|
|δέσκαλος|wl-grc-02605|`διδάσκαλος` |s. auch διδάσκαλος|
|δονάτιβον|wl-grc-03070|`δωνατίουον` |s. auch δωνατίουον|
|δωνατίουον|wl-grc-03165|`δονάτιβον` |s. auch δονάτιβον|
|ἐγγαρία|wl-grc-03194|`ἀγγαρεία` `ἀγγαρία` |s. auch ἀγγαρεία, ἀγγαρία und Lateinisch angaria|
|ἐθέλω|wl-grc-03285|`θέλω` |s. auch θέλω|
|εἶδον|wl-grc-03299|`ἰδού` `ἰδέ` `ὁράω` |s. auch ἰδέ, ἰδού und ὁράω|
|εἶπον|wl-grc-03356|`λέγω` `εἰρημένος` `ἐρῶ` |s. auch εἰρημένος, `ἐρῶ` und λέγω|
|εἰρημένος|wl-grc-03358|`λέγω` `εἶπον` `ἐρῶ` |s. auch `εἶπον`, `ἐρῶ` und λέγω|
|ἑκκαιδέκατος|wl-grc-03508|`ἑξκαιδέκατος` |s. auch ἑξκαιδέκατος|
|ἐλαιών|wl-grc-03645|`ἐλαών` |s. auch ἐλαών|
|ἐλαών|wl-grc-03663|`ἐλαιών` |s. auch ἐλαιών|
|ἐξοδιάζω|wl-grc-04097|`ἐξωδιάζω` |s. auch ἐξωδιάζω|
|ἐξωδιάζω|wl-grc-04125|`ἐξοδιάζω` |s. auch ἐξοδιάζω|
|ἐξωδιασμός|wl-grc-04126|`ἐξοδιασμός` |s. auch ἐξοδιασμός|
|ἐπιορκέω|wl-grc-04421|`ἐφιορκέω` |s. auch ἐφιορκέω|
|ἐραυνάω|wl-grc-04603|`ἐρευνάω` |s. auch ἐρευνάω|
|ἐρευνάω|wl-grc-04646|`ἐραυνάω` |s. auch ἐραυνάω|
|ἔρρωμαι|wl-grc-04676|`ῥώννυμαι` |s. auch ῥώννυμαι|
|ἐρῶ|wl-grc-04682|`λέγω` `εἶπον` `εἰρημένος` |s. auch `εἶπον`, εἰρημένος und λέγω|
|ἐσπαρμένη|wl-grc-04691|`σπείρω` |s. auch σπείρω|
|εὐετηρία|wl-grc-04756|`εὐητηρία` |s. auch εὐητηρία|
|εὐητηρία|wl-grc-04762|`εὐετηρία` |s. auch εὐετηρία|
|ἐφιορκέω|wl-grc-04930|`ἐπιορκέω` |s. auch ἐπιορκέω|
|ζμύρνη|wl-grc-05004|`σμύρνα` |s. auch σμύρνα|
|θασσαλάριος|wl-grc-05198|`τεσσαράριος` `τεσσεράριος` `τεσσαλάριος` `tesserarius` |s. auch τεσσαλάριος, τεσσαράριος, τεσσεράριος und Lateinisch `tesserarius`|
|θεῖος 2|wl-grc-05220||„Onkel"|
|θέλω|wl-grc-05224|`ἐθέλω` |s. auch ἐθέλω|
|θιλουρός|wl-grc-05303|`θυρουρός` `θυρωρός` |s. auch θυρουρός und θυρωρός|
|ἰδέ|wl-grc-05397|`ἰδού` `εἶδον` `ὁράω` |s. auch `εἶδον`, ἰδού und ὁράω|
|ἰδού|wl-grc-05421|`εἶδον` `ἰδέ` `ὁράω` |s. auch `εἶδον`, ἰδέ und ὁράω|
|καθάπαξ|wl-grc-05619|`κατάπαξ` |s. auch κατάπαξ|
|καθωσιωμένος|wl-grc-05680|`καθοσιόω` |s. auch καθοσιόω|
|καρπός 2|wl-grc-05868||„Handgelenk"|
|κατάπαξ|wl-grc-06004|`καθάπαξ` |s. auch καθάπαξ|
|κιθώνιον|wl-grc-06300|`κιτώνιον` `χιτώνιον` |s. auch κιτώνιον und `χιτώνιον`|
|κιτώνιον|wl-grc-06327|`κιθώνιον` `χιτώνιον` |s. auch κιθώνιον und `χιτώνιον`|
|κοκούλλιον|wl-grc-06446|`κουκούλλιον` |s. auch κουκούλλιον|
|κουκούλλιον|wl-grc-06643|`κοκούλλιον` |s. auch κοκούλλιον|
|λαξός|wl-grc-06939|`λαοξός` |s. auch λαοξός|
|λαοξός|wl-grc-06944|`λαξός` |s. auch λαξός|
|λέγω|wl-grc-06982|`εἶπον` `εἰρημένος` `ἐρῶ` |s. auch `εἶπον`, εἰρημένος und `ἐρῶ`|
|μείς|wl-grc-07423|`μήν` |s. auch μήν|
|μήν|wl-grc-07601|`μείς` |s. auch μείς|
|μήν 2|wl-grc-07602||Partikel|
|μισθόομαι|wl-grc-07669|`μισθόω` |s. auch μισθόω|
|μόϊον|wl-grc-07703|`μώϊον` `μούιον` |s. auch μούιον und μώϊον|
|μούιον|wl-grc-07771|`μώϊον` `μόϊον` |s. auch μόϊον und μώϊον|
|μώϊον|wl-grc-07833|`μόϊον` `μούιον` |s. auch μόϊον und `μούιον`|
|νάουϊον|wl-grc-07844|`ναύβιον` |s. auch ναύβιον|
|οἶδα|wl-grc-08093||oft s.v. εἰδέναι|
|οἰκουμένη|wl-grc-08132|`οἰκέω` |s. auch οἰκέω|
|οὐ|wl-grc-08484||oft unter οὐκ und οὐχ|
|οὐεξιλλατίων|wl-grc-08505|`οὐηξιλλατίων` `vexillatio` |s. auch οὐηξιλλατίων und Lateinisch `vexillatio`|
|οὐηξιλλατίων|wl-grc-08513|`οὐεξιλλατίων` `vexillatio` |s. auch οὐεξιλλατίων und Lateinisch `vexillatio`|
|παλαιστροφύλαξ|wl-grc-08641|`παραστροφύλ-` |s. auch παραστροφυλ-|
|πατρεμουνιάλιος|wl-grc-08978|`πατριμουνάλιος` |s. auch πατριμουνάλιος|
|πεντηκοστή|wl-grc-09081|`ν̅` |s. auch ν᾽|
|περίειμι|wl-grc-09114||εἰμί|
|περίειμι 2|wl-grc-09115||εἶμι|
|πράσσω|wl-grc-09601|`πράττω` |s. auch πράττω|
|πράττω|wl-grc-09606|`πράσσω` |s. auch πράσσω|
|πρετέριτος|wl-grc-09619|`praeteritus` `πραιτέριτος` |s. auch πραιτέριτος und Lateinisch `praeteritus`|
|πρίγκιψ|wl-grc-09625|`princeps` `πρίγκεψ` |s. auch πρίγκεψ und Lateinisch `princeps`|
|προαγορεύω|wl-grc-09644|`προλέγω` |s. auch προλέγω|
|προεστώς|wl-grc-09712|`προΐσταμαι` |s. auch προΐσταμαι|
|προλέγω|wl-grc-09756|`προαγορεύω` |s. auch προαγορεύω|
|ῥογάτωρ|wl-grc-10190|`ῥωγάτωρ` |s. auch ῥωγάτωρ|
|ῥογεύω|wl-grc-10191|`ῥωγεύω` |s. auch ῥωγεύω|
|ῥωγάτωρ|wl-grc-10223|`ῥογάτωρ` |s. auch ῥογάτωρ|
|σαλίς|wl-grc-10271|`σελίς` |s. auch σελίς|
|σεβένινος|wl-grc-10334|`σιβένινος` |s. auch σιβένινος|
|σελίς|wl-grc-10352|`σαλίς` |s. auch σαλίς|
|σημειοφόρος|wl-grc-10385|`σημειαφόρος` `semiaphorus` `σημεαφόρος` |s. auch `σημεαφόρος`, σημιαφόρος und Lateinisch `semiaphorus`|
|σιππουργός|wl-grc-10453|`στιππουργός` |s. auch στιππουργός|
|σπυρίδιον|wl-grc-10686|`σφυρίδιον` |s. auch σφυριδιον|
|στιππουργός|wl-grc-10784|`σιππουργός` |s. auch σιππουργός|
|σύμπαντι|wl-grc-11017|`σύμπας` |s. auch σύμπας|
|τεσσαλάριος|wl-grc-11535|`τεσσαράριος` `τεσσεράριος` `tesserarius` `θασσαλάριος` |s. auch θασσαλάριος, τεσσαράριος, τεσσεράριος und Lateinisch `tesserarius`|
|τεσσαράριος|wl-grc-11542|`τεσσεράριος` `τεσσαλάριος` `tesserarius` `θασσαλάριος` |s. auch θασσάλαριος, τεσσαλάριος, τεσσεράριος und Lateinisch `tesserarius`|
|τούρμη|wl-grc-11719|`τύρμη` `turma` |s. auch τύρμη und Lateinisch `turma`|
|τουτί|wl-grc-11723|`οὑτοσί` |s. auch οὑτοσί|
|τριάντα|wl-grc-11773|`τριάκοντα` |s. auch τριάκοντα|
|ὑγεῖα|wl-grc-11907|`ὑγίεια` `ὑγία` |s. auch ὑγίεια und ὑγία|
|ὑγία|wl-grc-11908|`ὑγίεια` `ὑγεῖα` |s. auch ὑγίεια und `ὑγεῖα`|
|χιτών|wl-grc-12626|`κιθών` |s. auch κιθών und χιθών|
|χρεία|wl-grc-12706|`χρήα` |s. auch χρήα|
|χρήα|wl-grc-12716|`χρεία` |s. auch χρεία|
|χώννυμι|wl-grc-12810|`χόω` |s. auch χόω|
|Αὐασίτης|wl-grc-13469|`Ὀασίτης` |s. auch Ὀασίτης|
|Μερμέρθα|wl-grc-14851|`Πέραν Μερμέρθων` |s. auch Πέραν Μερμέρθων|
|Μυρισμοῦ λατομία|wl-grc-14942|`Murismú` |s. auch Lateinisch Murismu|
|Νέα Ἰουστίνου πόλις|wl-grc-14974||s. auch Ἰουστίνου πόλις|
|Ὀξύρυγχος|wl-grc-15135|`Oxyrunchus` |s. auch Lateinisch Oxyrhunchus|
|Πολέμωνος μερίς|wl-grc-15637|`Θεμίστου καὶ Πολέμωνος μερίδες` |s. auch Θεμίστου καὶ Πολέμωνος μερίδες|
|Σεσεμβύθεως|wl-grc-15906|`Ἰβιὼν Σεσεμβύθεως` |s. auch Ἰβιὼν Σ.|
|Συήνη|wl-grc-16026|`Σουήνη` |s. auch Σουήνη|
|Δεκέμβριος|wl-grc-16760|`Τεκέβερ` `December` |s. auch Τεκέβερ und Lateinisch `December`|
|Νοέμβριος|wl-grc-16795|`Νοέπερ` `November` |s. auch Νοέπερ und Lateinisch `November`|
|νουμηνία|wl-grc-16797|`νεομηνία` |s. auch νεομηνία|
|Ὀκτῶβερ|wl-grc-16802|`Ὀκτώβριος` `October` |s. auch Ὀκτώβριος und Lateinisch `October`|
|Σεθέβερ|wl-grc-16821|`Σεπτέμβριος` `September` |s. auch Σεπτέμβριος und Lateinisch `September`|
|Ἀμμωνία|wl-grc-17490|`Ἀμωνία` |s. auch Ἀμωνία|
|Ἀμμώνιος|wl-grc-17495|`Ammonius` `Ἀμώνιος` |s. auch Ἀμώνιος und Lateinisch `Ammonius`|
|Ἄπα Ὧλ|wl-grc-17844|`Ἀπαώλ` |s. auch Ἀπαώλ|
|Ἄπα Ὧρ|wl-grc-17845|`Ἀπαωρ` |s. auch Ἀπαώρ|
|Δικαῖος|wl-grc-19232|`Δικέος` |s. auch Δικέος|
|Εἰρήνη|wl-grc-19434|`Ἰρήνη` |s. auch Ἰρήνη|
|Ἰούλιος|wl-grc-20789|`Ἄπα Ἰούλιος` `Iulius` |s. auch Ἄπα Ἰούλιος und Lateinisch `Iulius`|
|Κλήμης|wl-grc-21443|`Κλήμενς` `Clemens` `Clemes` |s. auch Κλήμενς und Lateinisch `Clemens`, `Clemes`|
|Οὐάλης|wl-grc-23364|`Οὐάλενς` `Vales` `Valens` |s. auch `Οὐάλενς` und Lateinisch `Valens` und `Valens` und `Vales`|
|Οὐίκτωρ|wl-grc-23430|`Βίκτωρ` `Victor` |s. auch Βίκτωρ und Lateinisch `Victor`|
|Πομπώνιος|wl-grc-25498|`Πωμπώνιος` |s. auch Πωμπώνιος|
|Εἶσις|wl-grc-29439|`Ἶσις` `Isis Augusta` |s. auch `Ἶσις` und Lateinisch Isis|
|Ἶσις|wl-grc-29504|`Εἶσις` `Isis Augusta` |s. auch `Εἶσις` und Lateinisch Isis|
|Σάραπις|wl-grc-29621|`Serapis` `Σέραπις` |s. auch Σέραπις und Lateinisch `Serapis`|
|Σέραπις|wl-grc-29630|`Σάραπις` `Serapis` |s. auch Σάραπις und Lateinisch `Serapis`|
|Μικρὰ Ὄασις|wl-grc-30395|`Ὄασις Μικρά` |s. auch Ὄασις Μικρά|
|Μεγάλη Ὄασις|wl-grc-31789|`Ὄασις Μεγάλη` |s. auch Ὄασις Μεγάλη|
|Aprilis|wl-la-00002|`Ἀπρίλιος` `Aprilius` |s. auch `Aprilius` und Ἀπρίλιος|
|Athyr|wl-la-00003|`Ἁθύρ` |s. auch Ἁθύρ|
|December|wl-la-00005|`Τεκέβερ` `Δεκέμβριος` |s. auch `Δεκέμβριος` und Τεκέβερ|
|November|wl-la-00017|`Νοέμβριος` `Νοέπερ` |s. auch `Νοέμβριος` und Νοέπερ|
|October|wl-la-00018|`Ὀκτῶβερ` `Ὀκτώβριος` |s. auch `Ὀκτῶβερ` und Ὀκτώβριος|
|September|wl-la-00022|`Σεθέβερ` `Σεπτέμβριος` |s. auch `Σεθέβερ` und Σεπτέμβριος|
|Ammonius|wl-la-00051|`Ἀμμώνιος` `Ἀμώνιος` |s. auch `Ἀμμώνιος`|
|Anup|wl-la-00067|`Ἀνοῦπ` |Anup|
|Capiton|wl-la-00127|`Καπίτων` |Capiton|
|Clemens|wl-la-00147|`Κλήμενς` `Κλήμης` |s. auch Κλήμενς und `Κλήμης`|
|Clemes|wl-la-00149|`Κλήμενς` `Κλήμης` `Clemens` |s. auch `Clemens` und Κλήμενς, `Κλήμης`|
|Equitius|wl-la-00220||s. auch Ἐκύτιος|
|Eustathius|wl-la-00222|`Εὐστάθιος` |Eustathius|
|Serapis|wl-la-00680|`Σάραπις` `Σέραπις` |s. auch Σάραπις und Σέραπις|
|actuarius|wl-la-00697|`ἀκτουάριος` |s. auch ἀκτουάριος|
|adiutor|wl-la-00704|`ἀδιούτωρ` `ἀιούτωρ` |s. auch ἀδιούτωρ und ἀιούτωρ|
|angaria|wl-la-00761|`ἀγγαρεία` `ἀγγαρία` |s. auch ἀγγαρεία, ἀγγαρία und ἐγγαρία|
|annona|wl-la-00766|`ἀννῶνα` `ἀννωναρία` |s. auch `ἀννῶνα` und ἀννωναρία|
|annonarius|wl-la-00767|`ἀννωνάριος` |s. auch ἀννωνάριος|
|argentarius|wl-la-00780|`ἀργεντάριος` |s. auch ἀργεντάριος|
|beneficiarius|wl-la-00815|`βενεφικιάριος` |s. auch βενεφικιάριος|
|brevis|wl-la-00827|`βρέβειον` `βρέουιον` `βρέυιον` |s. auch `βρέβειον`, βρέουιον und `βρέυιον`|
|comes|wl-la-00951|`κόμες` `κόμις` `κόμης` |s. auch κόμες, κόμης und κόμις|
|conductor|wl-la-00971|`κονδούκτωρ` |s. auch κονδούκτωρ|
|cornicularius|wl-la-01010|`κορνικουλάριος` |s. auch κορνικουλάριος|
|corrector|wl-la-01012|`κορρήκτωρ` |s. auch κορρήκτωρ|
|curator|wl-la-01035|`κουράτωρ` |s. auch κουράτωρ|
|denarius|wl-la-01067|`δηνάριον` |s. auch δηνάριον|
|di|wl-la-01076||= Griechisch δι᾽|
|dioecesis|wl-la-01087|`διοίκησις` |s. auch διοίκησις|
|domesticus|wl-la-01098|`δομεστικός` |s. auch δομεστικός|
|dromadarius|wl-la-01108|`δρομαδάριος` `δρομεδάριος` |s. auch δρομαδάριος und `δρομεδάριος`|
|ducenarius|wl-la-01110|`δουκηνάριος` |s. auch δουκηνάριος|
|duplicarius|wl-la-01115|`δουπλικάριος` |s. auch δουπλικάριος|
|emu|wl-la-01131||= Griechisch ἐμοῦ|
|etelioth|wl-la-01147|`τελειόω` |s. auch τελειόω|
|eteliothe|wl-la-01148|`τελειόω` |s. auch τελειόω|
|familia|wl-la-01189|`φαμιλία` |s. auch φαμιλία|
|familiaris|wl-la-01190|`φαμιλιάριος` |s. auch φαμιλιάριος|
|galearius|wl-la-01231|`γαλεάριος` |s. auch γαλεάριος|
|libellus|wl-la-01372|`λίβελλος` |s. auch λίβελλος|
|librarius|wl-la-01380|`λιβράριος` |s. auch λιβράριος|
|magister|wl-la-01403|`μάγιστερ` |s. auch μάγιστερ|
|magistrianus|wl-la-01404|`μαγιστριανός` |s. auch μαγιστριανός|
|matium|wl-la-01420|`μάτιον` |s. auch μάτιον|
|metropolis|wl-la-01446|`μητρόπολις` |s. auch μητρόπολις|
|modius|wl-la-01464|`μόδιος` |s. auch μόδιος|
|nauclerus|wl-la-01492|`ναύκληρος` |s. auch ναύκληρος|
|nomus|wl-la-01504|`νομός` |s. auch νομός|
|numerus|wl-la-01522|`νούμερος` |s. auch νούμερος|
|officium|wl-la-01541|`ὀφφίκιον` |s. auch ὀφφίκιον|
|onelates|wl-la-01547|`ὀνηλάτης` |s. auch ὀνηλάτης|
|pentecedecate|wl-la-01583|`πεντεκαιδέκατος` |s. auch πεντεκαιδέκατος|
|poria|wl-la-01619|`πορεία` |s. auch πορεία|
|praepositus|wl-la-01636|`πραιπόσιτος` |s. auch πραιπόσιτος|
|praeteritus|wl-la-01644|`πρετέριτος` `πραιτέριτος` |s. auch πραιτέριτος und πρετέριτος|
|praetor|wl-la-01646|`πραίτωρ` |s. auch πραίτωρ|
|praetorianus|wl-la-01647|`πραιτωριανός` |s. auch πραιτωριανός|
|princeps|wl-la-01659|`princeps` `πρίγκεψ` |s. auch πρίγκεψ und πρίγκιψ|
|principia|wl-la-01660|`πριγκίπια` |s. auch πριγκίπια|
|procurator|wl-la-01665|`προκουράτωρ` |s. auch προκουράτωρ|
|scopelarius|wl-la-01793|`σκοπελάριος` |s. auch σκοπελάριος|
|semiaphorus|wl-la-01815|`σημειαφόρος` `σημειοφόρος` `σημεαφόρος` |s. auch σημειαφόρος und σημειοφόρος|
|signifer|wl-la-01836|`σίγνιφερ` |s. auch σίγνιφερ|
|speculator|wl-la-01863|`σπεκουλάτωρ` |s. auch σπεκουλάτωρ|
|stationarius|wl-la-01870|`στατιωνάριος` |s. auch στατιωνάριος|
|sum|wl-la-01889||oft s.v. esse|
|sumbolaiografus|wl-la-01890|`συμβολαιογράφος` |s. auch συμβολαιογράφος|
|tabellarius|wl-la-01904|`ταβελλάριος` |s. auch ταβελλάριος|
|tesserarius|wl-la-01924|`τεσσαράριος` `τεσσεράριος` `τεσσαλάριος` `θασσαλάριος` |s. auch θασσαλάριος, τεσσαλάριος, τεσσαράριος und τεσσεράριος|
|upodiaconus|wl-la-01979|`ὑποδιάκονος` |s. auch ὑποδιάκονος|
|verbum|wl-la-02006|`βέρβον` |s. auch βέρβον|
|vestigatio|wl-la-02015|`οὐεστιγατίων` |s. auch οὐεστιγατίων|
|vestigator|wl-la-02016|`οὐεστιγάτωρ` |s. auch οὐεστιγάτωρ|
|adelpos|wl-la-02065||= Griechisch ἀδελφός|
|artaba|wl-la-02067|`ἀρτάβη` |s. auch ἀρτάβη|
|ce|wl-la-02068||= Griechisch καί ?|
|cero|wl-la-02069||= Griechisch χαίρω|
|crite|wl-la-02070||= Griechisch κριθή|
|dyon|wl-la-02072||= Griechisch δυῶν|
|etelesth|wl-la-02073||= Griechisch ἐτελέσθη|
|eteliothh|wl-la-02074|`τελειόω` |s. auch τελειόω|
|exsun|wl-la-02075||= Griechisch ἐξ ὧν|
|lambano|wl-la-02080||= Griechisch λαμβάνω|
|obule|wl-la-02081||= Griechisch ὀβολός|
|obulun|wl-la-02082||= Griechisch ὀβολός|
|pempo|wl-la-02083||= Griechisch πέμπω|
|Aprilius|wl-la-02132|`Ἀπρίλιος` `Aprilis` |s. auch `Aprilis` und Ἀπρίλιος|


## Character test
    
#### Entries that contain suspicious Unicode characters

This section is empty unless there are Greek lemmata that contain Latin characters (except punctuation and numbers) or Latin lemmata that contain Greek characters. The entries should be fixed in the input and the transformation re-run until this section is empty or the characters are judged correct (this should be recorded as known exception in [/papyri-wl-data/staging/library/reporting/1-log.xsl](https://github.com/cceh/papyri-wl-data/edit/master/staging/library/reporting/1-log.xsl).).

|Lemma|PWL-ID|FM number|offending character(s)|note|
|---|---|---|---|---|
|Agaθo|wl-la-00036|38 (la, persons)|θ|known exception|
