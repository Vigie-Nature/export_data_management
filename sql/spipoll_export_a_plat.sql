select
    `o`.`id` AS `observation_id`,
    `p`.`id` AS `session_id`,
    `p`.`name` AS `session_name`,
    `p`.`protocoleLong` AS `protocole_long`,
    `p`.`userId` AS `user_id`,
    `u`.`username` AS `user_pseudo`,
    `u`.`token` AS `user_token`,
    cast(replace(replace(replace(`p`.`commentaire`, '\\r', ' '), '\\n', ' '), '\\t', ' ') as char charset utf8mb3) AS `commentaire`,
    `plante`.`sc_name` AS `plante_sc`,
    `plante`.`fr_name` AS `plante_fr`,
    `plante`.`long_name` AS `plante_long_name`,
    `p`.`plantePrecision` AS `plante_precision`,
    `p`.`planteInconnue` AS `plante_inconnue`,
    `caractere_plante`.`value` AS `plante_caractere`,
    if(`mediaFleur`.`url` is not null,
    concat('https://spgp-api.65mo.fr', `mediaFleur`.`url`),
    concat('https://spgp-api.65mo.fr/api/containers/', `mediaFleur`.`container`, '/download/', `mediaFleur`.`filename`)) AS `photo_fleur`,
    if(`mediaPlante`.`url` is not null,
    concat('https://spgp-api.65mo.fr', `mediaPlante`.`url`),
    concat('https://spgp-api.65mo.fr/api/containers/', `mediaPlante`.`container`, '/download/', `mediaPlante`.`filename`)) AS `photo_plante`,
    if(`mediaFeuille`.`url` is not null,
    concat('https://spgp-api.65mo.fr', `mediaFeuille`.`url`),
    concat('https://spgp-api.65mo.fr/api/containers/', `mediaFeuille`.`container`, '/download/', `mediaFeuille`.`filename`)) AS `photo_feuille`,
    if(`mediaStation`.`url` is not null,
    concat('https://spgp-api.65mo.fr', `mediaStation`.`url`),
    concat('https://spgp-api.65mo.fr/api/containers/', `mediaStation`.`container`, '/download/', `mediaStation`.`filename`)) AS `photo_lieu`,
    st_y(`p`.`geopoint`) AS `latitude`,
    st_x(`p`.`geopoint`) AS `longitude`,
    `p`.`postalCode` AS `code_postal`,
    `hab`.`habitat` AS `habitat`,
    `p`.`distanceRuche` AS `distance_ruche`,
    `grande_culture`.`value` AS `grande_culture`,
    `p`.`date` AS `session_date`,
    `p`.`heureDebut` AS `session_starting_time`,
    `p`.`heureFin` AS `session_ending_time`,
    `nebulosite`.`value` AS `nebulosite`,
    `temperature`.`value` AS `temperature`,
    `vent`.`value` AS `vent`,
    `p`.`fleurOmbre` AS `fleur_ombre`,
    `taxon`.`sc_name` AS `insecte_sc`,
    `taxon`.`fr_name` AS `insecte_fr`,
    `taxon`.`long_name` AS `taxon`,
    `taxon`.`RANG` AS `insecte_rang`,
    `taxon`.`Ordre` AS `insecte_ordre`,
    `o`.`denominationPlusPrecise` AS `insecte_denominationPlusPrecise`,
    `o`.`denominationPlusPreciseCdNomTaxref` AS `insecte_CdNomtaxref`,
    `abondance`.`value` AS `taxon_count`,
    cast(replace(replace(replace(`o`.`commentaire`, '\\r', ' '), '\\n', ' '), '\\t', ' ') as char charset utf8mb3) AS `insecte_commentaire`,
    if(`mediaTaxon1`.`url` is not null,
    concat('https://spgp-api.65mo.fr', `mediaTaxon1`.`url`),
    concat('https://spgp-api.65mo.fr/api/containers/', `mediaTaxon1`.`container`, '/download/', `mediaTaxon1`.`filename`)) AS `insecte_photo_1`,
    if(`mediaTaxon2`.`url` is not null,
    concat('https://spgp-api.65mo.fr', `mediaTaxon2`.`url`),
    concat('https://spgp-api.65mo.fr/api/containers/', `mediaTaxon2`.`container`, '/download/', `mediaTaxon2`.`filename`)) AS `insecte_photo_2`,
    `o`.`taxonVuSurFleur` AS `insecte_vu_sur_fleur`,
    `o`.`nbValidation` AS `nb_validation`,
    `o`.`nbSuggestIdent` AS `nb_suggestion`,
    `p`.`created` AS `date_creation_bdd`,
    `p`.`updated` AS `date_update_bdd`
from
    (((((((((((((((((`spgp`.`spipoll_participation` `p`
left join `spgp`.`users` `u` on
    (`u`.`id` = `p`.`userId`))
left join `spgp`.`spipoll_plante` `plante` on
    (`plante`.`id` = `p`.`planteId`))
left join `spgp`.`thesaurus` `caractere_plante` on
    (`caractere_plante`.`id` = `p`.`caractereFleurId`))
left join `spgp`.`medias` `mediaFleur` on
    (`mediaFleur`.`id` = `p`.`imgFleurId`))
left join `spgp`.`medias` `mediaPlante` on
    (`mediaPlante`.`id` = `p`.`imgPlanteId`))
left join `spgp`.`medias` `mediaFeuille` on
    (`mediaFeuille`.`id` = `p`.`imgFeuilleId`))
left join `spgp`.`medias` `mediaStation` on
    (`mediaStation`.`id` = `p`.`imgStationId`))
left join (
    select
        `spgp`.`spipoll_participation_habitat`.`participationId` AS `participationId`,
        group_concat(`spgp`.`thesaurus`.`value` separator ',') AS `habitat`
    from
        (`spgp`.`spipoll_participation_habitat`
    join `spgp`.`thesaurus` on
        (`spgp`.`spipoll_participation_habitat`.`habitatId` = `spgp`.`thesaurus`.`id`))
    group by
        `spgp`.`spipoll_participation_habitat`.`participationId`) `hab` on
    (`p`.`id` = `hab`.`participationId`))
left join `spgp`.`thesaurus` `grande_culture` on
    (`grande_culture`.`id` = `p`.`grandeCultureId`))
left join `spgp`.`thesaurus` `nebulosite` on
    (`nebulosite`.`id` = `p`.`nebulositeId`))
left join `spgp`.`thesaurus` `temperature` on
    (`temperature`.`id` = `p`.`temperatureId`))
left join `spgp`.`thesaurus` `vent` on
    (`vent`.`id` = `p`.`ventId`))
left join `spgp`.`spipoll_observation` `o` on
    (`o`.`participationId` = `p`.`id`))
left join `spgp`.`spipoll_insecte` `taxon` on
    (`taxon`.`id` = `o`.`taxonId`))
left join `spgp`.`thesaurus` `abondance` on
    (`abondance`.`id` = `o`.`nbTaxonId`))
left join `spgp`.`medias` `mediaTaxon1` on
    (`o`.`imgTaxon1Id` = `mediaTaxon1`.`id`))
left join `spgp`.`medias` `mediaTaxon2` on
    (`o`.`imgTaxon2Id` = `mediaTaxon2`.`id`))
where
    `p`.`isDeleted` = 0;