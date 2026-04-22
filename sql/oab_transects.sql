SELECT
  `participations`.`id` AS `session_id`,
  CAST(`participations`.`participation_date` AS DATE) AS `session_date`,
  `participations`.`user_id` AS `user_id`,
  st_x(`parcelles`.`localisation`) AS `longitude`,
  st_y(`parcelles`.`localisation`) AS `latitude`,
  `t`.*
FROM 
  `participations`
  INNER JOIN `parcelles`
    ON `parcelles`.`id` = `participations`.`parcelle_id`,
  -- Aplatir les données du transect
  json_table(
    `participations`.`data`,
    '$' COLUMNS (
      `taxon_gaze`                 VARCHAR(10) PATH "$.transect.gaze_oab_papillons_taxons_thesaurus",
      `taxon_souci`                VARCHAR(10) PATH "$.transect.souci_oab_papillons_taxons_thesaurus",
      `taxon_citron`               VARCHAR(10) PATH "$.transect.citron_oab_papillons_taxons_thesaurus",
      `taxon_flambe`               VARCHAR(10) PATH "$.transect.flambe_oab_papillons_taxons_thesaurus",
      `taxon_myrtil`               VARCHAR(10) PATH "$.transect.myrtil_oab_papillons_taxons_thesaurus",
      `taxon_tircis`               VARCHAR(10) PATH "$.transect.tircis_oab_papillons_taxons_thesaurus",
      `taxon_aurores`              VARCHAR(10) PATH "$.transect.aurores_oab_papillons_taxons_thesaurus",
      `taxon_cuivres`              VARCHAR(10) PATH "$.transect.cuivres_oab_papillons_taxons_thesaurus",
      `taxon_machaon`              VARCHAR(10) PATH "$.transect.machaon_oab_papillons_taxons_thesaurus",
      `taxon_megeres`              VARCHAR(10) PATH "$.transect.megeres_oab_papillons_taxons_thesaurus",
      `taxon_procris`              VARCHAR(10) PATH "$.transect.procris_oab_papillons_taxons_thesaurus",
      `taxon_vulcain`              VARCHAR(10) PATH "$.transect.vulcain_oab_papillons_taxons_thesaurus",
      `taxon_amaryllis`            VARCHAR(10) PATH "$.transect.amaryllis_oab_papillons_taxons_thesaurus",
      `taxon_belle_dame`           VARCHAR(10) PATH "$.transect.belle_dame_oab_papillons_taxons_thesaurus",
      `taxon_demi_deuil`           VARCHAR(10) PATH "$.transect.demi_deuil_oab_papillons_taxons_thesaurus",
      `taxon_paon_du_jour`         VARCHAR(10) PATH "$.transect.paon_du_jour_oab_papillons_taxons_thesaurus",
      `taxon_lycenes_bleus`        VARCHAR(10) PATH "$.transect.lycenes_bleus_oab_papillons_taxons_thesaurus",
      `taxon_non_determine`        VARCHAR(10) PATH "$.transect.non_determine_oab_papillons_taxons_thesaurus",
      `taxon_petite_tortue`        VARCHAR(10) PATH "$.transect.petite_tortue_oab_papillons_taxons_thesaurus",
      `taxon_tabac_d_espagne`      VARCHAR(10) PATH "$.transect.tabac_d_espagne_oab_papillons_taxons_thesaurus",
      `taxon_robert_le_diable`     VARCHAR(10) PATH "$.transect.robert_le_diable_oab_papillons_taxons_thesaurus",
      `taxon_pierides_blanches`    VARCHAR(10) PATH "$.transect.pierides_blanches_oab_papillons_taxons_thesaurus",
      `taxon_hesperides_orangees`  VARCHAR(10) PATH "$.transect.hesperides_orangees_oab_papillons_taxons_thesaurus",
      `taxon_hesperides_tachetees` VARCHAR(10) PATH "$.transect.hesperides_tachetees_oab_papillons_taxons_thesaurus"
    )
  ) AS `t`
WHERE
  `participations`.`protocol_id` = 7
  AND `participations`.`deleted_at` IS NULL