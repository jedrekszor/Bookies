create table payouts(
payout_id number not null,
money float not null,
payout_date date not null,
client_id number not null,
bet_id number not null,
constraint pk_payouts primary key (payout_id),
constraint fk_payouts_client_id foreign key (client_id) references clients (client_id),
constraint fk_payouts_bet_id foreign key (bet_id) references bets (bet_id)
);

create table bets(
bet_id number not null,
client_id number not null,
odd_id number not null,
money_placed float not null,
constraint pk_bets primary key (bet_id),
constraint fk_bets_client_id foreign key (client_id) references clients (client_id),
constraint fk_bets_odd_id foreign key (odd_id) references odds (odd_id)
);