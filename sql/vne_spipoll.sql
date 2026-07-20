SELECT
   observations.observationpk AS session_id,
   observations.date AS session_date,
   observations_details_spipoll.debut_session as session_starting_time,
   observations_details_spipoll.fin_session as session_ending_time,
   dico_structures.name AS nom_etablissement,
   dico_structures.zipcode AS code_postal_etablissement,
   dico_structures.city AS ville_etablissement,
   dico_academies.name as academie,
   zones.zonepk AS site_id,
   groupes.structurefk AS structure_id,
   zones.latitude AS latitude,
   zones.longitude AS longitude,

   observations_abondances.nom_espece AS taxon,
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=observations_abondances.abondance
   AND t='observations_details_spipoll'
   AND champ='nb_insecte_simultane') AS taxon_count,

   observations_details_spipoll.fleur as espece_fleur,
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=observations_details_spipoll.type_plante
   AND t='observations_details_spipoll'
   AND champ='type_plante') AS type_fleur,
   CASE WHEN observations_details_spipoll.ombre = FALSE THEN 'Non'
        ELSE 'Oui' END AS "fleur_a_lombre",


   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=observations_details_spipoll.couverture_nuageuse
   AND t='observations_details_spipoll'
   AND champ='couverture_nuageuse') AS nebulosite,
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=observations_details_spipoll.temperature
   AND t='observations_details_spipoll'
   AND champ='temperature') AS temperature,
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=observations_details_spipoll.vent
   AND t='observations_details_spipoll'
   AND champ='vent') AS vent,


  (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=zones.environnement
   AND t='zones'
   AND champ='environnement') AS type_de_milieu,
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=zones.surface
   AND t='zones'
   AND champ='surface') AS surface_zone,
   zones_changes.type_habitat as type_habitat,
   zones_description_spipoll.distance_fleur_ruche as distance_ruche


FROM observations
LEFT JOIN observateurs ON observations.observateurfk = observateurs.observateurpk
LEFT JOIN groupes ON groupes.groupepk = observateurs.groupefk
LEFT JOIN users ON users.userpk=groupes.userfk
LEFT JOIN observations_abondances on observations_abondances.observationfk = observations.observationpk
left join observations_details_spipoll on observations_details_spipoll.observationfk = observations.observationpk
left join zones_changes on observations.zonechangefk = zones_changes.zonechangepk
left join zones on zones.zonepk = zones_changes.zonefk
left join zones_description_spipoll on zones_description_spipoll.zonechangefk = zones_changes.zonechangepk
left join dico_structures on dico_structures.structurepk = groupes.structurefk
left join dico_academies on dico_academies.academiepk = dico_structures.academiefk


WHERE
observations.protocolefk = 3
and users.email not in('vne5@yopmail.com')


