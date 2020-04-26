--VISTA_B that, for each of the games of the last matchday of the current season of 
--the national football championship of Liga Nos, show the date of the game, 
--the visited and visiting team, the total amount bet and the total amount of 
--prizes paid to the bettors who won the respective bets. Sort the results by the total stake.

--DataJogo equipaVisitada equipaVisitante TotalApostado totalPremios
----------- -------------- --------------- -------------- ------------

create or replace view view_b as

select match_date, 
       A_team_id,
       B_team_id,
       odds_sums.sum_bets,
       payouts_sums.sum_payouts
       
       
from games g,
  (
--    get games_id with the total money bet on that game
    select o.game_id as o_game_id, 
           round(sum(b.money_placed),2) as sum_bets
    from odds o
    left outer join bets b on o.odd_id = b.odd_id     
    group by o.game_id
    order by o.game_id desc
  ) odds_sums,
  
  (
--    get games_id with the total prizes paid for that game
    select o.game_id as o_game_id, 
           round(sum(p.money),2) as sum_payouts
    from odds o
    left outer join bets b on o.odd_id = b.odd_id  
    left outer join payouts p on b.bet_id = p.bet_id
    group by o.game_id
  ) payouts_sums

--      connect odds and prizes by the same game_id
where g.game_id = odds_sums.o_game_id and
      g.game_id = payouts_sums.o_game_id and
      
--      there are some games the money is not bet on
      odds_sums.sum_bets is not null and
      payouts_sums.sum_payouts is not null and
      
--      select only those matches with the latest match_date
      match_date = (
                    select max(match_date)
                    from games);