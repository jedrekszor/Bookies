alter SESSION set NLS_TIMESTAMP_FORMAT = 'dd/mm/yyyy HH24:MI';
alter SESSION set NLS_DATE_FORMAT = 'dd/mm/yyyy';

create table history_games(
game_id number not null,
phase_id number not null,
A_team_id varchar(10) not null,
B_team_id varchar(10) not null,
match_date timestamp not null,
stadium varchar(50) not null,
A_goals number not null,
B_goals number not null,
constraint pk_history_games primary key (game_id),
constraint fk_history_games_game_id foreign key (game_id) references games (game_id)
);

create or replace trigger t_game_history_insert_stadium
before insert on history_games
for each row
begin
  if :NEW.stadium is null then
    select stadium
    into :NEW.stadium
    from teams
    where team_id = :NEW.A_team_id;
  end if;
end;

--day 1
INSERT INTO history_games VALUES(1,1,'POR','LFC','09/08/2019 20:30',null,0,0);
INSERT INTO history_games VALUES(2,1,'SC','FA','10/08/2019 16:30',null,0,2);
INSERT INTO history_games VALUES(3,1,'GV','PO','10/08/2019 19:00',null,2,1);
INSERT INTO history_games VALUES(4,1,'BEN','PF','10/08/2019 21:30',null,5,0);
INSERT INTO history_games VALUES(5,1,'BO','DA','11/08/2019 16:00',null,2,1);
INSERT INTO history_games VALUES(6,1,'MA','SCP','11/08/2019 18:30',null,1,1);
INSERT INTO history_games VALUES(7,1,'BR','MOR','11/08/2019 21:00',null,3,1);
INSERT INTO history_games VALUES(8,1,'VFC','TO','12/08/2019 20:15',null,0,0);
INSERT INTO history_games VALUES(9,1,'RA','VSE','08/09/2019 15:00',null,1,1);

--day 2
INSERT INTO history_games VALUES(10,2,'FA','RA','16/08/2019 20:30',null,1,0);
INSERT INTO history_games VALUES(11,2,'MOR','GV','17/08/2019 16:30',null,3,0);
INSERT INTO history_games VALUES(12,2,'LFC','BEN','17/08/2019 19:00',null,0,2);
INSERT INTO history_games VALUES(13,2,'PO','VFC','17/08/2019 21:30',null,4,0);
INSERT INTO history_games VALUES(14,2,'PF','SC','18/08/2019 16:00',null,0,1);
INSERT INTO history_games VALUES(15,2,'DA','MA','18/08/2019 16:00',null,3,1);
INSERT INTO history_games VALUES(16,2,'VSE','BO','18/08/2019 18:30',null,1,1);
INSERT INTO history_games VALUES(17,2,'SCP','BR','18/08/2019 21:00',null,2,1);
INSERT INTO history_games VALUES(18,2,'TO','POR','19/08/2019 20:15',null,1,2);

--day 3
INSERT INTO history_games VALUES(19,3,'VFC','MOR','23/08/2019 19:00',null,0,0);
INSERT INTO history_games VALUES(20,3,'RA','DA','23/08/2019 21:15',null,5,1);
INSERT INTO history_games VALUES(21,3,'BEN','PO','24/08/2019 19:00',null,0,2);
INSERT INTO history_games VALUES(22,3,'BO','PF','24/08/2019 21:30',null,1,1);
INSERT INTO history_games VALUES(23,3,'MA','TO','25/08/2019 16:00',null,2,3);
INSERT INTO history_games VALUES(24,3,'SC','LFC','25/08/2019 16:00',null,0,0);
INSERT INTO history_games VALUES(25,3,'POR','SCP','25/08/2019 18:30',null,1,3);
INSERT INTO history_games VALUES(26,3,'GV','BR','25/08/2019 20:30',null,1,1);
INSERT INTO history_games VALUES(27,3,'VSE','FA','25/08/2019 21:00',null,1,1);

