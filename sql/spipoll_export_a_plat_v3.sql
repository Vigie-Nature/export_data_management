-- spgp_vues.spipoll_export_a_plat_v3 source
select
    `p`.`id` AS `session_id`,
    cast(replace(replace(replace(json_value(`p`.`data`, '$.nom'), '\r', ' '), '\n', ' '), '	', ' ') as char charset utf8mb3) AS `session_name`,
    json_value(`p`.`data`, '$.protocoleLong') AS `protocole_long`,
    `p`.`user_id` AS `user_id`,
    `u`.`username` AS `user_pseudo`,
    json_value(`t1`.`data`, '$.sc_name') AS `plante_sc`,
    json_value(`t1`.`data`, '$.fr_name') AS `plante_fr`,
    `t1`.`title` AS `plante_long_name`,
    cast(replace(replace(replace(json_value(`p`.`data`, '$.plantePrecision'), '\r', ' '), '\n', ' '), '	', ' ') as char charset utf8mb3) AS `plante_precision`,
    json_value(`p`.`data`, '$.planteJeNeSaisPas') AS `plante_ne_sais_pas`,
    json_value(`p`.`data`, '$.plantePasDansLaListe') AS `plante_pas_dans_liste`,
    `t2`.`title` AS `plante_caractere`,
    concat('https://spgp-api-pre.65mo.fr', `mediaFleur`.`name`) AS `photo_fleur_A_CORRIGER`,
    concat('https://spgp-api-pre.65mo.fr', `mediaPlante`.`name`) AS `photo_plante_A_CORRIGER`,
    concat('https://spgp-api-pre.65mo.fr', `mediaFeuille`.`name`) AS `photo_feuille_A_CORRIGER`,
    concat('https://spgp-api-pre.65mo.fr', `mediaPaysage`.`name`) AS `photo_lieu_A_CORRIGER`,
    st_y(`oa`.`geodata`) AS `latitude`,
    st_x(`oa`.`geodata`) AS `longitude`,
    `oa`.`postcode` AS `zipcode`,
    replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(json_extract(`p`.`data`, '$.habitats'), '"', ''), '[', ''), ']', ''), 'spipoll.habitats.bord-de-l-eau', 'Bord de l\'eau'), 'spipoll.habitats.bord-de-route', 'Bord de route'), 'spipoll.habitats.foret', 'Forêt'), 'spipoll.habitats.grande-s-culture-s', 'Grande(s) culture(s)'), 'spipoll.habitats.jardin-prive', 'Jardin privé'), 'spipoll.habitats.littoral', 'Littoral'), 'spipoll.habitats.parc-ou-jardin-public', 'Parc ou jardin public'), 'spipoll.habitats.peri-urbain', 'Péri-urbain'), 'spipoll.habitats.prairie', 'Prairie'), 'spipoll.habitats.rochers', 'Rochers'), 'spipoll.habitats.rural', 'Rural'), 'spipoll.habitats.urbain', 'Urbain') AS `habitats`,
    json_value(`p`.`data`, '$.distanceRuche') AS `distance_ruche`,
    `t3`.`title` AS `grande_culture`,
    json_value(`p`.`data`, '$.date') AS `session_date`,
    substring_index(json_value(`p`.`data`, '$.heureDebut'), ':', 2) AS `session_starting_time`,
    substring_index(json_value(`p`.`data`, '$.heureFin'), ':', 2) AS `session_ending_time`,
    `t4`.`title` AS `nebulosite`,
    `t5`.`title` AS `temperature`,
    `t6`.`title` AS `vent`,
    json_value(`p`.`data`, '$.fleurOmbre') AS `fleur_ombre`,
    json_value(`t7`.`data`, '$.sc_name') AS `insecte_sc`,
    json_value(`t7`.`data`, '$.fr_name') AS `insecte_fr`,
    `t7`.`title` AS `taxon`,
    json_value(`t7`.`data`, '$.rang') AS `insecte_rang`,
    json_value(`t7`.`data`, '$.ordre') AS `insecte_ordre`,
    cast(replace(replace(replace(json_value(`o`.`data`, '$.denominationPlusPrecise'), '\r', ' '), '\n', ' '), '	', ' ') as char charset utf8mb3) AS `insecte_denominationPlusPrecise`,
    json_value(`o`.`data`, '$.denominationPlusPreciseCdNomTaxref') AS `denominationPlusPreciseCdNomTaxref`,
    `t8`.`title` AS `taxon_count`,
    cast(replace(replace(replace(json_value(`o`.`data`, '$.commentaire'), '\r', ' '), '\n', ' '), '	', ' ') as char charset utf8mb3) AS `insecte_commentaire`,
    concat('https://spgp-api-pre.65mo.fr', `mediaTaxon1`.`name`) AS `insecte_photo_1_A_CORRIGER`,
    concat('https://spgp-api-pre.65mo.fr', `mediaTaxon2`.`name`) AS `insecte_photo_2_A_CORRIGER`,
    json_value(`o`.`data`, '$.taxonVuSurFleur') AS `insecte_vu_sur_fleur`,
    count(distinct `c`.`id`) AS `nb_validation`,
    count(distinct `c1`.`id`) AS `nb_suggestion`,
    `p`.`created_at` AS `creation_date`,
    `p`.`updated_at` AS `update_date`
