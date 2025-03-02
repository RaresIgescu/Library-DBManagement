create table LOCATIE (
id_locatie number(3) constraint locatie_pk primary key,
etaj number(1),
zona number(1),
rand number(2),
raft number(2));

create table EDITURA (
id_editura number(3) constraint editura_pk primary key,
nume varchar2(30),
oras varchar2(30),
strada varchar2(30),
cod_postal number(6));

create table AUTOR (
id_autor number(3) constraint autor_pk primary key,
id_editura number(3),
nume varchar2(30),
prenume varchar2(30),
nationalitate varchar2(30),
constraint autor_editura_fk foreign key (id_editura) references  EDITURA(id_editura));

create table CARTE (
id_carte number(3) constraint carte_pk primary key,
id_locatie number(3),
id_editura number(3),
an_aparitie number(4),
gen varchar2(20),
titlu varchar2(30),
nr_autori number(2),
constraint carte_locatie_fk foreign key (id_locatie) references LOCATIE(id_locatie),
constraint carte_editura_fk foreign key (id_editura) references EDITURA(id_editura));

create table STOC (
id_stoc number(3) constraint stoc_pk primary key,
id_carte number(3),
nr_disponibile number(3),
constraint stoc_carte_fk foreign key (id_carte) references CARTE(id_carte));

create table REDACTEAZA (
id_carte number(3),
id_autor number(3),
constraint redacteaza_pk primary key (id_carte, id_autor),
constraint redacteaza_carte_fk foreign key (id_carte) references CARTE(id_carte),
constraint redacteaza_autor_fk foreign key (id_autor) references AUTOR(id_autor));

create table ANGAJAT (
id_angajat number(3) constraint angajat_pk primary key,
nume varchar2(30),
prenume varchar2(30),
telefon number(9),
strada varchar2(30),
cod_postal number(6));

create table CITITOR (
id_cititor number(3) constraint cititor_pk primary key,
id_angajat number(3),
nume varchar2(30),
prenume varchar2(30),
varsta varchar2(30),
email varchar2(50),
oras varchar2(30),
strada varchar2(30),
cod_postal number(6),
constraint cititor_angajat_fk foreign key (id_angajat) references ANGAJAT(id_angajat));

create table EVENIMENT (
id_eveniment number(3) constraint eveniment_pk primary key,
nume varchar2(30),
data date,
sala number(3),
nr_participanti number(3));

create table ORGANIZEAZA (
id_cititor number(3),
id_eveniment number(3),
constraint organizeaza_pk primary key (id_cititor, id_eveniment),
constraint organizeaza_cititor_fk foreign key (id_cititor) references CITITOR(id_cititor),
constraint organizeaza_eveniment_fk foreign key (id_eveniment) references EVENIMENT(id_eveniment));

create table IMPRUMUT (
id_cititor number(3),
id_carte number(3),
data_imprumut date, 
data_returnare date,
constraint imprumut_pk primary key (id_cititor, id_carte),
constraint imprumut_cititor_fk foreign key (id_cititor) references CITITOR(id_cititor),
constraint imprumut_carte_fk foreign key (id_carte) references CARTE(id_carte));

drop table imprumut;
drop table organizeaza;
drop table redacteaza;
drop table stoc;
drop table carte;
drop table autor;
drop table editura;
drop table angajat;
drop table eveniment;
drop table cititor;
drop table locatie;

insert all
    into locatie values (1, 1, 1, 1, 1)
    into locatie values (2, 1, 1, 1, 2)
    into locatie values (3, 1, 3, 1, 3)
    into locatie values (4, 1, 4, 1, 4)
    into locatie values (5, 2, 1, 2, 1)
    into locatie values (6, 2, 2, 3, 4)
    into locatie values (7, 2, 3, 2, 3)
    into locatie values (8, 3, 2, 3, 2)
    into locatie values (9, 4, 1, 4, 1)
    into locatie values (10, 5, 1, 5, 2)
    select *
    from dual;
commit;

insert all
    into editura values (1, 'Minerva', 'Bucuresti', 'Sperantei', 021932)
    into editura values (2, 'Polirom', 'Iasi', 'Universitatii', 700067)
    into editura values (3, 'Humanitas', 'Cluj-Napoca', 'Horea', 400174)
    into editura values (4, 'Bookzone', 'Bucuresti', 'Libertatii', 250882)
    into editura values (5, 'Paralela 45', 'Bucuresti', 'Magheru', 310224)
    into editura values (6, 'Polirom', 'Bucuresti', 'Stirbei Voda', 30205)
    into editura values (7, 'Litera', 'Bucuresti', 'Stefan cel Mare', 223004)
    into editura values (8, 'Humanitas', 'Timisoara', 'Victoriei', 300101)
    into editura values (9, 'Corint', 'Bucuresti', 'Barbu Vacarescu', 203276)
    into editura values (10, 'RedRom', 'Vaslui', null, 472490)
    into editura values (11, 'Cosarom', 'Galati', null, 329812)
    into editura values (12, 'Cuvant', 'Suceava', null, 432841)
    select *
    from dual;
