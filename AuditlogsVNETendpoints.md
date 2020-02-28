# Restricting network access to only Azure SQL Managed Instance subnet to your SQL Audit logs storage account

One of the security risk is exposing this storage account which contains your SQL Managed Instance Audit logs which can be subjected to tampering or deletions. Hence, it is very important to lock down this storage account so that only your SQL Managed instance has access to it and blocked from everybody else.

Go to the Storage account which contains your SQL Server audit logs

![image](https://user-images.githubusercontent.com/22504173/75550179-540ea580-59ff-11ea-928f-d61fc1d45a18.png)

Once you enable this VNET endpoint on the storage account, Only SQL MI will be able to write to the storage account. You need to exclusively add other VNET\Subnets if you want to give whitelisted access to other privileged users or use SQL MI or query the audit logs accordingly.

