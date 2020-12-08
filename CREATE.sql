
CREATE TABLE dbo.RoomType(
	RoomTypeID int NOT NULL IDENTITY(1,1),
	Name varchar(100) NOT NULL,
	Description varchar(100) NULL
)
GO
ALTER TABLE dbo.RoomType ADD CONSTRAINT PK_RoomType_RoomTypeID PRIMARY KEY CLUSTERED (RoomTypeID ASC)
GO

CREATE TABLE dbo.Rooms(
RoomID int NOT NULL IDENTITY(1,1),
RoomNumber int NOT NULL,
RoomTypeID int NOT NULL,
Floor int NOT NULL,
NRofBeds int NOT NULL
)
GO

ALTER TABLE dbo.Rooms ADD CONSTRAINT PK_Rooms_RoomID PRIMARY KEY CLUSTERED (RoomID ASC)
GO

ALTER TABLE dbo.Rooms ADD CONSTRAINT FK_Rooms_RoomType_RoomTypeID FOREIGN KEY (RoomTypeID)
REFERENCES dbo.RoomType(RoomTypeID)
GO

CREATE TABLE dbo.Country(
CountryID int NOT NULL IDENTITY(1,1),
CountryName varchar(50) NOT NULL,
CountryCode varchar(2) NOT NULL
)
GO

ALTER TABLE dbo.Country ADD CONSTRAINT PK_Country_CountryID PRIMARY KEY CLUSTERED (CountryID ASC)
GO

CREATE TABLE dbo.Clients(
ClientID int NOT NULL IDENTITY(1,1),
FirstName nvarchar(50) NOT NULL,
LastName nvarchar(50) NOT NULL,
CountryId int NOT NULL, 
DateOfBirth Date NULL,
DocumentNumber varchar(40) NOT NULL,
Email varchar(100)
)
GO

ALTER TABLE dbo.Clients ADD CONSTRAINT PK_Clients_ClientID PRIMARY KEY CLUSTERED (ClientID ASC)
GO

ALTER TABLE dbo.Clients ADD CONSTRAINT FK_Clients_Country_CountryID FOREIGN KEY(CountryId)
REFERENCES dbo.Country (CountryID)
GO 


CREATE TABLE dbo.Reservations(
ReservationID int NOT NULL IDENTITY(1,1),
ClientID int NOT NULL,
CheckinDate date NOT NULL,
CheckOutDate date NOT NULL,
RoomID int NOT NULL,
PriceForStay decimal NOT NULL
)
GO

ALTER TABLE dbo.Reservations ADD CONSTRAINT PK_Reservations_ReservationID PRIMARY KEY CLUSTERED (ReservationID ASC)
GO

ALTER TABLE dbo.Reservations ADD CONSTRAINT FK_Reservations_Clients_ClientID FOREIGN KEY(ClientID)
REFERENCES dbo.Clients(ClientID)
GO

ALTER TABLE dbo.Reservations ADD CONSTRAINT FK_Reservations_Rooms_RoomID FOREIGN KEY(RoomID)
REFERENCES dbo.Rooms(RoomID)
GO

ALTER TABLE dbo.Reservations
ALTER COLUMN PriceForStay Decimal (12, 2) NOT NULL 


CREATE TABLE dbo.PriceList(
RoomTypeID int NOT NULL,
InTheSeason decimal NOT NULL,
OffSeason decimal NOT NULL
)
GO 

ALTER TABLE dbo.PriceList ADD CONSTRAINT PK_PriceList_RoomTypeID PRIMARY KEY CLUSTERED (RoomTypeID ASC)
GO
ALTER TABLE dbo.PriceList ADD CONSTRAINT FK_PriceList_RoomType_RoomTypeID FOREIGN KEY(RoomTypeID)
REFERENCES dbo.RoomType (RoomTypeID)
GO

ALTER TABLE dbo.PriceList 
ALTER COLUMN InTheSeason decimal (12,2) NOT NULL 

ALTER TABLE dbo.PriceList 
ALTER COLUMN OffSeason decimal (12,2) NOT NULL 

--Tabela - Usuniête rezerwacje
CREATE TABLE dbo.CanceledReservations(
	CanceledReservationsID int NOT NULL IDENTITY(1,1),
	ReservationID int NOT NULL,
	ClientID int NOT NULL,
	CheckinDate date NOT NULL,
	CheckOutDate date NOT NULL,
	RoomID int NOT NULL,
	PriceForStay decimal(12,2) NOT NULL, 
	CancelationDate DATETIME2 NOT NULL
)
GO
ALTER TABLE dbo.CanceledReservations ADD CONSTRAINT PK_CanceledReservations_CanceledReservationsID 
PRIMARY KEY CLUSTERED (CanceledReservationsID ASC)
GO 

ALTER TABLE dbo.CanceledReservations ADD CONSTRAINT FK_CanceledReservations_Clients_ClientID FOREIGN KEY (ClientID)
REFERENCES dbo.Clients(ClientID)
GO

ALTER TABLE dbo.CanceledReservations ADD CONSTRAINT FK_CanceledReservations_Rooms_RoomID FOREIGN KEY (RoomID)
REFERENCES dbo.Rooms(RoomID)
GO