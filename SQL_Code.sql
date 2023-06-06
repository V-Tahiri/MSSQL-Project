create database KONCERTI
use KONCERTI

create table Arena(
 Arena_ID int Primary Key ,
 Emri varchar (50) not null unique,
 Shteti varchar(50) not null,
 Qyteti varchar(50)not null,
 Rruga varchar(100) ,
 Zip_Kodi char(5) ,
 Kapaciteti int not null
 );

 create table Koncerti(
 Koncerti_ID int Primary Key,
 Emri varchar (50) not null unique,
 Arena_ID int Foreign Key references Arena(Arena_ID)
 );

 create table Performuesi(
 Performuesi_ID int Primary Key,
 Emri varchar(50) not null,
 Mbiemri varchar (50) not null,
 Gjinia char(1) check(Gjinia in ('F','M')) not null,
 Datelindja date not null,
 Zhanri varchar (50) null,
 Arena_ID int Foreign Key references Arena(Arena_ID) ,
 Koncerti_ID int Foreign Key references Koncerti(Koncerti_ID)
 );

 create table Pjesemarresi(
 Pjesemarresi_ID int Primary key,
 Emri varchar (50) not null,
 Mbiemri varchar (50) not null,
 Gjinia char(1) check(Gjinia in ('F','M')) not null,
 Datelindja date not null,
 Email varchar(20) check(Email in ('@')) null,
 Nr_Personal int not null,
 Shteti varchar(50) not null,
 Qyteti varchar(50) not null,
 Rruga varchar(100) null,
 Zip_Kodi char(5) null
 );

 create table Stafi(
 Stafi_ID int Primary Key,
 Emri varchar (50) not null,
 Mbiemri varchar (50) not null,
 Nr_Personal int not null,
 Mosha int not null,
 Datelindja date null,
 Gjinia char(1) check(Gjinia in ('F','M')) not null,
 Shteti varchar(50) not null,
 Qyteti varchar(50) not null,
 Rruga varchar(100) null,
 Zip_Kodi char(5) null,
 Koncerti_ID int Foreign Key references Koncerti(Koncerti_ID)
 );

 create table Stage(
 Stage_ID int identity(1,1) Primary Key,
 Numri int not null,
 Dimensionet int null
 );

 create table Tekniku(
 Stafi_ID_Tekniku int Primary key,
 Fusha varchar(50) not null,
 Arena_ID int Foreign Key references Arena(Arena_ID),
 Stafi_ID int Foreign Key references Stafi(Stafi_ID),
 Stage_ID int Foreign Key references Stage(Stage_ID)
 );

 create table Sigurimi(
 Stafi_ID_Sigurimi int Primary key,
 Lloji varchar(50) not null,
 Arena_ID int Foreign Key references Arena(Arena_ID),
 Stafi_ID int Foreign Key references Stafi(Stafi_ID)
 );

 create table Mirembajtesi(
 Stafi_ID_Mirembajtesi int Primary key,
 Detyra varchar(50) not null,
 Arena_ID int Foreign Key references Arena(Arena_ID),
 Stafi_ID int Foreign Key references Stafi(Stafi_ID)
 );

 create table Paga(
 Paga_ID int Primary Key,
 Taksa money  not null,
 Bruto_Paga money not null,
 Neto_Paga money not null,
 Stafi_ID int unique Foreign Key references Stafi(Stafi_ID)
 );

 create table Kioska(
 Kioska_ID int Primary Key,
 Shteti varchar(50) not null,
 Qyteti varchar(50) not null,
 Rruga varchar(100) null,
 Zip_Kodi char(5) null,
 Numri_I_Tiketes int not null
 );

 create table Bileta(
 Bileta_ID int,
 Pjesemarresi_ID int not null,
 Primary Key(Bileta_ID, Pjesemarresi_ID),
 Foreign Key (Pjesemarresi_ID) references Pjesemarresi(Pjesemarresi_ID),
 Nr_Ulses int not null,
 Nr_Rreshtit int not null,
 Data_E_Blerjes date null,
 Data_E_Koncertit date null,
 Lloji char(20) check(Lloji in ('ADULT','CHILD','VIP')) not null,
 Kioska_ID int Foreign Key references Kioska(Kioska_ID)
 );

 create table Banda(
 Banda_ID int,
 Primary Key(Banda_ID, Performuesi_ID),
 Emri varchar (50) not null,
 Nr_I_Artisteve int not null,
 Performuesi_ID int unique Foreign Key references Performuesi(Performuesi_ID)
 );

 create table Playlist(
 Playlist_ID int Primary Key not null,
 Emri_I_Playlist varchar(50) not null,
 Performuesi_ID int Foreign Key references Performuesi(Performuesi_ID)
 );

 create table Kenget(
 Kenget_ID int Primary Key,
 Emri varchar (50) not null,
 Kompozitori varchar (50) null,
 Bitet int null,
 Çmimi_I_Kenges money not null,
 Playlist_ID int Foreign Key references Playlist(Playlist_ID) 
 );

 create table Restaurant(
 Restaurant_ID int Primary Key,
 Emri varchar (50) not null,
 Orari_I_Punes time not null,
 Menu nvarchar(500) null,
 Pjesemarresi_ID int unique Foreign Key references Pjesemarresi(Pjesemarresi_ID)
 );

 create table Makeup_Artist(
 Makeup_Artist_ID int Primary Key,
 Emri varchar (50) not null,
 Mbiemri varchar (50) not null,
 Gjinia char(1) check(Gjinia in ('F','M')) not null,
 Mosha int not null,
 );

 create table Dizajneri(
 Dizajneri_ID int Primary Key,
 Emri varchar (50) not null,
 Mbiemri varchar (50) not null,
 Gjinia char(1) check(Gjinia in ('F','M')) not null,
 Mosha int not null,
 );

 create table Nr_Telefonit(
 Nr_Telefonit_ID int,
 Pjesemarresi_ID int,
 Makeup_Artist_ID int,
 Dizajneri_ID int,
 Restaurant_ID int,
 Primary Key(Nr_Telefonit_ID, Pjesemarresi_ID, Makeup_Artist_ID, Dizajneri_ID, Restaurant_ID),
 Foreign Key (Pjesemarresi_ID) references Pjesemarresi(Pjesemarresi_ID),
 Foreign Key (Makeup_Artist_ID) references Makeup_Artist(Makeup_Artist_ID),
 Foreign Key (Dizajneri_ID) references Dizajneri(Dizajneri_ID),
 Foreign Key (Restaurant_ID) references Restaurant(Restaurant_ID)
 );

 create table Takon(
 Performuesi_ID int Foreign Key references Performuesi(Performuesi_ID),
 Pjesemarresi_ID int Foreign Key references Pjesemarresi(Pjesemarresi_ID),
 Primary Key(Performuesi_ID, Pjesemarresi_ID),
 Kohezgjatja time
 );

 create table Dhoma(
 Dhoma_ID int identity(1,1) Primary Key not null,
 Numri int not null,
 Kati int not null,
 Arena_ID int Foreign Key references Arena(Arena_ID)
 );

 create table Sherben(
 Performuesi_ID int,
 Pjesemarresi_ID int,
 Dhoma_ID int,
 Primary Key(Performuesi_ID, Pjesemarresi_ID, Dhoma_ID),
 Foreign Key (Performuesi_ID, Pjesemarresi_ID) references Takon(Performuesi_ID, Pjesemarresi_ID),
 Foreign Key(Dhoma_ID) references  Dhoma(Dhoma_ID)
 );

 create table Nga(
 Dizajneri_ID int,
 Makeup_Artist_ID int,
 Primary Key(Dizajneri_ID, Makeup_Artist_ID),
 Foreign Key (Dizajneri_ID) references Dizajneri(Dizajneri_ID),
 Foreign Key (Makeup_Artist_ID) references Makeup_Artist(Makeup_Artist_ID),
 Kohezgjatja time
 );

 create table Perkujdeset(
 Performuesi_ID int,
 Dizajneri_ID int,
 Makeup_Artist_ID int,
 Primary Key(Performuesi_ID,Dizajneri_ID, Makeup_Artist_ID),
 Foreign Key (Dizajneri_ID, Makeup_Artist_ID) references Nga(Dizajneri_ID, Makeup_Artist_ID),
 Foreign Key (Performuesi_ID) references Performuesi(Performuesi_ID)
 );

 create table Kontrolli(
 Stafi_ID_Sigurimi int,
 Kontrolli_ID int,
 Primary Key(Stafi_ID_Sigurimi, Kontrolli_ID),
 Foreign Key (Stafi_ID_Sigurimi) references Sigurimi(Stafi_ID_Sigurimi),
 Pjesemarresi_ID int foreign key references Pjesemarresi(Pjesemarresi_ID)
 );

 select *
 from Arena

 insert into Arena values 
