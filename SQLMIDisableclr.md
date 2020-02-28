# Disable CLR on Azure SQL Managed Instance

CLR(Common Language Runtime) is another Data exfiltration risk on Azure SQL Managed Instance and it needs to be disabled unless there is a very specific need. This can be a potential risk and should be enabled after duly understanding the operations and should be audited.

Here is the code to disable CLR on Azure SQL Managed Instance
```TSQL
sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'clr enabled', 0;  
GO  
RECONFIGURE  
GO    
```

[T-SQL script to disable CLR on SQL Managed Instance](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/SQLMIDisableCLR.sql)

