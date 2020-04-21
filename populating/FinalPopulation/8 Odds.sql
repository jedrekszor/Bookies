create table odd_type(
odd_type_id number not null,
name varchar(30) not null,
constraint pk_odd_type primary key (odd_type_id)
);

insert into odd_type values(1, 'team A wins');
insert into odd_type values(2, 'draw');
insert into odd_type values(3, 'team B wins');