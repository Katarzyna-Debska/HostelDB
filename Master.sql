--this file needs to be executed in command mode. "Query" menu, and selecting "SQLCMD mode"
:setvar server "DESKTOP-SHQUP0G\SQLEXPRESS" 
:setvar path "C:\Users\katar\OneDrive\Pulpit\BAZA\PROJEKT"
print 'Script path: ' + '$(path)'
print 'Log on to the server: ' + '$(server)'
GO
:connect $(server)
GO
USE [master]
GO
print 'Create HOTEL Database'
CREATE DATABASE HOTEL 
GO
USE [HOTEL]
GO

print 'Create Tables'
:r $(path)/CREATE.sql
GO
print 'Create Procedures and Triggers'
:r $(path)/Stored_Procedures_Triggers.sql
GO
print 'Create Views'
:r $(path)/VIEWS.sql
GO
print 'Populate tables'
:r $(path)/INSERT.sql
GO


--drop database HOTEL