create table competitions(
competition_id varchar(20),
name varchar(30),
sport varchar(30),
country varchar(30),
season varchar(30),
start_date date,
end_date date,
constraint pk_competitions primary key (competition_id)
);

create table phases(
phase_id number not null,
competition_id varchar(20) not null,
phase_name varchar(30) not null,
start_date date not null,
end_date date not null,
constraint pk_phases primary key (phase_id),
constraint fk_phases_competition_id foreign key (competition_id) references competitions (competition_id)
);
