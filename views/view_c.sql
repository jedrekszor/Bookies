create or replace view view_c as

select row_number() over 
       (order by (s.won*3) + s.draw desc, s.played, s.won desc) as place, 
       t.name, 
       s.played, 
       s.won, 
       s.draw, 
       s.lost, 
       (s.won*3) + s.draw as points 

from teams t, team_statistics s
where t.team_id = s.team_id and s.competition_id = (
  select competition_id
  from competitions
  where name = 'Liga NOS' and season = '2019/20');