-- removing previous data in the database; don't run this part if you are running this script for the first time
USE master;
GO
ALTER DATABASE Project6320 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
Drop database Project6320

-- first time script runner start from here
-- Creating a new database
Create database Project6320
use Project6320
GO
Create table Club(
ClubID int unique not null,
ManagerID int,
Jointime char(10),
C_country varchar(50))

create table Manager(
ManagerID int unique not null,
Gender Char (1),
FirstName varchar (50),
LastName varchar (50),
Phone varchar (20),
Address varchar (200))

create table Member(
MemberID int unique not null,
ClubID int,
Gender Char (1),
FirstName varchar (50),
LastName varchar (50),
Phone varchar (20),
Address varchar (200),
Player Char(1))


create table Donator(
DonatorID int unique not null,
D_Country varchar(50),
ContactName varchar(100),
D_Addr varchar(200),
D_Phone char(20))

create table Donation_Record(
TransactionID int unique not null,
DonatorID int,
ClubID int,
DonateTime char(50),
Amount float(24))
-- adding primary key
alter table Club add Primary Key (ClubID)
alter table Manager add Primary Key (ManagerID)
alter table Member add Primary key (MemberID)
alter table Donator add Primary Key (DonatorID)
alter table Donation_Record add Primary key (TransactionID)
-- adding foreign key
alter table Club add foreign key (ManagerID) references Manager(ManagerID)
alter table Member add foreign key (ClubID) references Club(ClubID)
alter table Donation_Record add foreign key (DonatorID) references Donator(DonatorID)
alter table Donation_Record add foreign key (ClubID) references Club(ClubID)

-- adding data into the table
insert Manager values (1,'F','Jacky','Apple','123456789','800 W Campbell Rd, Richardson, TX 75080'),(2,'M','John','Banana','987654321',NULL)

insert Club values (1,1,'06/22/2000','China'),
(2,2,'01/01/2001','USA')

insert Member values  (1,1,'M','James','Adams','123456789',NULL,'F'),
(2,1,'F','Mary','Brown','234567890','801 W Campbell Rd, Richardson, TX 75080','T'),
(3,1,'M','Tim','White','345678901','801 W Campbell Rd, Richardson, TX 75080','F'),
(4,2,'F','Cindy','Red',NULL,'801 W Campbell Rd, Richardson, TX 75080','F'),
(5,2,'F','Mary','Steward','345678901','801 W Campbell Rd, Richardson, TX 75080','F'),
(6,2,'M','Tom','Blue','345678901','801 W Campbell Rd, Richardson, TX 75080','T'),
(7,2,'M','Jason','Yellow','345678901','801 W Campbell Rd, Richardson, TX 75080','F'),
(8,2,'F','Sydney','Pink','345678901','801 W Campbell Rd, Richardson, TX 75080','F'),
(9,2,'F','Lawren','Violet','345678901','801 W Campbell Rd, Richardson, TX 75080','F')

insert Donator values (1,'USA','Peter Parker','801 W Campbell Rd, Richardson, TX 75080','123456789')

insert Donation_Record values (100000,1,1,'10/22/2018 12:44:30',10000000),
(100001,1,2,'10/23/2018 12:44:30',20000000)

--test if data are in place & show all data in all tables #a
select * from Member 
select * from Club
select * from Manager
select * from Donator
select * from Donation_Record

-- #b inner join
select * from Member as a inner join Club  as b on a.ClubID=b.ClubID
-- #c full join
select * from Member as a full join Club  as b on a.ClubID=b.ClubID

-- perform jeft join of Member table and Club table #d
select * from Member as a left join Club  as b on a.ClubID=b.ClubID

-- #e right join
select * from Member as a right join Club  as b on a.ClubID=b.ClubID
-- #f intersect
select * from Member where (ClubID=1 And Player='T')
INTERSECT
select * from Member where (ClubID=2 And Player='T')


-- select the representitive players from club 1 and club 2 (assuming there are more than 2 clubs in the database) using union #g
select * from Member where (ClubID=1 And Player='T')
UNION
select * from Member where (ClubID=2 And Player='T')

-- #h using except

select * from Member where (ClubID=1 And Player='T')
Except
select * from Member where (ClubID=2 And Player='T')