USE [HOTEL]
GO
--Tabela Country

INSERT INTO Country (CountryName, CountryCode) VALUES ( 'Poland', 'PL')
INSERT INTO Country (CountryName, CountryCode) VALUES ( 'Ireland', 'IE')
INSERT INTO Country (CountryName, CountryCode) VALUES ( 'United Kingdom', 'GB')
INSERT INTO Country (CountryName, CountryCode) VALUES ( 'United States', 'US')
INSERT INTO Country (CountryName, CountryCode) VALUES ( 'Spain' , 'ES')
INSERT INTO Country (CountryName, CountryCode) VALUES ( 'Italy', 'IT') 
INSERT INTO Country (CountryName, CountryCode) VALUES ( 'Ukraine', 'UA')
INSERT INTO Country (CountryName, CountryCode) VALUES ( 'Germany',  'DE') 
INSERT INTO Country (CountryName, CountryCode) VALUES ( 'China', 'CN') 
INSERT INTO Country (CountryName, CountryCode) VALUES ( 'Russia', 'RU')
 
 -- Tabela Clients

 INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email) 
 VALUES ( 'Tomasz', 'Kruczkowski', '1', '19980626', '98062605214', 't.kruczkowski@gmail.com')
 
 INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email) 
 VALUES ( 'Emily', 'Murphy', '2', '19750120', 'D23145890', 'emilymurphy@gmail.com') 

 INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email) 
 VALUES ( 'Rowan', 'Atkinson', '3', '19550106', '533380006', 'atkinsonr@gmail.com') 

 INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email) 
 VALUES ( ' William', 'Pitt', '4', '19631218', '467291799', 'wpitt@gmail.com')

 INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email) 
 VALUES ( 'Penelope', 'Cruz', '5', '19740428', '740428882A', 'penelope.cruz@gmail.com')

 INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email)
 VAlUES ( 'Monica', 'Bellucci', '6', '19640930', 'K640930889', 'mbelluci@gmail.com')
 
INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email)
VALUES ( 'Jurij', 'Andruchowycz', '7', '19600313', '130360467', 'andruchowychj@gmail.com')

INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email)
VALUES ( 'Jenny', 'Erpenbeck', '8', '19670312', '6703123352', 'Erpenbeckj@gmail.com')

INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email)
VALUES ( 'Yu', 'Hua', '9', '19600403', 'E544378921', 'huayu@gmail.com') 

INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email)
VALUES ( 'Svetlana', 'Prokopyeva', '10', '19791001', 'R322136787', 'sprokopyeva@gmail.com') 

--Tabela RoomType 

INSERT INTO RoomType (Name, Description) 
VALUES ('Singel', 'A room assigned to one person, have one bad')

INSERT INTO RoomType (Name, Description) 
VALUES ('Double', 'A room assigned to two people. Have one bed')

INSERT INTO RoomType (Name, Description) 
VALUES ('Twin', 'A room with two beds. May be occupied by one or more people')

INSERT INTO RoomType (Name, Description) 
VALUES ('Triple', 'A room assigned to three people have three beds')

INSERT INTO RoomType (Name, Description) 
VALUES ('Triple2', 'A room assigned to three people have two beds')

INSERT INTO RoomType (Name, Description) 
VALUES ('Quad', 'A room assigned to four people have four beds')

--Tabela Rooms

INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, NRofBeds)
VALUES ( '1', '1', '1', '1')

INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, NRofBeds)
VALUES ('2', '2', '1', '1')

INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, NRofBeds)
VALUES ('3', '2', '1', '1')

INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, NRofBeds)
VALUES ('4', '3', '1', '2')

INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, NRofBeds)
VALUES ('5', '3', '1', '2')

INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, NRofBeds)
VALUES ('6', '4', '2', '3')

INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, NRofBeds)
VALUES ('7', '5', '2', '2')

INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, NRofBeds)
VALUES ('8', '5', '2', '2')

INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, NRofBeds)
VALUES ('9', '6', '2', '4')

INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, NRofBeds)
VALUES ('10', '2', '2', '1')

-- Tabela Price-list

INSERT INTO PriceList (RoomTypeID, InTheSeason, OffSeason) VALUES ('1', '50', '35')

INSERT INTO PriceList (RoomTypeID, InTheSeason, OffSeason) VALUES ('2', '75', '50')

INSERT INTO PriceList (RoomTypeID, InTheSeason, OffSeason) VALUES ('3', '100', '75')

INSERT INTO PriceList (RoomTypeID, InTheSeason, OffSeason) VALUES ('4', '150', '135')

INSERT INTO PriceList (RoomTypeID, InTheSeason, OffSeason) VALUES ('5', '150', '135')

INSERT INTO PriceList (RoomTypeID, InTheSeason, OffSeason) VALUES ('6', '200', '175')