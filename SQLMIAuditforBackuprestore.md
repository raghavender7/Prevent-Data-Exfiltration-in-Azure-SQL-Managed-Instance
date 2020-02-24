# Configure Server Auditing for Azure SQL Managed Instance to capture Backup and Restore activity

Auditing is a very important part of security configuration on any Database service and it becomes more critical in a cloud environment. Azure SQL Managed Instance Server audit can be written to Azure Storage or Log analytics workspaces. In this setup we will be showcasing Log analytics workspace so that we can use the native functionality to easily alert and notify teams when any suspcious activities happen related to backups and restores to any unauthorized locations. Here is the direct link to the 
  [T-SQL script to enable auditing on a SQL Managed Instance](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/SQLAuditingbackuprestoreMI.sql)
## Step 1: To enable Diagnostic Logging at Azure SQL Managed Instance level.

Enable Diagnostic Settings under the Monitoring category under Azure SQL Managed Instance properties. Make sure you select the **SQLSecurityAuditEvents** under logs. For the Destination details, please click **Send to Log Analytics** and select the right Log analytics workspace where you want to direct your Audit logs. Finally Click Save button

![image](https://user-images.githubusercontent.com/22504173/75150778-1e05b480-56d3-11ea-8b37-f45cf9375c84.png)
![image](https://user-images.githubusercontent.com/22504173/75150785-22ca6880-56d3-11ea-938c-7d4fbf473790.png)

## Step 2: To configure Auditing at Azure SQL Managed Instance level 
On the SQL MI instance, Log on with the Privileged Admin rights, Enable the SQL MI Instance for Server auditing and select the location as **EXTERNAL_MONITOR** to direct your logs to Log Analytics workspace instead of an Azure storage location which is the default.
Once you run this code, the next step is to create to Server Audit specification
```TSQL
CREATE SERVER AUDIT BackupRestoreAudit TO EXTERNAL_MONITOR;
GO
```
## Step 3: To create the Server Audit specification
Create a server audit specification to capture all the Backup and restore activity on the SQL instance and anything to do with the existing audit as well. In this way, no one can tamper with the audit before they backup or restore databases.

```TSQL
CREATE SERVER AUDIT SPECIFICATION BackupRestoreAuditSpec
FOR SERVER AUDIT BackupRestoreAudit
ADD (BACKUP_RESTORE_GROUP),
ADD (AUDIT_CHANGE_GROUP)
WITH (STATE=ON);
```
## Step 4: To enable to auditing feature

Enable the server audit created in the earlier step. This is the final step and Auditing has been enabled for your Azure SQL Managed Instance.
```TSQL
ALTER SERVER AUDIT BackupRestoreAudit WITH (STATE=ON);
GO
```
## Monitoring the Audit logs
All the logs show up in the Log Analytics workspace. Click on the **Logs** option under General Category to open the Kusto Query explorer where in you can write your Kusto queries to explore your data and then create alerts accordingly

![image](https://user-images.githubusercontent.com/22504173/75151353-8012e980-56d4-11ea-92e7-c7ae748caef2.png)

This query will show all the logs captured by SQL Auditing option which we have enabled on the Azure SQL Managed instance in the earlier steps
```KQL
AzureDiagnostics | where Category == "SQLSecurityAuditEvents" 
```
## Create Alerts to notify on any suspicious activities
Here are steps to create Alerts based on a Custom log query. You can customize this accordingly to your SLA requirements and create an Action group to notify when certain thresholds are hit
```KQL
AzureDiagnostics
| where Category == "SQLSecurityAuditEvents" and action_name_s =="BACKUP" and statement_s contains "COPY_ONLY" | count
```
![image](https://user-images.githubusercontent.com/22504173/75151572-016a7c00-56d5-11ea-85d4-5780b35ac0c2.png)
![image](https://user-images.githubusercontent.com/22504173/75151622-252dc200-56d5-11ea-8368-6c69997bf73a.png)

