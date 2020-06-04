create trigger J_UPDATE_PAYMENTS_BALANCE
    after insert
    on PAYOUTS
    for each row
declare
begin
    update CLIENTS set BALANCE = BALANCE + :new.money where CLIENT_ID = :new.client_id;
end;
/

