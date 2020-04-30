create table odd_type(
odd_type_id number not null,
name varchar(30) not null,
constraint pk_odd_type primary key (odd_type_id)
);

insert into odd_type values(1, 'team A wins');
insert into odd_type values(2, 'draw');
insert into odd_type values(3, 'team B wins');

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