--day 4
INSERT INTO history_games VALUES(28,4,'MOR','POR','30/08/2019 19:00',null,1,0);
INSERT INTO history_games VALUES(29,4,'LFC','BO','30/08/2019 21:15',null,0,1);
INSERT INTO history_games VALUES(30,4,'DA','FA','31/08/2019 16:30',null,2,3);
INSERT INTO history_games VALUES(31,4,'PF','MA','31/08/2019 16:30',null,0,1);
INSERT INTO history_games VALUES(32,4,'SCP','RA','31/08/2019 19:00',null,2,3);
INSERT INTO history_games VALUES(33,4,'GV','VFC','31/08/2019 21:30',null,0,0);
INSERT INTO history_games VALUES(34,4,'TO','SC','01/09/2019 16:00',null,0,0);
INSERT INTO history_games VALUES(35,4,'PO','VSE','01/09/2019 18:30',null,3,0);
INSERT INTO history_games VALUES(36,4,'BR','BEN','01/09/2019 21:00',null,0,4);

--day 5
INSERT INTO history_games VALUES(37,5,'VFC','BR','13/09/2019 20:30',null,1,0);
INSERT INTO history_games VALUES(38,5,'FA','PF','14/09/2019 16:30',null,4,2);
INSERT INTO history_games VALUES(39,5,'BEN','GV','14/09/2019 19:00',null,2,0);
INSERT INTO history_games VALUES(40,5,'VSE','DA','14/09/2019 21:30',null,5,1);
INSERT INTO history_games VALUES(41,5,'SC','MOR','15/09/2019 16:00',null,2,0);
INSERT INTO history_games VALUES(42,5,'RA','TO','15/09/2019 16:00',null,2,4);
INSERT INTO history_games VALUES(43,5,'MA','LFC','15/09/2019 16:00',null,1,3);
INSERT INTO history_games VALUES(44,5,'POR','PO','15/09/2019 18:00',null,2,3);
INSERT INTO history_games VALUES(45,5,'BO','SCP','15/09/2019 20:00',null,1,1);

--day 6
INSERT INTO history_games VALUES(46,6,'PF','DA','20/09/2019 20:30',null,2,1);
INSERT INTO history_games VALUES(47,6,'LFC','RA','21/09/2019 18:00',null,0,2);
INSERT INTO history_games VALUES(48,6,'MOR','BEN','21/09/2019 20:30',null,1,2);
INSERT INTO history_games VALUES(49,6,'GV','BO','22/09/2019 15:30',null,0,0);
INSERT INTO history_games VALUES(50,6,'TO','VSE','22/09/2019 18:00',null,1,3);
INSERT INTO history_games VALUES(51,6,'VFC','POR','22/09/2019 18:00',null,0,0);
INSERT INTO history_games VALUES(52,6,'PO','SC','22/09/2019 20:30',null,2,0);
INSERT INTO history_games VALUES(53,6,'BR','MA','23/09/2019 19:00',null,2,2);
INSERT INTO history_games VALUES(54,6,'SCP','FA','23/09/2019 21:00',null,1,2);

--day 7
INSERT INTO history_games VALUES(55,7,'BO','TO','27/09/2019 20:30',null,0,0);
INSERT INTO history_games VALUES(56,7,'MA','MOR','28/09/2019 16:30',null,2,1);
INSERT INTO history_games VALUES(57,7,'BEN','VFC','28/09/2019 19:00',null,1,0);
INSERT INTO history_games VALUES(58,7,'FA','LFC','28/09/2019 21:30',null,3,1);
INSERT INTO history_games VALUES(59,7,'SC','GV','29/09/2019 16:00',null,1,0);
INSERT INTO history_games VALUES(60,7,'VSE','PF','29/09/2019 16:00',null,1,0);
INSERT INTO history_games VALUES(61,7,'POR','BR','29/09/2019 18:00',null,0,1);
INSERT INTO history_games VALUES(62,7,'RA','PO','29/09/2019 20:00',null,0,1);
INSERT INTO history_games VALUES(63,7,'DA','SCP','30/09/2019 20:15',null,0,1);

