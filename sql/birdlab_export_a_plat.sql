select
    distinct `p`.`id` AS `session_id`,
    `p`.`guid` AS `user_id`,
    `u`.`name` AS `user_nom`,
    `level`.`title` AS `user_level`,
    `p`.`date` AS `session_date`,
    replace(replace(json_extract(`p`.`manger`, '$.localisation'), '[', ''), ']', '') AS `mangeoires_coordonnees_gps`,
    `p`.`postcode` AS `mangeoires_code_postal`,
    json_value(`p`.`manger`, '$.name') AS `mangeoires_nom`,
    `manger_type`.`title` AS `mangeoires_type`,
    json_value(`p`.`manger`, '$.dist') AS `mangeoires_distance`,
    if(json_value(`p`.`manger`, '$.photo') = '', json_value(`p`.`manger`, '$.photo'), concat('https://api.birdlab.fr/photos/', json_value(`p`.`manger`, '$.photo'), '.jpg')) AS `mangeoires_photo`,
    `manger_context1`.`title` AS `environnement`,
    json_value(`p`.`manger`, '$.context2[0]') AS `presence_arbres`,
    json_value(`p`.`manger`, '$.context2[1]') AS `presence_haies`,
    json_value(`p`.`manger`, '$.context2[2]') AS `presence_animaux`,
    json_value(`p`.`manger`, '$.context2[3]') AS `presence_bruit`,
    `p`.`bruit` AS `presence_bruit2`,
    `weather`.`title` AS `meteo`,
    `temp`.`title` AS `temperature`,
    `p`.`temp` AS `temperature2`,
    cast(replace(replace(replace(`p`.`comment`, '\\r', ' '), '\\n', ' '), '\\t', ' ') as char charset utf8mb3) AS `commentaire`,
    `e`.`arrival_order` AS `numero_individu`,
    `birds`.`title` AS `taxon`,
    `action`.`title` AS `action`,
    `e`.`moment` AS `seconde`
from
    (((((((((`birdlab`.`birdlab_protocols` `p`
left join `birdlab`.`birdlab_users` `u` on
    (`u`.`guid` = `p`.`guid`))
left join `birdlab`.`birdlab_thesaurus_level` `level` on
    (`level`.`id` = `p`.`level`))
left join `birdlab`.`birdlab_thesaurus_manger_type` `manger_type` on
    (`manger_type`.`id` = json_value(`p`.`manger`, '$.type')))
left join `birdlab`.`birdlab_thesaurus_manger_context1` `manger_context1` on
    (`manger_context1`.`id` = json_value(`p`.`manger`, '$.context1')))
left join `birdlab`.`birdlab_thesaurus_weather` `weather` on
    (`weather`.`id` = `p`.`weather`))
left join `birdlab`.`birdlab_thesaurus_temp` `temp` on
    (`temp`.`id` = `p`.`temp`))
left join `birdlab`.`birdlab_events` `e` on
    (`e`.`protocol_id` = `p`.`id`))
left join `birdlab`.`birdlab_thesaurus_birds` `birds` on
    (`birds`.`id` = `e`.`bird`))
left join `birdlab`.`birdlab_thesaurus_action` `action` on
    (`action`.`id` = `e`.`action`))
where
    `e`.`moment` >= 0;