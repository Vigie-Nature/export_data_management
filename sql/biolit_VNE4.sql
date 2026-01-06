SELECT
   observations.observationpk AS session_id,
   observations.date AS session_date,
   groupes.structurefk AS structure_id,
   --users.nom AS Nom_enseignant,
   --users.prenom AS Prenom_enseignant,
   --groupes.anneescol AS Annee_scolaire,
   --groupes.name AS Nom_classe,
   --groupes.niveau AS Niveau_classe,
   --observateurs.name AS Nom_groupe,
   --observateurs.effectif AS Nombre_eleves,
   dico_structures.name AS nom_etablissement,
   dico_structures.zipcode AS code_postal_etablissement,
   dico_structures.city AS ville_etablissement,
   dico_academies.name as academie,
   zones.zonepk AS site_id,
   zones.latitude AS latitude,
   zones.longitude AS longitude,
   observations_abondances.nom_espece AS taxon,
   observations_abondances.abondance AS taxon_count,
   --observations_abondances.photo_taxon as Photo_taxon,

   -- Informations li?es ? la description de la zone d'observation
   observations_details_biolit.heure_maree_basse as heure_maree_basse,
   observations_details_biolit.coefficient_maree as coefficient_maree,
   observations_details_biolit.esp_rencontrees as Algues_rencontrees,
   observations_details_biolit.autres_algues as Autres_algues_rencontrees,

   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=observations_details_biolit.pourcentage_recouvrement
   AND t='observations_details_biolit'
   AND champ='pourcentage_recouvrement') AS Pourcentage_recouvrement_rochers,

   --observations_details_biolit.photo_estran_vers_cote_json,
  -- observations_details_biolit.photo_estran_vers_mer_json,

   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=observations_details_biolit.algue_etudiee
   AND t='observations_details_biolit'
   AND champ='algue_etudiee') AS Algue_etudiee,
   --observations_details_biolit.photo_ceinture_algale_json,

   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=observations_details_biolit.pourcentage_recouvrement_algues
   AND t='observations_details_biolit'
   AND champ='pourcentage_recouvrement') AS Pourcentage_recouvrement_algues,
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=observations_details_biolit.pourcentage_recouvrement_balanes
   AND t='observations_details_biolit'
   AND champ='pourcentage_recouvrement') AS Pourcentage_recouvrement_balanes,
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=observations_details_biolit.pourcentage_recouvrement_moules
   AND t='observations_details_biolit'
   AND champ='pourcentage_recouvrement') AS Pourcentage_recouvrement_moules
   --replace(replace(observations.notes,chr(10),' '),chr(13),' ') AS Notes

FROM observations
	LEFT JOIN observations_abondances on observations_abondances.observationfk = observations.observationpk
	left join observations_details_biolit on observations_details_biolit.observationfk = observations.observationpk
	LEFT JOIN observateurs ON observateurs.observateurpk = observations.observateurfk
	LEFT JOIN groupes ON groupes.groupepk = observateurs.groupefk
	LEFT JOIN users ON users.userpk = groupes.userfk
	left join zones_changes on zones_changes.zonechangepk = observations.zonechangefk
	left join zones on zones.zonepk = zones_changes.zonefk
	left join dico_structures on dico_structures.structurepk = groupes.structurefk
	left join dico_academies on dico_academies.academiepk = dico_structures.academiefk

WHERE
observations.protocolefk = 6
--and groupes.anneescol = '2019'
--AND dico_etablissements.zipcode LIKE '93%'
and users.email not in('vne5@yopmail.com')