--day 8
INSERT INTO history_games VALUES(64,8,'PF','RA','25/10/2019 20:30',null,0,0);
INSERT INTO history_games VALUES(65,8,'LFC','DA','26/10/2019 15:30',null,3,2);
INSERT INTO history_games VALUES(66,8,'GV','POR','26/10/2019 15:30',null,1,1);
INSERT INTO history_games VALUES(67,8,'VFC','MA','26/10/2019 18:00',null,0,0);
INSERT INTO history_games VALUES(68,8,'MOR','BO','26/10/2019 20:30',null,1,1);
INSERT INTO history_games VALUES(69,8,'TO','BEN','27/10/2019 15:00',null,0,1);
INSERT INTO history_games VALUES(70,8,'PO','FA','27/10/2019 17:30',null,3,0);
INSERT INTO history_games VALUES(71,8,'SCP','VSE','27/10/2019 20:00',null,3,1);
INSERT INTO history_games VALUES(72,8,'BR','SC','28/10/2019 20:15',null,2,0);

--day 9
INSERT INTO history_games VALUES(73,9,'DA','TO','05/10/2019 15:30',null,0,1);
INSERT INTO history_games VALUES(74,9,'RA','MOR','30/10/2019 17:00',null,1,1);
INSERT INTO history_games VALUES(75,9,'MA','PO','30/10/2019 18:45',null,1,1);
INSERT INTO history_games VALUES(76,9,'VSE','LFC','30/10/2019 20:00',null,5,0);
INSERT INTO history_games VALUES(77,9,'BEN','POR','30/10/2019 20:15',null,4,0);
INSERT INTO history_games VALUES(78,9,'FA','GV','30/10/2019 21:00',null,2,1);
INSERT INTO history_games VALUES(79,9,'PF','SCP','31/10/2019 19:45',null,1,2);
INSERT INTO history_games VALUES(80,9,'SC','VFC','31/10/2019 20:15',null,1,1);
INSERT INTO history_games VALUES(81,9,'BO','BR','31/10/2019 20:15',null,2,0);

--day 10
INSERT INTO history_games VALUES(82,10,'BEN','RA','02/11/2019 18:00',null,2,0);
INSERT INTO history_games VALUES(83,10,'MOR','VSE','02/11/2019 20:30',null,1,1);
INSERT INTO history_games VALUES(84,10,'GV','MA','03/11/2019 15:00',null,2,0);
INSERT INTO history_games VALUES(85,10,'TO','SCP','03/11/2019 17:30',null,1,0);
INSERT INTO history_games VALUES(86,10,'PO','DA','03/11/2019 20:00',null,1,0);
INSERT INTO history_games VALUES(87,10,'BR','FA','03/11/2019 20:15',null,2,2);
INSERT INTO history_games VALUES(88,10,'LFC','PF','04/11/2019 19:00',null,1,0);
INSERT INTO history_games VALUES(89,10,'VFC','BO','04/11/2019 21:00',null,1,0);
INSERT INTO history_games VALUES(90,10,'POR','SC','04/11/2019 21:00',null,1,1);

--day 11
INSERT INTO history_games VALUES(91,11,'DA','GV','08/11/2019 20:30',null,1,2);
INSERT INTO history_games VALUES(92,11,'RA','VFC','09/11/2019 15:30',null,1,0);
INSERT INTO history_games VALUES(93,11,'SC','BEN','09/11/2019 18:00',null,1,2);
INSERT INTO history_games VALUES(94,11,'FA','MOR','09/11/2019 20:30',null,3,3);
INSERT INTO history_games VALUES(95,11,'PF','TO','10/11/2019 15:00',null,1,0);
INSERT INTO history_games VALUES(96,11,'MA','POR','10/11/2019 15:00',null,1,1);
INSERT INTO history_games VALUES(97,11,'SCP','LFC','10/11/2019 18:30',null,2,0);
INSERT INTO history_games VALUES(98,11,'VSE','BR','10/11/2019 20:00',null,0,2);
INSERT INTO history_games VALUES(99,11,'BO','PO','10/11/2019 21:00',null,0,1);

--day 12
INSERT INTO history_games VALUES(100,12,'SC','BO','29/11/2019 20:30',null,1,2);
INSERT INTO history_games VALUES(101,12,'MOR','DA','30/11/2019 15:30',null,3,2);
INSERT INTO history_games VALUES(102,12,'BEN','MA','30/11/2019 18:00',null,4,0);
INSERT INTO history_games VALUES(103,12,'POR','FA','30/11/2019 20:30',null,2,1);
INSERT INTO history_games VALUES(104,12,'TO','LFC','01/12/2019 15:00',null,0,1);
INSERT INTO history_games VALUES(105,12,'VFC','VSE','01/12/2019 17:30',null,1,1);
INSERT INTO history_games VALUES(106,12,'GV','SCP','01/12/2019 20:00',null,3,1);
INSERT INTO history_games VALUES(107,12,'BR','RA','02/12/2019 18:45',null,2,0);
INSERT INTO history_games VALUES(108,12,'PO','PF','02/12/2019 20:45',null,2,0);