(1,'United Center', 'US', 'Chicago',null, null, '23500' )
insert into Arena values 
(2, 'Philippine Arena', 'Philippines', 'Bocaue',null, null, '55000' )
insert into Arena values 
(3, 'PNC Arena', 'US', 'Tampa',null, null, '21000' )
insert into Arena values
(4,'Sportpaleis','Belgium','Antwerp',null, null, '23359')
insert into Arena values
(5,'Enterprise Center','US','Missouri',null, null, '22000')
insert into Arena values
(6,'Dean Smith Center','US','North Carolina',null, null, '21750')
insert into Arena values
(7,'Manchester Arena','UK','North Carolina',null, null, '21000')
insert into Arena values
(8,'Rupp Arena','US','Kentucky',null, null, '20545')
insert into Arena values
(9,'Madison Square Garden','US','New York City',null, null, '20789')
insert into Arena values
(10,'Little Caesars Arena','US','Detroit',null, null, '20491')
insert into Arena values
(11,'Spectrum Center','US','North Carolina',null, null, '20200')
insert into Arena values
(12,'AccorHotels Arena','France','Paris',null, null, '20300')
insert into Arena values
(13,'New Budapest Arena','Hungary','Budapest',null, null, '20022')
insert into Arena values
(14,'Poliedro de Caracas','Venezuela','Caracas',null, null, '20000')
insert into Arena values
(15,'Altice Arena','Portugal','Lisbon',null, null, '20000')
insert into Arena values
(16,'Coliseo Amauta','Peru','Lima',null, null, '20000')
insert into Arena values
(17,'Amway Center','US','Florida',null, null, '20000')
insert into Arena values
(18,'Ticketpro Dome','South Africa','Gauteng',null, null, '20000')
insert into Arena values
(19,'Rogers Arena','Canada','Vancouver',null, null, '19700')
insert into Arena values
(20,'Oracle Arena','US','California',null, null, '19596')
insert into Arena values
(21,'TD Garden','US','Boston',null, null, '19580')
insert into Arena values
(22,'Bud Walton Arena','US','Arkansas',null, null, '19368')
insert into Arena values
(23,'KeyBank Center','US','New York',null, null, '19200')
insert into Arena values
(24,'Legacy Arena','US','Alabama',null, null, '19000')
insert into Arena values
(25,'Marriott Center','US','Utah',null, null, '18987')
insert into Arena values
(26,'Jeunesse Arena','Brazil','Rio de Janeiro',null, null, '18768')
insert into Arena values
(27,'Cadillac Arena','China','Bejing',null, null, '18000')
insert into Arena values
(28,'Dalian Arena','China','Dalian',null, null, '18000')

select *
from Koncerti

insert into Koncerti values
(1,'No Filter Tour', 4)
insert into Koncerti values
(2,'KThe Wall Live', 6)
insert into Koncerti values
(3,'Vertigo Tour', 9)
insert into Koncerti values
(4,'World Tour', 24)
insert into Koncerti values
(5,'Wrecking Ball World Tour', 28)
insert into Koncerti values
(6,'Reputation Stadium Tour', 7)
insert into Koncerti values
(7,'Voodoo Lounge Tour', 8)
insert into Koncerti values
(8,'Farewell Yellow Brick Road', 10)
insert into Koncerti values
(9,'The Police Reunion Tour', 11)
insert into Koncerti values
(10,'Beautiful Trauma World Tour', 1)
insert into Koncerti values
(11,'WorldWired Tour', 21)
insert into Koncerti values
(12,'Black Ice World Tour', 22)
insert into Koncerti values
(13,'The Wall Live', 19)
insert into Koncerti values
(14,'A Head Full of Dreams Tour', 17)
insert into Koncerti values
(15,'Prism Tour', 15)
insert into Koncerti values
(16,'A Bigger Bang Tour', 5)
insert into Koncerti values
(17,'Bad World Tour', 3)
insert into Koncerti values
(18,'Sweetener World Tour', 27)
insert into Koncerti values
(19,'Steel Wheels Tour', 18)
insert into Koncerti values
(20,'Glass Spider Tour', 16)
insert into Koncerti values
(21,'Honeymoon Tour', 13)
insert into Koncerti values
(22,'The Joshua Tree Tour', 14)
insert into Koncerti values
(23,'Zoo TV Tour', 20)
insert into Koncerti values
(24,'Come On Over Tour', 2)
insert into Koncerti values
(25,'The Girlie Show', 26)
insert into Koncerti values
(26,'Atomic Jazz', null)

select *
from Performuesi

insert into Performuesi values
(1,'Ariana', 'Grande', 'F', '6/26/1993', null, 10, 18)
insert into Performuesi values
(2,'Michael', 'Jackson', 'M', '8/29/1958', null, 17, 6)
insert into Performuesi values
(3,'Taylor', 'Swift', 'F', '12/13/1989', null, 8, 10)
insert into Performuesi values
(4,'Lady', 'Gaga', 'F', '3/28/1986', null, 15, 3)
insert into Performuesi values
(5,'Elvis', 'Presley', 'M', '1/8/1935', null, 27, 4)
insert into Performuesi values
(6,'Selena', 'Gomez', 'F', '7/22/1992', null, 2, 9)
insert into Performuesi values
(7,'Beyonce', ' Knowles', 'F', '9/4/1981', null, 28, 16)
insert into Performuesi values
(8,'Jennifer', ' Lopez', 'F', '7/24/1969', null, 21, 8)
insert into Performuesi values
(9,'Britney', ' Spears', 'F', '12/2/1981', null, 24, 11)
insert into Performuesi values
(10,'Snoop', 'Dogg', 'M', '10/20/1971', null, 16, 15)
insert into Performuesi values
(11,'Bruno', 'Mars', 'M', '10/8/1985', null, 13, 1)
insert into Performuesi values
(12,'Demi', 'Lovato', 'F', '8/20/1992', null, 5, 25)
insert into Performuesi values
(13,'Katy', 'Perry', 'F', '10/25/1984', null, 19, 7)
insert into Performuesi values
(14,'Travis', 'Scott', 'M', '4/30/1992', null, 6, 5)
insert into Performuesi values
(15,'Whitney', 'Houston', 'F', '8/9/1963', null, 14, 22)
insert into Performuesi values
(16,'Ice', 'Cube', 'M', '6/15/1969', null, 25, 2)
insert into Performuesi values
(17,'Dolly', 'Parton', 'F', '1/19/1946', null, 11, 21)
insert into Performuesi values
(18,'Johnny', 'Cash', 'M', '2/26/1932', null, 12, 17)
insert into Performuesi values
(19,'Frank', 'Sinatra', 'M', '12/12/1915', null, 26, 14)
insert into Performuesi values
(20,'Frank', 'Sinatra', 'M', '12/12/1915', null, 20, 20)
insert into Performuesi values
(21,'Mariah', 'Carey', 'F', '3/27/1970', null, 22, 24)
insert into Performuesi values
(22,'Kendrick', 'Lamar', 'M', '6/17/1987', null, 7, 23)
insert into Performuesi values
(23,'Robyn', ' Fenty', 'F', '2/20/1988', null, 9, 19)
insert into Performuesi values
(24,'Gwen', ' Stefani', 'F', '10/3/1969', null, 23, 13)
insert into Performuesi values
(25,'Alicia', ' Keys', 'F', '1/25/1981', null, 4, 12)
insert into Performuesi values
(26,'Summer', ' Walker', 'F', '4/11/1996', null, null, null)
insert into Performuesi values
(27,'Ella', ' Mai', 'F', '11/3/1994', null, null, null)

select *
from Pjesemarresi

insert into Pjesemarresi values
(1,'Ema', 'Kutllovci', 'F', '7/04/2002', null, '1242998345','Kosove','Prishtina',null, null)
insert into Pjesemarresi values
(2,'Verona', 'Tahiri', 'F', '4/24/2002', null, '1244556856','Kosovo','Prishtina',null, null)
insert into Pjesemarresi values
(3,'Joni', 'Shala', 'M', '3/14/2001', null, '1244526451','Canada','Toronto',null, null)
insert into Pjesemarresi values
(4,'Albana', 'Berisha', 'F', '8/10/2000', null, '1225728451','US','Boston',null, null)
insert into Pjesemarresi values
(5,'Vesa', 'Gashi', 'F', '12/6/2000', null, '1223627452','US','Michigan',null, null)
insert into Pjesemarresi values
(6,'Artan', 'Morina', 'M', '12/28/2001', null, '1223627657','US','California',null, null)
insert into Pjesemarresi values
(7,'Victor', 'Perez', 'M', '11/22/1999', null, '1223621435','Spain','Barcelona',null, null)
insert into Pjesemarresi values
(8,'Mateo', 'Carlos', 'M', '10/30/1994', null, '1216326435','Italy','Verona',null, null)
insert into Pjesemarresi values
(9,'Sarah', 'Smith', 'F', '11/28/1996', null, '1219136385','UK','London',null, null)
insert into Pjesemarresi values
(10,'Marcus', 'Schmidt', 'M', '11/15/1992', null, '1345616263','Germany','Munich',null, null)
insert into Pjesemarresi values
(11,'Sylvie', 'Lavaux', 'F', '2/19/1991', null, '1124523329','France','Paris',null, null)
insert into Pjesemarresi values
(12,'Janne', 'Michaelsen', 'F', '1/25/1993', null, '1225526389','Norway','Oslo',null, null)
insert into Pjesemarresi values
(13,'Anton', 'Alvarez', 'M', '3/22/1999', null, '1124424599','Canada','Vancouver',null, null)
insert into Pjesemarresi values
(14,'Anton', 'Alvarez', 'M', '3/13/1993', null, '1224321529','Canada','Calgary',null, null)
insert into Pjesemarresi values
(15,'Elias', ' Blegen', 'M', '11/1/1997', null, '1257891456','Norway','Bergen',null, null)
insert into Pjesemarresi values
(16,'Ami', 'Bush', 'F', '12/4/1998', null, '1277411352','UK','Liverpool',null, null)
insert into Pjesemarresi values
(17,'Constantinus', 'Mahdi', 'M', '6/25/1993', null, '1124532456','US','Las Vegas',null, null)
insert into Pjesemarresi values
(18,'Noah', 'Beck', 'M', '7/25/1999', null, '1124529987','US','California',null, null)
insert into Pjesemarresi values
(19,'Liam', 'McCartney', 'M', '12/12/2001', null, '1124524432','US','Los Angeles',null, null)
insert into Pjesemarresi values
(20,'Fahrie', 'Yilmaz', 'F', '5/10/1995', null, '1234514569','Turkey','Istanbul',null, null)
insert into Pjesemarresi values
(21,'Doriane', 'Cadmus', 'F', '7/12/1998', null, '1124528876','Norway','Oslo',null, null)
insert into Pjesemarresi values
(22,'Adil', 'Devi', 'M', '2/1/1997', null, '1225579376','India','Mumbai',null, null)
insert into Pjesemarresi values
(23,'Jozua', 'Anastasia', 'M', '4/18/2000', null, '1124963276','Germany','Frankfurt',null, null)
insert into Pjesemarresi values
(24,'Paislee', 'Ave', 'F', '7/22/2002', null, '1124875686','Italy','Turin',null, null)
insert into Pjesemarresi values
(25,'Naoise', 'Cerdic', 'F', '3/28/2001', null, '1129634086','South America','Peru',null, null)
insert into Pjesemarresi values
(26,'Kazuo', 'Kamaria', 'M', '9/28/2003', null, '1129688456','India','Surat',null, null)

