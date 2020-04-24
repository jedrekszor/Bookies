create or replace view view_b as

select game_id, 
        odds_sums.sum_bets,
        payouts_sums.sum_payouts
        
from history_games g,
  (
    select o.game_id as o_game_id, 
           round(sum(b.money_placed),2) as sum_bets
    from odds o
    left outer join bets b on o.odd_id = b.odd_id     
    group by o.game_id
    order by o.game_id desc
  ) odds_sums,
  
  (
    select o.game_id as o_game_id, 
           round(sum(p.money),2) as sum_payouts
    from odds o
    left outer join bets b on o.odd_id = b.odd_id  
    left outer join payouts p on b.bet_id = p.bet_id
    group by o.game_id
    order by o.game_id desc
  ) payouts_sums

where g.game_id = odds_sums.o_game_id and
      g.game_id = payouts_sums.o_game_id and
      odds_sums.sum_bets is not null and
      payouts_sums.sum_payouts is not null;