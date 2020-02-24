# Configure Server Auditing for Azure SQL Managed Instance to capture Backup and Restore activity

Auditing is a very important part of security configuration on any Database service and it becomes more critical in a cloud environment. Azure SQL Managed Instance Server audit can be written to Azure Storage or Log analytics workspaces. In this setup we will be showcasing Log analytics workspace so that we can use the native functionality to easily alert and notify teams when any suspcious activities happen related to backups and restores to any unauthorized locations.

## Step 1: To enable Diagnostic Logging at Azure SQL Managed Instance level.




## Step 2: To configure Auditing at Azure SQL Managed Instance level 

```TSQL
CREATE SERVER AUDIT BackupRestoreAudit TO EXTERNAL_MONITOR;
GO
```
## Step 3: To create the Server Audit specification

```TSQL
CREATE SERVER AUDIT SPECIFICATION BackupRestoreAuditSpec
FOR SERVER AUDIT BackupRestoreAudit
ADD (BACKUP_RESTORE_GROUP),
ADD (AUDIT_CHANGE_GROUP)
WITH (STATE=ON);
```
## Step 4: To enable to auditing feature

```TSQL
ALTER SERVER AUDIT BackupRestoreAudit WITH (STATE=ON);
GO
```
## Monitoring the Audit logs

## Creating Alerts to notify on any suspicious activities
