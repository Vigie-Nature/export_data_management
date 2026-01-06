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
   observations_abondances.nom_espece AS taxon,
   observations_abondances.abondance AS taxon_count,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones.environnement
   AND t='zones'
   AND champ='environnement') AS Type_de_milieu,
   zones_changes.composition as Composition_zone,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones.surface
   AND t='zones'
   AND champ='surface') AS Surface_zone,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_escargots.distance_bois
   AND t='zones_description_escargots'
   AND champ='distance_bois') AS Distance_bois,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_escargots.distance_prairie
   AND t='zones_description_escargots'
   AND champ='distance_prairie') AS Distance_prairie,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_escargots.distance_champ_cultive
   AND t='zones_description_escargots'
   AND champ='distance_champ_cultive') AS Distance_champ,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_escargots.engrais
   AND t='zones_description_escargots'
   AND champ='engrais') AS Utilisation_engrais,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_escargots.insecticides
   AND t='zones_description_escargots'
   AND champ='insecticides') AS Utilisation_insecticides,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_escargots.herbicides
   AND t='zones_description_escargots'
   AND champ='herbicides') AS Utilisation_herbicides,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_escargots.fongicides
   AND t='zones_description_escargots'
   AND champ='fongicides') AS Utilisation_fongicides,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_escargots.antilimaces
   AND t='zones_description_escargots'
   AND champ='antilimaces') AS Utilisation_antilimaces,
  (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_escargots.bouilliebordelaise
   AND t='zones_description_escargots'
   AND champ='bouilliebordelaise') AS Utilisation_boulliebordelaise,
   zones_placettes.placettepk AS Numero_planche,
   (zones_placettes.largeur*zones_placettes.longueur)/10000 AS Surface_planche,
   zones_placettes.environnement

FROM observations
LEFT JOIN observateurs ON observations.observateurfk = observateurs.observateurpk
LEFT JOIN groupes ON groupes.groupepk = observateurs.groupefk
LEFT JOIN users ON users.userpk=groupes.userfk
LEFT JOIN observations_abondances on observations_abondances.observationfk =observations.observationpk
left join zones_changes on observations.zonechangefk = zones_changes.zonechangepk
left join zones on zones.zonepk = zones_changes.zonefk
left join zones_placettes on zones_placettes.placettepk = observations_abondances.placettefk
left join zones_description_escargots on zones_description_escargots.zonechangefk = zones_changes.zonechangepk
left join dico_structures on dico_structures.structurepk = groupes.structurefk
left join dico_academies on dico_academies.academiepk = dico_structures.academiefk


WHERE
observations.protocolefk = 2
and users.email not in('vne5@yopmail.com')
--and groupes.anneescol = '2019'
--AND dico_etablissements.zipcode LIKE '93%'
--and observations_abondances.abondance > 0

