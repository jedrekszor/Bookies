create table teams(
team_id varchar(10) not null,
name varchar(50) not null,
stadium varchar(50),
constraint pk_teams_team_id primary key (team_id)
);

create table future_games(
game_id int not null,
A_team_id varchar(10) not null,
B_team_id varchar(10) not null,
match_date date not null,
stadium varchar(50),
constraint pk_future_games_game_id primary key (game_id),
constraint fk_future_games_A_team_id foreign key (A_team_id) references teams (team_id),
constraint fk_future_games_B_team_id foreign key (B_team_id) references teams (team_id)
);

create table team_statistics(
team_id varchar(10) not null,
played int,
won int,
draw int,
lost int,
constraint pk_team_statistics_team_id primary key (team_id),
constraint fk_team_statistics_team_id foreign key (team_id) references teams (team_id)
);

create table history_games(
A_team_id varchar(10) not null,
B_team_id varchar(10) not null,
match_date date not null,
stadium varchar(50) not null,
winner_id varchar(10),
constraint pk_history_games_id primary key (A_team_id, B_team_id),
constraint fk_history_games_A_team_id foreign key (A_team_id) references teams (team_id),
constraint fk_history_games_B_team_id foreign key (B_team_id) references teams (team_id),
constraint fk_history_games_winner_id foreign key (winner_id) references teams (team_id)
);

create table history_comparison(
A_team_id varchar(10) not null,
B_team_id varchar(10) not null,
matches_amount int,
A_won int,
draw int,
B_won int,
constraint pk_history_comparison_id primary key (A_team_id, B_team_id),
constraint fk_history_comp_A_team_id foreign key (A_team_id) references teams (team_id),
constraint fk_history_comp_B_team_id foreign key (B_team_id) references teams (team_id)
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
constraint fk_prob_B_A_team_id foreign key (A_team_id) references team_statistics (team_id),
constraint fk_prob_B_B_team_id foreign key (B_team_id) references team_statistics (team_id),
constraint fk_prob_B_prob_A_id foreign key (prob_A_id) references probability_A (prob_A_id)
);

create table odds(
game_id int not null,
A_win_odd float not null,
draw_odd float not null,
B_win_odd float not null,
constraint pk_odds_game_id primary key (game_id),
constraint fk_odds_game_id foreign key (game_id) references future_games (game_id)
);

create table recalculations(
game_id int not null,
placed_win_A float,
placed_draw float,
placed_win_B float,
placed_total float,
max_prize float,
result_prize_A float,
result_prize_draw float,
result_prize_B float,
constraint pk_recalculations_game_id primary key (game_id),
constraint fk_recalculations_game_id foreign key (game_id) references odds (game_id)
);

create table participants(
client_id int not null,
game_id int not null,
money_placed float not null,
bet_result varchar(1) not null,
constraint pk_participants_client_id primary key (client_id),
constraint fk_participants_game_id foreign key (game_id) references recalculations (game_id)
);