commit;

insert all
    into autor values(1, null, 'Marin', 'Preda', 'Roman')
    into autor values(2, 2, 'Ion', 'Creanga', 'Roman')
    into autor values(3, 4, 'Mihai', 'Eminescu', 'Roman')
    into autor values(4, null, 'Mircea', 'Eliade', 'Roman')
    into autor values(5, null, 'George', 'Cosbuc', 'Roman')
    into autor values(6, 7, 'Ioan', 'Slavici', 'Roman')
    into autor values(7, 11, 'Liviu', 'Rebreanu', 'Roman')
    into autor values(8, 10, 'Ion', 'Luca Caragiale', 'Roman')
    into autor values(9, null, 'Matei', 'Visniec', 'Roman')
    into autor values(10, 3, 'Octavian', 'Paler', 'Roman')
    into autor values(11, 4, 'Eugene', 'Ionesco', 'Francez')
    into autor values(12, 9, 'Leo', 'Tolstoi', 'Rus')
    into autor values(13, null, 'William', 'Shakespeare', 'Englez')
    into autor values(14, null, 'Gabriel', 'Garcia Marquez', 'Columbian')
    into autor values(15, 1, 'Haruki', 'Murakami', 'Japonez')
    into autor values(16, 2, 'J.K.', 'Rowling', 'Englez')
    into autor values(17, 4, 'Mark', 'Twain', null)
    into autor values(18, 5, 'Red', 'Hand', null)
    select *
    from dual;
commit;

insert all
    into carte values (1, 1, 3, 2010, 'Horror', 'Uciderea', 1)
    into carte values (2, 3, 7, 1989, 'Istorie', 'Revolutia', 2)
    into carte values (3, 10, 12, 2023, 'Fantasy', 'Inapoi in viitor', 3)
    into carte values (4, 4, 11, 2008, 'Istorie', 'Batalia', 1)
    into carte values (5, 5, 10, 2002, 'Economie', 'Caderea pietei', 1)
    into carte values (6, 6 , 9, 2003, 'Aventura', 'Probele insulei', 1)
    into carte values (7, 7, 8, 1999, 'Horror', 'IT', 2)
    into carte values (8, 8, 7, 1850, 'Geografie', 'Prima harta a pamantului', 2)
    into carte values (9, 2, 6, 1998, 'Istorie', 'Primi ani dupa revolutie', 1)
    into carte values (10, 3, 2, 2001, 'Fantasy', 'Lupta galaxiilor', 1)
    into carte values (11, 9, 4, 2005, 'Geografie', 'Romania: Comoara Ascunsa', 1)
    into carte values (12, 10, 1, 2004, 'Economie', 'Blockchain', 1)
    into carte values (13, 6, 5, 2003, 'Aventura', 'Urmarirea', 1)
    into carte values (14, 3, 4, 1972, 'Istorie', 'Comunismul', 3)
    into carte values (15, 1, 6, 2019, 'Dezvoltare personala', 'Cum sa devii mai bun', 1)
    into carte values (16, 2, 7, 1945, 'Istorie', 'Ultimele clipe de teroare', 1)
    into carte values (17, 4, 8, 2015, 'Fantasy', 'Prietenul secret', 1)
    into carte values (18, 2, 3, 2020, 'Istorie', '1942', 1)
    into carte values (19, 3, 4, 2016, 'Istorie', '1942', 2)
    select *
    from dual;
commit;


insert all 
    into stoc values (1, 1, 12)
    into stoc values (2, 2, 20)
    into stoc values (3, 3, 4)
    into stoc values (4, 4, 8)
    into stoc values (5, 5, 22)
    into stoc values (6, 6, 10)
    into stoc values (7, 7, 3)
    into stoc values (8, 8, 6)
    into stoc values (9, 9, 17)
    into stoc values (10, 10, 25)
    into stoc values (11, 11, 16)
    into stoc values (12, 12, 9)
    into stoc values (13, 13, 33)
    into stoc values (14, 14, 10)
    into stoc values (15, 15, 5)
    into stoc values (16, 16, 2)
    into stoc values (17, 17, 12)
    into stoc values (18, 18, 0)
    into stoc values (19, 19, 1)
    select *
    from dual;
commit;

