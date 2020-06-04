create trigger L_FILL_BET
    before insert
    on BETS
    for each row
declare
    v_bet_date    timestamp;
    v_odd_value   odds.value%type;
    v_odd_type    odds.odd_type_id% type;
    v_probability number;
    v_A_team_id   teams.team_id%type;
    v_B_team_id   teams.team_id%type;
begin
    --     assign sysdate to new inserted row
    v_bet_date := sysdate;
    :new.BET_DATE := v_bet_date;

-- get value and type of odd by odd_id
    select VALUE, ODD_TYPE_ID
    into v_odd_value, v_odd_type
    from ODDS
    where ODD_ID = :new.ODD_ID;

--     get teams ids of the game with particular odd
    select A_TEAM_ID, B_TEAM_ID
    into v_A_team_id, v_B_team_id
    from games g
             join ODDS O on O.GAME_ID = g.GAME_ID
    where O.ODD_ID = :new.ODD_ID;

--     select probability to win depending on odd type
    select case v_odd_type
               when 1 then A_WIN_CHANCE
               when 2 then DRAW_CHANCE
               when 3 then B_WIN_CHANCE end
    into v_probability
    from PROBABILITY_B
    where A_TEAM_ID = v_A_team_id and B_TEAM_ID = v_B_team_id
       or B_TEAM_ID = v_A_team_id and A_TEAM_ID = v_B_team_id;

    --     display data
--     DBMS_OUTPUT.PUT_LINE('date: ' || v_bet_date);
--     DBMS_OUTPUT.PUT_LINE('value: ' || v_odd_value);
--     DBMS_OUTPUT.PUT_LINE('prob: ' || v_probability);
end;
/

