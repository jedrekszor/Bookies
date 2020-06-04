create trigger M_UPDATE_ODDS
    after insert
    on BETS
    for each row
declare
    v_game_id           games.game_id%type;
    v_sum_on_one_game   CALC_TOTAL.PLACED_TOTAL%type;
    v_odd_type_id       odd_type.odd_type_id%type;
    v_total_prize       calc_type_game.result_prize%type;
    v_total_match_prize calc_type_game.placed%type;
    v_max_prize         CALC_TOTAL.MAX_PRIZE%type;
begin
    
    --  get game_id and odd_type_id of bet odd
    select game_id, odd_type_id
    into v_game_id, v_odd_type_id
    from odds
    where odd_id = :new.odd_id;
    --
--  get total prize for the game_id nad odd_type
    select PLACED_TOTAL
    into v_sum_on_one_game
    from CALC_TOTAL
    where GAME_ID = v_game_id;
    --
--  get total sum placed on the game on the same result
    select result_prize
    into v_total_prize
    from CALC_TYPE_GAME
    where game_id = v_game_id
      and odd_type_id = v_odd_type_id;
    --
--     get max prize on the game
    select MAX_PRIZE
    into v_max_prize
    from CALC_TOTAL
    where GAME_ID = v_game_id;
    --
--  the amount of a bet on a game result exceeds € 100
    if :new.money_placed > 100 or

        --the amount of a bet on a result of the game is greater than 2% of the total amount bet on that result.
       :new.money_placed > v_sum_on_one_game * 0.02 or

        --total Prize on match result > Total Max Prize Match
       v_total_prize >= v_total_match_prize then

        DBMS_OUTPUT.PUT_LINE('(!) recalculation');
        ODD_CTRL.RECALCULATE_ODD(v_game_id);
--             
    else
        DBMS_OUTPUT.PUT_LINE('(x) stays');
    end if;
end;
/

