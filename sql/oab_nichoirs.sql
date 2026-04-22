SELECT
  `participations`.`id` AS `session_id`,
  CAST(`participations`.`participation_date` AS DATE) AS `session_date`,
  `participations`.`user_id` AS `user_id`,
  st_x(`parcelles`.`localisation`) AS `longitude`,
  st_y(`parcelles`.`localisation`) AS `latitude`,
  -- Somme des abondances des deux nichoirs
  IFNULL(CAST(`n1`.`abeilles`            AS INT), 0) +
  IFNULL(CAST(`n2`.`abeilles`            AS INT), 0)
    AS `taxon_abeilles`,
  IFNULL(CAST(`n1`.`coton`               AS INT), 0) +
  IFNULL(CAST(`n2`.`coton`               AS INT), 0)
    AS `taxon_coton`,
  IFNULL(CAST(`n1`.`resine`              AS INT), 0) +
  IFNULL(CAST(`n2`.`resine`              AS INT), 0)
    AS `taxon_resine`,
  IFNULL(CAST(`n1`.`petales`             AS INT), 0) +
  IFNULL(CAST(`n2`.`petales`             AS INT), 0)
    AS `taxon_petales`,
  IFNULL(CAST(`n1`.`terre_boue`          AS INT), 0) +
  IFNULL(CAST(`n2`.`terre_boue`          AS INT), 0)
    AS `taxon_terre_boue`,
  IFNULL(CAST(`n1`.`herbes_tiges`        AS INT), 0) +
  IFNULL(CAST(`n2`.`herbes_tiges`        AS INT), 0)
    AS `taxon_herbes_tiges`,
  IFNULL(CAST(`n1`.`feuilles_machees`    AS INT), 0) +
  IFNULL(CAST(`n2`.`feuilles_machees`    AS INT), 0)
    AS `taxon_feuilles_machees`,
  IFNULL(CAST(`n1`.`morceaux_de_feuille` AS INT), 0) +
  IFNULL(CAST(`n2`.`morceaux_de_feuille` AS INT), 0)
    AS `taxon_morceaux_de_feuille`
FROM 
  `participations`
  INNER JOIN `parcelles`
    ON `parcelles`.`id` = `participations`.`parcelle_id`,
  -- Aplatir les données du premier nichoir
  json_table(
    `participations`.`data`,
    '$.nichoir1' COLUMNS (
      `abeilles`            VARCHAR(10) PATH '$.nombreAbeilles',
      `coton`               VARCHAR(10) PATH '$.coton_oab_nichoirs_nature_loge_thesaurus',
      `resine`              VARCHAR(10) PATH '$.resine_oab_nichoirs_nature_loge_thesaurus',
      `petales`             VARCHAR(10) PATH '$.petales_oab_nichoirs_nature_loge_thesaurus',
      `terre_boue`          VARCHAR(10) PATH '$.terre_boue_oab_nichoirs_nature_loge_thesaurus',
      `herbes_tiges`        VARCHAR(10) PATH '$.herbes_tiges_oab_nichoirs_nature_loge_thesaurus',
      `feuilles_machees`    VARCHAR(10) PATH '$.feuilles_machees_oab_nichoirs_nature_loge_thesaurus',
      `morceaux_de_feuille` VARCHAR(10) PATH '$.morceaux_de_feuilles_oab_nichoirs_nature_loge_thesaurus'
    )
  ) AS `n1`,
  -- Aplatir les données du deuxième nichoir
  json_table(
    `participations`.`data`,
    '$.nichoir2' COLUMNS (
      `abeilles`            VARCHAR(10) PATH '$.nombreAbeilles',
      `coton`               VARCHAR(10) PATH '$.coton_oab_nichoirs_nature_loge_thesaurus',
      `resine`              VARCHAR(10) PATH '$.resine_oab_nichoirs_nature_loge_thesaurus',
      `petales`             VARCHAR(10) PATH '$.petales_oab_nichoirs_nature_loge_thesaurus',
      `terre_boue`          VARCHAR(10) PATH '$.terre_boue_oab_nichoirs_nature_loge_thesaurus',
      `herbes_tiges`        VARCHAR(10) PATH '$.herbes_tiges_oab_nichoirs_nature_loge_thesaurus',
      `feuilles_machees`    VARCHAR(10) PATH '$.feuilles_machees_oab_nichoirs_nature_loge_thesaurus',
      `morceaux_de_feuille` VARCHAR(10) PATH '$.morceaux_de_feuilles_oab_nichoirs_nature_loge_thesaurus'
    )
  ) AS `n2`
WHERE
  `participations`.`protocol_id` = 6
  AND `participations`.`deleted_at` IS NULL
