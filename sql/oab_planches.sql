SELECT
  `participations`.`id` AS `session_id`,
  CAST(`participations`.`participation_date` AS DATE) AS `session_date`,
  `participations`.`user_id` AS `user_id`,
  st_x(`parcelles`.`localisation`) AS `longitude`,
  st_y(`parcelles`.`localisation`) AS `latitude`,
  -- Somme des abondances des trois planches
  IFNULL(CAST(`p1`.`vers` AS INT), 0) +
  IFNULL(CAST(`p2`.`vers` AS INT), 0) +
  IFNULL(CAST(`p3`.`vers` AS INT), 0)
    AS `taxon_vers`,
  IFNULL(CAST(`p1`.`autres` AS INT), 0) +
  IFNULL(CAST(`p2`.`autres` AS INT), 0) +
  IFNULL(CAST(`p3`.`autres` AS INT), 0)
    AS `taxon_autres`,
  IFNULL(CAST(`p1`.`orvets` AS INT), 0) +
  IFNULL(CAST(`p2`.`orvets` AS INT), 0) +
  IFNULL(CAST(`p3`.`orvets` AS INT), 0)
    AS `taxon_orvets`,
  IFNULL(CAST(`p1`.`lezards` AS INT), 0) +
  IFNULL(CAST(`p2`.`lezards` AS INT), 0) +
  IFNULL(CAST(`p3`.`lezards` AS INT), 0)
    AS `taxon_lezards`,
  IFNULL(CAST(`p1`.`luisants` AS INT), 0) +
  IFNULL(CAST(`p2`.`luisants` AS INT), 0) +
  IFNULL(CAST(`p3`.`luisants` AS INT), 0)
    AS `taxon_luisants`,
  IFNULL(CAST(`p1`.`serpents` AS INT), 0) +
  IFNULL(CAST(`p2`.`serpents` AS INT), 0) +
  IFNULL(CAST(`p3`.`serpents` AS INT), 0)
    AS `taxon_serpents`,
  IFNULL(CAST(`p1`.`araignees` AS INT), 0) +
  IFNULL(CAST(`p2`.`araignees` AS INT), 0) +
  IFNULL(CAST(`p3`.`araignees` AS INT), 0)
    AS `taxon_araignees`,
  IFNULL(CAST(`p1`.`cloportes` AS INT), 0) +
  IFNULL(CAST(`p2`.`cloportes` AS INT), 0) +
  IFNULL(CAST(`p3`.`cloportes` AS INT), 0)
    AS `taxon_cloportes`,
  IFNULL(CAST(`p1`.`amphibiens` AS INT), 0) +
  IFNULL(CAST(`p2`.`amphibiens` AS INT), 0) +
  IFNULL(CAST(`p3`.`amphibiens` AS INT), 0)
    AS `taxon_amphibiens`,
  IFNULL(CAST(`p1`.`helicelles` AS INT), 0) +
  IFNULL(CAST(`p2`.`helicelles` AS INT), 0) +
  IFNULL(CAST(`p3`.`helicelles` AS INT), 0)
    AS `taxon_helicelles`,
  IFNULL(CAST(`p1`.`petit_gris` AS INT), 0) +
  IFNULL(CAST(`p2`.`petit_gris` AS INT), 0) +
  IFNULL(CAST(`p3`.`petit_gris` AS INT), 0)
    AS `taxon_petit_gris`,
  IFNULL(CAST(`p1`.`fourmiliere` AS INT), 0) +
  IFNULL(CAST(`p2`.`fourmiliere` AS INT), 0) +
  IFNULL(CAST(`p3`.`fourmiliere` AS INT), 0)
    AS `taxon_fourmiliere`,
  IFNULL(CAST(`p1`.`zonite_peson` AS INT), 0) +
  IFNULL(CAST(`p2`.`zonite_peson` AS INT), 0) +
  IFNULL(CAST(`p3`.`zonite_peson` AS INT), 0)
    AS `taxon_zonite_peson`,
  IFNULL(CAST(`p1`.`milles_pattes` AS INT), 0) +
  IFNULL(CAST(`p2`.`milles_pattes` AS INT), 0) +
  IFNULL(CAST(`p3`.`milles_pattes` AS INT), 0)
    AS `taxon_milles_pattes`,
  IFNULL(CAST(`p1`.`autres_limaces` AS INT), 0) +
  IFNULL(CAST(`p2`.`autres_limaces` AS INT), 0) +
  IFNULL(CAST(`p3`.`autres_limaces` AS INT), 0)
    AS `taxon_autres_limaces`,
  IFNULL(CAST(`p1`.`carabe_sup__2cm` AS INT), 0) +
  IFNULL(CAST(`p2`.`carabe_sup__2cm` AS INT), 0) +
  IFNULL(CAST(`p3`.`carabe_sup__2cm` AS INT), 0)
    AS `taxon_carabe_sup__2cm`,
  IFNULL(CAST(`p1`.`elegante_striee` AS INT), 0) +
  IFNULL(CAST(`p2`.`elegante_striee` AS INT), 0) +
  IFNULL(CAST(`p3`.`elegante_striee` AS INT), 0)
    AS `taxon_elegante_striee`,
  IFNULL(CAST(`p1`.`autres_escargots` AS INT), 0) +
  IFNULL(CAST(`p2`.`autres_escargots` AS INT), 0) +
  IFNULL(CAST(`p3`.`autres_escargots` AS INT), 0)
    AS `taxon_autres_escargots`,
  IFNULL(CAST(`p1`.`presence_d_oeufs` AS INT), 0) +
  IFNULL(CAST(`p2`.`presence_d_oeufs` AS INT), 0) +
  IFNULL(CAST(`p3`.`presence_d_oeufs` AS INT), 0)
    AS `taxon_presence_d_oeufs`,
  IFNULL(CAST(`p1`.`quelques_fourmis` AS INT), 0) +
  IFNULL(CAST(`p2`.`quelques_fourmis` AS INT), 0) +
  IFNULL(CAST(`p3`.`quelques_fourmis` AS INT), 0)
    AS `taxon_quelques_fourmis`,
  IFNULL(CAST(`p1`.`caragouille_rosee` AS INT), 0) +
  IFNULL(CAST(`p2`.`caragouille_rosee` AS INT), 0) +
  IFNULL(CAST(`p3`.`caragouille_rosee` AS INT), 0)
    AS `taxon_caragouille_rosee`,
  IFNULL(CAST(`p1`.`grand_carabe_dore` AS INT), 0) +
  IFNULL(CAST(`p2`.`grand_carabe_dore` AS INT), 0) +
  IFNULL(CAST(`p3`.`grand_carabe_dore` AS INT), 0)
    AS `taxon_grand_carabe_dore`,
  IFNULL(CAST(`p1`.`grand_carabe_noir` AS INT), 0) +
  IFNULL(CAST(`p2`.`grand_carabe_noir` AS INT), 0) +
  IFNULL(CAST(`p3`.`grand_carabe_noir` AS INT), 0)
    AS `taxon_grand_carabe_noir`,
  IFNULL(CAST(`p1`.`petits_mammiferes` AS INT), 0) +
  IFNULL(CAST(`p2`.`petits_mammiferes` AS INT), 0) +
  IFNULL(CAST(`p3`.`petits_mammiferes` AS INT), 0)
    AS `taxon_petits_mammiferes`,
  IFNULL(CAST(`p1`.`grande_loche_noire` AS INT), 0) +
  IFNULL(CAST(`p2`.`grande_loche_noire` AS INT), 0) +
  IFNULL(CAST(`p3`.`grande_loche_noire` AS INT), 0)
    AS `taxon_grande_loche_noire`,
  IFNULL(CAST(`p1`.`grande_loche_rouge` AS INT), 0) +
  IFNULL(CAST(`p2`.`grande_loche_rouge` AS INT), 0) +
  IFNULL(CAST(`p3`.`grande_loche_rouge` AS INT), 0)
    AS `taxon_grande_loche_rouge`,
  IFNULL(CAST(`p1`.`petite_limace_noire` AS INT), 0) +
  IFNULL(CAST(`p2`.`petite_limace_noire` AS INT), 0) +
  IFNULL(CAST(`p3`.`petite_limace_noire` AS INT), 0)
    AS `taxon_petite_limace_noire`,
  IFNULL(CAST(`p1`.`escargot_de_bourgogne` AS INT), 0) +
  IFNULL(CAST(`p2`.`escargot_de_bourgogne` AS INT), 0) +
  IFNULL(CAST(`p3`.`escargot_de_bourgogne` AS INT), 0)
    AS `taxon_escargot_de_bourgogne`,
  IFNULL(CAST(`p1`.`carabe_de_moins_d_1_cm` AS INT), 0) +
  IFNULL(CAST(`p2`.`carabe_de_moins_d_1_cm` AS INT), 0) +
  IFNULL(CAST(`p3`.`carabe_de_moins_d_1_cm` AS INT), 0)
    AS `taxon_carabe_de_moins_d_1_cm`,
  IFNULL(CAST(`p1`.`carabe_entre_1_et_2_cm` AS INT), 0) +
  IFNULL(CAST(`p2`.`carabe_entre_1_et_2_cm` AS INT), 0) +
  IFNULL(CAST(`p3`.`carabe_entre_1_et_2_cm` AS INT), 0)
    AS `taxon_carabe_entre_1_et_2_cm`,
  IFNULL(CAST(`p1`.`grande_limace_tachetee` AS INT), 0) +
  IFNULL(CAST(`p2`.`grande_limace_tachetee` AS INT), 0) +
  IFNULL(CAST(`p3`.`grande_limace_tachetee` AS INT), 0)
    AS `taxon_grande_limace_tachetee`,
  IFNULL(CAST(`p1`.`escargot_des_haies_des_bois` AS INT), 0) +
  IFNULL(CAST(`p2`.`escargot_des_haies_des_bois` AS INT), 0) +
  IFNULL(CAST(`p3`.`escargot_des_haies_des_bois` AS INT), 0)
    AS `taxon_escargot_des_haies_des_bois`,
  IFNULL(CAST(`p1`.`maillots_clausilies_et_bulimes` AS INT), 0) +
  IFNULL(CAST(`p2`.`maillots_clausilies_et_bulimes` AS INT), 0) +
  IFNULL(CAST(`p3`.`maillots_clausilies_et_bulimes` AS INT), 0)
    AS `taxon_maillots_clausilies_et_bulimes`,
  IFNULL(CAST(`p1`.`petite_limace_tachetee_ou_grise` AS INT), 0) +
  IFNULL(CAST(`p2`.`petite_limace_tachetee_ou_grise` AS INT), 0) +
  IFNULL(CAST(`p3`.`petite_limace_tachetee_ou_grise` AS INT), 0)
    AS `taxon_petite_limace_tachetee_ou_grise`
