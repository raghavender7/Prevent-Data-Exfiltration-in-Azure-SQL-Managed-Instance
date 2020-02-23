# Prevent Data Exfiltration in Azure SQL Database Managed Instance
This repo provides documentation on how to tighten your security surface area on Azure SQL Database Managed Instances to prevent and protect against any Data exfiltration scenarios

As part of your Network Infrastructure, you might have tightened your security to make sure you have all the bells and whistles to lock down your Azure SQL Instance to be accessed only by your application and not exposed to Internet or any other traffic. However, this doesn’t stop a malicious admin to take a backup or create a linked server to some other resource outside your enterprise subscription. This is called Data Exfiltration. In a typical On-prem Infrastructure, you can lock down network access completely to make sure that the data never leaves your network. However, In a cloud setup, there is a possibility that someone with elevated privileges can export data or perform any malicious activity to their own resources outside your organization which can compromise your enterprise data. Hence, it is very important to understand different data exfiltration scenarios and make sure that you are taking the right steps to both prevent and monitor such activities.

Here are different different Exfiltration scenarios.
![image](https://user-images.githubusercontent.com/22504173/75120368-4b158100-5659-11ea-8a34-8a05440158e1.png)


# Backups to Unauthorized Locations
Azure SQL Managed instances supports taking backups to a URL with the COPY_ONLY flag. This means that a malicious user can take a backup of the database to a personal storage account within the same Azure region. There are couple of ways to make sure that we prevent this from happening.

## Preventive Actions
* Restricted Admin Access:
   Always follow the principle of least privilege to make sure that you are always granting the minimum permissions to your DBAs and other privileged users. 
   [GitHub](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/Restricted%20Admin.sql)
* Use Transparent Data Encryption (TDE)

## Controls


# Copying Data through Linked Servers
## Preventive Actions
* Restricted Admin Access
## Controls

# Outbound Calls through CLR Integration
## Preventive Actions
* Restricted Admin Access
* Turn off CLR Integration
## Controls

# Sending Data through DBMail
## Preventive Actions
* Restricted Admin Access
## Controls

# Reading Data from Audit Logs
## Preventive Actions
* Locking storage firewall to Managed Instance subnet
## Controls






