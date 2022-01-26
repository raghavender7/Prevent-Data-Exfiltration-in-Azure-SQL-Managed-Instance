USE [master]
GO


-- Create a server role for Restricted Admin
CREATE SERVER ROLE [RestrictedAdmin]
GO

-- Grant the following least privilege permissions to the server role

GRANT CONNECT ANY DATABASE TO [RestrictedAdmin]
GRANT SELECT ALL USER SECURABLES TO [RestrictedAdmin]
GRANT VIEW SERVER STATE TO [RestrictedAdmin]
GRANT ALTER ANY CONNECTION TO [RestrictedAdmin]
GRANT VIEW ANY DEFINITION TO [RestrictedAdmin]
GRANT VIEW ANY DATABASE TO [RestrictedAdmin]
GRANT ALTER ANY CONNECTION TO [RestrictedAdmin]
GRANT ALTER SERVER STATE TO [RestrictedAdmin]
GRANT ALTER ANY EVENT SESSION TO [RestrictedAdmin]
GRANT ALTER TRACE TO [RestrictedAdmin]
DENY ALTER ANY DATABASE TO [RestrictedAdmin]
DENY ALTER ANY LINKED SERVER TO [RestrictedAdmin]
DENY ALTER ANY LOGIN TO [RestrictedAdmin]
DENY ALTER ANY ENDPOINT TO [RestrictedAdmin]
DENY ALTER ANY DATABASE TO [RestrictedAdmin]
DENY ALTER ANY CREDENTIAL TO [RestrictedAdmin]
DENY ALTER ANY SERVER AUDIT TO [RestrictedAdmin]
DENY ALTER ANY SERVER ROLE TO [RestrictedAdmin]
DENY ALTER SETTINGS TO [RestrictedAdmin]
DENY IMPERSONATE ANY LOGIN TO [RestrictedAdmin]
DENY ADMINISTER BULK OPERATIONS TO [RestrictedAdmin]
--GRANT VIEW DATABASE STATE TO [RestrictedAdmin]

-- Finally, Add your DBAs and other users(preferably AD groups) to this server role
ALTER SERVER ROLE [RestrictedAdmin] ADD MEMBER [service.sql]
GO
