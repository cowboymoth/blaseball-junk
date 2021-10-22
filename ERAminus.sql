WITH league_ERA AS (
	SELECT
		SUM(runs_allowed)/SUM(innings)*9 as earned_runs_avg,
		season
		FROM data.pitching_stats_player_season p
GROUP BY season
)
SELECT ranked_era.* from
	(SELECT
		p.player_name,
		p.season+1 AS season, 
		p.innings,
		TRUNC(p.earned_run_average/lg.earned_runs_avg*100, 1) AS era_minus,
		rank() OVER (PARTITION BY p.player_name ORDER BY (p.earned_run_average/lg.earned_runs_avg))
	FROM data.pitching_stats_player_season p
	JOIN league_ERA lg ON p.season = lg.season
	WHERE team_id ='9debc64f-74b7-4ae1-a4d6-fce0144b6ea5'
	AND innings>100
	ORDER BY era_minus) ranked_era
WHERE rank=1
