SELECT
   observations.observationpk AS session_id,
   observations.date AS session_date,
   groupes.anneescol AS Annee_scolaire,
   groupes.structurefk AS structure_id,
   dico_structures.name AS Nom_etablissement,
   dico_structures.zipcode AS Code_postal_etablissement,
   dico_structures.city AS Ville_etablissement,
   dico_academies.name as Academie,
   zones.zonepk as site_id,
   zones.latitude AS Latitude, 
   zones.longitude AS Longitude,
   observations_abondances.nom_espece AS taxon,
   observations_abondances.abondance AS taxon_count,
   cast(observations_details_plagesvivantes.nb_quadrats as INT)+1 as nombre_total_quadrat,
   cast(observations_abondances.quadrat as INT)+1 as Numero_quadrat,
   dico_species.speciepk,

   
   -- Informations issues de la saisie des donn?es
   observations_details_plagesvivantes.heure_debut as session_starting_time,
   observations_details_plagesvivantes.epaisseur_laisse,
   observations_details_plagesvivantes.largeur_laisse,
   observations_details_plagesvivantes.longueur_laisse,
   observations_details_plagesvivantes.photos_quadrats_json,
   (CASE observations_details_plagesvivantes.trace_cribleuse WHEN TRUE THEN 'Oui' ELSE 'Non' END) as trace_cribleuse,
   (CASE observations_details_plagesvivantes.acces_engins WHEN TRUE THEN 'Oui' ELSE 'Non' END) as acces_engins,
   observations_details_plagesvivantes.activites as activites_observees,
   
   -- Informations issues de la description de la zone d'observation
   cast(zones_description_plagesvivantes.longueur as decimal)*1000 as Longueur_transect_en_metre,
   zones_description_plagesvivantes.secteur as Point_GPS_transects,
   
   replace(replace(observations.notes,chr(10),' '),chr(13),' ') AS Notes

FROM observations
LEFT JOIN observateurs ON observations.observateurfk = observateurs.observateurpk
LEFT JOIN groupes ON groupes.groupepk = observateurs.groupefk
LEFT JOIN users ON users.userpk=groupes.userfk 
LEFT JOIN observations_abondances on observations_abondances.observationfk = observations.observationpk
left join observations_details_plagesvivantes on observations_details_plagesvivantes.observationfk =observations.observationpk 
left join zones_changes on observations.zonechangefk = zones_changes.zonechangepk
left join zones on zones.zonepk = zones_changes.zonefk
left join zones_placettes on zones_placettes.placettepk = observations_abondances.placettefk
left join zones_description_plagesvivantes on zones_description_plagesvivantes.zonechangefk = zones_changes.zonechangepk
left join dico_structures on dico_structures.structurepk = groupes.structurefk 
left join dico_academies on dico_academies.academiepk = dico_structures.academiefk 
left join dico_species on dico_species.speciepk = observations_abondances.speciefk 

WHERE 
observations.protocolefk = 12
-- and groupes.anneescol = '2022'
--and dico_academies.name in ('LILLE', 'AMIENS')
and users.email not in('vne5@yopmail.com')
--AND dico_etablissements.zipcode LIKE '93%'
and observations_abondances.abondance > 0

