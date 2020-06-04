create trigger P1_TRIG_A2019156557
    before insert
    on BETS
    for each row
declare
    v_game_id     games.GAME_ID%type;
    v_odd_type_id odds.odd_type_id%type;
    v_calc_id     number := 0;
--             operands
    v_count       number := 0;
--             values
    v_odd_value   number;
begin
    --         get game_id of bet and odd value
    select GAMES.GAME_ID, O2.VALUE, O2.ODD_TYPE_ID
    into v_game_id, v_odd_value, v_odd_type_id
    from GAMES
             join ODDS O2 on GAMES.GAME_ID = O2.GAME_ID
    where O2.ODD_ID = :new.odd_id;

    --         check if record of current bet game exists
    select count(*)
    into v_count
    from CALC_TYPE_GAME
             join GAMES G on CALC_TYPE_GAME.GAME_ID = G.GAME_ID
             join ODDS O on G.GAME_ID = O.GAME_ID
    where O.ODD_ID = :new.odd_id
      and CALC_TYPE_GAME.ODD_TYPE_ID = v_odd_type_id;
    --
--         if not, create new record
    if v_count = 0 then

        select coalesce(max(calc_id), 0)
        into v_calc_id
        from calc_type_game;
        v_calc_id := v_calc_id + 1;

        insert into CALC_TYPE_GAME values (v_calc_id, v_game_id, v_odd_type_id, 0, 0);
    end if;

    update CALC_TYPE_GAME
    set PLACED       = PLACED + :new.money_placed,
        RESULT_PRIZE = RESULT_PRIZE + (:new.money_placed * v_odd_value),

        --         max prize is total money placed on odd * this odd_value
        ODD_TYPE_ID  = v_odd_type_id
    where GAME_ID = v_game_id
      and ODD_TYPE_ID = v_odd_type_id;

end;
/

