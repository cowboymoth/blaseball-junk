WITH league_OPS AS (
	SELECT
		(SUM(total_bases)/SUM(at_bats))+((SUM(hits)+SUM(walks)+SUM(hit_by_pitches))/(SUM(at_bats)+SUM(walks)+SUM(hit_by_pitches)+SUM(sacrifice_flies))) as on_base_slg,
		season
		FROM data.batting_stats_player_season p
GROUP BY season
)
SELECT ranked_ops.* from
	(SELECT
		p.player_name,
		p.season+1 AS season, 
		p.plate_appearances,
		TRUNC(p.on_base_slugging/lg.on_base_slg * 100, 0) AS ops_plus,
		rank() OVER (PARTITION BY p.player_name ORDER BY (p.on_base_slugging/lg.on_base_slg) DESC)
	FROM data.batting_stats_player_season p
	JOIN league_OPS lg ON p.season = lg.season
	WHERE team_id = '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5'
	AND plate_appearances>100
	ORDER BY ops_plus desc) ranked_ops
WHERE rank=1
