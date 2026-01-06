SELECT
   observations.observationpk AS session_id,
   observations.date AS session_date,
   zones.zonepk AS site_id,
   groupes.structurefk AS structure_id,
--   users.nom AS Nom_enseignant,
--   users.prenom AS Prenom_enseignant,
--   groupes.anneescol AS Annee_scolaire,
--   groupes.name AS Nom_classe,
--   groupes.niveau AS Niveau,
--   observateurs.name AS Nom_groupe,
--   groupes.effectifs AS Nombre_eleves,
   --dico_structures.no_uai as Numero_UAI,
   dico_structures.name AS Nom_etablissement,
   dico_structures.zipcode AS Code_postal_etablissement,
   dico_structures.city AS Ville_etablissement,
   dico_academies.name as Academie,
   zones.latitude AS Latitude, 
   zones.longitude AS Longitude,
   zones.adresse AS Adresse,
   cast(right(zones_placettes.name,1) as INT)+1 as Numero_arbre,
   replace(cast(zones_placettes.environnement->'nom_espece' as varchar), '"', '') as Espece_arbre,
   cast(replace(cast(zones_placettes.environnement->'circonference_arbre' as varchar), '"', '') as int) as Circonference_arbre,
   cast(observations_abondances.quadrat as INT)+1 as Numero_quadrat,
   observations_abondances.nom_espece AS taxon,
   observations_abondances.speciefk as speciepk,
   observations_abondances.abondance as taxon_count,
   observations_abondances.infos_complementaires->'abondances_details'->'face_0' as Abondance_face_Nord,
   observations_abondances.infos_complementaires->'abondances_details'->'face_1' as Abondance_face_Est,
   observations_abondances.infos_complementaires->'abondances_details'->'face_2' as Abondance_face_Sud,
   observations_abondances.infos_complementaires->'abondances_details'->'face_3' as Abondance_face_Ouest,
   -- Informations issues de la saisie des donn?es
   --Pour arbre ombrage : on commence par transformer le JSON en VARCHAR puis on enl?ve les guillements et enfin on transforme en integer pour faire la correspondance avec le dico_label
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=cast(replace(cast(zones_placettes.environnement->'ombre_face' as varchar),'"','' ) as int)
   AND t='saisie_lichen_ombre_face'
   AND champ='option') AS Arbre_ombrage,
   (case cast(zones_placettes.environnement->'ombre_face_orientation' -> '0' -> 'value' as bool) WHEN TRUE THEN 'Oui' ELSE 'Non' END) as Ombre_face_Nord,
   (case cast(zones_placettes.environnement->'ombre_face_orientation' -> '1' -> 'value' as bool) WHEN TRUE THEN 'Oui' ELSE 'Non' END) as Ombre_face_Est,
   (case cast(zones_placettes.environnement->'ombre_face_orientation' -> '2' -> 'value' as bool) WHEN TRUE THEN 'Oui' ELSE 'Non' END) as Ombre_face_Sud,
   (case cast(zones_placettes.environnement->'ombre_face_orientation' -> '3' -> 'value' as bool) WHEN TRUE THEN 'Oui' ELSE 'Non' END) as Ombre_face_Ouest,
   
   -- Informations issues de la description de la zone d'observation
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_lichen.zone_pietonne
   AND t='zones_description_lichen'
   AND champ='zone_pietonne') AS Zone_pietonne,
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_lichen.espace_type
   AND t='zones_description_lichen'
   AND champ='espace_type') AS type_espace,
   (SELECT label
   FROM dico_labels
   WHERE dico_labels.valeur=zones_description_lichen.frequentation_automobile
   AND t='zones_description_lichen'
   AND champ='frequentation_automobile') AS frequentation_automobile,
   observations_abondances.photo_taxon as Photo_taxon,
   replace(replace(observations.notes,chr(10),' '),chr(13),' ') AS Notes

FROM observations
LEFT JOIN observateurs ON observations.observateurfk = observateurs.observateurpk
LEFT JOIN groupes ON groupes.groupepk = observateurs.groupefk
LEFT JOIN users ON users.userpk=groupes.userfk 
LEFT JOIN observations_abondances on observations_abondances.observationfk =observations.observationpk
left join zones_changes on observations.zonechangefk = zones_changes.zonechangepk
left join zones on zones.zonepk = zones_changes.zonefk
left join zones_placettes on zones_placettes.placettepk = observations_abondances.placettefk
left join zones_description_lichen on zones_description_lichen.zonechangefk = zones_changes.zonechangepk
left join dico_structures on dico_structures.structurepk = groupes.structurefk 
left join dico_academies on dico_academies.academiepk = dico_structures.academiefk 


WHERE 
observations.protocolefk = 14
--and dico_academies.name in ('LILLE', 'AMIENS')
and users.email not in('vne5@yopmail.com')
--AND dico_etablissements.zipcode LIKE '93%'
--and observations_abondances.abondance > 0


