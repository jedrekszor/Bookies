alter SESSION set NLS_TIMESTAMP_FORMAT = 'dd/mm/yyyy HH24:MI';
alter SESSION set NLS_DATE_FORMAT = 'dd/mm/yyyy';

--COMPTETITIONS
insert into competitions values('LN','Liga NOS','Football','Portugal','2019/20','09/08/2019','17/05/2020');

--PHASES
insert into phases values(1, 'LN', 'Round 1', '09/08/2019', '08/09/2019');
insert into phases values(2, 'LN', 'Round 2', '16/08/2019', '19/08/2019');
insert into phases values(3, 'LN', 'Round 3', '23/08/2019', '25/08/2019');
insert into phases values(4, 'LN', 'Round 4', '30/08/2019', '01/09/2019');
insert into phases values(5, 'LN', 'Round 5', '13/09/2019', '15/09/2019');
insert into phases values(6, 'LN', 'Round 6', '20/09/2019', '23/09/2019');
insert into phases values(7, 'LN', 'Round 7', '27/09/2019', '30/09/2019');
insert into phases values(8, 'LN', 'Round 8', '25/10/2019', '28/10/2019');
insert into phases values(9, 'LN', 'Round 9', '05/10/2019', '31/10/2019');
insert into phases values(10, 'LN', 'Round 10', '02/11/2019', '04/11/2019');
insert into phases values(11, 'LN', 'Round 11', '08/11/2019', '10/11/2019');
insert into phases values(12, 'LN', 'Round 12', '29/11/2019', '02/12/2019');
insert into phases values(13, 'LN', 'Round 13', '06/12/2019', '09/12/2019');
insert into phases values(14, 'LN', 'Round 14', '13/12/2019', '16/12/2019');
insert into phases values(15, 'LN', 'Round 15', '04/01/2020', '05/01/2020');
insert into phases values(16, 'LN', 'Round 16', '10/01/2020', '12/01/2020');
insert into phases values(17, 'LN', 'Round 17', '17/01/2020', '19/01/2020');
insert into phases values(18, 'LN', 'Round 18', '26/01/2020', '29/01/2020');
insert into phases values(19, 'LN', 'Round 19', '31/01/2020', '02/02/2020');
insert into phases values(20, 'LN', 'Round 20', '07/02/2020', '09/02/2020');
insert into phases values(21, 'LN', 'Round 21', '14/02/2020', '16/02/2020');
insert into phases values(22, 'LN', 'Round 22', '21/02/2020', '24/02/2020');
insert into phases values(23, 'LN', 'Round 23', '28/02/2020', '03/03/2020');
insert into phases values(24, 'LN', 'Round 24', '06/03/2020', '08/03/2020');

--later on phases are suspended due to COVID-19

insert into phases values(25, 'LN', 'Round 25', '13/03/2020', '15/03/2020');
insert into phases values(26, 'LN', 'Round 26', '20/03/2020', '22/03/2020');
insert into phases values(27, 'LN', 'Round 27', '04/04/2020', '05/04/2020');
insert into phases values(28, 'LN', 'Round 28', '10/04/2020', '11/04/2020');
insert into phases values(29, 'LN', 'Round 29', '17/04/2020', '19/04/2020');
insert into phases values(30, 'LN', 'Round 30', '21/04/2020', '23/04/2020');