select *
from Stafi

insert into Stafi values
(1,'Ramiro','Gilbert','123456','32',null,'M','US','New York', null, null, 4)
insert into Stafi values
(2,'Aedan','Powell','122457','28',null,'M','US','Texas', null, null, 6)
insert into Stafi values
(3,'Jody','Sandoval','121458','29',null,'F','US','Arizona', null, null, 9)
insert into Stafi values
(4,'Tasha','Payne','124359','32',null,'F','UK','London', null, null, 24)
insert into Stafi values
(5,'Monique','Vaughn','123526','34',null,'F','Spain','Madrid', null, null, null)
insert into Stafi values
(6,'Pedro','Cunningham','12352621','39',null,'M','Portugal','Lisbon', null, null, 7)
insert into Stafi values
(7,'Alton','Hart','143352621','39',null,'M','US','Missisippi', null, null, 8)
insert into Stafi values
(8,'Casey','Parsons','124226912','40',null,'F','US','Texas', null, null, 10)
insert into Stafi values
(9,'Jake','Thomas','121526782','28',null,'M','US','New Jersey', null, null, 11)
insert into Stafi values
(10,'Della','Snyder','129826901','29',null,'F','US','Nashville', null, null, 1)
insert into Stafi values
(11,'Leslie','Davis','112312','39',null,'F','US','San Francisco', null, null, 21)
insert into Stafi values
(12,'Nola','Gonzalez','1453981','30',null,'F','Brazil','Brasilia', null, null, 22)
insert into Stafi values
(13,'Phyllis','Bradley','121354526','41',null,'M','US','Austin', null, null, 19)
insert into Stafi values
(14,'Duane','Diaz','129842144','43',null,'M','UK','Manchester', null, null, 17)
insert into Stafi values
(15,'Sonja','Cortez','139176318','30',null,'F','US','Detroit', null, null, 15)
insert into Stafi values
(16,'Joy','Hill','103986283','28',null,'M','US','New Orleans', null, null, 5)
insert into Stafi values
(17,'Hugo','Yates','12345526','26',null,'M','US','Houston', null, null, 3)
insert into Stafi values
(18,'Toby','Maxwell','129947827','31',null,'M','France','Paris', null, null, null)
insert into Stafi values
(19,'Sheryl','Simpson','12345632','34',null,'F','US','New Jersey', null, null, 18)
insert into Stafi values
(20,'Lorraine','Stone','7283627','38',null,'F','US','San Antonio', null, null, 16)
insert into Stafi values
(21,'Doreen','Carpenter','3762567','33',null,'F','UK','Edinburgh', null, null, 13)
insert into Stafi values
(22,'Serene','Smith','2138998','26',null,'F','US','Tampa', null, null, 14)
insert into Stafi values
(23,'Luna','Tahiri','126776','29',null,'F','US','Miami', null, null, 20)
insert into Stafi values
(24,'Kyle','Blake','898987','32',null,'M','Austria','Vienna', null, null, 2)
insert into Stafi values
(25,'Kimberly','Clayton','8281009','25',null,'F','Germany','Berlin', null, null, null)
insert into Stafi values
(26,'Janet','Hawkins','19299873','45',null,'F','UK','London', null, null, 4)
insert into Stafi values
(27,'Donald','Schultz','646239','49',null,'M','US','Madison', null, null, 6)
insert into Stafi values
(28,'Austin','Knight','12635265','32',null,'M','US','Tucson', null, null, 9)
insert into Stafi values
(29,'Marcus','Hamilton','2276676','29',null,'M','US','Omaha', null, null, 24)
insert into Stafi values
(30,'Katherine','Flowers','21822377','28',null,'F','UK','Sheffield', null, null, null)
insert into Stafi values
(31,'Ruben','Murphy','7237787','48',null,'M','US','Columbus', null, null, 7)
insert into Stafi values
(32,'Clarence','Higgins','1726716','23',null,'F','US','Boise', null, null, 8)
insert into Stafi values
(33,'Regina','Luna','1299382','21',null,'F','US','Las Vegas', null, null, 10)
insert into Stafi values
(34,'Doris','Arnold','2626266','29',null,'M','US','Cambridge', null, null, 11)
insert into Stafi values
(35,'Tonya','Valdez','2625386','29',null,'F','Spain','Barcelona', null, null, 1)
insert into Stafi values
(36,'Beth','Carson','1929883','39',null,'F','US','Omaha', null, null, 21)
insert into Stafi values
(37,'Noah','Sherman','23872778','46',null,'M','US','El Paso', null, null, 22)
insert into Stafi values
(38,'Cora','Logan','32237667','39',null,'F','US','Sacramento', null, null, 19)
insert into Stafi values
(39,'Rudy','Newton','235536','43',null,'F','Kosovo','Prishtina', null, null, 17)
insert into Stafi values
(40,'Marcella','Osborne','2399889','54',null,'F','Portugal','Lisbon', null, null, 15)

select *
from Stage

insert into Stage values
('1', null)
insert into Stage values
('2', null)
insert into Stage values
('3', null)
insert into Stage values
('4', null)
insert into Stage values
('5', null)
insert into Stage values
('6', null)
insert into Stage values
('7', null)
insert into Stage values
('8', null)
insert into Stage values
('9', null)
insert into Stage values
('10', null)

select *
from Tekniku

insert into Tekniku  values
(1,'Ndriqimi', 1, 10, 1)
insert into Tekniku  values
(2,'Zerimi', 2, 9, 3)
insert into Tekniku  values
(3,'Video', 3, 8, 8)
insert into Tekniku  values
(4,'Fencing', 4, 7, 2)
insert into Tekniku  values
(5,'Zerimi', 5, 6, 9)
insert into Tekniku  values
(6,'Video', 6, 5, 4)
insert into Tekniku  values
(7,'Ndriqimi', 7, 4, 7)
insert into Tekniku  values
(8,'Fencing', 8, 3, 5)
insert into Tekniku  values
(9,'Video', 9, 2, 6)
insert into Tekniku  values
(10,'Zerimi', 10, 1, 10)

select *
from Sigurimi

insert into Sigurimi values
(1,'Bodyguard',  1, 20)
insert into Sigurimi values
(2,'Monitorues',  2, 21)
insert into Sigurimi values
(3,'Percjelles', 3, 22)
insert into Sigurimi values
(4,'Monitorues', 4, 23)
insert into Sigurimi values
(5,'Percjelles', 5, 24)
insert into Sigurimi values
(6,'Bodyguard', 6, 25)
insert into Sigurimi values
(7,'Bodyguard', 7, 26)
insert into Sigurimi values
(8,'Monitorues', 8, 27)
insert into Sigurimi values
(9,'Monitorues', 9, 28)
insert into Sigurimi values
(10,'Percjelles', 10, 29)

select *
from Mirembajtesi

insert into Mirembajtesi values
(1,'Dezinfektimi', 10, 30)
insert into Mirembajtesi values
(2,'Pastrimi i stage', 14, 31)
insert into Mirembajtesi values
(3,'Pastrimi i uleseve', 25, 32)
insert into Mirembajtesi values
(4,'Dezinfektimi', 6, 33)
insert into Mirembajtesi values
(5,'Pastrimi i stage', 2, 34)
insert into Mirembajtesi values
(6,'Pastrimi i uleseve', 13, 35)
insert into Mirembajtesi values
(7,'Dezinfektimi', 17, 36)
insert into Mirembajtesi values
(8,'Dezinfektimi', 28, 37)
insert into Mirembajtesi values
(9,'Pastrimi i stage', 16, 38)
insert into Mirembajtesi values
(10,'Pastrimi i uleseve', 9, 39)

select *
from Restaurant

insert into Restaurant values 
(1,'The Pink Door','8:00', null, 12)
insert into Restaurant values 
(2,'Blue Mermaid','11:00', null, 10)
insert into Restaurant values 
(3,'Bamboo House','09:00', null, 3)
insert into Restaurant values 
(4,'Thai the Knot','07:00', null, 7)
insert into Restaurant values 
(5,'Coconut Garden','08:30', null, 26)
insert into Restaurant values 
(6,'Bella Bella Mozzarella','10:00', null, 20)
insert into Restaurant values 
(7,'Classico Italiano','10:30', null, 1)
insert into Restaurant values 
(8,'Guacamole Brothers','12:00', null, 11)
insert into Restaurant values 
(9,'Burrito Boyz','09:00', null, 19)
insert into Restaurant values 
(10,'Tikkaway','10:00', null, 18)
insert into Restaurant values 
(11,'Curry Kingdom','08:00', null, 17)
insert into Restaurant values 
(12,'Curry Leaves','08:30', null, 25)
insert into Restaurant values 
(13,'Taste of Bavaria','06:00', null, 22)
insert into Restaurant values 
(14,'World of Wurst','10:30', null, 6)
insert into Restaurant values 
(15,'Rasta Pasta','11:00', null, 13)
insert into Restaurant values 
(16,'Just Jerks','09:00', null, 4)
insert into Restaurant values 
(17,'Pegasus Taverna','10:30', null, 5)
insert into Restaurant values 
(18,'Pita Heaven','09:30', null, 23)
insert into Restaurant values 
(19,'Pizza Pit','10:30', null, 8)
insert into Restaurant values 
(20,'Wok to Walk','10:00', null, 9)
insert into Restaurant values 
(21,'Steak ‘n Shake','08:00', null, 14)
insert into Restaurant values 
(22,'Whataburger','08:00', null, 15)
insert into Restaurant values 
(23,'Brunch Bowl','08:30', null, 21)
insert into Restaurant values 
(24,'Barely Vegan','09:30', null, 16)
insert into Restaurant values 
(25,'Plant Power Fast Food','09:30', null, null)

