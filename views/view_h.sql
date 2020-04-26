create or replace view view_h as

select t.name, max(o.value) as maximum
from teams t, odds o
where (o.odd_type_id = 1 and o.game_id in (
  select game_id
  from history_games
  where (A_team_id = t.team_id))) or 
(o.odd_type_id = 3 and o.game_id in (
  select game_id
  from history_games
  where (B_team_id = t.team_id)))
group by t.name;