# Disable DBMail on Azure SQL Managed Instance

DBMail is another Data exfiltration risk on Azure SQL Managed Instance and it needs to be disabled unless there is a very specific need. Most of the alerting can be now done by log analytics or any other notification service and hence there is now a very limited need to enable DBMail directly on the SQL Instance.

Here is the code to disable DBMail on Azure SQL Managed Instance
```TSQL
sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'Database Mail XPs', 0;  
GO  
RECONFIGURE  
GO  
```

[T-SQL script to disable DBMail on SQL Managed Instance](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/SQLMIDisableDBMail.sql)