select *
from Dhoma

insert into Dhoma values 
('110', '1', 4)
insert into Dhoma values 
('111', '2', 10)
insert into Dhoma values 
('112', '2', 12)
insert into Dhoma values 
('113', '3', 21)
insert into Dhoma values 
('114', '4', 19)
insert into Dhoma values 
('115', '5', 14)
insert into Dhoma values 
('116', '5', 12)
insert into Dhoma values 
('117', '4', 11)
insert into Dhoma values 
('118', '3', 22)
insert into Dhoma values 
('119', '2', 6)
insert into Dhoma values 
('120', '1', 25)
insert into Dhoma values 
('121', '1', 8)
insert into Dhoma values 
('122', '2', 5)
insert into Dhoma values 
('123', '4', 2)
insert into Dhoma values 
('124', '5', 26)
insert into Dhoma values 
('125', '6', 20)
insert into Dhoma values 
('126', '6', 27)
insert into Dhoma values 
('127', '2', 1)
insert into Dhoma values 
('128', '1', 7)
insert into Dhoma values 
('129', '2', 9)
insert into Dhoma values 
('130', '1', 13)
insert into Dhoma values 
('131', '1', 11)
insert into Dhoma values 
('132', '2', 14)
insert into Dhoma values 
('133', '4', 19)
insert into Dhoma values 
('134', '4', 3)

select *
from Playlist

insert into Playlist values
(1,'Disco Baby',1)
insert into Playlist values
(2,'Deja Vu',2)
insert into Playlist values
(3,'Viral Hits',3)
insert into Playlist values
(4,'Party',23)
insert into Playlist values
(5,'In my Feels',10)
insert into Playlist values
(6,'Sleepy Sonnets',13)
insert into Playlist values
(7,'Take me Home',21)
insert into Playlist values
(8,'Crowd Pleasers',11)
insert into Playlist values
(9,'Touch and Shine',25)
insert into Playlist values
(10,'Your Blue Eyes',5)
insert into Playlist values
(11,'Smells Like Grass',9)
insert into Playlist values
(12,'What is LOVE?',24)
insert into Playlist values
(13,'Come and Go',18)

select *
from Kenget

insert into Kenget values
(1,'Middle Of The Night', null, null, 3.99, 3)
insert into Kenget values
(2,'Positions', null, null, 2.99, 6)
insert into Kenget values
(3,'Blank Space', null, null, 0.99, 2)
insert into Kenget values
(4,'Cool for the summer', null, null, 3.99, 9)
insert into Kenget values
(5,'No tears left to cry', null, null, 4.99, 11)
insert into Kenget values
(6,'Obsessed', null, null, 0.99, 12)
insert into Kenget values
(7,'Starboy', null, null, 2.99, 4)
insert into Kenget values
(8,'Halo', null, null, 2.99, 7)
insert into Kenget values
(9,'Take a bow', null, null, 3.99, 13)
insert into Kenget values
(10,'Mirrors', null, null, 3.99, 1)

select *
from Banda

insert into Banda values 
(1,'ABBA', '4', 1)
insert into Banda values 
(2,'ACDC', '6', 2)
insert into Banda values 
(3,'Aerosmith', '5', 3)
insert into Banda values 
(4,'The Animals', '5', 4)
insert into Banda values 
(5,'Arcade Fire', '6', 5)
insert into Banda values 
(6,'The Beatles', '4', 6)
insert into Banda values 
(7,'Big Star', '4', 7)
insert into Banda values 
(8,'Coldplay', '4', 8)
insert into Banda values 
(9,'The Eagles', '6', 9)
insert into Banda values 
(10,'The Flamingos', '6', 10)
insert into Banda values 
(11,'Green Day', '3', 11)
insert into Banda values 
(12,'Jonas Brothers', '3', 12)
insert into Banda values 
(13,'The Louvin Brothers', '2', 13)
insert into Banda values 
(14,'Love', '6', 14)
insert into Banda values 
(15,'Metallica', '5', 15)

select *
from Kioska

insert into Kioska values 
(11,'US','New York',null, null, '12311311')
insert into Kioska values 
(23,'UK','Manchester',null, null, '82737327')
insert into Kioska values 
(31,'US','Florida',null, null, '74728834')
insert into Kioska values 
(48,'US','California',null, null, '1892891')
insert into Kioska values 
(53,'US','Washington',null, null, '3662388')
insert into Kioska values 
(62,'UK','London',null, null, '2189813')
insert into Kioska values 
(71,'US','New Jersey',null, null, '23929388')
insert into Kioska values 
(80,'US','Alabama',null, null, '2323877')
insert into Kioska values 
(91,'US','Ohio',null, null, '32823988')
insert into Kioska values 
(12,'US','Orlando',null, null, '23023998')
insert into Kioska values 
(10,'US','Detorit',null, null, '9288932')
insert into Kioska values 
(41,'Germany','Berlin',null, null, '82398238')
insert into Kioska values 
(94,'Switzerland','Zurich',null, null, '3282398')
insert into Kioska values 
(85,'US','Idaho',null, null, '2932389')
insert into Kioska values 
(97,'Italy','Verona',null, null, '28982982')
insert into Kioska values 
(50,'Italy','Florence',null, null, '3723782')
insert into Kioska values 
(28,'Austria','Vienna',null, null, '13213344')
insert into Kioska values 
(19,'France','Paris',null, null, '94238438')
insert into Kioska values 
(20,'Norway','Oslo',null, null, '3235467')
insert into Kioska values 
(72,'South America','Peru',null, null, '83548989')
insert into Kioska values 
(17,'US','Alaska',null, null, '38948923')
insert into Kioska values
(25,'Germany','Frankfurt',null, null, '747278723')
insert into Kioska values 
(2,'Albania','Tirana',null, null, '29823923')
insert into Kioska values 
(4,'US','San Francisco',null, null, '328328239')

select *
from Bileta

insert into Bileta values
(1,1,'2','3',null,null,'VIP', 2)
insert into Bileta values
(2,2,'1','2',null,null,'VIP', 4)
insert into Bileta values
(3,3,'3','4',null,null,'VIP', 10)
insert into Bileta values
(4,4,'6','5',null,null,'CHILD', 12)
insert into Bileta values
(5,5,'4','1',null,null,'VIP', 17)
insert into Bileta values
(6,6,'5','0',null,null,'ADULT', 19)
insert into Bileta values
(7,7,'1','1',null,null,'ADULT', 23)
insert into Bileta values
(8,8,'4','2',null,null,'VIP', 20)
insert into Bileta values
(9,9,'5','1',null,null,'VIP', 50)
insert into Bileta values
(10,10,'18','3',null,null,'CHILD', 53)
insert into Bileta values
(11,11,'21','2',null,null,'CHILD', 62)
insert into Bileta values
(12,12,'34','3',null,null,'VIP', 71)
insert into Bileta values
(13,13,'45','6',null,null,'ADULT', 72)
insert into Bileta values
(14,14,'12','3',null,null,'ADULT', 80)
insert into Bileta values
(15,15,'18','4',null,null,'ADULT', 85)

select *
from Dizajneri

insert into Dizajneri values
(1,'Valdrin','Sahiti','M', 37)
insert into Dizajneri values
(2,'Coco','Chanel','F', 45)
insert into Dizajneri values
(3,'Donna','Karan','F', 29)
insert into Dizajneri values
(4,'Giorgio','Armani','M', 52)
insert into Dizajneri values
(5,'Calvin','Klein','M', 46)
insert into Dizajneri values
(6,'Donatella','Versace','F', 58)
insert into Dizajneri values
(7,'Ralph','Lauren','M', 49)
insert into Dizajneri values
(8,'Christian','Dior','M', 51)
insert into Dizajneri values
(9,'Tom','Ford','M', 53)
insert into Dizajneri values
(10,'Pierre','Cardin','M', 61)
insert into Dizajneri values
(11,'Christian','Louboutin','M', 64)
insert into Dizajneri values
(12,'Karl','Lagerfeld','M', 57)
insert into Dizajneri values
(13,'Roberto','Cavalli','M', 35)
insert into Dizajneri values
(14,'Marc','Jacobs','M', 36)
insert into Dizajneri values
(15,'Betsey','Johnson','M', 24)
insert into Dizajneri values
(16,'Sandy','Powell','M', 22)
insert into Dizajneri values
(17,'Valentino','Garavani','M', 46)
insert into Dizajneri values
(18,'Miuccia','Prada','F', 72)
insert into Dizajneri values
(19,'Tommy','Hilfiger','M', 74)
insert into Dizajneri values
(20,'Carolina','Herrera','F', 36)
insert into Dizajneri values
(21,'Herve','Leger','M', 38)
insert into Dizajneri values
(22,'Stella','McCartney','F', 29)
insert into Dizajneri values
(23,'Ralph','Rucci','M', 28)
insert into Dizajneri values
(24,'Salvatori','Ferragamo','M', 43)
insert into Dizajneri values
(25,'Daphne','Guinness','F', 41)

select *
from Makeup_Artist

