create table odd_type(
odd_type_id number not null,
name varchar(30) not null,
constraint pk_odd_type primary key (odd_type_id)
);

create table odds(
odd_id number not null,
game_id number not null,
odd_type_id number not null,
value float not null,
odd_date date,
constraint pk_odds primary key (odd_id),
constraint fk_odds_game_id foreign key (game_id) references games (game_id),
constraint fk_odds_odd_type_id foreign key (odd_type_id) references odd_type (odd_type_id)
);

create table history_odds(
odd_id number not null,
game_id number not null,
odd_type_id number not null,
value float not null,
odd_date date,
constraint pk_history_odds primary key (odd_id)
);

create table calc_type_game(
game_id number not null,
odd_type_id number not null,
result_prize float not null,
placed float not null,
constraint pk_calc_type_game primary key (game_id, odd_type_id),
constraint fk_calc_type_game_game_id foreign key (game_id) references games (game_id),
constraint fk_calc_type_game_odd_type_id foreign key (odd_type_id) references odd_type (odd_type_id)
);

create table calc_total(
game_id number not null,
placed_total float not null,
max_prize float not null,
constraint pk_calc_total primary key (game_id),
constraint fk_calc_total_game_id foreign key (game_id) references games (game_id)
);

create table bets(
bet_id number not null,
client_id number not null,
odd_id number not null,
money_placed float not null,
odd_value float not null,
constraint pk_bets primary key (bet_id),
constraint fk_bets_client_id foreign key (client_id) references clients (client_id),
constraint fk_bets_odd_id foreign key (odd_id) references odds (odd_id)
);

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
