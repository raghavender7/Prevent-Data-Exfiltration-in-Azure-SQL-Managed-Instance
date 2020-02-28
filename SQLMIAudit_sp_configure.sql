CREATE SERVER AUDIT Audit_sp_configure TO EXTERNAL_MONITOR
WHERE (object_name = 'sp_configure');
GO

CREATE SERVER AUDIT SPECIFICATION Audit_sp_configure_sp
FOR SERVER AUDIT Audit_sp_configure
  ADD (SCHEMA_OBJECT_ACCESS_GROUP);
GO
ALTER SERVER AUDIT SPECIFICATION Audit_sp_configure_sp WITH (STATE = ON);
GO

ALTER SERVER AUDIT Audit_sp_configure WITH (STATE = ON);
GO