from
    (((((((((((((((((((((((((`spgp_v3`.`participations` `p`
left join `spgp_v3`.`users` `u` on
    (`u`.`id` = `p`.`user_id`))
left join `spgp_v3`.`thesaurus_values` `t1` on
    (`t1`.`value` = json_value(`p`.`data`, '$.plante')))
left join `spgp_v3`.`thesaurus_values` `t2` on
    (`t2`.`value` = json_value(`p`.`data`, '$.caracterePlante')))
left join `spgp_v3`.`participations_medias` `pmf` on
    (`pmf`.`participation_id` = `p`.`id` and `pmf`.`relation` = 'photoFleur'))
left join `spgp_v3`.`medias` `mediaFleur` on
    (`mediaFleur`.`id` = `pmf`.`media_id`))
left join `spgp_v3`.`participations_medias` `pmp` on
    (`pmp`.`participation_id` = `p`.`id` and `pmp`.`relation` = 'photoPlante'))
left join `spgp_v3`.`medias` `mediaPlante` on
    (`mediaPlante`.`id` = `pmp`.`media_id`))
left join `spgp_v3`.`participations_medias` `pmfe` on
    (`pmfe`.`participation_id` = `p`.`id` and `pmfe`.`relation` = 'photoFeuille'))
left join `spgp_v3`.`medias` `mediaFeuille` on
    (`mediaFeuille`.`id` = `pmfe`.`media_id`))
left join `spgp_v3`.`participations_medias` `pmpa` on
    (`pmpa`.`participation_id` = `p`.`id` and `pmpa`.`relation` = 'photoPaysage'))
left join `spgp_v3`.`medias` `mediaPaysage` on
    (`mediaPaysage`.`id` = `pmpa`.`media_id`))
left join `spgp_v3`.`observation_areas` `oa` on
    (`oa`.`id` = `p`.`observation_area_id`))
left join `spgp_v3`.`thesaurus_values` `t3` on
    (`t3`.`value` = json_value(`p`.`data`, '$.presenceGrandeCulture')))
left join `spgp_v3`.`thesaurus_values` `t4` on
    (`t4`.`value` = json_value(`p`.`data`, '$.nebulosite')))
left join `spgp_v3`.`thesaurus_values` `t5` on
    (`t5`.`value` = json_value(`p`.`data`, '$.temperature')))
left join `spgp_v3`.`thesaurus_values` `t6` on
    (`t6`.`value` = json_value(`p`.`data`, '$.vent')))
left join `spgp_v3`.`observations` `o` on
    (`o`.`participation_id` = `p`.`id`))
left join `spgp_v3`.`thesaurus_values` `t7` on
    (`t7`.`value` = json_value(`o`.`data`, '$.taxon')))
left join `spgp_v3`.`thesaurus_values` `t8` on
    (`t8`.`value` = json_value(`o`.`data`, '$.nombre')))
left join `spgp_v3`.`observations_medias` `omt1` on
    (`omt1`.`observation_id` = `o`.`id` and `omt1`.`relation` = 'photoTaxon1'))
left join `spgp_v3`.`medias` `mediaTaxon1` on
    (`mediaTaxon1`.`id` = `omt1`.`media_id`))
left join `spgp_v3`.`observations_medias` `omt2` on
    (`omt2`.`observation_id` = `o`.`id` and `omt2`.`relation` = 'photoTaxon2'))
left join `spgp_v3`.`medias` `mediaTaxon2` on
    (`mediaTaxon2`.`id` = `omt2`.`media_id`))
left join `spgp_v3`.`comments` `c` on
    (`c`.`resource_id` = `o`.`id` and `c`.`model` = 'vote' and `c`.`resource_type` = 'observation'))
left join `spgp_v3`.`comments` `c1` on
    (`c1`.`resource_id` = `o`.`id` and `c1`.`model` = 'suggestion' and `c1`.`resource_type` = 'observation'))
where
    `p`.`observatory_id` = 3
    and `p`.`deleted_at` is null
    and `p`.`status` <> 'draft'
group by
    `p`.`id`,
    `o`.`id`;