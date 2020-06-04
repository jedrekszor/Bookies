create trigger K_UPDATE_BET_BALANCE
    after insert
    on BETS
    for each row
declare
begin
    update CLIENTS set BALANCE = BALANCE - :new.money_placed where CLIENT_ID = :new.client_id;
end;
/
