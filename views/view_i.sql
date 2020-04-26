create or replace view view_i as

select c.name,
       round(sum(b.money_placed),2) as money_placed, 
       round(sum(p.money),2) as money_won

from clients c
join bets b on c.client_id = b.client_id
join history_odds o on b.odd_id = o.odd_id
join history_games g on o.game_id = g.game_id
join payouts p on b.bet_id = p.bet_id

where g.match_date > add_months(match_date, -1 * 12)
group by c.client_id, c.name
having count(g.game_id) < (
                select count(game_id) * 0.1 as tenPercent
                from history_games
                where match_date > add_months(match_date, -1 * 12)
              ) and
            sum(b.money_placed) < sum(p.money)
order by money_won desc;