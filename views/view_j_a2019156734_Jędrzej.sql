--Top clients with the highest wim ratio

create or replace view view_j_a2019156734 as

select c.client_id, round(p.total_wins / b.total_bets * 100,2) win_ratio, c.phone_no, c.id_number
from clients c,
    (
      select b.client_id as b_client_id, count(b.bet_id) as total_bets
      from bets b
      group by b.client_id
    ) b,
    (
      select p.client_id as p_client_id, count(p.payout_id) as total_wins
      from payouts p
      group by p.client_id
    ) p
where c.client_id = b.b_client_id and c.client_id = p.p_client_id and
      round(p.total_wins / b.total_bets * 100,2) >= 70
order by round(p.total_wins / b.total_bets * 100,2) desc;