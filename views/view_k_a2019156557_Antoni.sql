--list of top underdogs(team which have big odd - it is not supposed to win) which actually won the game.
--with the money won and name of that client

create or replace view view_k_a2019156557 as
  select *
  from (
          select round(o.value,2) as odd_value, 
                 round(p.money,2) as money_won,
                 p.client_id as true_fan,
          
          case when o.odd_type_id = 1
          then
          (
            Select t.name
            from teams t
            where t.team_id = g.A_team_id
          )
          else
          (
            Select t.name
            from teams t
            where t.team_id = g.B_team_id
          )  
          end as underdog
          
          from payouts p
          join bets b on p.bet_id = b.bet_id
          join history_odds o on b.odd_id = o.odd_id
          join history_games g on o.game_id = g.game_id
                  
          where o.odd_type_id = 1 or o.odd_type_id = 3
          order by o.value desc
        )
  where rownum <= 10;