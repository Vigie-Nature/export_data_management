SELECT
  `participations`.`id` AS `session_id`,
  CAST(`participations`.`participation_date` AS DATE) AS `session_date`,
  `participations`.`user_id` AS `user_id`,
  st_x(`parcelles`.`localisation`) AS `longitude`,
  st_y(`parcelles`.`localisation`) AS `latitude`,
  IFNULL(CAST(`p1`.`epiges_adultes` AS INT), 0) +
  IFNULL(CAST(`p2`.`epiges_adultes` AS INT), 0) +
  IFNULL(CAST(`p3`.`epiges_adultes` AS INT), 0)
    AS `taxon_epiges_adultes`,
  IFNULL(CAST(`p1`.`epiges_juveniles` AS INT), 0) +
  IFNULL(CAST(`p2`.`epiges_juveniles` AS INT), 0) +
  IFNULL(CAST(`p3`.`epiges_juveniles` AS INT), 0)
    AS `taxon_epiges_juveniles`,
  IFNULL(CAST(`p1`.`endoges_adultes` AS INT), 0) +
  IFNULL(CAST(`p2`.`endoges_adultes` AS INT), 0) +
  IFNULL(CAST(`p3`.`endoges_adultes` AS INT), 0)
    AS `taxon_endoges_adultes`,
  IFNULL(CAST(`p1`.`endoges_juveniles` AS INT), 0) +
  IFNULL(CAST(`p2`.`endoges_juveniles` AS INT), 0) +
  IFNULL(CAST(`p3`.`endoges_juveniles` AS INT), 0)
    AS `taxon_endoges_juveniles`,
  IFNULL(CAST(`p1`.`aneciques_tete_noire_adultes` AS INT), 0) +
  IFNULL(CAST(`p2`.`aneciques_tete_noire_adultes` AS INT), 0) +
  IFNULL(CAST(`p3`.`aneciques_tete_noire_adultes` AS INT), 0)
    AS `taxon_aneciques_tete_noire_adultes`,
  IFNULL(CAST(`p1`.`aneciques_tete_noire_juveniles` AS INT), 0) +
  IFNULL(CAST(`p2`.`aneciques_tete_noire_juveniles` AS INT), 0) +
  IFNULL(CAST(`p3`.`aneciques_tete_noire_juveniles` AS INT), 0)
    AS `taxon_aneciques_tete_noire_juveniles`,
  IFNULL(CAST(`p1`.`aneciques_tete_rouge_adultes` AS INT), 0) +
  IFNULL(CAST(`p2`.`aneciques_tete_rouge_adultes` AS INT), 0) +
  IFNULL(CAST(`p3`.`aneciques_tete_rouge_adultes` AS INT), 0)
    AS `taxon_aneciques_tete_rouge_adultes`,
  IFNULL(CAST(`p1`.`aneciques_tete_rouge_juveniles` AS INT), 0) +
  IFNULL(CAST(`p2`.`aneciques_tete_rouge_juveniles` AS INT), 0) +
  IFNULL(CAST(`p3`.`aneciques_tete_rouge_juveniles` AS INT), 0)
    AS `taxon_aneciques_tete_rouge_juveniles`,
  IFNULL(CAST(`p1`.`autres_non_determines_adultes` AS INT), 0) +
  IFNULL(CAST(`p2`.`autres_non_determines_adultes` AS INT), 0) +
  IFNULL(CAST(`p3`.`autres_non_determines_adultes` AS INT), 0)
    AS `taxon_autres_non_determines_adultes`,
  IFNULL(CAST(`p1`.`autres_non_determines_juveniles` AS INT), 0) +
  IFNULL(CAST(`p2`.`autres_non_determines_juveniles` AS INT), 0) +
  IFNULL(CAST(`p3`.`autres_non_determines_juveniles` AS INT), 0)
    AS `taxon_autres_non_determines_juveniles`