FROM 
  `participations`
  INNER JOIN `parcelles`
    ON `parcelles`.`id` = `participations`.`parcelle_id`,
  -- Aplatir les données de la première planche
  json_table(
    `participations`.`data`,
    '$.planche1' COLUMNS (
      `vers`                            VARCHAR(10) PATH "$.Vers_oab_invertebres_taxons_thesaurus",
      `autres`                          VARCHAR(10) PATH "$.Autres_oab_invertebres_taxons_thesaurus",
      `orvets`                          VARCHAR(10) PATH "$.Orvets_oab_invertebres_taxons_thesaurus",
      `lezards`                         VARCHAR(10) PATH "$.Lezards_oab_invertebres_taxons_thesaurus",
      `luisants`                        VARCHAR(10) PATH "$.Luisants_oab_invertebres_taxons_thesaurus",
      `serpents`                        VARCHAR(10) PATH "$.Serpents_oab_invertebres_taxons_thesaurus",
      `araignees`                       VARCHAR(10) PATH "$.Araignees_oab_invertebres_taxons_thesaurus",
      `cloportes`                       VARCHAR(10) PATH "$.Cloportes_oab_invertebres_taxons_thesaurus",
      `amphibiens`                      VARCHAR(10) PATH "$.Amphibiens_oab_invertebres_taxons_thesaurus",
      `helicelles`                      VARCHAR(10) PATH "$.Helicelles_oab_invertebres_taxons_thesaurus",
      `petit_gris`                      VARCHAR(10) PATH "$.Petit_gris_oab_invertebres_taxons_thesaurus",
      `fourmiliere`                     VARCHAR(10) PATH "$.Fourmiliere_oab_invertebres_taxons_thesaurus",
      `zonite_peson`                    VARCHAR(10) PATH "$.Zonite_peson_oab_invertebres_taxons_thesaurus",
      `milles_pattes`                   VARCHAR(10) PATH "$.Milles_pattes_oab_invertebres_taxons_thesaurus",
      `autres_limaces`                  VARCHAR(10) PATH "$.Autres_limaces_oab_invertebres_taxons_thesaurus",
      `carabe_sup__2cm`                 VARCHAR(10) PATH "$.Carabe_sup__2cm_oab_invertebres_taxons_thesaurus",
      `elegante_striee`                 VARCHAR(10) PATH "$.Elegante_striee_oab_invertebres_taxons_thesaurus",
      `autres_escargots`                VARCHAR(10) PATH "$.Autres_escargots_oab_invertebres_taxons_thesaurus",
      `presence_d_oeufs`                VARCHAR(10) PATH "$.Presence_d_oeufs_oab_invertebres_taxons_thesaurus",
      `quelques_fourmis`                VARCHAR(10) PATH "$.Quelques_fourmis_oab_invertebres_taxons_thesaurus",
      `caragouille_rosee`               VARCHAR(10) PATH "$.Caragouille_rosee_oab_invertebres_taxons_thesaurus",
      `grand_carabe_dore`               VARCHAR(10) PATH "$.Grand_carabe_dore_oab_invertebres_taxons_thesaurus",
      `grand_carabe_noir`               VARCHAR(10) PATH "$.Grand_carabe_noir_oab_invertebres_taxons_thesaurus",
      `petits_mammiferes`               VARCHAR(10) PATH "$.Petits_mammiferes_oab_invertebres_taxons_thesaurus",
      `grande_loche_noire`              VARCHAR(10) PATH "$.Grande_loche_noire_oab_invertebres_taxons_thesaurus",
      `grande_loche_rouge`              VARCHAR(10) PATH "$.Grande_loche_rouge_oab_invertebres_taxons_thesaurus",
      `petite_limace_noire`             VARCHAR(10) PATH "$.Petite_limace_noire_oab_invertebres_taxons_thesaurus",
      `escargot_de_bourgogne`           VARCHAR(10) PATH "$.Escargot_de_bourgogne_oab_invertebres_taxons_thesaurus",
      `carabe_de_moins_d_1_cm`          VARCHAR(10) PATH "$.Carabe_de_moins_d_1_cm_oab_invertebres_taxons_thesaurus",
      `carabe_entre_1_et_2_cm`          VARCHAR(10) PATH "$.Carabe_entre_1_et_2_cm_oab_invertebres_taxons_thesaurus",
      `grande_limace_tachetee`          VARCHAR(10) PATH "$.Grande_limace_tachetee_oab_invertebres_taxons_thesaurus",
      `escargot_des_haies_des_bois`     VARCHAR(10) PATH "$.Escargot_des_haies_des_bois_oab_invertebres_taxons_thesaurus",
      `maillots_clausilies_et_bulimes`  VARCHAR(10) PATH "$.Maillots_Clausilies_et_bulimes_oab_invertebres_taxons_thesaurus",
      `petite_limace_tachetee_ou_grise` VARCHAR(10) PATH "$.Petite_limace_tachetee_ou_grise_oab_invertebres_taxons_thesaurus"
    )
  ) AS `p1`,
  -- Aplatir les données de la deuxième planche
  json_table(
    `participations`.`data`,
    '$.planche2' COLUMNS (
      `vers`                            VARCHAR(10) PATH "$.Vers_oab_invertebres_taxons_thesaurus",
      `autres`                          VARCHAR(10) PATH "$.Autres_oab_invertebres_taxons_thesaurus",
      `orvets`                          VARCHAR(10) PATH "$.Orvets_oab_invertebres_taxons_thesaurus",
      `lezards`                         VARCHAR(10) PATH "$.Lezards_oab_invertebres_taxons_thesaurus",
      `luisants`                        VARCHAR(10) PATH "$.Luisants_oab_invertebres_taxons_thesaurus",
      `serpents`                        VARCHAR(10) PATH "$.Serpents_oab_invertebres_taxons_thesaurus",
      `araignees`                       VARCHAR(10) PATH "$.Araignees_oab_invertebres_taxons_thesaurus",
      `cloportes`                       VARCHAR(10) PATH "$.Cloportes_oab_invertebres_taxons_thesaurus",
      `amphibiens`                      VARCHAR(10) PATH "$.Amphibiens_oab_invertebres_taxons_thesaurus",
      `helicelles`                      VARCHAR(10) PATH "$.Helicelles_oab_invertebres_taxons_thesaurus",
      `petit_gris`                      VARCHAR(10) PATH "$.Petit_gris_oab_invertebres_taxons_thesaurus",
      `fourmiliere`                     VARCHAR(10) PATH "$.Fourmiliere_oab_invertebres_taxons_thesaurus",
      `zonite_peson`                    VARCHAR(10) PATH "$.Zonite_peson_oab_invertebres_taxons_thesaurus",
      `milles_pattes`                   VARCHAR(10) PATH "$.Milles_pattes_oab_invertebres_taxons_thesaurus",
      `autres_limaces`                  VARCHAR(10) PATH "$.Autres_limaces_oab_invertebres_taxons_thesaurus",
      `carabe_sup__2cm`                 VARCHAR(10) PATH "$.Carabe_sup__2cm_oab_invertebres_taxons_thesaurus",
      `elegante_striee`                 VARCHAR(10) PATH "$.Elegante_striee_oab_invertebres_taxons_thesaurus",
      `autres_escargots`                VARCHAR(10) PATH "$.Autres_escargots_oab_invertebres_taxons_thesaurus",
      `presence_d_oeufs`                VARCHAR(10) PATH "$.Presence_d_oeufs_oab_invertebres_taxons_thesaurus",
      `quelques_fourmis`                VARCHAR(10) PATH "$.Quelques_fourmis_oab_invertebres_taxons_thesaurus",
      `caragouille_rosee`               VARCHAR(10) PATH "$.Caragouille_rosee_oab_invertebres_taxons_thesaurus",
      `grand_carabe_dore`               VARCHAR(10) PATH "$.Grand_carabe_dore_oab_invertebres_taxons_thesaurus",
      `grand_carabe_noir`               VARCHAR(10) PATH "$.Grand_carabe_noir_oab_invertebres_taxons_thesaurus",
      `petits_mammiferes`               VARCHAR(10) PATH "$.Petits_mammiferes_oab_invertebres_taxons_thesaurus",
      `grande_loche_noire`              VARCHAR(10) PATH "$.Grande_loche_noire_oab_invertebres_taxons_thesaurus",
      `grande_loche_rouge`              VARCHAR(10) PATH "$.Grande_loche_rouge_oab_invertebres_taxons_thesaurus",
      `petite_limace_noire`             VARCHAR(10) PATH "$.Petite_limace_noire_oab_invertebres_taxons_thesaurus",
      `escargot_de_bourgogne`           VARCHAR(10) PATH "$.Escargot_de_bourgogne_oab_invertebres_taxons_thesaurus",
      `carabe_de_moins_d_1_cm`          VARCHAR(10) PATH "$.Carabe_de_moins_d_1_cm_oab_invertebres_taxons_thesaurus",
      `carabe_entre_1_et_2_cm`          VARCHAR(10) PATH "$.Carabe_entre_1_et_2_cm_oab_invertebres_taxons_thesaurus",
      `grande_limace_tachetee`          VARCHAR(10) PATH "$.Grande_limace_tachetee_oab_invertebres_taxons_thesaurus",
      `escargot_des_haies_des_bois`     VARCHAR(10) PATH "$.Escargot_des_haies_des_bois_oab_invertebres_taxons_thesaurus",
      `maillots_clausilies_et_bulimes`  VARCHAR(10) PATH "$.Maillots_Clausilies_et_bulimes_oab_invertebres_taxons_thesaurus",
      `petite_limace_tachetee_ou_grise` VARCHAR(10) PATH "$.Petite_limace_tachetee_ou_grise_oab_invertebres_taxons_thesaurus"
    )
  ) AS `p2`,  
  -- Aplatir les données de la troisième planche
  json_table(
    `participations`.`data`,
    '$.planche3' COLUMNS (
      `vers`                            VARCHAR(10) PATH "$.Vers_oab_invertebres_taxons_thesaurus",
      `autres`                          VARCHAR(10) PATH "$.Autres_oab_invertebres_taxons_thesaurus",
      `orvets`                          VARCHAR(10) PATH "$.Orvets_oab_invertebres_taxons_thesaurus",
      `lezards`                         VARCHAR(10) PATH "$.Lezards_oab_invertebres_taxons_thesaurus",
      `luisants`                        VARCHAR(10) PATH "$.Luisants_oab_invertebres_taxons_thesaurus",
      `serpents`                        VARCHAR(10) PATH "$.Serpents_oab_invertebres_taxons_thesaurus",
      `araignees`                       VARCHAR(10) PATH "$.Araignees_oab_invertebres_taxons_thesaurus",
      `cloportes`                       VARCHAR(10) PATH "$.Cloportes_oab_invertebres_taxons_thesaurus",
      `amphibiens`                      VARCHAR(10) PATH "$.Amphibiens_oab_invertebres_taxons_thesaurus",
      `helicelles`                      VARCHAR(10) PATH "$.Helicelles_oab_invertebres_taxons_thesaurus",
      `petit_gris`                      VARCHAR(10) PATH "$.Petit_gris_oab_invertebres_taxons_thesaurus",
      `fourmiliere`                     VARCHAR(10) PATH "$.Fourmiliere_oab_invertebres_taxons_thesaurus",
      `zonite_peson`                    VARCHAR(10) PATH "$.Zonite_peson_oab_invertebres_taxons_thesaurus",
      `milles_pattes`                   VARCHAR(10) PATH "$.Milles_pattes_oab_invertebres_taxons_thesaurus",
      `autres_limaces`                  VARCHAR(10) PATH "$.Autres_limaces_oab_invertebres_taxons_thesaurus",
      `carabe_sup__2cm`                 VARCHAR(10) PATH "$.Carabe_sup__2cm_oab_invertebres_taxons_thesaurus",
      `elegante_striee`                 VARCHAR(10) PATH "$.Elegante_striee_oab_invertebres_taxons_thesaurus",
      `autres_escargots`                VARCHAR(10) PATH "$.Autres_escargots_oab_invertebres_taxons_thesaurus",
      `presence_d_oeufs`                VARCHAR(10) PATH "$.Presence_d_oeufs_oab_invertebres_taxons_thesaurus",
      `quelques_fourmis`                VARCHAR(10) PATH "$.Quelques_fourmis_oab_invertebres_taxons_thesaurus",
      `caragouille_rosee`               VARCHAR(10) PATH "$.Caragouille_rosee_oab_invertebres_taxons_thesaurus",
      `grand_carabe_dore`               VARCHAR(10) PATH "$.Grand_carabe_dore_oab_invertebres_taxons_thesaurus",
      `grand_carabe_noir`               VARCHAR(10) PATH "$.Grand_carabe_noir_oab_invertebres_taxons_thesaurus",
      `petits_mammiferes`               VARCHAR(10) PATH "$.Petits_mammiferes_oab_invertebres_taxons_thesaurus",
      `grande_loche_noire`              VARCHAR(10) PATH "$.Grande_loche_noire_oab_invertebres_taxons_thesaurus",
      `grande_loche_rouge`              VARCHAR(10) PATH "$.Grande_loche_rouge_oab_invertebres_taxons_thesaurus",
      `petite_limace_noire`             VARCHAR(10) PATH "$.Petite_limace_noire_oab_invertebres_taxons_thesaurus",
      `escargot_de_bourgogne`           VARCHAR(10) PATH "$.Escargot_de_bourgogne_oab_invertebres_taxons_thesaurus",
      `carabe_de_moins_d_1_cm`          VARCHAR(10) PATH "$.Carabe_de_moins_d_1_cm_oab_invertebres_taxons_thesaurus",
      `carabe_entre_1_et_2_cm`          VARCHAR(10) PATH "$.Carabe_entre_1_et_2_cm_oab_invertebres_taxons_thesaurus",
      `grande_limace_tachetee`          VARCHAR(10) PATH "$.Grande_limace_tachetee_oab_invertebres_taxons_thesaurus",
      `escargot_des_haies_des_bois`     VARCHAR(10) PATH "$.Escargot_des_haies_des_bois_oab_invertebres_taxons_thesaurus",
      `maillots_clausilies_et_bulimes`  VARCHAR(10) PATH "$.Maillots_Clausilies_et_bulimes_oab_invertebres_taxons_thesaurus",
      `petite_limace_tachetee_ou_grise` VARCHAR(10) PATH "$.Petite_limace_tachetee_ou_grise_oab_invertebres_taxons_thesaurus"
    )
  ) AS `p3`
WHERE
  `participations`.`protocol_id` = 9
  AND `participations`.`deleted_at` IS NULL
