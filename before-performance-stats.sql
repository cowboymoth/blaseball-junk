
WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP

with batting_events_plus AS(
	SELECT 	
		pl.player_name, 
		te.nickname, 
		SUM(b.hit) AS hits,
		SUM(b.at_bat) AS at_bats,
		SUM(b.home_run) AS home_runs,
		SUM(b.runs_batted_in) AS rbis,
		SUM(b.walk) AS walks,
		SUM(b.hbp) AS hbp,
		SUM(b.sacrifice_fly) AS sac_flys,
		SUM(b.total_bases) AS total_bases,
		SUM(r.was_base_stolen) AS stolen_bases,
		SUM(r.was_caught_stealing) AS caught_stealing
		
	FROM data.batting_stats_all_events b
	INNER JOIN data.running_stats_all_events r ON b.player_id = r.player_id
	INNER JOIN data.players pl ON b.player_id = pl.player_id AND pl.valid_until is NULL
	INNER JOIN data.teams te ON te.team_id = b.batter_team_id AND te.valid_until is NULL
WHERE b.season=6 -- EDIT HERE! remember to zero index ; season 1=0, season 2=1, etc.
AND b.day<50 -- EDIT HERE! also zero-indexed
AND is_haunting=0 
GROUP BY pl.player_name, te.nickname )

SELECT * FROM
batting_events_plus bep

WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP
