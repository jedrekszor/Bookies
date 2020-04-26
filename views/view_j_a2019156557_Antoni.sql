--Players' percentage contribution in Company's pure income
--(How much money in percentage bettor left in company loosing)

create or replace view view_j_a2019156557 as

select c.client_id,
      round(
      (client_sum_bet.total - client_sum_payout.total) / 
      (
        (select sum(b.money_placed) from bets b) + 
        (select round(sum(p.money),2) from payouts p)
      ) * 100,2) as precetnage_contribution
      
from clients c,
    (
      select b.client_id as b_client_id, 
      sum(b.money_placed) as total
      from bets b
      group by b.client_id
    ) client_sum_bet,
    (
      select p.client_id as p_client_id, 
      round(sum(p.money),2) as total
      from payouts p
      group by p.client_id
    ) client_sum_payout 
    
where c.client_id = client_sum_bet.b_client_id and
      c.client_id = client_sum_payout.p_client_id
order by precetnage_contribution desc;



