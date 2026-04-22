SELECT
  `participations`.`id` AS `session_id`,
  CAST(`participations`.`participation_date` AS DATE) AS `session_date`,
  `participations`.`user_id` AS `user_id`,
  st_x(`parcelles`.`localisation`) AS `longitude`,
  st_y(`parcelles`.`localisation`) AS `latitude`,
  -- Somme des abondances des trois planches
  IFNULL(CAST(`p1`.`vers` AS INT), 0) +
  IFNULL(CAST(`p1`.`vers` AS INT), 0) +
  IFNULL(CAST(`p1`.`vers` AS INT), 0)
    AS `taxon_vers`,
  IFNULL(CAST(`p1`.`autres` AS INT), 0) +
  IFNULL(CAST(`p1`.`autres` AS INT), 0) +
  IFNULL(CAST(`p1`.`autres` AS INT), 0)
    AS `taxon_autres`,
  IFNULL(CAST(`p1`.`orvets` AS INT), 0) +
  IFNULL(CAST(`p1`.`orvets` AS INT), 0) +
  IFNULL(CAST(`p1`.`orvets` AS INT), 0)
    AS `taxon_orvets`,
  IFNULL(CAST(`p1`.`lezards` AS INT), 0) +
  IFNULL(CAST(`p1`.`lezards` AS INT), 0) +
  IFNULL(CAST(`p1`.`lezards` AS INT), 0)
    AS `taxon_lezards`,
  IFNULL(CAST(`p1`.`luisants` AS INT), 0) +
  IFNULL(CAST(`p1`.`luisants` AS INT), 0) +
  IFNULL(CAST(`p1`.`luisants` AS INT), 0)
    AS `taxon_luisants`,
  IFNULL(CAST(`p1`.`serpents` AS INT), 0) +
  IFNULL(CAST(`p1`.`serpents` AS INT), 0) +
  IFNULL(CAST(`p1`.`serpents` AS INT), 0)
    AS `taxon_serpents`,
  IFNULL(CAST(`p1`.`araignees` AS INT), 0) +
  IFNULL(CAST(`p1`.`araignees` AS INT), 0) +
  IFNULL(CAST(`p1`.`araignees` AS INT), 0)
    AS `taxon_araignees`,
  IFNULL(CAST(`p1`.`cloportes` AS INT), 0) +
  IFNULL(CAST(`p1`.`cloportes` AS INT), 0) +
  IFNULL(CAST(`p1`.`cloportes` AS INT), 0)
    AS `taxon_cloportes`,
  IFNULL(CAST(`p1`.`amphibiens` AS INT), 0) +
  IFNULL(CAST(`p1`.`amphibiens` AS INT), 0) +
  IFNULL(CAST(`p1`.`amphibiens` AS INT), 0)
    AS `taxon_amphibiens`,
  IFNULL(CAST(`p1`.`helicelles` AS INT), 0) +
  IFNULL(CAST(`p1`.`helicelles` AS INT), 0) +
  IFNULL(CAST(`p1`.`helicelles` AS INT), 0)
    AS `taxon_helicelles`,
  IFNULL(CAST(`p1`.`petit_gris` AS INT), 0) +
  IFNULL(CAST(`p1`.`petit_gris` AS INT), 0) +
  IFNULL(CAST(`p1`.`petit_gris` AS INT), 0)
    AS `taxon_petit_gris`,
  IFNULL(CAST(`p1`.`fourmiliere` AS INT), 0) +
  IFNULL(CAST(`p1`.`fourmiliere` AS INT), 0) +
  IFNULL(CAST(`p1`.`fourmiliere` AS INT), 0)
    AS `taxon_fourmiliere`,
  IFNULL(CAST(`p1`.`zonite_peson` AS INT), 0) +
  IFNULL(CAST(`p1`.`zonite_peson` AS INT), 0) +
  IFNULL(CAST(`p1`.`zonite_peson` AS INT), 0)
    AS `taxon_zonite_peson`,
  IFNULL(CAST(`p1`.`milles_pattes` AS INT), 0) +
  IFNULL(CAST(`p1`.`milles_pattes` AS INT), 0) +
  IFNULL(CAST(`p1`.`milles_pattes` AS INT), 0)
    AS `taxon_milles_pattes`,
  IFNULL(CAST(`p1`.`autres_limaces` AS INT), 0) +
  IFNULL(CAST(`p1`.`autres_limaces` AS INT), 0) +
  IFNULL(CAST(`p1`.`autres_limaces` AS INT), 0)
    AS `taxon_autres_limaces`,
  IFNULL(CAST(`p1`.`carabe_sup__2cm` AS INT), 0) +
  IFNULL(CAST(`p1`.`carabe_sup__2cm` AS INT), 0) +
  IFNULL(CAST(`p1`.`carabe_sup__2cm` AS INT), 0)
    AS `taxon_carabe_sup__2cm`,
  IFNULL(CAST(`p1`.`elegante_striee` AS INT), 0) +
  IFNULL(CAST(`p1`.`elegante_striee` AS INT), 0) +
  IFNULL(CAST(`p1`.`elegante_striee` AS INT), 0)
    AS `taxon_elegante_striee`,
  IFNULL(CAST(`p1`.`autres_escargots` AS INT), 0) +
  IFNULL(CAST(`p1`.`autres_escargots` AS INT), 0) +
  IFNULL(CAST(`p1`.`autres_escargots` AS INT), 0)
    AS `taxon_autres_escargots`,
  IFNULL(CAST(`p1`.`presence_d_oeufs` AS INT), 0) +
  IFNULL(CAST(`p1`.`presence_d_oeufs` AS INT), 0) +
  IFNULL(CAST(`p1`.`presence_d_oeufs` AS INT), 0)
    AS `taxon_presence_d_oeufs`,
  IFNULL(CAST(`p1`.`quelques_fourmis` AS INT), 0) +
  IFNULL(CAST(`p1`.`quelques_fourmis` AS INT), 0) +
  IFNULL(CAST(`p1`.`quelques_fourmis` AS INT), 0)
    AS `taxon_quelques_fourmis`,
  IFNULL(CAST(`p1`.`caragouille_rosee` AS INT), 0) +
  IFNULL(CAST(`p1`.`caragouille_rosee` AS INT), 0) +
  IFNULL(CAST(`p1`.`caragouille_rosee` AS INT), 0)
    AS `taxon_caragouille_rosee`,
  IFNULL(CAST(`p1`.`grand_carabe_dore` AS INT), 0) +
  IFNULL(CAST(`p1`.`grand_carabe_dore` AS INT), 0) +
  IFNULL(CAST(`p1`.`grand_carabe_dore` AS INT), 0)
    AS `taxon_grand_carabe_dore`,
  IFNULL(CAST(`p1`.`grand_carabe_noir` AS INT), 0) +
  IFNULL(CAST(`p1`.`grand_carabe_noir` AS INT), 0) +
  IFNULL(CAST(`p1`.`grand_carabe_noir` AS INT), 0)
    AS `taxon_grand_carabe_noir`,
  IFNULL(CAST(`p1`.`petits_mammiferes` AS INT), 0) +
  IFNULL(CAST(`p1`.`petits_mammiferes` AS INT), 0) +
  IFNULL(CAST(`p1`.`petits_mammiferes` AS INT), 0)
    AS `taxon_petits_mammiferes`,
  IFNULL(CAST(`p1`.`grande_loche_noire` AS INT), 0) +
  IFNULL(CAST(`p1`.`grande_loche_noire` AS INT), 0) +
  IFNULL(CAST(`p1`.`grande_loche_noire` AS INT), 0)
    AS `taxon_grande_loche_noire`,
  IFNULL(CAST(`p1`.`grande_loche_rouge` AS INT), 0) +
  IFNULL(CAST(`p1`.`grande_loche_rouge` AS INT), 0) +
  IFNULL(CAST(`p1`.`grande_loche_rouge` AS INT), 0)
    AS `taxon_grande_loche_rouge`,
  IFNULL(CAST(`p1`.`petite_limace_noire` AS INT), 0) +
  IFNULL(CAST(`p1`.`petite_limace_noire` AS INT), 0) +
  IFNULL(CAST(`p1`.`petite_limace_noire` AS INT), 0)
    AS `taxon_petite_limace_noire`,
  IFNULL(CAST(`p1`.`escargot_de_bourgogne` AS INT), 0) +
  IFNULL(CAST(`p1`.`escargot_de_bourgogne` AS INT), 0) +
  IFNULL(CAST(`p1`.`escargot_de_bourgogne` AS INT), 0)
    AS `taxon_escargot_de_bourgogne`,
  IFNULL(CAST(`p1`.`carabe_de_moins_d_1_cm` AS INT), 0) +
  IFNULL(CAST(`p1`.`carabe_de_moins_d_1_cm` AS INT), 0) +
  IFNULL(CAST(`p1`.`carabe_de_moins_d_1_cm` AS INT), 0)
    AS `taxon_carabe_de_moins_d_1_cm`,
  IFNULL(CAST(`p1`.`carabe_entre_1_et_2_cm` AS INT), 0) +
  IFNULL(CAST(`p1`.`carabe_entre_1_et_2_cm` AS INT), 0) +
  IFNULL(CAST(`p1`.`carabe_entre_1_et_2_cm` AS INT), 0)
    AS `taxon_carabe_entre_1_et_2_cm`,
  IFNULL(CAST(`p1`.`grande_limace_tachetee` AS INT), 0) +
  IFNULL(CAST(`p1`.`grande_limace_tachetee` AS INT), 0) +
  IFNULL(CAST(`p1`.`grande_limace_tachetee` AS INT), 0)
    AS `taxon_grande_limace_tachetee`,
  IFNULL(CAST(`p1`.`escargot_des_haies_des_bois` AS INT), 0) +
  IFNULL(CAST(`p1`.`escargot_des_haies_des_bois` AS INT), 0) +
  IFNULL(CAST(`p1`.`escargot_des_haies_des_bois` AS INT), 0)
    AS `taxon_escargot_des_haies_des_bois`,
  IFNULL(CAST(`p1`.`maillots_clausilies_et_bulimes` AS INT), 0) +
  IFNULL(CAST(`p1`.`maillots_clausilies_et_bulimes` AS INT), 0) +
  IFNULL(CAST(`p1`.`maillots_clausilies_et_bulimes` AS INT), 0)
    AS `taxon_maillots_clausilies_et_bulimes`,
  IFNULL(CAST(`p1`.`petite_limace_tachetee_ou_grise` AS INT), 0) +
  IFNULL(CAST(`p1`.`petite_limace_tachetee_ou_grise` AS INT), 0) +
  IFNULL(CAST(`p1`.`petite_limace_tachetee_ou_grise` AS INT), 0)
    AS `taxon_petite_limace_tachetee_ou_grise`
