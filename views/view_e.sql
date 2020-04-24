create or replace view view_e as

select b.client_id, 
       c.name, 
       c.surname, 
       g.game_id,
       round(b.money_placed / game_total_sum.total_money * 100,2) as percentage
       
from history_games g
left outer join history_odds o on g.game_id = o.game_id
left outer join bets b on o.odd_id = b.odd_id
join clients c on b.client_id = c.client_id,
(
      select ga.game_id as ga_game_id, 
      coalesce(sum(b.money_placed),0) as total_money
      from history_games ga
      left outer join history_odds o on ga.game_id = o.game_id
      left outer join bets b on o.odd_id = b.odd_id
      left outer join clients c on b.client_id = c.client_id
      group by ga.game_id
      
      ) game_total_sum
    
where g.match_date > add_months(g.match_date, -2 * 12) and
      b.money_placed > game_total_sum.total_money * 0.1 and
      game_total_sum.ga_game_id = g.game_id
order by percentage asc;