insert all
    into redacteaza values (1,1)
    into redacteaza values (2,1)
    into redacteaza values (2,7)
    into redacteaza values (3,1)
    into redacteaza values (3,10)
    into redacteaza values (3,15)
    into redacteaza values (4,5)
    into redacteaza values (5,9)
    into redacteaza values (6,2)
    into redacteaza values (7,11)
    into redacteaza values (7,12)
    into redacteaza values (8,2)
    into redacteaza values (8,17)
    into redacteaza values (9,12)
    into redacteaza values (10,15)
    into redacteaza values (11,16)
    into redacteaza values (12,11)
    into redacteaza values (13,13)
    into redacteaza values (14,9)
    into redacteaza values (14,10)
    into redacteaza values (14,3)
    into redacteaza values (15,9)
    into redacteaza values (16,3)
    into redacteaza values (17,12)
    into redacteaza values (18, 1)
    into redacteaza values (19, 7)
    into redacteaza values (19, 10)
    select *
    from dual;
commit;

insert all
    into angajat values (1, 'Nicolae', 'Stanciu', 0770382921, 'nicostn@gmail.com', 730215)
    into angajat values (2, 'Vinicius', 'Junior', 0721567890, 'vincentiu@gmail.com', 032832)
    into angajat values (3, 'Jude', 'Belligham', 0732123456, 'judeblg@yahoo.com', 110438)
    into angajat values (4, 'Claudiu', 'Petrila', 0710234567, 'petrilacl@gmail.com', 900016)
    into angajat values (5, 'Gheorghe', 'Hagi', 0765443210, 'hagimnd@personal.com', 463291)
    into angajat values (6, 'Stefan', 'Tarnovanu', 0721987654, 'tarnvstefan@gmail.com', 038232)
    into angajat values (7, 'Valentin', 'Cretu', 0771122334, 'valicretu@yahoo.com', 573212)
    select *
    from dual;
commit;

insert all
    into eveniment values (1, 'Club de carte', TO_DATE('2003-01-14', 'YYYY-MM-DD'), 2, 32)
    into eveniment values (2, 'Targ de carte', TO_DATE('2004-11-16', 'YYYY-MM-DD'), 10, 71)
    into eveniment values (3, 'Dezvoltare personala', TO_DATE('2024-11-28', 'YYYY-MM-DD'), 8, 62)
    into eveniment values (4, 'Club de carte', TO_DATE('2023-02-23', 'YYYY-MM-DD'), 1, 103)
    into eveniment values (5, 'Workshop protejarea mediului', TO_DATE('2024-05-23', 'YYYY-MM-DD'), 3, 12)
    into eveniment values (6, 'Cursuri literatur', TO_DATE('2024-07-16', 'YYYY-MM-DD'), 7, 21)
    into eveniment values (7, 'Dezvoltare personala', TO_DATE('2022-06-07', 'YYYY-MM-DD'), 10, 43)
    into eveniment values (8, 'Podcast istorie', TO_DATE('2019-09-30', 'YYYY-MM-DD'), 4, 50)
    into eveniment values (9, 'Club de carte', TO_DATE('2023-10-05', 'YYYY-MM-DD'), 10, 27)
    into eveniment values (10, 'Cursuri literatura', TO_DATE('2024-05-12', 'YYYY-MM-DD'), 2, 30)
    select *
    from dual;
commit;

insert all
    into cititor values (1, 1, 'Igescu', 'Rares-Andrei', 20, 'raresigescu@gmail.com', 'Vaslui', 'Pacii', 050882)
    into cititor values (2, 3, 'Bari', 'Melisa-Aysel', 21, 'ayselbari@yahoo.com', 'Bucuresti', 'Aviatorilor', 030551)
    into cititor values (3, 7, 'Baltic', 'Bianca-Nicoleta', 21, 'mareabaltica@gmail.com', 'Cluj-Napoca', 'Primaverii', 400174)
    into cititor values (4, 2, 'Igescu', 'Mircea-Ovidiu', 41, 'elena.dumitrescu@fmi.com', 'Timisoara', 'Traian', 300192)
    into cititor values (5, 4, 'Lucescu', 'Mircea', 28, 'mrnrdc@google.com', 'Constanta', 'Mihai Viteazu', 900657)
    into cititor values (6, 6, 'Lixandru', 'Maxim', 37, 'andreigeorge@yahoo.com', 'Bucuresti', 'Stefan cel Mare', 020432)
    into cititor values (7, 3, 'Dragusin', 'Radu', 33, 'mariaaaaa@evrica.ro', 'Bucuresti', 'Muresenilor', 060723)
    into cititor values (8, 6, 'Ratiu', 'Andrei', 29, 'stanciul@gmail.com', 'Oradea', 'Republicii', 410012)
    into cititor values (9, 1, 'Nita', 'Florin', 26, 'crisvoicu@personal.com', 'Galati', 'Dunarii', 800052)
    into cititor values (10, 3, 'Moldovan', 'Horatiu', 35, 'andreeaflr@google.com', 'Sibiu', 'Victoriei', 550167)
    into cititor values (11, 5, 'Manea', 'Cristian', 39, 'mircea-gheorghe@gmail.com', 'Craiova', 'Independentei', 200321)
    into cititor values (12, 5, 'Popescu', 'Octavian', 31, 'adinu@gmail.com.com', 'Ploiesti', 'Garii', 100200)
    into cititor values (13, 2, 'Mann', 'Denis', 27, 'anamara@gmail.com', 'Targu Mures', 'Cuza Voda', 540039)
    into cititor values (14, 7, 'Mihaila', 'Valentin', 30, 'iacobctl@yahoo.com', 'Bucuresti', 'Mihai Eminescu', 040294)
    into cititor values (15, 1, 'Marin', 'Razvan', 36, 'lrscns@gmail.com', 'Bucuresti', 'Republicii', 021332)
    into cititor values (16, 6, 'Marin', 'Marius', 23, 'barbumrn@gmail.com', 'Braila', 'Traian', 810012)
    into cititor values (17, 4, 'Hagi', 'Ianis', 40, 'stanelena@yahoo.com', 'Arad', 'Mihai Viteazu', 310021)
    into cititor values (18, 2, 'Ratiu', 'Andrei', 28, 'rayvaleccano@gmail.com', 'Barcelona', 'Stadionului', 000100)
    select *
    from dual;
