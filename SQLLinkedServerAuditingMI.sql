USE [master]GO
CREATE SERVER AUDIT [LinkedServer] TO EXTERNAL_MONITOR;
GOCREATE DATABASE AUDIT SPECIFICATION [LinkedServerMaster]FOR SERVER AUDIT [LinkedServer]ADD (EXECUTE ON OBJECT::[sys].[sp_addlinkedserver] BY [dbo]),ADD (EXECUTE ON OBJECT::[sys].[sp_addserver] BY [dbo]),ADD (EXECUTE ON OBJECT::[sys].[sp_dropserver] BY [dbo]),ADD (EXECUTE ON OBJECT::[sys].[sp_addlinkedsrvlogin] BY [dbo]),ADD (EXECUTE ON OBJECT::[sys].[sp_droplinkedsrvlogin] BY [dbo]),ADD (EXECUTE ON OBJECT::[sys].[sp_serveroption] BY [dbo]),ADD (EXECUTE ON OBJECT::[sys].[sp_setnetname] BY [dbo])WITH (STATE = ON)GO

ALTER SERVER AUDIT [LinkedServer] WITH (STATE=ON);
GO

