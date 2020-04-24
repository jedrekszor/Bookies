create or replace view view_g as
select * from(
  select g.match_date, g.A_team_id, g.B_team_id, (
    select value
    from odds
    where game_id = g.game_id and odd_type_id = 1) as odd_1, (
    select value
    from odds
    where game_id = g.game_id and odd_type_id = 2) as odd_x, (
    select value
    from odds
    where game_id = g.game_id and odd_type_id = 3) as odd_2
  from games g
  where g.match_date > sysdate + 1/24
  order by g.match_date)
where rownum <= 11;