--day 13
INSERT INTO history_games VALUES(109,13,'BO','BEN','06/12/2019 20:30',null,1,4);
INSERT INTO history_games VALUES(110,13,'MA','SC','07/12/2019 15:00',null,2,2);
INSERT INTO history_games VALUES(111,13,'FA','TO','07/12/2019 18:00',null,2,3);
INSERT INTO history_games VALUES(112,13,'DA','BR','07/12/2019 20:30',null,1,0);
INSERT INTO history_games VALUES(113,13,'VSE','POR','08/12/2019 15:00',null,2,0);
INSERT INTO history_games VALUES(114,13,'PF','VFC','08/12/2019 15:00',null,2,3);
INSERT INTO history_games VALUES(115,13,'SCP','MOR','08/12/2019 17:30',null,1,0);
INSERT INTO history_games VALUES(116,13,'LFC','PO','08/12/2019 20:00',null,1,1);
INSERT INTO history_games VALUES(117,13,'RA','GV','09/12/2019 20:15',null,1,0);

--day 14
INSERT INTO history_games VALUES(118,14,'POR','RA','13/12/2019 20:30',null,1,1);
INSERT INTO history_games VALUES(119,14,'MA','BO','14/12/2019 15:30',null,1,0);
INSERT INTO history_games VALUES(120,14,'BEN','FA','14/12/2019 18:00',null,4,0);
INSERT INTO history_games VALUES(121,14,'VFC','DA','14/12/2019 20:30',null,1,0);
INSERT INTO history_games VALUES(122,14,'MOR','LFC','15/12/2019 15:00',null,2,1);
INSERT INTO history_games VALUES(123,14,'GV','VSE','15/12/2019 17:30',null,2,2);
INSERT INTO history_games VALUES(124,14,'BR','PF','15/12/2019 20:00',null,0,1);
INSERT INTO history_games VALUES(125,14,'SC','SCP','16/12/2019 19:00',null,0,4);
INSERT INTO history_games VALUES(126,14,'PO','TO','16/12/2019 20:15',null,3,0);

--day 15
INSERT INTO history_games VALUES(127,15,'BO','POR','04/01/2020 15:30',null,1,1);
INSERT INTO history_games VALUES(128,15,'DA','SC','04/01/2020 15:30',null,0,1);
INSERT INTO history_games VALUES(129,15,'LFC','BR','04/01/2020 18:00',null,1,7);
INSERT INTO history_games VALUES(130,15,'VSE','BEN','04/01/2020 20:30',null,0,1);
INSERT INTO history_games VALUES(131,15,'PF','MOR','05/01/2020 15:00',null,1,0);
INSERT INTO history_games VALUES(132,15,'TO','GV','05/01/2020 15:00',null,1,1);
INSERT INTO history_games VALUES(133,15,'RA','MA','05/01/2020 15:00',null,0,1);
INSERT INTO history_games VALUES(134,15,'SCP','PO','05/01/2020 17:30',null,1,2);
INSERT INTO history_games VALUES(135,15,'FA','VFC','05/01/2020 20:00',null,3,0);

--day 16
INSERT INTO history_games VALUES(136,16,'SC','RA','10/01/2020 19:00',null,0,1);
INSERT INTO history_games VALUES(137,16,'BEN','DA','10/01/2020 19:00',null,2,1);
INSERT INTO history_games VALUES(138,16,'MOR','PO','10/01/2020 21:15',null,2,4);
INSERT INTO history_games VALUES(139,16,'POR','PF','11/01/2020 15:30',null,0,0);
INSERT INTO history_games VALUES(140,16,'BO','FA','11/01/2020 18:00',null,0,1);
INSERT INTO history_games VALUES(141,16,'VFC','SCP','11/01/2020 20:30',null,1,3);
INSERT INTO history_games VALUES(142,16,'GV','LFC','12/01/2020 15:00',null,2,0);
INSERT INTO history_games VALUES(143,16,'MA','VSE','12/01/2020 17:30',null,0,0);
INSERT INTO history_games VALUES(144,16,'BR','TO','12/01/2020 20:00',null,2,1);

