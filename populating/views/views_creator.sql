CREATE OR REPLACE VIEW view_A AS
  select hg.MATCH_DATE, hg.A_TEAM_ID, hg.B_TEAM_ID
  from history_games hg
  inner join phases p on hg.phase_id = p.phase_id 
  where p.competition_id = 'LN';