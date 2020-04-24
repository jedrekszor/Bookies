create or replace view view_d as

select * from(
  select g.match_date, g.A_team_id as visited, B_team_id as visiting, sum(b.money_placed) as bets, count(o.game_id) as bettors
  from bets b, odds o, games g
  where o.odd_id = b.odd_id and o.game_id = g.game_id
  group by g.match_date, g.A_team_id, B_team_id
  order by bets desc)
where rownum <= 11;