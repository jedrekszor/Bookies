create table history_comparison(
A_team_id varchar(10) not null,
B_team_id varchar(10) not null,
matches_amount int not null,
A_won int not null,
draw int not null,
B_won int not null,
constraint pk_history_comparison primary key (A_team_id, B_team_id),
constraint fk_history_comp_A_team_id foreign key (A_team_id) references teams (team_id),
constraint fk_history_comp_B_team_id foreign key (B_team_id) references teams (team_id)
);

create table team_statistics(
team_id varchar(10) not null,
competition_id varchar(20) not null,
played int not null,
won int not null,
draw int not null,
lost int not null,
constraint pk_team_statistics primary key (team_id, competition_id),
constraint fk_team_stats_team_id foreign key (team_id) references teams (team_id),
constraint fk_team_stats_competition_id foreign key (competition_id) references competitions (competition_id)
);

create table probability_A(
prob_A_id varchar(20) not null,
A_team_id varchar(10) not null,
B_team_id varchar(10) not null,
A_win_chance float not null,
draw_chance float not null,
B_win_chance float not null,
constraint pk_prob_A_id primary key (prob_A_id),
constraint fk_prob_A_A_team_id foreign key (A_team_id, B_team_id) references history_comparison (A_team_id, B_team_id)
);

create table probability_B(
A_team_id varchar(10) not null,
B_team_id varchar(10) not null,
A_win_chance float not null,
draw_chance float not null,
B_win_chance float not null,
prob_A_id varchar(20) not null,
constraint pk_prob_B_id primary key (A_team_id, B_team_id),
constraint fk_prob_B_prob_A_id foreign key (prob_A_id) references probability_A (prob_A_id)
);

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

create table clients(
client_id number not null,
name varchar(20) not null,
surname varchar(20) not null,
id_number varchar(20) not null,
phone_no varchar(15) not null,
balance float not null,
constraint pk_clients primary key (client_id)
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
