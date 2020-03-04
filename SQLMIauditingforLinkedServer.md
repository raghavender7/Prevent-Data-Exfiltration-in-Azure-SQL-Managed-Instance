# Configure Server Auditing for Azure SQL Managed Instance to capture Linked Server activity
Auditing is a very important part of security configuration on any Database service and it becomes more critical in a cloud environment. Azure SQL Managed Instance Server audit can be written to Azure Storage or Log analytics workspaces. In this setup we will be showcasing Log analytics workspace so that we can use the native functionality to easily alert and notify teams when any suspcious activities happen related to Linked server execution. Here is the direct link to the 
  [T-SQL script to enable auditing on a SQL Managed Instance](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/SQLAuditingbackuprestoreMI.sql)
## Step 1: To enable Diagnostic Logging at Azure SQL Managed Instance level.

Enable Diagnostic Settings under the Monitoring category under Azure SQL Managed Instance properties. Make sure you select the **SQLSecurityAuditEvents** under logs. For the Destination details, please click **Send to Log Analytics** and select the right Log analytics workspace where you want to direct your Audit logs. Finally Click Save button

![image](https://user-images.githubusercontent.com/22504173/75150778-1e05b480-56d3-11ea-8b37-f45cf9375c84.png)
![image](https://user-images.githubusercontent.com/22504173/75150785-22ca6880-56d3-11ea-938c-7d4fbf473790.png)

## Step 2: To configure Auditing at Azure SQL Managed Instance level 
On the SQL MI instance, Log on with the Privileged Admin rights, Enable the SQL MI Instance for Server auditing and select the location as **EXTERNAL_MONITOR** to direct your logs to Log Analytics workspace instead of an Azure storage location which is the default.
Once you run this code, the next step is to create to Server Audit specification
```TSQL
CREATE SERVER AUDIT [LinkedServer] TO EXTERNAL_MONITOR;
GO
```
## Step 3: To create the Server Audit specification
Create a server audit specification to capture all the Linked server activity on the SQL instance and anything to do with the existing audit as well. In this way, no one can tamper with the audit before they create a linked server

```TSQL
CREATE DATABASE AUDIT SPECIFICATION [LinkedServerMaster]
FOR SERVER AUDIT [LinkedServer]
ADD (EXECUTE ON OBJECT::[sys].[sp_addlinkedserver] BY [dbo]),
ADD (EXECUTE ON OBJECT::[sys].[sp_addserver] BY [dbo]),
ADD (EXECUTE ON OBJECT::[sys].[sp_dropserver] BY [dbo]),
ADD (EXECUTE ON OBJECT::[sys].[sp_addlinkedsrvlogin] BY [dbo]),
ADD (EXECUTE ON OBJECT::[sys].[sp_droplinkedsrvlogin] BY [dbo]),
ADD (EXECUTE ON OBJECT::[sys].[sp_serveroption] BY [dbo]),
ADD (EXECUTE ON OBJECT::[sys].[sp_setnetname] BY [dbo])
WITH (STATE = ON);
GO
```
## Step 4: To enable the server audit

Enable the server audit created in the earlier step. This is the final step and Auditing has been enabled for your Azure SQL Managed Instance.
```TSQL
ALTER SERVER AUDIT [LinkedServer] WITH (STATE=ON);
GO
```
## Monitoring the Audit logs
All the logs show up in the Log Analytics workspace. Click on the **Logs** option under General Category to open the Kusto Query explorer where in you can write your Kusto queries to explore your data and then create alerts accordingly

![image](https://user-images.githubusercontent.com/22504173/75543363-9cbe6280-59ef-11ea-92c4-df51018417b7.png)

This query will show all the logs captured by SQL Auditing option which we have enabled on the Azure SQL Managed instance in the earlier steps
```KQL
AzureDiagnostics | where Category == "SQLSecurityAuditEvents" 
```
## Create Alerts to notify on any suspicious activities
Here are steps to create Alerts based on a Custom log query. You can customize this accordingly to your SLA requirements and create an Action group to notify when certain thresholds are hit. Click on the **New Alert** option on the top of the query window.
```KQL
AzureDiagnostics
| where Category == "SQLSecurityAuditEvents" and action_name_s =="EXECUTE"  and object_name_s =="sp_addlinkedserver" | count
```

![image](https://user-images.githubusercontent.com/22504173/75916508-7a30ad00-5e26-11ea-95b6-6417db26ef03.png)

![image](https://user-images.githubusercontent.com/22504173/75916520-7f8df780-5e26-11ea-8fff-5f96bafacd4e.png)
## Create an action group to get notified on the alert. This could be an email, SMS, Webhook or Logic apps etc.

![image](https://user-images.githubusercontent.com/22504173/75916533-83ba1500-5e26-11ea-922b-702499f80116.png)

## Finally, provide an Alert name and Create the Alert rule

![image](https://user-images.githubusercontent.com/22504173/75916685-c8de4700-5e26-11ea-8e9c-f576d96f464c.png)

## Test the Alert

Run the following script to enable "clr enabled" or "Database Mail XPs" on the Azure SQL Managed instance

```TSQL
sp_addlinkedserver'test'

```

## After sometime, you will get an email or text message with  the information as an Alert.
![image](https://user-images.githubusercontent.com/22504173/75595388-2440bb80-5a5a-11ea-9dfb-c72f065d0dc0.png)
