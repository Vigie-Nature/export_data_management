	SELECT
		created,
        year(created) as annee,
        userId as user_id,
        ownerId as owner_id,
        resourceId as resource_id,
        resourceType as resource_type,
        sysComment as sys_comment,
        typeId,
        comment
	FROM
		spgp.spipoll_social_events