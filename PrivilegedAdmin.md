# Enabling Azure AD authentication on Azure SQL Managed Instance and adding AAD server logins as Sysadmins for Privileged users

Azure Active Directory authentication is a mechanism of connecting to Azure SQL Managed Instance by using identities in Azure Active Directory (Azure AD). With Azure AD authentication, you can centrally manage the identities of database users and other Microsoft services in one central location.

All the privileged users in Azure SQL Managed instance need to have AAD server logins on the Managed SQL Instance. Preferable to create an AAD Group as a sysadmin on the SQL Server.

In order to enable AAD authentication for managed SQL Instance, you need to Set an AAD admin on the Azure SQL Managed Instance properties. 

![image](https://user-images.githubusercontent.com/22504173/75589234-403b6180-5a48-11ea-9ecb-051c514f0311.png)


Once you set the admin, then you will be able to add AAD accounts as server logins and then added to the corresponding server role accordingly.
 [T-SQL Script to create AAD server logins and granting sysadmin](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/PrivilegedAdmin.sql)

```TSQL
USE master
GO
CREATE LOGIN [abc@microsoft.com] FROM EXTERNAL PROVIDER
GO
ALTER SERVER ROLE sysadmin ADD MEMBER [abc@microsoft.com]
GO

```


In this way, you can guarantee that all your sysadmins are connecting from Azure AD accounts only. Also you can set Azure AD conditional access on these accounts that they can be accessed only from certain regions or devices etc.

For Securing location and time, the best practice is to enable Privileged Identity management to log onto Secured Jump start VMs within the same VNET as the SQL Managed instance and then connecting to the managed instance over these secure VMs to lock down the admin access. Link : https://docs.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-getting-started


 