commit;

insert all
    into organizeaza values (1, 1)
    into organizeaza values (2, 1)
    into organizeaza values (6, 2)
    into organizeaza values (8, 3)
    into organizeaza values (10, 4)
    into organizeaza values (3, 5)
    into organizeaza values (1, 6)
    into organizeaza values (3, 7)
    into organizeaza values (5, 7)
    into organizeaza values (10, 7)
    into organizeaza values (12, 8)
    into organizeaza values (3, 9)
    into organizeaza values (6, 10)
    select *
    from dual;
commit;

insert all
    into imprumut values (1, 1, to_date('2024-11-24', 'YYYY-MM-DD'), null)
    into imprumut values (3, 1, to_date('2024-10-16', 'YYYY-MM-DD'), to_date('2024-10-23', 'YYYY-MM-DD'))
    into imprumut values (2, 1, to_date('2023-09-27', 'YYYY-MM-DD'), to_date('2023-10-05', 'YYYY-MM-DD'))
    into imprumut values (10, 3, to_date('2024-07-01', 'YYYY-MM-DD'), null)
    into imprumut values (16, 3, to_date('2019-03-10', 'YYYY-MM-DD'), to_date('2019-03-21', 'YYYY-MM-DD'))
    into imprumut values (3, 4, to_date('2024-12-03', 'YYYY-MM-DD'), to_date('2024-12-23', 'YYYY-MM-DD'))
    into imprumut values (4, 7, to_date('2023-10-08', 'YYYY-MM-DD'), to_date('2023-10-16', 'YYYY-MM-DD'))
    into imprumut values (5, 10, to_date('2022-06-09', 'YYYY-MM-DD'), null)
    into imprumut values (7, 10, to_date('2020-02-01', 'YYYY-MM-DD'), to_date('2020-03-15', 'YYYY-MM-DD'))
    into imprumut values (8, 10, to_date('2019-08-12', 'YYYY-MM-DD'), null)
    into imprumut values (12, 13, to_date('2024-02-06', 'YYYY-MM-DD'), null)
    into imprumut values (2, 13, to_date('2023-06-23', 'YYYY-MM-DD'), to_date('2023-06-28', 'YYYY-MM-DD'))
    into imprumut values (7, 16, to_date('2018-01-28', 'YYYY-MM-DD'), to_date('2028-02-10', 'YYYY-MM-DD'))
    select *
    from dual;
commit;

alter table autor modify nume not null;
alter table autor modify prenume not null;
alter table editura modify nume not null;
alter table editura modify oras not null;
alter table editura modify cod_postal not null;
alter table carte modify nr_exemplare not null;
alter table carte modify gen not null;
alter table carte modify titlu not null;
alter table locatie modify etaj not null;
alter table locatie modify zona not null;
alter table locatie modify rand not null;
alter table locatie modify raft not null;
alter table angajat modify nume not null;
alter table angajat modify prenume not null;
alter table angajat modify telefon not null;
alter table cititor modify nume not null;
alter table cititor modify prenume not null;
alter table cititor modify varsta not null;
alter table cititor modify cod_postal not null;
alter table eveniment modify nume not null;
alter table eveniment modify sala not null;
alter table eveniment modify nr_participanti not null;
alter table cititor     
            add constraint check_varsta check (varsta > 14);
alter table eveniment
            add constraint check_participanti check (nr_participanti > 10);
alter table imprumut modify data_imprumut not null;