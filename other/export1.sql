--------------------------------------------------------
--  File created - Tuesday-April-21-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body CALCULATIONS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "AABD"."CALCULATIONS" AS

  procedure match_comparison AS
    
    cursor c_games_only is
      select *
      from history_games;
      
    v_A_team_id teams.team_id%type;
    v_B_team_id teams.team_id%type;
    
    v_temp_A_team_id teams.team_id%type;
    v_temp_B_team_id teams.team_id%type;
    
    v_result varchar2(20);
    
    v_A_win number;
    v_draw number;
    v_B_win number;
      
  BEGIN
      FOR curr_game IN c_games_only LOOP
          BEGIN
            
  --          FIND PAIR OF TEAMS -> IF FOUND update_record IF NOT EXCEPTION WILL OCCUR
            select A_team_id, B_team_id
            into v_temp_A_team_id, v_temp_B_team_id
            from history_comparison
            where 
              A_team_id = curr_game.A_team_id and
              B_team_id = curr_game.B_team_id
              or
              A_team_id = curr_game.B_team_id and
              B_team_id = curr_game.A_team_id;
              
              goto update_record;        
                
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               goto insert_record;
         END;
  
        <<insert_record>>
  --      INSERT EMPTY RECORD WITH PAIR OF TEAMS
        insert into history_comparison 
        values (curr_game.A_team_id, curr_game.B_team_id, 0, 0, 0, 0);
        
  --      SET FLAGS WITH ORDER (later used if there is no reversed direction of teams id)
        v_temp_A_team_id := curr_game.A_team_id;
        v_temp_B_team_id := curr_game.B_team_id;
        
        goto update_record;
        
        <<update_record>> 
        
  --      FUNCTION WILL RETURN A, B, or 0 DEPENDING WHO WON
        v_result := CHECK_MATCH_RESULT(
          curr_game.A_team_id,
          curr_game.A_goals,
          curr_game.B_team_id,
          curr_game.B_goals);
          
          v_A_win := 0;
          v_draw := 0;
          v_B_win := 0;
        
  --      CHECK IF IS NORMAL ORDER
        if curr_game.A_team_id = v_temp_A_team_id 
        and curr_game.B_team_id = v_temp_B_team_id then
        
  --        some
          if v_result = 'A' then
            v_A_win := 1;
          elsif v_result = 'B' then
            v_B_win := 1;
          else
            v_draw := 1;
          end if;
          
                else
  --      IF DIRECTION IS CHANGED TREAC TEAM A AS B AND VICE VERSA
  --      some
          if v_result = 'A' then
            v_B_win := 1;
          elsif v_result = 'B' then
            v_A_win := 1;
          else
            v_draw := 1;
          end if;
        
        end if;
        
--      UPDATE TEAMS STATISTICS
      update history_comparison
      set matches_amount = matches_amount + 1,
          A_won = A_won + v_A_win,
          B_won = B_won + v_B_win,
          draw = draw + v_draw
          
      where A_team_id = curr_game.A_team_id and
            B_team_id = curr_game.B_team_id
            or
            A_team_id = curr_game.B_team_id and
            B_team_id = curr_game.A_team_id;
                  
    END LOOP;
  END match_comparison;
  
  FUNCTION check_match_result (
    P_A_TEAM_ID IN VARCHAR2,
    A_score IN Number,
    P_B_TEAM_ID IN VARCHAR2,
    B_score In number
    ) RETURN VARCHAR2 AS 

    v_result varchar(20);
    BEGIN
  
    if A_score > B_score then
      v_result := 'A';
    elsif A_score < B_score then
      v_result := 'B';
    else
      v_result := '0';
    end if;
    
    RETURN v_result;
  END CHECK_MATCH_RESULT;
  
  procedure calculate_probability_A is
  
    v_max number := 0;
    v_id number := 0;
    v_count number := 0;
    v_A_win_prob float := 0;
    v_draw_prob float := 0;
    v_B_win_prob float := 0;
    
  cursor c_history_comparison is
    select * from history_comparison;
    
  begin    
    for record in c_history_comparison   
    loop
    
      v_id := v_id + 1;
    
      select count(*)
      into v_count from probability_A
      where A_team_id = record.A_team_id and B_team_id = record.B_team_id;
      
      v_A_win_prob := (record.A_won/(record.matches_amount+1))*100;
      v_draw_prob := (record.draw/(record.matches_amount+1))*100;
      v_B_win_prob := (record.B_won/(record.matches_amount+1))*100;
      
      if v_count = 0 then
        insert into probability_A
        values (v_id, record.A_team_id, record.B_team_id, v_A_win_prob, v_draw_prob, v_B_win_prob);
      else
        update probability_A
        set A_win_chance = v_A_win_prob,
            draw_chance = v_draw_prob,
            B_win_chance = v_B_win_prob
        where A_team_id = record.A_team_id and B_team_id = record.B_team_id;
      end if;
    end loop;
  end calculate_probability_A;
  
END CALCULATIONS;

/
