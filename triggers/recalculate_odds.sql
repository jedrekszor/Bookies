create or replace trigger t_odds_recalculate_on_bet 
after insert on bets
for each row

declare

v_game_id games.game_id%type;
v_all_sum_bet bets.money_placed%type;

v_sum_on_one_game bets.money_placed%type;
v_odd_type_id odd_type.odd_type_id%type;

v_total_prize calc_type_game.result_prize%type;
v_total_match_prize calc_type_game.placed%type;

begin

--  get game_id and odd_type_id of bet odd
  select game_id, odd_type_id
  into v_game_id, v_odd_type_id
  from odds
  where odd_id = :NEW.odd_id;

--  get total sum placed on the game on the same result
  select coalesce(sum(b.money_placed),0)
  into v_sum_on_one_game
  from bets b
  join odds o on b.odd_id = o.odd_id
  where o.game_id = v_game_id and o.odd_type_id = odd_type_id
  group by o.game_id
  order by o.game_id;
  
--  get total prize for the game_id nad odd_type
  select result_prize
  into v_total_prize
  from calc_type_game
  where game_id = v_game_id and odd_type_id = 1;
  
  select sum(c.placed)*0.7
  into v_total_match_prize
  from calc_type_game c
  where c.game_id = v_game_id;
  
--  the amount of a bet on a game result exceeds € 100
  if :NEW.money_placed > 100 then
    odd_ctrl.recalculate_odd(v_game_id, v_odd_type_id);
  
--the amount of a bet on a result of the game is greater than 2% of the total amount bet on that result.
  elsif :NEW.money_placed > v_sum_on_one_game * 0.02 then
    odd_ctrl.recalculate_odd(v_game_id, v_odd_type_id);
  
--total Prize Result Match (r) ? Totoal Max Prize Match
  elsif v_total_prize > v_total_match_prize then
      odd_ctrl.recalculate_odd(v_game_id, v_odd_type_id);    
  end if;
  
end t_odds_recalculate_on_bet;


  


