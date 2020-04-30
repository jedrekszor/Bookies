--TEAMS
create table teams(
team_id varchar(10) not null,
name varchar(50) not null,
sport varchar(30),
stadium varchar(100),
country varchar(50),
constraint pk_teams_team_id primary key (team_id)
);