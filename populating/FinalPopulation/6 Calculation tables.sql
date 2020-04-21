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