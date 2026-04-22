select
    `st1`.`releve_id` AS `session_id`,
    `st1`.`user_id` AS `user_id`,
    `st1`.`structure_id` AS `structure_id`,
    `st1`.`structure_nom` AS `structure_nom`,
    `st1`.`structure_nom_non_referencee` AS `structure_nom_non_referencee`,
    `st1`.`plage_nom` AS `site_name`,
    `st1`.`geometry` AS `geometry`,
    `st1`.`latitude` AS `latitude`,
    `st1`.`longitude` AS `longitude`,
    `st1`.`aire_biogeographique` AS `aire_biogeographique`,
    `st1`.`code_postal` AS `code_postal`,
    `st1`.`transect_id` AS `transect_id`,
    `st1`.`transect_numero` AS `transect_numero`,
    `st1`.`transect_description` AS `transect_description`,
    `st1`.`url_photo_transect` AS `url_photo_transect`,
    `st1`.`date` AS `session_date`,
    `st1`.`heure` AS `session_time`,
    `st1`.`nb_participant` AS `nb_participant`,
    `st1`.`type_public` AS `type_public`,
    `st1`.`ecole_nom` AS `ecole_nom`,
    `st1`.`longueur_laisse` AS `longueur_laisse`,
    `st1`.`largeur_laisse` AS `largeur_laisse`,
    `st1`.`epaisseur_laisse` AS `epaisseur_laisse`,
    `st1`.`passage_cribleuse` AS `passage_cribleuse`,
    `st1`.`engins_motorises` AS `engins_motorises`,
    `st1`.`activites` AS `activites`,
    `st1`.`commentaires` AS `commentaires`,
    `st1`.`nb_quadrat` AS `nb_quadrat`,
    `st1`.`Q1_validation` AS `Q1_validation`,
    `st1`.`Q1_url_photo` AS `Q1_url_photo`,
    `st1`.`Q2_validation` AS `Q2_validation`,
    `st1`.`Q2_url_photo` AS `Q2_url_photo`,
    `st1`.`Q3_validation` AS `Q3_validation`,
    `st1`.`Q3_url_photo` AS `Q3_url_photo`,
    `st1`.`Q4_validation` AS `Q4_validation`,
    `st1`.`Q4_url_photo` AS `Q4_url_photo`,
    `st1`.`Q5_validation` AS `Q5_validation`,
    `st1`.`Q5_url_photo` AS `Q5_url_photo`,
    `st1`.`remarques_quadrats` AS `remarques_quadrats`,
    `st1`.`expert` AS `expert`,
    `st1`.`observation_id` AS `observation_id`,
    `st1`.`taxon_id` AS `taxon_id`,
    `st1`.`taxon` AS `taxon`,
    `st1`.`algue_code` AS `algue_code`,
    `st1`.`Q1_abondance` AS `Q1_abondance`,
    `st1`.`Q2_abondance` AS `Q2_abondance`,
    `st1`.`Q3_abondance` AS `Q3_abondance`,
    `st1`.`Q4_abondance` AS `Q4_abondance`,
    `st1`.`Q5_abondance` AS `Q5_abondance`,
    `st1`.`url_photo_algue_a_confirmer` AS `url_photo_algue_a_confirmer`,
    `st1`.`commentaire_algue_a_confirmer` AS `commentaire_algue_a_confirmer`,
    `st1`.`date_creation_bdd` AS `date_creation_bdd`,
    `st1`.`date_modif_bdd` AS `date_modif_bdd`
