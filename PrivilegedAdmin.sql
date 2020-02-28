USE master
GO
CREATE LOGIN [srgolla@microsoft.com] FROM EXTERNAL PROVIDER
GO

ALTER SERVER ROLE sysadmin ADD MEMBER [srgolla@microsoft.com]
GO




https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-aad-security-tutorial