insert into Makeup_Artist values
(1,'Sellma', 'Kasumoviq', 'F', 38)
insert into Makeup_Artist values
(2,'Mario', 'Dedivanovic', 'M', 39)
insert into Makeup_Artist values
(3,'Pat', 'McGrath', 'F', 32)
insert into Makeup_Artist values
(4,'Mary', 'Greenwell', 'F', 33)
insert into Makeup_Artist values
(5,'Matthew', 'VanLeeuwen', 'M', 37)
insert into Makeup_Artist values
(6,'Allan', 'Avendano', 'M', 43)
insert into Makeup_Artist values
(7,'Sir', 'John', 'M', 45)
insert into Makeup_Artist values
(8,'Lisa', ' Eldridge', 'F', 34)
insert into Makeup_Artist values
(9,'Sarah', 'Tanno', 'F', 35)
insert into Makeup_Artist values
(10,'Hung', 'Vango', 'M', 42)
insert into Makeup_Artist values
(11,'Patrick', 'Ta', 'M', 36)
insert into Makeup_Artist values
(12,'Mylah', 'Morales', 'F', 39)
insert into Makeup_Artist values
(13,'Kate', 'Lee', 'F', 40)
insert into Makeup_Artist values
(14,'Vincent', 'Oquendo', 'M', 41)
insert into Makeup_Artist values
(15,'Pati', 'Dubroff', 'F', 49)
insert into Makeup_Artist values
(16,'Charlotte', 'Tilbury', 'F', 48)
insert into Makeup_Artist values
(17,'Emily', 'Cheng', 'F', 46)
insert into Makeup_Artist values
(18,'Priscilla', 'Ono', 'F', 25)
insert into Makeup_Artist values
(19,'AJ', 'Crimson', 'M', 29)
insert into Makeup_Artist values
(20,'Nam', 'Vo', 'F', 26)
insert into Makeup_Artist values
(21,'Lisa', 'Elridge', 'F', 24)
insert into Makeup_Artist values
(22,'James', 'Charles', 'M', 22)
insert into Makeup_Artist values
(23,'Huda', 'Kattan', 'F', 27)
insert into Makeup_Artist values
(24,'Hrush', 'Achemyan', 'M', 21)
insert into Makeup_Artist values
(25,'Jefree', 'Star', 'F', 28)

select *
from Paga

insert into Paga values
(1,500.0, 350.0, 150.0, 1)
insert into Paga values
(2,300.0, 150.0, 150.0, 2)
insert into Paga values
(3, 650.0, 350.0, 250.0, 3)
insert into Paga values
(4, 700.0, 350.0, 350.0, 4)
insert into Paga values
(5, 400.0, 200.0, 200.0, 5)
insert into Paga values
(6, 500.0, 150.0, 350.0, 6)
insert into Paga values
(7, 400.0, 100.0, 300.0, 7)
insert into Paga values
(8, 200.0, 150.0, 50.0, 8)
insert into Paga values
(9, 550.0, 350.0, 200.0, 9)
insert into Paga values
(10, 750.0, 350.0, 450.0, 10)
insert into Paga values
(11, 500.0, 250.0, 250.0, 11)
insert into Paga values
(12, 800.0, 400.0, 400.0, 12)
insert into Paga values
(13, 200.0, 120.0, 80.0, 13)
insert into Paga values
(14, 500.0, 400.0, 100.0, 14)
insert into Paga values
(15, 900.0, 450.0, 450.0, 15)

select *
from Nga

insert into Nga values
(1,3,'02:00')
insert into Nga values
(2,2,'01:30')
insert into Nga values
(3,5,'03:00')
insert into Nga values
(4,8,'02:30')
insert into Nga values
(5,12,'01:00')
insert into Nga values
(6,20,'00:30')
insert into Nga values
(7,17,'02:00')
insert into Nga values
(8,11,'01:30')
insert into Nga values
(9,19,'01:00')
insert into Nga values
(10,25,'01:30')
insert into Nga values
(11,4,'01:30')
insert into Nga values
(12,22,'00:30')
insert into Nga values
(13,23,'03:30')
insert into Nga values
(14,21,'04:00')
insert into Nga values
(15,24,'02:30')

select *
from Takon

insert into Takon values
(14,2,null)
insert into Takon values
(6,15,null)
insert into Takon values
(9,8,null)
insert into Takon values
(4,11,null)
insert into Takon values
(23,12,null)
insert into Takon values
(19,17,null)
insert into Takon values
(20,18,null)
insert into Takon values
(25,22,null)
insert into Takon values
(16,1,null)
insert into Takon values
(2,25,null)
insert into Takon values
(17,24,null)
insert into Takon values
(18,23,null)
insert into Takon values
(22,19,null)
insert into Takon values
(7,9,null)
insert into Takon values
(5,3,null)

select *
from Kontrolli

insert into Kontrolli values
(1,1,1)
insert into Kontrolli values
(2,2,2)
insert into Kontrolli values
(3,3,3)
insert into Kontrolli values
(4,4,4)
insert into Kontrolli values
(5,5,5)
insert into Kontrolli values
(6,6,6)
insert into Kontrolli values
(7,7,7)
insert into Kontrolli values
(8,8,8)
insert into Kontrolli values
(9,9,9)
insert into Kontrolli values
(10,10,10)

select *
from Nr_Telefonit

insert into Nr_Telefonit values
(1, 18, 2, 16, 3)
insert into Nr_Telefonit values
(2, 9, 3, 19, 18)
insert into Nr_Telefonit values
(3, 26, 5, 20, 4)
insert into Nr_Telefonit values
(4, 21, 7, 22, 9)
insert into Nr_Telefonit values
(5, 13, 10, 24, 12)
insert into Nr_Telefonit values
(6, 2, 1, 1, 1)
insert into Nr_Telefonit values
(7, 25, 12, 21, 6)
insert into Nr_Telefonit values
(8, 14, 25, 3, 7)
insert into Nr_Telefonit values
(9, 11, 24, 4, 23)
insert into Nr_Telefonit values
(10, 18, 9, 2, 5)
insert into Nr_Telefonit values
(11, 16, 16, 17, 20)
insert into Nr_Telefonit values
(12, 19, 6, 25, 17)
insert into Nr_Telefonit values
(13, 8, 13, 5, 10)
insert into Nr_Telefonit values
(14, 10, 8, 11, 24)
insert into Nr_Telefonit values
(15, 4, 17, 23, 25)


select *
from Perkujdeset

insert into Perkujdeset values
(4,4,8)
insert into Perkujdeset values
(8,6,20)
insert into Perkujdeset values
(11,9,19)
insert into Perkujdeset values
(6,2,2)
insert into Perkujdeset values
(17,15,24)
insert into Perkujdeset values
(23,1,3)
insert into Perkujdeset values
(21,10,25)
insert into Perkujdeset values
(25,13,23)
insert into Perkujdeset values
(19,5,12)
insert into Perkujdeset values
(9,8,11)
insert into Perkujdeset values
(5,3,5)
insert into Perkujdeset values
(14,12,22)
insert into Perkujdeset values
(1,14,21)
insert into Perkujdeset values
(20,7,17)
insert into Perkujdeset values
(22,11,4)

select *
from Sherben

insert into Sherben values
(4,11,4)
insert into Sherben values
(5,3,9)
insert into Sherben values
(9,8,5)
insert into Sherben values
(6,15,7)
insert into Sherben values
(7,9,3)
insert into Sherben values
(16,1,6)
insert into Sherben values
(17,24,10)
insert into Sherben values
(18,23,11)
insert into Sherben values
(19,17,2)
insert into Sherben values
(20,18,8)
insert into Sherben values
(22,19,12)
insert into Sherben values
(23,12,17)
insert into Sherben values
(25,22,13)
insert into Sherben values
(1,2,1)
insert into Sherben values
(2,25,15)


UPDATE Performuesi
SET Emri = 'Justin'
WHERE Performuesi_ID = 1;

UPDATE Performuesi
SET Mbiemri = 'Bieber'
WHERE Performuesi_ID = 1;

select * from Performuesi

UPDATE Pjesemarresi
SET Shteti = 'Hungary'
WHERE Pjesemarresi_ID = 6;

UPDATE Pjesemarresi
SET Qyteti = 'Budapest'
WHERE Pjesemarresi_ID = 6;

select * from Pjesemarresi

UPDATE Koncerti
SET Emri = 'SunnyHill'
WHERE Koncerti_ID = 2;

select * from Koncerti

UPDATE Arena
SET Emri = 'Fadil Vokrri'
WHERE Arena_ID = 15;

UPDATE Arena
SET Shteti = 'Kosovo'
WHERE Arena_ID = 15;

UPDATE Arena
SET Qyteti = 'Prishtina'
WHERE Arena_ID = 15;

select * from Arena

UPDATE Banda
SET Nr_I_Artisteve = '4'
WHERE Banda_ID = 12;

select * from Banda

UPDATE Dhoma
SET Kati = '6'
WHERE Dhoma_ID = 24;

select * from Dhoma

UPDATE Kenget
SET Çmimi_I_Kenges = 7.99
WHERE Kenget_ID = 10;

select * from Kenget

UPDATE Kioska
SET Numri_I_Tiketes = '623949247'
WHERE Kioska_ID = 12;

select * from Kioska

UPDATE Bileta
SET Lloji = 'VIP'
WHERE Bileta_ID = 2;

select * from Bileta

UPDATE Makeup_Artist
SET Emri= 'Ariel'
WHERE Makeup_Artist_ID=7;

UPDATE Makeup_Artist
SET Mbiemri='Tejada'
WHERE Makeup_Artist_ID=7;

select * from Makeup_Artist

UPDATE Paga
SET Taksa= 900.00
WHERE Paga_ID=2;

UPDATE Paga
SET Bruto_Paga= 400.00
WHERE Paga_ID= 6;

select * from Paga

UPDATE Restaurant
SET Orari_I_Punes= '10:30'
WHERE Restaurant_ID=3;

select * from Restaurant

UPDATE Sigurimi
SET Lloji='Bodyguard'
WHERE Stafi_ID_Sigurimi=10;

select * from Sigurimi

UPDATE Playlist
SET Emri_I_Playlist='Fun in the Sun'
WHERE Playlist_ID = 3;

select * from Playlist

DELETE 
FROM  Tekniku
WHERE Fusha like 'Zerimi';

select * from Tekniku

DELETE
FROM  Kenget
WHERE Çmimi_I_Kenges=3.99;

select * from Kenget

DELETE 
FROM  Kontrolli
WHERE Stafi_ID_Sigurimi = 7;

select * from Kontrolli

DELETE 
FROM  Banda
WHERE Nr_I_Artisteve>3;