FROM 
  `participations`
  INNER JOIN `parcelles`
    ON `parcelles`.`id` = `participations`.`parcelle_id`,
  -- Aplatir les données de la première planche
  json_table(
    `participations`.`data`,
    '$' COLUMNS (
      `vers`                            VARCHAR(10) PATH "$.planche1.Vers_oab_invertebres_taxons_thesaurus",
      `autres`                          VARCHAR(10) PATH "$.planche1.Autres_oab_invertebres_taxons_thesaurus",
      `orvets`                          VARCHAR(10) PATH "$.planche1.Orvets_oab_invertebres_taxons_thesaurus",
      `lezards`                         VARCHAR(10) PATH "$.planche1.Lezards_oab_invertebres_taxons_thesaurus",
      `luisants`                        VARCHAR(10) PATH "$.planche1.Luisants_oab_invertebres_taxons_thesaurus",
      `serpents`                        VARCHAR(10) PATH "$.planche1.Serpents_oab_invertebres_taxons_thesaurus",
      `araignees`                       VARCHAR(10) PATH "$.planche1.Araignees_oab_invertebres_taxons_thesaurus",
      `cloportes`                       VARCHAR(10) PATH "$.planche1.Cloportes_oab_invertebres_taxons_thesaurus",
      `amphibiens`                      VARCHAR(10) PATH "$.planche1.Amphibiens_oab_invertebres_taxons_thesaurus",
      `helicelles`                      VARCHAR(10) PATH "$.planche1.Helicelles_oab_invertebres_taxons_thesaurus",
      `petit_gris`                      VARCHAR(10) PATH "$.planche1.Petit_gris_oab_invertebres_taxons_thesaurus",
      `fourmiliere`                     VARCHAR(10) PATH "$.planche1.Fourmiliere_oab_invertebres_taxons_thesaurus",
      `zonite_peson`                    VARCHAR(10) PATH "$.planche1.Zonite_peson_oab_invertebres_taxons_thesaurus",
      `milles_pattes`                   VARCHAR(10) PATH "$.planche1.Milles_pattes_oab_invertebres_taxons_thesaurus",
      `autres_limaces`                  VARCHAR(10) PATH "$.planche1.Autres_limaces_oab_invertebres_taxons_thesaurus",
      `carabe_sup__2cm`                 VARCHAR(10) PATH "$.planche1.Carabe_sup__2cm_oab_invertebres_taxons_thesaurus",
      `elegante_striee`                 VARCHAR(10) PATH "$.planche1.Elegante_striee_oab_invertebres_taxons_thesaurus",
      `autres_escargots`                VARCHAR(10) PATH "$.planche1.Autres_escargots_oab_invertebres_taxons_thesaurus",
      `presence_d_oeufs`                VARCHAR(10) PATH "$.planche1.Presence_d_oeufs_oab_invertebres_taxons_thesaurus",
      `quelques_fourmis`                VARCHAR(10) PATH "$.planche1.Quelques_fourmis_oab_invertebres_taxons_thesaurus",
      `caragouille_rosee`               VARCHAR(10) PATH "$.planche1.Caragouille_rosee_oab_invertebres_taxons_thesaurus",
      `grand_carabe_dore`               VARCHAR(10) PATH "$.planche1.Grand_carabe_dore_oab_invertebres_taxons_thesaurus",
      `grand_carabe_noir`               VARCHAR(10) PATH "$.planche1.Grand_carabe_noir_oab_invertebres_taxons_thesaurus",
      `petits_mammiferes`               VARCHAR(10) PATH "$.planche1.Petits_mammiferes_oab_invertebres_taxons_thesaurus",
      `grande_loche_noire`              VARCHAR(10) PATH "$.planche1.Grande_loche_noire_oab_invertebres_taxons_thesaurus",
      `grande_loche_rouge`              VARCHAR(10) PATH "$.planche1.Grande_loche_rouge_oab_invertebres_taxons_thesaurus",
      `petite_limace_noire`             VARCHAR(10) PATH "$.planche1.Petite_limace_noire_oab_invertebres_taxons_thesaurus",
      `escargot_de_bourgogne`           VARCHAR(10) PATH "$.planche1.Escargot_de_bourgogne_oab_invertebres_taxons_thesaurus",
      `carabe_de_moins_d_1_cm`          VARCHAR(10) PATH "$.planche1.Carabe_de_moins_d_1_cm_oab_invertebres_taxons_thesaurus",
      `carabe_entre_1_et_2_cm`          VARCHAR(10) PATH "$.planche1.Carabe_entre_1_et_2_cm_oab_invertebres_taxons_thesaurus",
      `grande_limace_tachetee`          VARCHAR(10) PATH "$.planche1.Grande_limace_tachetee_oab_invertebres_taxons_thesaurus",
      `escargot_des_haies_des_bois`     VARCHAR(10) PATH "$.planche1.Escargot_des_haies_des_bois_oab_invertebres_taxons_thesaurus",
      `maillots_clausilies_et_bulimes`  VARCHAR(10) PATH "$.planche1.Maillots_Clausilies_et_bulimes_oab_invertebres_taxons_thesaurus",
      `petite_limace_tachetee_ou_grise` VARCHAR(10) PATH "$.planche1.Petite_limace_tachetee_ou_grise_oab_invertebres_taxons_thesaurus"
    )
  ) AS `p1`,
  -- Aplatir les données de la deuxième planche
  json_table(
    `participations`.`data`,
    '$' COLUMNS (
      `vers`                            VARCHAR(10) PATH "$.planche2.Vers_oab_invertebres_taxons_thesaurus",
      `autres`                          VARCHAR(10) PATH "$.planche2.Autres_oab_invertebres_taxons_thesaurus",
      `orvets`                          VARCHAR(10) PATH "$.planche2.Orvets_oab_invertebres_taxons_thesaurus",
      `lezards`                         VARCHAR(10) PATH "$.planche2.Lezards_oab_invertebres_taxons_thesaurus",
      `luisants`                        VARCHAR(10) PATH "$.planche2.Luisants_oab_invertebres_taxons_thesaurus",
      `serpents`                        VARCHAR(10) PATH "$.planche2.Serpents_oab_invertebres_taxons_thesaurus",
      `araignees`                       VARCHAR(10) PATH "$.planche2.Araignees_oab_invertebres_taxons_thesaurus",
      `cloportes`                       VARCHAR(10) PATH "$.planche2.Cloportes_oab_invertebres_taxons_thesaurus",
      `amphibiens`                      VARCHAR(10) PATH "$.planche2.Amphibiens_oab_invertebres_taxons_thesaurus",
      `helicelles`                      VARCHAR(10) PATH "$.planche2.Helicelles_oab_invertebres_taxons_thesaurus",
      `petit_gris`                      VARCHAR(10) PATH "$.planche2.Petit_gris_oab_invertebres_taxons_thesaurus",
      `fourmiliere`                     VARCHAR(10) PATH "$.planche2.Fourmiliere_oab_invertebres_taxons_thesaurus",
      `zonite_peson`                    VARCHAR(10) PATH "$.planche2.Zonite_peson_oab_invertebres_taxons_thesaurus",
      `milles_pattes`                   VARCHAR(10) PATH "$.planche2.Milles_pattes_oab_invertebres_taxons_thesaurus",
      `autres_limaces`                  VARCHAR(10) PATH "$.planche2.Autres_limaces_oab_invertebres_taxons_thesaurus",
      `carabe_sup__2cm`                 VARCHAR(10) PATH "$.planche2.Carabe_sup__2cm_oab_invertebres_taxons_thesaurus",
      `elegante_striee`                 VARCHAR(10) PATH "$.planche2.Elegante_striee_oab_invertebres_taxons_thesaurus",
      `autres_escargots`                VARCHAR(10) PATH "$.planche2.Autres_escargots_oab_invertebres_taxons_thesaurus",
      `presence_d_oeufs`                VARCHAR(10) PATH "$.planche2.Presence_d_oeufs_oab_invertebres_taxons_thesaurus",
      `quelques_fourmis`                VARCHAR(10) PATH "$.planche2.Quelques_fourmis_oab_invertebres_taxons_thesaurus",
      `caragouille_rosee`               VARCHAR(10) PATH "$.planche2.Caragouille_rosee_oab_invertebres_taxons_thesaurus",
      `grand_carabe_dore`               VARCHAR(10) PATH "$.planche2.Grand_carabe_dore_oab_invertebres_taxons_thesaurus",
      `grand_carabe_noir`               VARCHAR(10) PATH "$.planche2.Grand_carabe_noir_oab_invertebres_taxons_thesaurus",
      `petits_mammiferes`               VARCHAR(10) PATH "$.planche2.Petits_mammiferes_oab_invertebres_taxons_thesaurus",
      `grande_loche_noire`              VARCHAR(10) PATH "$.planche2.Grande_loche_noire_oab_invertebres_taxons_thesaurus",
      `grande_loche_rouge`              VARCHAR(10) PATH "$.planche2.Grande_loche_rouge_oab_invertebres_taxons_thesaurus",
      `petite_limace_noire`             VARCHAR(10) PATH "$.planche2.Petite_limace_noire_oab_invertebres_taxons_thesaurus",
      `escargot_de_bourgogne`           VARCHAR(10) PATH "$.planche2.Escargot_de_bourgogne_oab_invertebres_taxons_thesaurus",
      `carabe_de_moins_d_1_cm`          VARCHAR(10) PATH "$.planche2.Carabe_de_moins_d_1_cm_oab_invertebres_taxons_thesaurus",
      `carabe_entre_1_et_2_cm`          VARCHAR(10) PATH "$.planche2.Carabe_entre_1_et_2_cm_oab_invertebres_taxons_thesaurus",
      `grande_limace_tachetee`          VARCHAR(10) PATH "$.planche2.Grande_limace_tachetee_oab_invertebres_taxons_thesaurus",
      `escargot_des_haies_des_bois`     VARCHAR(10) PATH "$.planche2.Escargot_des_haies_des_bois_oab_invertebres_taxons_thesaurus",
      `maillots_clausilies_et_bulimes`  VARCHAR(10) PATH "$.planche2.Maillots_Clausilies_et_bulimes_oab_invertebres_taxons_thesaurus",
      `petite_limace_tachetee_ou_grise` VARCHAR(10) PATH "$.planche2.Petite_limace_tachetee_ou_grise_oab_invertebres_taxons_thesaurus"
    )
  ) AS `p2`,  
  -- Aplatir les données de la troisième planche
  json_table(
    `participations`.`data`,
    '$' COLUMNS (
      `vers`                            VARCHAR(10) PATH "$.planche3.Vers_oab_invertebres_taxons_thesaurus",
      `autres`                          VARCHAR(10) PATH "$.planche3.Autres_oab_invertebres_taxons_thesaurus",
      `orvets`                          VARCHAR(10) PATH "$.planche3.Orvets_oab_invertebres_taxons_thesaurus",
      `lezards`                         VARCHAR(10) PATH "$.planche3.Lezards_oab_invertebres_taxons_thesaurus",
      `luisants`                        VARCHAR(10) PATH "$.planche3.Luisants_oab_invertebres_taxons_thesaurus",
      `serpents`                        VARCHAR(10) PATH "$.planche3.Serpents_oab_invertebres_taxons_thesaurus",
      `araignees`                       VARCHAR(10) PATH "$.planche3.Araignees_oab_invertebres_taxons_thesaurus",
      `cloportes`                       VARCHAR(10) PATH "$.planche3.Cloportes_oab_invertebres_taxons_thesaurus",
      `amphibiens`                      VARCHAR(10) PATH "$.planche3.Amphibiens_oab_invertebres_taxons_thesaurus",
      `helicelles`                      VARCHAR(10) PATH "$.planche3.Helicelles_oab_invertebres_taxons_thesaurus",
      `petit_gris`                      VARCHAR(10) PATH "$.planche3.Petit_gris_oab_invertebres_taxons_thesaurus",
      `fourmiliere`                     VARCHAR(10) PATH "$.planche3.Fourmiliere_oab_invertebres_taxons_thesaurus",
      `zonite_peson`                    VARCHAR(10) PATH "$.planche3.Zonite_peson_oab_invertebres_taxons_thesaurus",
      `milles_pattes`                   VARCHAR(10) PATH "$.planche3.Milles_pattes_oab_invertebres_taxons_thesaurus",
      `autres_limaces`                  VARCHAR(10) PATH "$.planche3.Autres_limaces_oab_invertebres_taxons_thesaurus",
      `carabe_sup__2cm`                 VARCHAR(10) PATH "$.planche3.Carabe_sup__2cm_oab_invertebres_taxons_thesaurus",
      `elegante_striee`                 VARCHAR(10) PATH "$.planche3.Elegante_striee_oab_invertebres_taxons_thesaurus",
      `autres_escargots`                VARCHAR(10) PATH "$.planche3.Autres_escargots_oab_invertebres_taxons_thesaurus",
      `presence_d_oeufs`                VARCHAR(10) PATH "$.planche3.Presence_d_oeufs_oab_invertebres_taxons_thesaurus",
      `quelques_fourmis`                VARCHAR(10) PATH "$.planche3.Quelques_fourmis_oab_invertebres_taxons_thesaurus",
      `caragouille_rosee`               VARCHAR(10) PATH "$.planche3.Caragouille_rosee_oab_invertebres_taxons_thesaurus",
      `grand_carabe_dore`               VARCHAR(10) PATH "$.planche3.Grand_carabe_dore_oab_invertebres_taxons_thesaurus",
      `grand_carabe_noir`               VARCHAR(10) PATH "$.planche3.Grand_carabe_noir_oab_invertebres_taxons_thesaurus",
      `petits_mammiferes`               VARCHAR(10) PATH "$.planche3.Petits_mammiferes_oab_invertebres_taxons_thesaurus",
      `grande_loche_noire`              VARCHAR(10) PATH "$.planche3.Grande_loche_noire_oab_invertebres_taxons_thesaurus",
      `grande_loche_rouge`              VARCHAR(10) PATH "$.planche3.Grande_loche_rouge_oab_invertebres_taxons_thesaurus",
      `petite_limace_noire`             VARCHAR(10) PATH "$.planche3.Petite_limace_noire_oab_invertebres_taxons_thesaurus",
      `escargot_de_bourgogne`           VARCHAR(10) PATH "$.planche3.Escargot_de_bourgogne_oab_invertebres_taxons_thesaurus",
      `carabe_de_moins_d_1_cm`          VARCHAR(10) PATH "$.planche3.Carabe_de_moins_d_1_cm_oab_invertebres_taxons_thesaurus",
      `carabe_entre_1_et_2_cm`          VARCHAR(10) PATH "$.planche3.Carabe_entre_1_et_2_cm_oab_invertebres_taxons_thesaurus",
      `grande_limace_tachetee`          VARCHAR(10) PATH "$.planche3.Grande_limace_tachetee_oab_invertebres_taxons_thesaurus",
      `escargot_des_haies_des_bois`     VARCHAR(10) PATH "$.planche3.Escargot_des_haies_des_bois_oab_invertebres_taxons_thesaurus",
      `maillots_clausilies_et_bulimes`  VARCHAR(10) PATH "$.planche3.Maillots_Clausilies_et_bulimes_oab_invertebres_taxons_thesaurus",
      `petite_limace_tachetee_ou_grise` VARCHAR(10) PATH "$.planche3.Petite_limace_tachetee_ou_grise_oab_invertebres_taxons_thesaurus"
    )
  ) AS `p3`
WHERE
  `participations`.`protocol_id` = 9
  AND `participations`.`deleted_at` IS NULL
