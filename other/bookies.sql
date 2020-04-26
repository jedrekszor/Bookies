  CREATE OR REPLACE VIEW "VIEW1" AS 
  select hg.phase_id as Round, 
         hg.match_date as MatchDate, 
         hg.A_team_id as Hosts, 
         hg.B_team_id as Visitors, 
         
        CASE
        WHEN hg.A_goals > hg.B_goals THEN '1'
        WHEN hg.A_goals < hg.B_goals THEN '2'
        WHEN hg.A_goals = hg.B_goals THEN 'x'
        ELSE ''
        END as match_result
       
  from history_games hg
  join phases p
  on hg.phase_id = p.phase_id
  where p.competition_id = 'LN';