create table calc_type_game(
calc_id number not null,
game_id number not null,
odd_type_id number not null,
result_prize float not null,
placed float not null,
constraint pk_calc_type_game primary key (calc_id),
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