--day 17
INSERT INTO history_games VALUES(145,17,'PO','BR','17/01/2020 19:00',null,1,2);
INSERT INTO history_games VALUES(146,17,'SCP','BEN','17/01/2020 21:15',null,0,2);
INSERT INTO history_games VALUES(147,17,'DA','POR','18/01/2020 15:30',null,3,0);
INSERT INTO history_games VALUES(148,17,'VSE','SC','18/01/2020 15:30',null,1,0);
INSERT INTO history_games VALUES(149,17,'TO','MOR','18/01/2020 18:00',null,1,1);
INSERT INTO history_games VALUES(150,17,'LFC','VFC','18/01/2020 20:30',null,0,1);
INSERT INTO history_games VALUES(151,17,'PF','GV','19/01/2020 15:00',null,0,0);
INSERT INTO history_games VALUES(152,17,'FA','MA','19/01/2020 17:30',null,1,1);
INSERT INTO history_games VALUES(153,17,'RA','BO','19/01/2020 20:00',null,2,0);

--day 18
INSERT INTO history_games VALUES(154,18,'FA','SC','26/01/2020 15:00',null,0,1);
INSERT INTO history_games VALUES(155,18,'TO','VFC','26/01/2020 15:00',null,0,3);
INSERT INTO history_games VALUES(156,18,'LFC','POR','26/01/2020 15:00',null,2,1);
INSERT INTO history_games VALUES(157,18,'PF','BEN','26/01/2020 17:30',null,0,2);
INSERT INTO history_games VALUES(158,18,'DA','BO','26/01/2020 20:00',null,0,1);
INSERT INTO history_games VALUES(159,18,'VSE','RA','27/01/2020 18:45',null,1,2);
INSERT INTO history_games VALUES(160,18,'SCP','MA','27/01/2020 21:00',null,1,0);
INSERT INTO history_games VALUES(161,18,'PO','GV','28/01/2020 20:15',null,2,1);
INSERT INTO history_games VALUES(162,18,'MOR','BR','29/01/2020 20:15',null,1,2);

--day 19
INSERT INTO history_games VALUES(163,19,'BEN','LFC','31/01/2020 19:00',null,3,2);
INSERT INTO history_games VALUES(164,19,'RA','FA','31/01/2020 21:15',null,2,2);
INSERT INTO history_games VALUES(165,19,'POR','TO','01/02/2020 15:30',null,0,1);
INSERT INTO history_games VALUES(166,19,'VFC','PO','01/02/2020 18:00',null,0,4);
INSERT INTO history_games VALUES(167,19,'MA','DA','02/02/2020 15:00',null,1,2);
INSERT INTO history_games VALUES(168,19,'GV','MOR','02/02/2020 15:00',null,1,5);
INSERT INTO history_games VALUES(169,19,'SC','PF','02/02/2020 17:30',null,2,1);
INSERT INTO history_games VALUES(170,19,'BR','SCP','02/02/2020 17:30',null,1,0);
INSERT INTO history_games VALUES(171,19,'BO','VSE','02/02/2020 20:00',null,2,0);

--day 20
INSERT INTO history_games VALUES(172,20,'PF','BO','07/02/2020 20:30',null,0,1);
INSERT INTO history_games VALUES(173,20,'FA','VSE','08/02/2020 15:30',null,0,7);
INSERT INTO history_games VALUES(174,20,'LFC','SC','08/02/2020 15:30',null,0,2);
INSERT INTO history_games VALUES(175,20,'BR','GV','08/02/2020 18:00',null,2,2);
INSERT INTO history_games VALUES(176,20,'PO','BEN','08/02/2020 20:30',null,3,2);
INSERT INTO history_games VALUES(177,20,'TO','MA','09/02/2020 15:00',null,0,0);
INSERT INTO history_games VALUES(178,20,'MOR','VFC','09/02/2020 15:00',null,1,1);
INSERT INTO history_games VALUES(179,20,'SCP','POR','09/02/2020 17:30',null,2,1);
INSERT INTO history_games VALUES(180,20,'DA','RA','09/02/2020 20:00',null,0,4);

