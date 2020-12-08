USE [HOTEL]
GO
-- WIDOK Lista aktualnych goœci w hotelu 

CREATE VIEW vCurrentClients
AS 
SELECT Clients.FirstName, Clients.LastName, Clients.DocumentNumber, Rooms.RoomNumber, 
Reservations.CheckinDate, Reservations.CheckOutDate,
Reservations.PriceForStay
FROM Reservations
JOIN Clients ON Reservations.ClientID = Clients.ClientID
JOIN Rooms ON Reservations.RoomID= Rooms.RoomID
WHERE getdate() between CheckinDate and CheckOutDate

GO
--Sprawdzam czy widok dzia³a:

/* EXEC sp_AddReservation @DocumentNumber= '130360467' , @CheckinDate ='20200909', @CheckOutDate= '20200920',
@RoomNumber = '3' 
EXEC sp_AddReservation @DocumentNumber= '467291799' , @CheckinDate ='20200909', @CheckOutDate= '20200920',
@RoomNumber = '5'
SELECT * FROM vCurrentClients */

-- Widok dodochód miesiêcznych -
CREATE VIEW vRevenue
AS
SELECT year(checkindate) as 'Year', month(checkindate) as 'Month',SUM (PriceForStay) AS 'Revenue'
FROM Reservations 
group by year(checkindate), month(checkindate)

GO
/*
SELECT * FROM vRevenue
ORDER BY YEAR, MONTH 
*/
