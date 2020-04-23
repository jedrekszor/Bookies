create or replace package random_generating is
  procedure events_teams_id;
end random_generating;

create or replace package body random_generating is

  procedure events_teams_id is
  
    cursor c_all_events is
      select *
      from events;
      
    v_random number;
    v_game_id events.game_id%type;
    
    v_A_id teams.team_id%type;
    v_B_id teams.team_id%Type;
    
    begin
      for curr in c_all_events
      loop
        
        select A_team_id, B_team_id
        into v_A_id, v_B_id
        from games
        where game_id = curr.game_id;
        
        SELECT TRUNC(DBMS_RANDOM.VALUE(1, 3))
        into v_random
        FROM DUAL;
        
        if v_random = 1 then
          update events
          set team_id = v_A_id
          where event_id = curr.event_id;
        else
          update events
          set team_id = v_B_id
          where event_id = curr.event_id;
        end if;
                
      end loop;
      
    end events_teams_id;
end random_generating;

