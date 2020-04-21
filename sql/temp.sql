insert into competitions values('LN', 'Liga NOS', 'Football', 'Portugal', '2019/20', to_date('09/08/2019', 'dd/mm/yyyy'), to_date('17/05/2020', 'dd/mm/yyyy'));

create or replace procedure game_add(p_phase games.phase_id%type, p_A_team games.A_team_id%type, p_B_team games.B_team_id%type, p_match_date games.match_date%type)
is
v_id games.game_id%type;
v_stadium games.stadium%type;
begin
  select max(game_id)+1 into v_id from games;
  select t.stadium into v_stadium from teams t where t.team_id = p_A_team;
  insert into games values (v_id, p_phase, p_A_team, p_B_team, p_match_date, v_stadium);
end;


drop table bets;
drop table calc_total;
drop table calc_type_game;
drop table clients;
drop table competitions;
drop table event_type;
drop table events;
drop table games;
drop table history_comparison;
drop table history_games;
drop table history_odds;
drop table odd_type;
drop table odds;
drop table payout;
drop table phases;
drop table probability_A;
drop table probability_B;
drop table team_statistics;
drop table teams;






create or replace package calculations as
  procedure add_to_team_stats;
  procedure calculate_stats;
end calculations;



create or replace package body calculations as
  procedure add_to_team_stats
  is
  v_team_A_id team_statistics.team_id%type;
  v_team_B_id team_statistics.team_id%type;
  v_competition_id team_statistics.competition_id%type;
  v_count number := 0;
  cursor c_history_games is
    select * from HISTORY_GAMES;
  begin
    for record in c_history_games
    loop
      select h.A_team_id, h.B_team_id, p.competition_id
      into v_team_A_id, v_team_B_id, v_competition_id from history_games h, phases p
      where h.phase_id = p.phase_id and h.game_id = record.game_id;
      
      select count(*)
      into v_count from team_statistics
      where team_id = v_team_A_id and competition_id = v_competition_id;
      
      if v_count = 0 then
        insert into team_statistics values(v_team_A_id, v_competition_id, 0, 0, 0, 0);
      end if;
      
      select count(*)
      into v_count from team_statistics
      where team_id = v_team_B_id and competition_id = v_competition_id;
      
      if v_count = 0 then
        insert into team_statistics values(v_team_B_id, v_competition_id, 0, 0, 0, 0);
      end if;
      
    end loop;
  end add_to_team_stats;


  procedure calculate_stats
  is
  v_team_A_id team_statistics.team_id%type;
  v_team_B_id team_statistics.team_id%type;
  v_competition_id team_statistics.competition_id%type;
  v_current_A_stats team_statistics%rowtype;
  v_current_B_stats team_statistics%rowtype;
  cursor c_history_games is
    select * from HISTORY_GAMES;
  begin
    for record in c_history_games
    loop
      select h.A_team_id, h.B_team_id, p.competition_id
      into v_team_A_id, v_team_B_id, v_competition_id from history_games h, phases p
      where h.phase_id = p.phase_id and h.game_id = record.game_id;
      
      select *
      into v_current_A_stats from team_statistics
      where team_id = v_team_A_id and competition_id = v_competition_id;
      
      select *
      into v_current_B_stats from team_statistics
      where team_id = v_team_B_id and competition_id = v_competition_id;
      
      dbms_output.put_line(record.A_goals || record.B_goals);
      
      if record.A_goals > record.B_goals then
        update team_statistics
        set played = v_current_A_stats.played + 1,
            won = v_current_A_stats.won + 1
        where team_id = v_team_A_id and competition_id = v_competition_id;
        update team_statistics
        set played = v_current_B_stats.played + 1,
            lost = v_current_B_stats.lost + 1
        where team_id = v_team_B_id and competition_id = v_competition_id;
        
      elsif record.A_goals < record.b_goals then
        update team_statistics
        set played = v_current_A_stats.played + 1,
            lost = v_current_A_stats.lost + 1
        where team_id = v_team_A_id and competition_id = v_competition_id;
        update team_statistics
        set played = v_current_B_stats.played + 1,
            won = v_current_B_stats.won + 1
        where team_id = v_team_B_id and competition_id = v_competition_id;
        
      elsif record.A_goals = record.b_goals then
        update team_statistics
        set played = v_current_A_stats.played + 1,
            draw = v_current_A_stats.draw + 1
        where team_id = v_team_A_id and competition_id = v_competition_id;
        
        update team_statistics
        set played = v_current_B_stats.played + 1,
            draw = v_current_B_stats.draw + 1
        where team_id = v_team_B_id and competition_id = v_competition_id;
      end if;
      
    end loop;
  end calculate_stats;
end calculations;


execute calculations.calculate_probability_B;



set serveroutput on;








