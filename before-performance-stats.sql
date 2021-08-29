
WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP

with batting_events_plus AS(
	SELECT 	
		player_id, 
		batter_team_id, 
		SUM(hit) AS hits,
		SUM(at_bat) AS at_bats,
		SUM(home_run) AS home_runs,
		SUM(runs_batted_in) AS rbis
		
		FROM data.batting_stats_all_events
WHERE season=19 -- EDIT HERE! remember to zero index ; season 1=0, season 2=1, etc.
AND day<50 -- EDIT HERE! zero-indexed
AND is_haunting=0
GROUP BY player_id, batter_team_id )

SELECT * FROM
batting_events_plus

WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP
