create trigger P2_TRIG_A2019156734
    after insert
    on BETS
    for each row
declare

    v_game_id   games.GAME_ID%type ;
    v_count     number := 0;
    v_odd_value number;
begin
    --         get game_id of bet and odd value
    select GAMES.GAME_ID, O2.VALUE
    into v_game_id, v_odd_value
    from GAMES
             join ODDS O2 on GAMES.GAME_ID = O2.GAME_ID
    where O2.ODD_ID = :new.odd_id;

--         check if record of current bet game exists
    select count(*)
    into v_count
    from CALC_TOTAL
             join GAMES G on CALC_TOTAL.GAME_ID = G.GAME_ID
             join ODDS O on G.GAME_ID = O.GAME_ID
    where O.ODD_ID = :new.odd_id;

--         if not, create new record
    if v_count = 0 then
        insert into CALC_TOTAL values (v_game_id, 0, 0);
    end if;

    update CALC_TOTAL
    set PLACED_TOTAL = PLACED_TOTAL + :new.money_placed,
        MAX_PRIZE    = MAX_PRIZE + (:new.money_placed * 0.7);
    --         max prize is 70% of total money placed on odd

end;
/