select * from Banda

DELETE 
From Bileta 
WHERE Pjesemarresi_ID  = 10;

select * from Bileta

DELETE 
FROM  Banda
WHERE Performuesi_ID = 13;
 
select * from Banda

DELETE 
FROM Dizajneri
WHERE Mosha < 45 ;

select * from Dizajneri

DELETE 
FROM Koncerti
WHERE Arena_ID = 11;

select * from Arena

DELETE 
FROM Makeup_Artist
WHERE Gjinia like 'F'; 

select * from Makeup_Artist

DELETE 
FROM Performuesi
WHERE Datelindja like '1993-06-26';

DELETE 
From Pjesemarresi 
WHERE Datelindja  > '6/20/2002';

DELETE 
FROM  Pjesemarresi
WHERE Emri like 'V%';

DELETE 
FROM Dizajneri
WHERE Mbiemri='Versace';

DELETE 
FROM Arena
WHERE Shteti='US';

DELETE 
FROM Dhoma
WHERE Kati = 4; 

/*FAZA E TRETE*/

--TASK 1 - Të krijoni min. 8 query të thjeshta (4 për student), të realizohen vetëm me një relacion (tabelë)

--1. Te shfaqen pjesemarresit femra dhe mes datelindjes 3/13/1993 dhe 11/1/1999
select Emri, Mbiemri ,Gjinia, Datelindja
from Pjesemarresi
where Gjinia like 'F' and Datelindja  between '3/13/1993' and '11/1/1999'

--2. Te shfaqet kioska e cila ndodhet ne 'US' dhe me ID me te madhe se 50
select Kioska_ID, Shteti, Qyteti
from Kioska
where Shteti like 'US' and Kioska_ID>50

--3. Te shfaqen dhomat qe ndodhen ne katin e 4 me numer te dhomes me te madh se 120
select Dhoma_ID, Numri, Kati
from Dhoma
where Kati=4 and Numri>120

--4. Te shfaqen restaurantet qe kane ID me te vogel se 15 dhe qe fillojne punen nga 10:30  
select Restaurant_ID, Emri, Orari_I_Punes
from Restaurant
where Orari_I_Punes='10:30' and Restaurant_ID<15

--5. Te shfaqen biletat e llojit ADULT dhe numrat e uleseve mes 1 deri ne 15
select Bileta_ID, Pjesemarresi_ID, Nr_Ulses, Lloji
from Bileta
where Lloji = 'Adult' and Nr_Ulses between '1' and '15'

--6. Te shfaqen arenat qe nuk ndodhen ne US
select a.Arena_ID, Emri, Shteti, Kapaciteti
from Arena a
where a.Shteti not like 'US'

--7. Te shfaqen bandat ku emrat e artisteve qe fillojne me A dhe numri i artisteve brenda tyre eshte me i madh se 4
select Emri, Nr_I_Artisteve
from Banda
where  Emri like 'A%' AND Nr_I_Artisteve>4

--8. Te shfaqen dizajneret me gjini jo meshkuj dhe emrat e te cileve fillojne me C
select Dizajneri_ID, Emri, Mbiemri, Gjinia
from Dizajneri
where Emri like 'C%' and Gjinia not like 'M'


--TASK 2 - Të krijoni min. 8 query të thjeshta (4 për student), të realizohen në minimum dy relacione (tabela) e më tepër.

--1. Te shfaqet koncerti me emrin "Sweetener World Tour"
select *
from Koncerti k, Arena a
where a.Arena_ID=k.Arena_ID and k.Emri like 'Sweetener World Tour'

--2. Te shfaqen performuesit e nje koncerti me gjinine F
select p.Emri, p.Mbiemri, p.Gjinia, k.Emri 
from Performuesi p, Koncerti k
where p.Koncerti_ID=k.Koncerti_ID and p.Gjinia like 'F'

--3. Te shfaqen performuesit me ID nga 10 deri 20 qe kane playlists me emer te ndryshem nga "Disco Baby"
select p.Emri_I_Playlist, p.Performuesi_ID, pf.Emri, pf.Mbiemri
from Playlist p, Performuesi pf
where p.Performuesi_ID=pf.Performuesi_ID and p.Emri_I_Playlist not like 'Disco Baby' and p.Performuesi_ID between '10' and '20'

--4. Te gjendet teknikut qe kontrollon fushen fencing
select t.Stafi_ID_Tekniku, t.Fusha
from Stafi s, Tekniku t
where s.Stafi_ID=t.Stafi_ID_Tekniku and t.Fusha like 'Fencing'
group by t.Fusha, t.Stafi_ID_Tekniku

--5. Te shfaqen te gjithe pjesemarresit qe takojne performuesit me gjini M
select pj.Emri, pj.Mbiemri, p.Emri, p.Mbiemri, p.Gjinia
from Pjesemarresi pj, takon t,  Performuesi p
where t.Pjesemarresi_ID=p.Performuesi_ID and t.Pjesemarresi_ID=pj.Pjesemarresi_ID and p.Gjinia like 'M'

--6. Te shfaqet vetem shteti ku do te mbahen koncertet
select distinct a.Shteti
from Koncerti k, Arena a
where a.Arena_ID=k.Arena_ID 

--7. Shfaqni pjesemarresit qe vizitojne restaurantin qe emri i tij fllon me shkronjen "T"
select p.Emri, p.Mbiemri, r.Emri, r.Orari_I_Punes
from Pjesemarresi p, Restaurant r
where p.Pjesemarresi_ID=r.Pjesemarresi_ID and r.Emri like 'T%' 

--8. Shfaqni dizajneret e gjinise M qe perkujdesen per performuesit
select d.Emri, d.Mbiemri, d.Gjinia, p.Emri, p.Mbiemri
from Performuesi p, Perkujdeset pk, Dizajneri d
where p.Performuesi_ID=d.Dizajneri_ID and d.Gjinia like	'M'
group by p.Emri, p.Mbiemri, d.Emri, d.Mbiemri, d.Gjinia



--TASK 3: Të krijoni min. 8 query të avancuara (4 për student), të realizuara në minimum dy relacione (tabela) e më tepër.

--1. Listoni performuesit te cileve mbiemri u mbaron me "ey" dhe shfaqni emrin e playlistes se tyre 
SELECT p.Performuesi_ID, p.Emri, p.Mbiemri, pt.Emri_I_Playlist
FROM Performuesi p
INNER JOIN Playlist pt
ON pt.Performuesi_ID=p.Performuesi_ID
where p.Mbiemri like '%ey'

--2. Te shfaqen te gjitha biletat e ndryshme nga "Child" dhe te renditen per nga numri i tiketes
SELECT k.Kioska_ID, k.Shteti, k.Qyteti, k.Numri_I_Tiketes, b.Lloji
FROM Kioska k
INNER JOIN Bileta b
ON b.Kioska_ID = k.Kioska_ID 
where b.Lloji not like 'CHILD'
order by k.Numri_I_Tiketes

--3. Te selektohen te gjitha koncertet me arena id (15-28) qe mbahen ne shtetet (US dhe China)
SELECT a.Arena_ID, a.Emri as [Emri i Arenes],a.Qyteti, a.Shteti,k.Koncerti_ID,k.Emri [Emri i Koncertit]
FROM Arena a
LEFT JOIN Koncerti k
ON a.Arena_ID=k.Arena_ID
where a.Shteti in ('US', 'CHINA') and a.Arena_ID between '15' and '28'

--4. Listoni te gjithe pjesemarresit e lindur prej dates "6/25/1993" deri me daten "3/13/1993" qe vizitojne restaurantet te cilet punojne nga ora 9:00
select concat(p.Emri, ' ', p.Mbiemri) [Emri i Plote] , p.Datelindja, p.Nr_Personal, r.Restaurant_ID, r.Emri, r.Orari_I_Punes
from Restaurant r
FULL JOIN Pjesemarresi p
on r.Pjesemarresi_ID=p.Pjesemarresi_ID
where p.Datelindja between '6/25/1993' and '3/13/1993' or r.Orari_I_Punes < '9:00'

--5. Te shfaqen tekniket qe rregullojne stage sipas te gjitha fushave duke e perjashtuar fushen e ndriqimit
select s.Stage_ID, t.Stafi_ID_Tekniku, t.Fusha
from Stage s
RIGHT JOIN Tekniku t
on s.Stage_ID=t.Stage_ID
where t.Fusha not like 'Ndriqimi'

--6. Shfaqni vetem mirembajtesit qe kan id me te vogel se 10, zip kodin e kane null dhe mosha te mos jete me i vogel se 3
select Distinct m.Stafi_ID_Mirembajtesi, concat(s.Emri,' ', s.Mbiemri) [Emri i plote], s.Mosha, a.Arena_ID,  s.Stafi_ID, a.Shteti,a.Emri, s.Zip_Kodi
from Mirembajtesi m inner join Arena a
on m.Arena_ID=a.Arena_ID inner join Stafi s
on m.Stafi_ID=s.Stafi_ID
where m.Stafi_ID_Mirembajtesi <10 and s.Zip_Kodi is null and not s.Mosha<30

--7. Te shfaqen te gjithe pjesemarresit dhe restaurantet qe i vizitojne me se shumti
select p.Pjesemarresi_ID, concat(p.Emri, ' ', p.Mbiemri) [Emri i Plote], p.Shteti, p.Qyteti, r.Pjesemarresi_ID, r.Restaurant_ID, r.Emri
from Restaurant r
RIGHT JOIN Pjesemarresi p
on r.Pjesemarresi_ID=p.Pjesemarresi_ID


--8. Listoni pjesemarresit meshkuj te cilet kane qene ne nje nga restaurantet para ores '10:30'
select CONCAT(p.Emri, ' ', p.Mbiemri) [Emri i plote], p.Gjinia, CONCAT(p.Shteti, ', ', p.Qyteti) [Vendi], r.Restaurant_ID, r.Emri, r.Orari_I_Punes
from Pjesemarresi p
FULL JOIN Restaurant r
on p.Pjesemarresi_ID=r.Pjesemarresi_ID
where p.Gjinia like 'M' and r.Orari_I_Punes < '10:30'



