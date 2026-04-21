SELECT DISTINCT
   dico_structures.structurepk AS structurepk,
   zones.zonepk AS site_id,
   groupes.structurefk AS structure_id,
   observations.observationpk AS session_id,
   observations.date AS session_date,
   dico_structures.name AS nom_etablissement,
   dico_structures.zipcode AS Code_postal_etablissement,
   dico_structures.city AS Ville_etablissement,
   dico_academies.name as Academie,
   zones.latitude AS Latitude_debut,
   zones.longitude AS Longitude_debut,
   zones_description_sauvages.latitude_fin as Latitude_fin,
   zones_description_sauvages.longitude_fin as Longitude_fin,
   (SELECT label_order
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_sauvages.cote_rue
   AND t='zones_description_fleurs'
   AND champ='cote_rue') AS Cote_rue,
   --observations_abondances.nom_espece AS Espece,
   dico_species.nom_espece AS taxon,
   observations_abondances.environnement_sauvages as Habitat
   -- CONCAT_JSON_MULTIPLE( observations_abondances.environnement_sauvages, ('value')::varchar, ('true')::varchar) as Environnement

FROM observations
LEFT JOIN observateurs ON observations.observateurfk = observateurs.observateurpk
LEFT JOIN groupes ON groupes.groupepk = observateurs.groupefk
LEFT JOIN users ON users.userpk=groupes.userfk
LEFT JOIN observations_abondances on observations_abondances.observationfk = observations.observationpk
left join zones_changes on observations.zonechangefk = zones_changes.zonechangepk
left join zones on zones.zonepk = zones_changes.zonefk
left join zones_description_sauvages on zones_description_sauvages.zonechangefk = zones_changes.zonechangepk
left join dico_structures on dico_structures.structurepk = groupes.structurefk
left join dico_academies on dico_academies.academiepk = dico_structures.academiefk
left join dico_species on dico_species.speciepk = observations_abondances.speciefk


WHERE
observations.protocolefk = 5
and users.email not in('vne5@yopmail.com')
--and groupes.anneescol = '2019'
--AND dico_etablissements.zipcode LIKE '93%'
