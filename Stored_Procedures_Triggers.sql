USE [HOTEL]
GO
-- PROCEDURA dodaj¹ca nowego klienta

CREATE or Alter PROCEDURE sp_AddClient
 @FirstName nvarchar(50),
 @LastName nvarchar(50),
 @CountryName varchar(50),
 @DocumentNumber varchar(40),
 @Email varchar(100),
 @DateOfBirth date = NULL

 AS
 BEGIN

 declare @CountryID int;
 -- walidacja 

 SELECT @CountryID = CountryID FROM dbo.Country WHERE CountryName = @CountryName;
 IF @CountryID is NULL
 BEGIN
		RAISERROR('Nie ma takiego kraju', 11, 1)
		RETURN -1
 END
 ELSE
 print 'KrajID to: ' + cast(@CountryID as varchar(5))

 -- Sprawdza czy dany klient juz istnieje, jesli tak to go nie dodaje ale zwraca informacje
 IF EXISTS(
		SELECT * FROM  Clients
		WHERE FirstName = @FirstName AND LastName = @LastName AND DocumentNumber=@DocumentNumber)
	BEGIN
	  RAISERROR('Jest juz taki klient!', 11, 1)
	  RETURN -1
	END
 -- dodaje klienta
	ELSE 
	BEGIN
		PRINT 'nie ma jeszcze takiej osoby w bazie'
		INSERT INTO Clients (FirstName, LastName, CountryId, DateOfBirth, DocumentNumber, Email)
		VALUES (@FirstName, @LastName, @CountryID, @DateOfBirth, @DocumentNumber, @Email) 
	END 
 END
 
 GO

 /*Dodajê klienta, który jest ju¿ w bazie- b³¹d
EXEC sp_AddClient @FirstName = 'Micha³', @LastName = 'Nowak', @CountryName = 'Poland', 
 @DateOfBirth = '19931218', @DocumentNumber = '931218402213', @Email = 'm.nowak@gmail.com'*
 -- Nie ma kraju w bazie- b³¹d
 EXEC sp_AddClient @FirstName ='Adam', @LastName = 'Ondra', @CountryName = 'Czech Republic', 
 @DateOfBirth = '19930205', @DocumentNumber = '9302053214A', @Email= 'ondraa@gmail.com' */

 --PROCEDURA DODAJ¥CA REZERWACJÊ 

 CREATE OR ALTER PROCEDURE sp_AddReservation
	@DocumentNumber varchar(40),
	@CheckinDate date,
	@CheckOutDate date, 
	@RoomNumber int

 AS
 BEGIN
 --Walidacja 
 DECLARE @ClientID int;
 SELECT @ClientID = ClientID FROM Clients WHERE DocumentNumber = @DocumentNumber;
 IF @ClientID IS NULL 
 BEGIN 
 RAISERROR ('Nie ma takiego klienta', 11, 1)
		RETURN -1
 END
 ELSE 
 print 'DocumentNumber to: ' + cast(@DocumentNumber as varchar(20)) 

 DECLARE @RoomID int;
 SELECT @RoomID = RoomID FROM Rooms WHERE RoomNumber= @RoomNumber;
 IF @RoomID IS NULL
 BEGIN 
 RAISERROR('Nie ma takiego pokoju', 11, 1)
		RETURN -1
 END
 ELSE 
 print 'RoomNumber to: ' + cast(@RoomNumber as varchar(5)) 

 --oblicza cene za pokoj
 declare @TotalPrice decimal(12,2);

 select @TotalPrice = DATEDIFF(day, @CheckinDate, @CheckOutDate)*
 case when Month(@CheckinDate) BETWEEN 7 and 9 then p.InTheSeason else p.OffSeason end 
 from Rooms r
 join dbo.PriceList p on p.RoomTypeID = r.RoomTypeID
 where r.RoomID = @RoomID

 print '------------------'
 print cast(@TotalPrice as varchar(10))
 print cast(@RoomID as varchar(10))
 print '------------------'

  --sprawdza czy istnieje ju¿ taka rezerwacja- ta sama data, ten sam pokój

 IF EXISTS(
		SELECT CheckinDate, CheckOutDate FROM Reservations
		WHERE ((CheckinDate <= @CheckinDate AND CheckOutDate >= @CheckOutDate) OR
		(CheckinDate <= @CheckOutDate AND CheckOutDate>= @CheckOutDate) OR
		(CheckinDate> @CheckinDate AND CheckOutDate< @CheckOutDate)) 
		AND 
		@RoomID = RoomID)
	BEGIN
	  RAISERROR('Jest juz taka rezerwacja!', 11, 1)
	  RETURN -1
	END

	ELSE
	BEGIN
		PRINT 'nie ma jeszcze takiej rezerwacji'
		INSERT INTO Reservations(ClientID,CheckinDate, CheckOutDate, RoomID,PriceForStay)
		VALUES (@ClientID,@CheckinDate,@CheckOutDate,@RoomID,@TotalPrice) 
	END 
 END

 GO
/*Dodanie rezerwacji, która ju¿ jest w tabeli- b³¹d

EXEC sp_AddReservation @DocumentNumber= '533380006' , @CheckinDate ='20201015', @CheckOutDate= '20201022',
@RoomNumber = '1'

Dodane rezerwacje 
EXEC sp_AddReservation @DocumentNumber= 'D23145890' , @CheckinDate ='20201201', @CheckOutDate= '20201206',
@RoomNumber = '2'

EXEC sp_AddReservation @DocumentNumber= 'E544378921' , @CheckinDate ='20210815', @CheckOutDate= '20210820',
@RoomNumber = '4'

EXEC sp_AddReservation @DocumentNumber= 'R322136787' , @CheckinDate ='20201101', @CheckOutDate= '20201106',
@RoomNumber = '5'

--Dodanie rezerwacji na pokój, który jest zarezerwowany w tym terminie- b³¹d

EXEC sp_AddReservation @DocumentNumber= '740428882A' , @CheckinDate ='20201013', @CheckOutDate= '20201020',
@RoomNumber = '1' */





-- Procedura usuwaj¹ca rezerwacjê 

CREATE OR ALTER PROCEDURE sp_DeletReservation
	@ReservationID int
 AS
 BEGIN

-- Usuniêcie wiersza

	DELETE FROM Reservations
	WHERE @ReservationID = ReservationID 

PRINT 'Liczba usuniêtych wierszy to.. ' + CAST(@@ROWCOUNT as char(3))

END 
GO
-- TRIGGER zapisuj¹cy dane usunietych rezerwacji do tabeli dbo.CanceledReservations

CREATE TRIGGER tr_CanceledReservation_DELETE
ON Reservations
FOR DELETE
AS 
BEGIN

INSERT INTO dbo.CanceledReservations(ReservationID, ClientID, CheckinDate, CheckOutDate, RoomID, 
PriceForStay, CancelationDate) 
SELECT d.ReservationID, d.ClientID, d.CheckinDate, d.CheckOutDate, d.RoomID, d.PriceForStay, 
Getdate() FROM deleted As d

END 
GO
-- Sprawdzam czy dzia³a procedura usuwaj¹ca rezerwacje i trigger

/* 
EXEC sp_AddReservation @DocumentNumber= 'K640930889' , @CheckinDate ='20210218', @CheckOutDate= '20220222',
@RoomNumber = '1'
EXEC sp_DeletReservation @ReservationID = '5'
SELECT * FROM dbo.CanceledReservations 

*/