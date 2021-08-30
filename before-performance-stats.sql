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
		SUM(b.total_bases) AS total_bases
		
	FROM data.batting_stats_all_events b
	INNER JOIN data.players pl ON b.player_id = pl.player_id AND pl.valid_until is NULL
	INNER JOIN data.teams te ON te.team_id = b.batter_team_id AND te.valid_until is NULL
--------------------------------------------------------------------------------------------
-- EDIT HERE! Remember season and day are zero indexed so season 1=0, season 2=1, etc.
WHERE b.season=6
AND b.day<=32
AND is_haunting=0 
GROUP BY pl.player_name, te.nickname 
ORDER BY te.nickname, pl.player_name ),
--------------------------------------------------------------------------------------------
player_stats AS (
	SELECT
		player_name,
		nickname,
		walks,
		hits,
		home_runs,
		rbis,
		ROUND((hits*1./at_bats),3) AS batting_average,
		ROUND(((hits+walks+hbp)*1./(at_bats+walks+hbp)),3) AS on_base_pct,
		ROUND((total_bases*1./at_bats),3) AS slugging_pct
	FROM batting_events_plus bep)
SELECT * FROM 
player_stats