--TASK 4: Të krijoni min. 8 subquery të thjeshta (4 për student).

--1. Te shkruhen pjesemarresit emri i te cileve fillon me shkronjen B qe kane blere bilete ne kiosken perkatese
select p.Pjesemarresi_ID, p.Emri, p.Mbiemri, p.Nr_Personal, b.Bileta_ID, b.Lloji, p.Shteti, p.Qyteti, k.Numri_I_Tiketes
from Pjesemarresi p, Bileta b, Kioska k
where p.Pjesemarresi_ID=b.Pjesemarresi_ID and k.Kioska_ID = b.Kioska_ID 
and p.Pjesemarresi_ID =
				(select Pjesemarresi_Id
				from Pjesemarresi p
				where p.Emri like 'B%' and b.Lloji like 'ADULT')

--2. Te shfaqen performuesit, kenget e te cileve nuk kushtojne '0.99'
select p.Performuesi_ID, p.Emri, p.Mbiemri, pl.Emri_I_Playlist, k.Kenget_ID, pl.Playlist_ID, k.Çmimi_I_Kenges
from Performuesi p, Playlist pl, Kenget k
where pl.Performuesi_ID=p.Performuesi_ID 
and k.Playlist_ID=pl.Playlist_ID 
and k.Kenget_ID in
				(select Kenget_ID
				from Kenget k
				where k.Çmimi_I_Kenges != '0.99')
order by p.Performuesi_ID asc

--3. Shfaqni Arenat ne North Carolina me kapacitet nga 21000-24000 dhe tekniket qe e rregullojne stage
select a.Arena_ID, a.Emri, a.Shteti, a.Qyteti, a.Kapaciteti, t.Stafi_ID_Tekniku, s.Stage_ID 
from Arena a inner join Tekniku t 
on a.Arena_ID = t.Arena_ID
inner join Stage s 
on t.Stage_ID = s.Stage_ID
where t.Stafi_ID_Tekniku in
						(select a.Arena_ID
						from Arena a
						where a.Qyteti like 'North Carolina' and a.Kapaciteti between '21000' and '24000')


--4. Te shfaqet stafi me gjinine 'F' dhe me ID nga 1-25 i cili punon ne Arenat qe nuk gjenden ne US
select s.Stafi_ID, CONCAT(s.Emri, ' ', s.Mbiemri) [Emri i plote], s.Gjinia, k.Koncerti_ID, k.Emri, k.Arena_ID, a.Emri, a.Shteti 
from Koncerti k inner join Stafi s on k.Koncerti_ID = s.Koncerti_ID
inner join Arena a on k.Arena_ID =a.Arena_ID
where s.Stafi_ID in 
				(select Stafi_ID from Koncerti k
				where s.Stafi_ID between '1' and '25' 
				and s.Gjinia like 'F' and a.Shteti not like 'US')


--5.Shfaqni te dhenat e teknikut qe eshte pjese e stafit dhe punon ne Arenen me ID 10
select s.Stafi_ID, s.Emri, s.Mbiemri,t.Stafi_ID_Tekniku, t.Arena_ID
from Stafi s inner join Tekniku t 
on s.Stafi_ID = t.Stafi_ID
inner join Stage st
on t.Stage_ID = st.Stage_ID
where t.Stafi_ID_Tekniku in
						(select t.Stafi_ID_Tekniku
						from Tekniku t
						where t.Arena_ID = 10)

--6.Te shfaqet stafi me moshe me te madhe se 30 vjet
select s.Stafi_ID, s.Emri, s.Mbiemri, s.Mosha
from Stafi s
where s.Mosha in (select s.Mosha
							from Stafi s
							where s.Mosha>30)
order by s.Mosha asc

--7.Te shfaqet koncerti me Id 7 dhe arena ne te cilen do te mbahet
select k.Koncerti_ID, k.Emri, k.Arena_ID
from Koncerti k
where k.Koncerti_ID = (select distinct a.Arena_ID
							from Koncerti a
							where a.Arena_ID=7)

--8. Te shfaqen te gjitha kenget, e qe qmimi i tyre eshte me i vogel se mesatarja e te gjitha kengeve
select k.Emri, k.Çmimi_I_Kenges
from Kenget k
where k.Çmimi_I_Kenges < 
						(select avg(k.Çmimi_I_Kenges)
						from Kenget k)
					

--TASK 5: Të krijoni min. 8 subquery të avancuara (4 për student). (min. 1 subquery në klauzolën
--SELECT, dhe min. 1 subquery ne klauzolën FROM)

--1. Te shfaqet performuesi i cili perkujdeset nga diazjneri me Id = 08
select p.Performuesi_ID, p.Emri, p.Mbiemri, pk.Dizajneri_ID
from Performuesi p inner join Perkujdeset pk
on p.Performuesi_ID = pk.Performuesi_ID
where pk.Dizajneri_ID like (select d.Dizajneri_ID
from [Dizajneri] d
where d.Dizajneri_ID = '8')

--2. Te shfaqen kenget ne playlist  me cmim me te vogel se 3.99
select pl.Playlist_ID, pl.Emri_I_Playlist, k.Kenget_ID, k.Emri, k.Çmimi_I_Kenges
from Playlist pl join Kenget k
on pl.Playlist_ID=k.Playlist_ID
where k.Çmimi_I_Kenges < all (select k.Çmimi_I_Kenges
							  from Kenget k
							  where k.Kenget_ID in (select k.Kenget_ID
												    from Kenget k
												    where k.Çmimi_I_Kenges like '3.99'))

--3. Te shfaqet pjesemarresi me Id = 06 qe kontrollohet nga Sigurimi perkates
select s.Stafi_ID_Sigurimi, s.Lloji, k.Pjesemarresi_ID
from Sigurimi s inner join Kontrolli k
on s.Stafi_ID_Sigurimi = k.Stafi_ID_Sigurimi
where k.Pjesemarresi_ID like (select p.Pjesemarresi_ID
from [Pjesemarresi] p
where p.Pjesemarresi_ID = '6')

--4. Te shfaqen kioskat, biletat e te ciles jane shitur kane numer te tiketes me te vogel se 29823923
select k.Kioska_ID, k.Numri_I_Tiketes, b.Bileta_ID
from Kioska k join Bileta b
on k.Kioska_ID=b.Kioska_ID
where k.Numri_I_Tiketes <all (select k.Numri_I_Tiketes
							  from Kioska k
							  where k.Kioska_ID in (select k.Kioska_ID
													from Kioska k
													where k.Numri_I_Tiketes like '29823923'))

--5. Te shfaqet Çmimi mesatar i te gjitha kengeve ne playlist qe fillojne me shkronjen M
Select (Select AVG(Kenget.Çmimi_I_Kenges)) [Çmimi Mesatar per Kenget qe Fillojne me Shkronjen M]
from (Select k.Çmimi_I_Kenges
from Kenget k join Playlist p
on k.Playlist_ID = p.Playlist_ID
where k.Emri like 'M%') as Kenget--6. Te shfaqet Pjesemarresi te cilit emri i fillon me shkronjen 'V' dhe numri personal me '124'Select (Select table1.Emri
where table1.Emri like 'V%') [EmratMeV]
from (Select p.Emri, p.Mbiemri,p.Nr_Personal
from Pjesemarresi p
where p.Nr_Personal  like '124%') as table1
where (Select table1.Emri
where table1.Emri like 'V%') is not null;

--7. Te shfaqet Pjesemarresi ne koncert qe takon performuesin me Id = 4
select p.Pjesemarresi_ID, concat(p.Emri, ' ', p.Mbiemri) [Emri dhe Mbiemri], t.Performuesi_ID
from Pjesemarresi p inner join Takon t
on p.Pjesemarresi_ID = t.Pjesemarresi_ID
where t.Performuesi_ID like (select pe.Performuesi_ID
							 from [Performuesi] pe
							 where pe.Performuesi_ID = '4')

--8. Te shfaqet Performuesi i cili perkujdeset nga MakeUp Artisti me Id = 2
select p.Performuesi_ID, p.Emri, p.Mbiemri, pk.Makeup_Artist_ID
from Performuesi p inner join Perkujdeset pk
on p.Performuesi_ID = pk.Performuesi_ID
where pk.Makeup_Artist_ID like (select m.Makeup_Artist_ID
								from [Makeup_Artist] m
								where m.Makeup_Artist_ID = '2')



--TASK 6:Të krijoni min. 8 query/subquery (4 për student). Duke përdorur operacionet e algjebrës
--relacionale (Union, Prerja, diferenca, etj.)


--1. Te shkruhen emrat e te gjithe personave qe gjenden ne koncert
(select Emri, Mbiemri from Pjesemarresi)
UNION
(select Emri, Mbiemri from Performuesi)

--2. Te gjenden anetaret e Stafit me gjinine mashkurllore dhe ata me gjinine femerore
(select s.Emri, s.Mbiemri, s.Gjinia, s.Mosha from Stafi s where s.Gjinia like 'M')
UNION
(select s.Emri, s.Mbiemri, s.Gjinia, s.Mosha from Stafi s where s.Gjinia like 'F')

--3. Te gjenden te dhenat e te gjithe mirembajtesve dhe sigurimit
select  s.Emri, s.Mbiemri, s.Nr_Personal, p.Bruto_Paga
from stafi s ,Mirembajtesi m, Paga p
where s.Stafi_ID=m.Stafi_ID_Mirembajtesi and s.Stafi_ID=p.Stafi_ID
union
select s.Emri, s.Mbiemri, s.Nr_Personal, p.Bruto_Paga
from Stafi s ,Sigurimi si, Paga p
where s.Stafi_ID=si.Stafi_ID_Sigurimi and s.Stafi_ID=p.Stafi_ID