from
    (
    select
        `p`.`id` AS `releve_id`,
        `p`.`userId` AS `user_id`,
        `u`.`username` AS `user_name`,
        `p`.`structureId` AS `structure_id`,
        `s`.`name` AS `structure_nom`,
        `p`.`structurenonref` AS `structure_nom_non_referencee`,
        `t`.`namePlage` AS `plage_nom`,
        concat(st_y(`t`.`geopoint`), ', ', st_x(`t`.`geopoint`)) AS `geometry`,
        st_y(`t`.`geopoint`) AS `latitude`, 
        st_x(`t`.`geopoint`) AS `longitude`,
        `t`.`biogeographicArea` AS `aire_biogeographique`,
        `t`.`postalCode` AS `code_postal`,
        `p`.`transectId` AS `transect_id`,
        `numtransectId`.`value` AS `transect_numero`,
        `t`.`geopolyline` AS `transect_coordonnees_GPS`,
        cast(replace(replace(replace(`t`.`description`, '\\r', ' '), '\\n', ' '), '\\t', ' ') as char charset utf8mb4) AS `transect_description`,
        if(`m`.`url` is not null, concat('https://spgp-api.65mo.fr', `m`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m`.`container`, '/download/', `m`.`filename`)) AS `url_photo_transect`,
        `p`.`dateSortie` AS `date`,
        `p`.`heureDebut` AS `heure`,
        `p`.`nombreParticipants` AS `nb_participant`,
        `publicType`.`value` AS `type_public`,
        `p`.`ecole` AS `ecole_nom`,
        `p`.`longueurlaisse` AS `longueur_laisse`,
        `p`.`largeurlaisse` AS `largeur_laisse`,
        `p`.`epaisseurlaisse` AS `epaisseur_laisse`,
        `p`.`passageCribleuse` AS `passage_cribleuse`,
        `p`.`enginMotorise` AS `engins_motorises`,
        `p`.`activites` AS `activites`,
        cast(replace(replace(replace(`p`.`remarque`, '\\r', ' '), '\\n', ' '), '\\t', ' ') as char charset utf8mb4) AS `commentaires`,
        `nbQuadraId`.`value` AS `nb_quadrat`,
        `validationQ1Id`.`value` AS `Q1_validation`,
        if(`m2`.`url` is not null, concat('https://spgp-api.65mo.fr', `m2`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m2`.`container`, '/download/', `m2`.`filename`)) AS `Q1_url_photo`,
        `validationQ2Id`.`value` AS `Q2_validation`,
        if(`m3`.`url` is not null, concat('https://spgp-api.65mo.fr', `m3`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m3`.`container`, '/download/', `m3`.`filename`)) AS `Q2_url_photo`,
        `validationQ3Id`.`value` AS `Q3_validation`,
        if(`m4`.`url` is not null, concat('https://spgp-api.65mo.fr', `m4`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m4`.`container`, '/download/', `m4`.`filename`)) AS `Q3_url_photo`,
        `validationQ4Id`.`value` AS `Q4_validation`,
        if(`m5`.`url` is not null, concat('https://spgp-api.65mo.fr', `m5`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m5`.`container`, '/download/', `m5`.`filename`)) AS `Q4_url_photo`,
        `validationQ5Id`.`value` AS `Q5_validation`,
        if(`m6`.`url` is not null, concat('https://spgp-api.65mo.fr', `m6`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m6`.`container`, '/download/', `m6`.`filename`)) AS `Q5_url_photo`,
        cast(replace(replace(replace(`p`.`remarque_quadra`, '\\r', ' '), '\\n', ' '), '\\t', ' ') as char charset utf8mb4) AS `remarques_quadrats`,
        `p`.`expert` AS `expert`,
        `o`.`id` AS `observation_id`,
        `o`.`taxonId` AS `taxon_id`,
        `algue`.`value` AS `taxon`,
        `algue`.`code` AS `algue_code`,
        `abondanceQ1Id`.`value` AS `Q1_abondance`,
        `abondanceQ2Id`.`value` AS `Q2_abondance`,
        `abondanceQ3Id`.`value` AS `Q3_abondance`,
        `abondanceQ4Id`.`value` AS `Q4_abondance`,
        `abondanceQ5Id`.`value` AS `Q5_abondance`,
        '' AS `url_photo_algue_a_confirmer`,
        '' AS `commentaire_algue_a_confirmer`,
        `o`.`created` AS `date_creation_bdd`,
        `o`.`updated` AS `date_modif_bdd`
    from
        ((((((((((((((((((((((((`spgp`.`pv_participation` `p`
    join `spgp`.`users` `u` on
        (`u`.`id` = `p`.`userId`))
    left join `spgp`.`pv_structures` `s` on
        (`s`.`id` = `p`.`structureId`))
    left join `spgp`.`pv_transect` `t` on
        (`t`.`id` = `p`.`transectId`))
    left join `spgp`.`medias` `m` on
        (`m`.`id` = `t`.`imgTransectId`))
    left join `spgp`.`medias` `m2` on
        (`m2`.`id` = `p`.`imgQ1Id`))
    left join `spgp`.`medias` `m3` on
        (`m3`.`id` = `p`.`imgQ2Id`))
    left join `spgp`.`medias` `m4` on
        (`m4`.`id` = `p`.`imgQ3Id`))
    left join `spgp`.`medias` `m5` on
        (`m5`.`id` = `p`.`imgQ4Id`))
    left join `spgp`.`medias` `m6` on
        (`m6`.`id` = `p`.`imgQ5Id`))
    left join `spgp`.`pv_observation` `o` on
        (`o`.`participationId` = `p`.`id`))
    left join `spgp`.`thesaurus` `numtransectId` on
        (`numtransectId`.`id` = `t`.`numtransectId`))
    left join `spgp`.`thesaurus` `publicType` on
        (`publicType`.`id` = `p`.`publicType`))
    left join `spgp`.`thesaurus` `nbQuadraId` on
        (`nbQuadraId`.`id` = `p`.`nbQuadraId`))
    left join `spgp`.`thesaurus` `validationQ1Id` on
        (`validationQ1Id`.`id` = `p`.`validationQ1Id`))
    left join `spgp`.`thesaurus` `validationQ2Id` on
        (`validationQ2Id`.`id` = `p`.`validationQ2Id`))
    left join `spgp`.`thesaurus` `validationQ3Id` on
        (`validationQ3Id`.`id` = `p`.`validationQ3Id`))
    left join `spgp`.`thesaurus` `validationQ4Id` on
        (`validationQ4Id`.`id` = `p`.`validationQ4Id`))
    left join `spgp`.`thesaurus` `validationQ5Id` on
        (`validationQ5Id`.`id` = `p`.`validationQ5Id`))
    left join `spgp`.`pv_algue` `algue` on
        (`algue`.`id` = `o`.`taxonId`))
    left join `spgp`.`thesaurus` `abondanceQ1Id` on
        (`abondanceQ1Id`.`id` = `o`.`abondanceQ1Id`))
    left join `spgp`.`thesaurus` `abondanceQ2Id` on
        (`abondanceQ2Id`.`id` = `o`.`abondanceQ2Id`))
    left join `spgp`.`thesaurus` `abondanceQ3Id` on
        (`abondanceQ3Id`.`id` = `o`.`abondanceQ3Id`))
    left join `spgp`.`thesaurus` `abondanceQ4Id` on
        (`abondanceQ4Id`.`id` = `o`.`abondanceQ4Id`))
    left join `spgp`.`thesaurus` `abondanceQ5Id` on
        (`abondanceQ5Id`.`id` = `o`.`abondanceQ5Id`))
    where
        `o`.`taxonId` in (
        select
            `o`.`taxonId`
        from
            `spgp`.`pv_observation` `o`)
union
    select
        `p`.`id` AS `releve_id`,
        `p`.`userId` AS `user_id`,
        `u`.`username` AS `user_name`,
        `p`.`structureId` AS `structure_id`,
        `s`.`name` AS `structure_nom`,
        `p`.`structurenonref` AS `structure_nom_non_referencee`,
        `t`.`namePlage` AS `plage_nom`,
        concat(st_y(`t`.`geopoint`), ', ', st_x(`t`.`geopoint`)) AS `geometry`,
        st_y(`t`.`geopoint`) AS `latitude`, 
        st_x(`t`.`geopoint`) AS `longitude`,
        `t`.`biogeographicArea` AS `aire_biogeographique`,
        `t`.`postalCode` AS `code_postal`,
        `p`.`transectId` AS `transect_id`,
        `numtransectId`.`value` AS `transect_numero`,
        `t`.`geopolyline` AS `transect_coordonnees_GPS`,
        cast(replace(replace(replace(`t`.`description`, '\\r', ' '), '\\n', ' '), '\\t', ' ') as char charset utf8mb4) AS `transect_description`,
        if(`m`.`url` is not null, concat('https://spgp-api.65mo.fr', `m`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m`.`container`, '/download/', `m`.`filename`)) AS `url_photo_transect`,
        `p`.`dateSortie` AS `date`,
        `p`.`heureDebut` AS `heure`,
        `p`.`nombreParticipants` AS `nb_participant`,
        `publicType`.`value` AS `type_public`,
        `p`.`ecole` AS `ecole_nom`,
        `p`.`longueurlaisse` AS `longueur_laisse`,
        `p`.`largeurlaisse` AS `largeur_laisse`,
        `p`.`epaisseurlaisse` AS `epaisseur_laisse`,
        `p`.`passageCribleuse` AS `passage_cribleuse`,
        `p`.`enginMotorise` AS `engins_motorises`,
        `p`.`activites` AS `activites`,
        cast(replace(replace(replace(`p`.`remarque`, '\\r', ' '), '\\n', ' '), '\\t', ' ') as char charset utf8mb4) AS `commentaires`,
        `nbQuadraId`.`value` AS `nb_quadrat`,
        `validationQ1Id`.`value` AS `Q1_validation`,
        if(`m2`.`url` is not null, concat('https://spgp-api.65mo.fr', `m2`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m2`.`container`, '/download/', `m2`.`filename`)) AS `Q1_url_photo`,
        `validationQ2Id`.`value` AS `Q2_validation`,
        if(`m3`.`url` is not null, concat('https://spgp-api.65mo.fr', `m3`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m3`.`container`, '/download/', `m3`.`filename`)) AS `Q2_url_photo`,
        `validationQ3Id`.`value` AS `Q3_validation`,
        if(`m4`.`url` is not null, concat('https://spgp-api.65mo.fr', `m4`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m4`.`container`, '/download/', `m4`.`filename`)) AS `Q3_url_photo`,
        `validationQ4Id`.`value` AS `Q4_validation`,
        if(`m5`.`url` is not null, concat('https://spgp-api.65mo.fr', `m5`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m5`.`container`, '/download/', `m5`.`filename`)) AS `Q4_url_photo`,
        `validationQ5Id`.`value` AS `Q5_validation`,
        if(`m6`.`url` is not null, concat('https://spgp-api.65mo.fr', `m6`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m6`.`container`, '/download/', `m6`.`filename`)) AS `Q5_url_photo`,
        cast(replace(replace(replace(`p`.`remarque_quadra`, '\\r', ' '), '\\n', ' '), '\\t', ' ') as char charset utf8mb4) AS `remarques_quadrats`,
        `p`.`expert` AS `expert`,
        `i`.`id` AS `observation_id`,
        `i`.`taxonId` AS `taxon_id`,
        'algue à confirmer' AS `algue à confirmer`,
        'algue à confirmer' AS `algue à confirmer`,
        `abondanceQ1Id`.`value` AS `Q1_abondance`,
        `abondanceQ2Id`.`value` AS `Q2_abondance`,
        `abondanceQ3Id`.`value` AS `Q3_abondance`,
        `abondanceQ4Id`.`value` AS `Q4_abondance`,
        `abondanceQ5Id`.`value` AS `Q5_abondance`,
        if(`m7`.`url` is not null, concat('https://spgp-api.65mo.fr', `m7`.`url`), concat('https://spgp-api.65mo.fr/api/containers/', `m7`.`container`, '/download/', `m7`.`filename`)) AS `url_photo_algue_a_confirmer`,
        cast(replace(replace(replace(`i`.`commentaire`, '\\r', ' '), '\\n', ' '), '\\t', ' ') as char charset utf8mb4) AS `commentaire_algue_a_confirmer`,
        `i`.`created` AS `date_creation_bdd`,
        `i`.`updated` AS `date_modif_bdd`
    from
        ((((((((((((((((((((((((`spgp`.`pv_participation` `p`
    join `spgp`.`users` `u` on
        (`u`.`id` = `p`.`userId`))
    left join `spgp`.`pv_structures` `s` on
        (`s`.`id` = `p`.`structureId`))
    left join `spgp`.`pv_transect` `t` on
        (`t`.`id` = `p`.`transectId`))
    left join `spgp`.`medias` `m` on
        (`m`.`id` = `t`.`imgTransectId`))
    left join `spgp`.`medias` `m2` on
        (`m2`.`id` = `p`.`imgQ1Id`))
    left join `spgp`.`medias` `m3` on
        (`m3`.`id` = `p`.`imgQ2Id`))
    left join `spgp`.`medias` `m4` on
        (`m4`.`id` = `p`.`imgQ3Id`))
    left join `spgp`.`medias` `m5` on
        (`m5`.`id` = `p`.`imgQ4Id`))
    left join `spgp`.`medias` `m6` on
        (`m6`.`id` = `p`.`imgQ5Id`))
    join `spgp`.`pv_algue_inconnue` `i` on
        (`i`.`participationId` = `p`.`id` and `i`.`taxonId` = 77 and `i`.`isIdentify` = 0))
    left join `spgp`.`medias` `m7` on
        (`m7`.`id` = `i`.`imgAlgueId`))
    left join `spgp`.`thesaurus` `numtransectId` on
        (`numtransectId`.`id` = `t`.`numtransectId`))
    left join `spgp`.`thesaurus` `publicType` on
        (`publicType`.`id` = `p`.`publicType`))
    left join `spgp`.`thesaurus` `nbQuadraId` on
        (`nbQuadraId`.`id` = `p`.`nbQuadraId`))
    left join `spgp`.`thesaurus` `validationQ1Id` on
        (`validationQ1Id`.`id` = `p`.`validationQ1Id`))
    left join `spgp`.`thesaurus` `validationQ2Id` on
        (`validationQ2Id`.`id` = `p`.`validationQ2Id`))
    left join `spgp`.`thesaurus` `validationQ3Id` on
        (`validationQ3Id`.`id` = `p`.`validationQ3Id`))
    left join `spgp`.`thesaurus` `validationQ4Id` on
        (`validationQ4Id`.`id` = `p`.`validationQ4Id`))
    left join `spgp`.`thesaurus` `validationQ5Id` on
        (`validationQ5Id`.`id` = `p`.`validationQ5Id`))
    left join `spgp`.`thesaurus` `abondanceQ1Id` on
        (`abondanceQ1Id`.`id` = `i`.`abondanceQ1Id`))
    left join `spgp`.`thesaurus` `abondanceQ2Id` on
        (`abondanceQ2Id`.`id` = `i`.`abondanceQ2Id`))
    left join `spgp`.`thesaurus` `abondanceQ3Id` on
        (`abondanceQ3Id`.`id` = `i`.`abondanceQ3Id`))
    left join `spgp`.`thesaurus` `abondanceQ4Id` on
        (`abondanceQ4Id`.`id` = `i`.`abondanceQ4Id`))
    left join `spgp`.`thesaurus` `abondanceQ5Id` on
        (`abondanceQ5Id`.`id` = `i`.`abondanceQ5Id`))
    where
        `i`.`taxonId` in (
        select
            `i`.`taxonId`
        from
            `spgp`.`pv_algue_inconnue` `i`)) `st1`
order by
    `st1`.`releve_id`;