--day 21
INSERT INTO history_games VALUES(181,21,'VFC','GV','14/02/2020 20:30',null,1,2);
INSERT INTO history_games VALUES(182,21,'POR','MOR','15/02/2020 15:30',null,1,1);
INSERT INTO history_games VALUES(183,21,'SC','TO','15/02/2020 15:30',null,1,0);
INSERT INTO history_games VALUES(184,21,'BEN','BR','15/02/2020 18:00',null,0,1);
INSERT INTO history_games VALUES(185,21,'RA','SCP','15/02/2020 20:30',null,1,1);
INSERT INTO history_games VALUES(186,21,'MA','PF','16/02/2020 15:00',null,3,0);
INSERT INTO history_games VALUES(187,21,'BO','LFC','16/02/2020 15:00',null,1,2);
INSERT INTO history_games VALUES(188,21,'VSE','PO','16/02/2020 17:30',null,1,2);
INSERT INTO history_games VALUES(189,21,'FA','DA','16/02/2020 20:00',null,1,1);

--day 22
INSERT INTO history_games VALUES(190,22,'DA','VSE','21/02/2020 20:30',null,0,2);
INSERT INTO history_games VALUES(191,22,'TO','RA','22/02/2020 18:00',null,1,2);
INSERT INTO history_games VALUES(192,22,'LFC','MA','22/02/2020 20:30',null,1,0);
INSERT INTO history_games VALUES(193,22,'MOR','SC','23/02/2020 15:00',null,2,1);
INSERT INTO history_games VALUES(194,22,'PF','FA','23/02/2020 15:00',null,2,1);
INSERT INTO history_games VALUES(195,22,'SCP','BO','23/02/2020 17:30',null,2,0);
INSERT INTO history_games VALUES(196,22,'BR','VFC','23/02/2020 20:00',null,3,1);
INSERT INTO history_games VALUES(197,22,'PO','POR','23/02/2020 20:30',null,1,0);
INSERT INTO history_games VALUES(198,22,'GV','BEN','24/02/2020 19:30',null,0,1);

--day 23
INSERT INTO history_games VALUES(199,23,'POR','VFC','28/02/2020 20:30',null,0,0);
INSERT INTO history_games VALUES(200,23,'RA','LFC','29/02/2020 18:00',null,0,0);
INSERT INTO history_games VALUES(201,23,'BO','GV','29/02/2020 20:30',null,0,1);
INSERT INTO history_games VALUES(202,23,'DA','PF','01/03/2020 15:00',null,1,3);
INSERT INTO history_games VALUES(203,23,'MA','BR','01/03/2020 17:30',null,1,2);
INSERT INTO history_games VALUES(204,23,'VSE','TO','01/03/2020 20:00',null,2,0);
INSERT INTO history_games VALUES(205,23,'SC','PO','02/03/2020 19:30',null,0,2);
INSERT INTO history_games VALUES(206,23,'BEN','MOR','02/03/2020 20:45',null,1,1);
INSERT INTO history_games VALUES(207,23,'FA','SCP','03/03/2020 20:00',null,3,1);

--day 24
INSERT INTO history_games VALUES(208,24,'BR','POR','06/03/2020 20:30',null,3,1);
INSERT INTO history_games VALUES(209,24,'TO','BO','07/03/2020 15:30',null,1,1);
INSERT INTO history_games VALUES(210,24,'VFC','BEN','07/03/2020 18:00',null,1,1);
INSERT INTO history_games VALUES(211,24,'PO','RA','07/03/2020 20:30',null,1,1);
INSERT INTO history_games VALUES(212,24,'MOR','MA','08/03/2020 15:00',null,2,0);
INSERT INTO history_games VALUES(213,24,'LFC','FA','08/03/2020 15:00',null,0,0);
INSERT INTO history_games VALUES(214,24,'GV','SC','08/03/2020 17:00',null,1,1);
INSERT INTO history_games VALUES(215,24,'SCP','DA','08/03/2020 17:30',null,2,0);
INSERT INTO history_games VALUES(216,24,'PF','VSE','08/03/2020 20:00',null,1,2);