--4. Listoni emrat e te gjitha shteteve te cilat kane kioskat me tiketa perkatese numri i te cilave perfundon me 8
select k.Shteti, k.Numri_I_Tiketes
from Kioska k
where k.Numri_I_Tiketes like '%8'
intersect
select Shteti, Numri_I_Tiketes
from Kioska k

--5. Listoni performuesit te cilet jane perkujdesur nga dizajner te tjere gjate koncertit te tyre duke perdorur Except
select p.Dizajneri_ID, p.Performuesi_ID
from Perkujdeset p
except
select d.Dizajneri_ID,p.Performuesi_ID
from Dizajneri d inner join Performuesi p
on d.Dizajneri_ID=p.Performuesi_ID

--6. Te shkruhet i gjithe stafi i gjinise femerore i cili punon ne arene, mosha e te cileve eshte me e vogel se 30 vjec
select Emri, Mbiemri, Gjinia, Mosha
from Stafi
where Mosha < 30 and Gjinia not like 'M'
except
select Emri,Shteti, Qyteti, Rruga
from Arena
order by Mosha asc

--7. Te selektohen shteti dhe qyteti i njejte ekzistues ndermjet pjesemarresit dhe areneave perkatese duke perdorur (Intersect)
select p.Shteti, p.Qyteti
from Pjesemarresi p
intersect
select a.Shteti, a.Qyteti
from Arena a

--8.Te shfaqen te gjith makeup artistet femra me performuesit qe ata perkujdesen
select ma.Makeup_Artist_ID, ma.Emri, ma.Mbiemri 
from Makeup_Artist ma 
where ma.Gjinia like 'F'
UNION
select p.Performuesi_ID, p.Emri, p.Mbiemri
from Performuesi p


--TASK 7: Të krijoni min. 8 Proceduara të ruajtura (Stored Procedure) (4 për student)

--1.Te shfaqet lloji i biletes qe pershtatet me id e pjesemarresit
create proc PjesemarresitSipasBiletes
@Id int
as
begin
declare @llojiBiletes char(20);
select @llojiBiletes = ( select b.Lloji
from Pjesemarresi p inner join Bileta b
on p.Pjesemarresi_ID=b.Pjesemarresi_ID
where p.Pjesemarresi_ID=@Id)

if @llojiBiletes like 'ADULT'
	begin
		print 'Lloji i biletes eshte Adult';
	end
else if @llojiBiletes like 'CHILD'
	begin
		print 'Lloji i biletes eshte Child';
	end
else if @llojiBiletes like 'VIP'
	begin
		print 'Lloji i biletes eshte VIP';
	end
else 
	begin
		print 'Nuk ka asnje bilete me kete parameter';
	end 
end

exec PjesemarresitSipasBiletes 15;

select p.Pjesemarresi_ID, p.Emri, p.Mbiemri, b.Lloji
from Pjesemarresi p inner join Bileta b
on p.Pjesemarresi_ID=b.Pjesemarresi_ID
group by p.Pjesemarresi_ID, p.Emri, p.Mbiemri, b.Lloji


--2. Te shfaqet nese kenga ekziston varesisht nga cmimi
create proc KengetSipasCmimit
@Id int
as
begin
declare @CmimiKenges money;
select @CmimiKenges = ( select k.Çmimi_I_Kenges
from Kenget k inner join Playlist p
on k.Playlist_ID=p.Playlist_ID
where k.Kenget_ID=@Id )

if @CmimiKenges ='0.99'
	begin
		print 'Cmimi i kenges eshte 0.99';
	end
else if @CmimiKenges ='2.99'
	begin
		print 'Cmimi i kenges eshte 2.99';
	end
else if @CmimiKenges ='3.99'
	begin
		print 'Cmimi i kenges eshte 3.99';
	end
else if @CmimiKenges ='4.99'
	begin
		print 'Cmimi i kenges eshte 4.99';
	end
else 
	begin
		print 'Nuk ka asnje kenge me kete cmim';
	end 
end

exec KengetSipasCmimit  2;

select k.Kenget_ID, k.Emri, k.Çmimi_I_Kenges
from Kenget k inner join Playlist p
on k.Playlist_ID=p.Playlist_ID
group by k.Kenget_ID, k.Emri, k.Çmimi_I_Kenges

--3.Te tregohet nese arena me koncertin me ID perkatese ka kapacitet nga 20k-30k
create proc ArenatSipasKapacitetit
@Id int
as
begin
declare @KapacitetiArenes int;
select @KapacitetiArenes = ( select a.Kapaciteti
from Koncerti k inner join Arena a
on k.Arena_ID=a.Arena_ID
where a.Arena_ID=@Id )

if @KapacitetiArenes between '20000' and '30000'
	begin
		print 'Arena ka kapacitet nga 20k-30k';
	end
else
	begin
		print 'Arena nuk e ka kete kapacitet';
	end
end

exec ArenatSipasKapacitetit 20;

select k.Koncerti_ID, k.Emri, a.Arena_ID, a.Kapaciteti
from Koncerti k inner join Arena a
on k.Arena_ID=a.Arena_ID
group by k.Koncerti_ID, k.Emri, a.Arena_ID, a.Kapaciteti


--4.Te shfaqen te gjitha restaurantet qe fillojne punen para orarit qe vjen nga inputi
create proc OrariIPunes
@oraripunes time
as
begin
select r.Restaurant_ID, r.Emri,r.Orari_I_Punes [Restaurantet Para Orarit Te Caktuar Nga Inputi]
from Restaurant r
where r.Orari_I_Punes<@oraripunes
end

exec OrariIPunes 
@oraripunes = '10:00'


--5.Te tregohet nese Pjesemarresi gjendet ne Restaurant ne varshmeri me orarin e caktuar

create proc PjesmarresitNeRestaurantSipasOrarit
@Id int
as
begin
declare @OrariRestaurantit time(7);
select @OrariRestaurantit = ( select r.Orari_I_Punes
from Restaurant r inner join Pjesemarresi p
on p.Pjesemarresi_ID=r.Pjesemarresi_ID
where p.Pjesemarresi_ID=@Id )

if @OrariRestaurantit between '9:00' and '10:30'
	begin
		print 'Pjesemarresi gjendet ne Restaurant ne kete orar';
	end
else
	begin
		print 'Pjesemarresi nuk gjendet ne Restaurant ne kete orar';
	end
end

exec PjesmarresitNeRestaurantSipasOrarit 7;

select p.Pjesemarresi_ID, p.Emri, p.Mbiemri, r.Orari_I_Punes
from Pjesemarresi p inner join Restaurant r
on p.Pjesemarresi_ID=r.Pjesemarresi_ID
group by p.Pjesemarresi_ID, p.Emri, p.Mbiemri, r.Orari_I_Punes

--6. Te shfaqen pjesemarresit qe vijne nga shteti 'US'
create proc PjesemarresitSipasShtetit
@Shteti varchar(50)
as
begin
select Emri, Mbiemri,Shteti [Pjesemarresit sipas Shtetit], Qyteti
from Pjesemarresi
where Shteti= @Shteti
end

PjesemarresitSipasShtetit
@Shteti ='US'


--7.Te shfaqet perqindja e performuesve qe i pershatet gjinise se kerkuar nga inputi
create proc PerqindjaEGjiniseSePerformuesve
@gjinia char(1)
as 
begin
declare @numeroPerformuesit int = (select count (*) from Performuesi)
declare @perqindjaGjinise int= (select count (*) from Performuesi where @gjinia=Gjinia)

print 'Performuesit me gjini ' + @gjinia + ' jane ' + Cast((100*@perqindjaGjinise/@numeroPerformuesit) as varchar(255)) + '%'
end

PerqindjaEGjiniseSePerformuesve 'M'

--8.Te shfaqen arenat qe ju pershtatet kapaciteti i derguarn nga useri
create proc PerqindjaEArenaveMeKapacitet
@kapaciteti char(5)
as 
begin
declare @llogaritKapacitetin int = (select count (*) from Arena)
declare @perqindjaKapacitetit int= (select count (*) from Arena where @kapaciteti=Kapaciteti)

print 'Arenat me kapacitet ' + @kapaciteti + ' jane ' + cast((100*@perqindjaKapacitetit/@llogaritKapacitetin) as varchar(255))  + '%'
end

PerqindjaEArenaveMeKapacitet '20000'



--EXTRA QUERY ME VIEW DHE WITH


--Nga kioska shfaqni pjesemarresit e gjinise mashkullore dhe femerore te cilet pranojne atributet perkatese dhe pastaj bashkoni ato permes UNION me view
create view [PjesemarresitM] as
select p.Pjesemarresi_ID, p.Emri,p.Mbiemri, p.Gjinia, k.Kioska_ID, b.Bileta_ID
from Pjesemarresi p, Bileta b, Kioska k
where b.Pjesemarresi_ID = p.Pjesemarresi_ID and  b.Kioska_ID = k.Kioska_ID
and p.Gjinia like 'M' and p.Pjesemarresi_ID between '1' and '15'
create view [PjesemarresitF] as
select p.Pjesemarresi_ID, p.Emri,p.Mbiemri, p.Gjinia, k.Kioska_ID, b.Bileta_ID
from Pjesemarresi p, Bileta b, Kioska k
where b.Pjesemarresi_ID = p.Pjesemarresi_ID and  b.Kioska_ID = k.Kioska_ID
and p.Gjinia like 'F' and k.Kioska_ID < 20

select * from PjesemarresitM
union
select * from PjesemarresitF


-- Te shfaqen kenget te cilat kane Çmim me te vogel se mesatarja e Çmimit te te gjitha kengeve
WITH average_cmimiKenges (AVG_Çmimi) AS 
(select AVG (Çmimi_I_Kenges) from Kenget)
select k.Kenget_ID, k.Emri, k.Çmimi_I_Kenges, av.AVG_Çmimi
from Kenget k, average_cmimiKenges av
where k.Çmimi_I_Kenges < av.AVG_Çmimi;


								 