FROM 
  `participations`
  INNER JOIN `parcelles`
    ON `parcelles`.`id` = `participations`.`parcelle_id`,
  -- Aplatir les données des trois placettes
  json_table(
    `participations`.`data`,
    '$.placette1' COLUMNS (
      `epiges_adultes`                  VARCHAR(10) PATH "$.epiges_oab_vdt_taxons_thesaurus.adultes",
      `epiges_juveniles`                VARCHAR(10) PATH "$.epiges_oab_vdt_taxons_thesaurus.juveniles",
      `endoges_adultes`                 VARCHAR(10) PATH "$.endoges_oab_vdt_taxons_thesaurus.adultes",
      `endoges_juveniles`               VARCHAR(10) PATH "$.endoges_oab_vdt_taxons_thesaurus.juveniles",
      `aneciques_tete_noire_adultes`    VARCHAR(10) PATH "$.aneciques_tete_noire_oab_vdt_taxons_thesaurus.adultes",
      `aneciques_tete_noire_juveniles`  VARCHAR(10) PATH "$.aneciques_tete_noire_oab_vdt_taxons_thesaurus.juveniles",
      `aneciques_tete_rouge_adultes`    VARCHAR(10) PATH "$.aneciques_tete_rouge_oab_vdt_taxons_thesaurus.adultes",
      `aneciques_tete_rouge_juveniles`  VARCHAR(10) PATH "$.aneciques_tete_rouge_oab_vdt_taxons_thesaurus.juveniles",
      `autres_non_determines_adultes`   VARCHAR(10) PATH "$.autres_non_detremines_oab_vdt_taxons_thesaurus.adultes",
      `autres_non_determines_juveniles` VARCHAR(10) PATH "$.autres_non_detremines_oab_vdt_taxons_thesaurus.juveniles"
    )
  ) AS `p1`,
  json_table(
    `participations`.`data`,
      '$.placette2' COLUMNS (
      `epiges_adultes`                  VARCHAR(10) PATH "$.epiges_oab_vdt_taxons_thesaurus.adultes",
      `epiges_juveniles`                VARCHAR(10) PATH "$.epiges_oab_vdt_taxons_thesaurus.juveniles",
      `endoges_adultes`                 VARCHAR(10) PATH "$.endoges_oab_vdt_taxons_thesaurus.adultes",
      `endoges_juveniles`               VARCHAR(10) PATH "$.endoges_oab_vdt_taxons_thesaurus.juveniles",
      `aneciques_tete_noire_adultes`    VARCHAR(10) PATH "$.aneciques_tete_noire_oab_vdt_taxons_thesaurus.adultes",
      `aneciques_tete_noire_juveniles`  VARCHAR(10) PATH "$.aneciques_tete_noire_oab_vdt_taxons_thesaurus.juveniles",
      `aneciques_tete_rouge_adultes`    VARCHAR(10) PATH "$.aneciques_tete_rouge_oab_vdt_taxons_thesaurus.adultes",
      `aneciques_tete_rouge_juveniles`  VARCHAR(10) PATH "$.aneciques_tete_rouge_oab_vdt_taxons_thesaurus.juveniles",
      `autres_non_determines_adultes`   VARCHAR(10) PATH "$.autres_non_detremines_oab_vdt_taxons_thesaurus.adultes",
      `autres_non_determines_juveniles` VARCHAR(10) PATH "$.autres_non_detremines_oab_vdt_taxons_thesaurus.juveniles"
    )
  ) AS `p2`,
  json_table(
    `participations`.`data`,
      '$.placette3' COLUMNS (
      `epiges_adultes`                  VARCHAR(10) PATH "$.epiges_oab_vdt_taxons_thesaurus.adultes",
      `epiges_juveniles`                VARCHAR(10) PATH "$.epiges_oab_vdt_taxons_thesaurus.juveniles",
      `endoges_adultes`                 VARCHAR(10) PATH "$.endoges_oab_vdt_taxons_thesaurus.adultes",
      `endoges_juveniles`               VARCHAR(10) PATH "$.endoges_oab_vdt_taxons_thesaurus.juveniles",
      `aneciques_tete_noire_adultes`    VARCHAR(10) PATH "$.aneciques_tete_noire_oab_vdt_taxons_thesaurus.adultes",
      `aneciques_tete_noire_juveniles`  VARCHAR(10) PATH "$.aneciques_tete_noire_oab_vdt_taxons_thesaurus.juveniles",
      `aneciques_tete_rouge_adultes`    VARCHAR(10) PATH "$.aneciques_tete_rouge_oab_vdt_taxons_thesaurus.adultes",
      `aneciques_tete_rouge_juveniles`  VARCHAR(10) PATH "$.aneciques_tete_rouge_oab_vdt_taxons_thesaurus.juveniles",
      `autres_non_determines_adultes`   VARCHAR(10) PATH "$.autres_non_detremines_oab_vdt_taxons_thesaurus.adultes",
      `autres_non_determines_juveniles` VARCHAR(10) PATH "$.autres_non_detremines_oab_vdt_taxons_thesaurus.juveniles"
    )
  ) AS `p3`
WHERE
  `participations`.`protocol_id` = 8
  AND `participations`.`deleted_at` IS NULL
