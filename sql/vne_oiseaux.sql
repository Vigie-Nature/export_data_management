SELECT
   observations.observationpk AS session_id,
   zones.zonepk AS site_id,
   groupes.structurefk AS structure_id,
   observations.date AS session_date,
   dico_structures.name AS nom_etablissement,
   dico_structures.zipcode AS Code_postal_etablissement,
   dico_structures.city AS Ville_etablissement,
   dico_academies.name as Academie,
   zones.latitude AS Latitude,
   zones.longitude AS Longitude,
   --observations_abondances.nom_espece AS Espece,
   dico_species.nom_espece AS taxon,
   observations_abondances.speciefk AS speciefk,
   observations_abondances.abondance AS taxon_count,
   observations_details_oiseaux.heure_debut AS Heure_debut,
   observations_details_oiseaux.heure_fin AS Heure_fin,
   observations_details_oiseaux.type_nourriture AS Presence_nourriture,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones.environnement
   AND t='zones'
   AND champ='environnement') AS Type_de_milieu,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones.surface
   AND t='zones'
   AND champ='surface') AS Surface_zone,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_oiseaux.distance_bois
   AND t='zones_description_escargots'
   AND champ='distance_bois') AS Distance_bois,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_oiseaux.distance_prairie
   AND t='zones_description_escargots'
   AND champ='distance_prairie') AS Distance_prairie,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_oiseaux.distance_champ_cultive
   AND t='zones_description_escargots'
   AND champ='distance_champ_cultive') AS Distance_champ,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_oiseaux.engrais
   AND t='zones_description_escargots'
   AND champ='engrais') AS Utilisation_engrais,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_oiseaux.insecticides
   AND t='zones_description_escargots'
   AND champ='insecticides') AS Utilisation_insecticides,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_oiseaux.herbicides
   AND t='zones_description_escargots'
   AND champ='herbicides') AS Utilisation_herbicides,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_oiseaux.fongicides
   AND t='zones_description_escargots'
   AND champ='fongicides') AS Utilisation_fongicides,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_oiseaux.antilimaces
   AND t='zones_description_escargots'
   AND champ='antilimaces') AS Utilisation_antilimaces,
  (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_oiseaux.bouilliebordelaise
   AND t='zones_description_escargots'
   AND champ='bouilliebordelaise') AS Utilisation_boulliebordelaise

FROM observations_abondances
LEFT JOIN observations on observations_abondances.observationfk = observations.observationpk
left join observations_details_oiseaux on observations_details_oiseaux.observationfk = observations.observationpk
LEFT JOIN observateurs ON observateurs.observateurpk = observations.observateurfk
LEFT JOIN groupes ON groupes.groupepk = observateurs.groupefk
LEFT JOIN users ON users.userpk = groupes.userfk
left join zones_changes on zones_changes.zonechangepk = observations.zonechangefk
left join zones on zones.zonepk = zones_changes.zonefk
left join zones_description_oiseaux on zones_description_oiseaux.zonechangefk = zones_changes.zonechangepk
left join dico_structures on dico_structures.structurepk = groupes.structurefk
left join dico_academies on dico_academies.academiepk = dico_structures.academiefk
left join dico_species on dico_species.speciepk = observations_abondances.speciefk

WHERE
observations.protocolefk = 1
and users.email not in('vne5@yopmail.com')
--and groupes.anneescol = '2019'
--AND dico_etablissements.zipcode LIKE '93%'
--and observations_abondances.abondance > 0
