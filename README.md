# Prevent Data Exfiltration in Azure SQL Database Managed Instance
This repo provides documentation on how to tighten your security surface area on Azure SQL Database Managed Instances to prevent and protect against any Data exfiltration scenarios

As part of your Network Infrastructure, you might have tightened your security to make sure you have all the bells and whistles to lock down your Azure SQL Instance to be accessed only by your application and not exposed to Internet or any other traffic. However, this doesn’t stop a malicious admin to take a backup or create a linked server to some other resource outside your enterprise subscription. This is called Data Exfiltration. In a typical On-prem Infrastructure, you can lock down network access completely to make sure that the data never leaves your network. However, In a cloud setup, there is a possibility that someone with elevated privileges can export data or perform any malicious activity to their own resources outside your organization which can compromise your enterprise data. Hence, it is very important to understand different data exfiltration scenarios and make sure that you are taking the right steps to both prevent and monitor such activities.

Here are different different Exfiltration scenarios.
![image](https://user-images.githubusercontent.com/22504173/75120368-4b158100-5659-11ea-8a34-8a05440158e1.png)


# Backups to Unauthorized Locations
By default, Azure SQL Database Managed Instance has automatic backups that are stored on Azure storage, fully encrypted, keeping you compliant, and providing most of the functionalities that you would need. Additionally, Managed Instance also enables you to take your own COPY_ONLY backups where you get an option to take backups to a URL with the COPY_ONLY flag. This means that a malicious user can take a backup of the database to his\her personal storage account. There are couple of ways to make sure that we prevent this from happening.

### Preventive Actions
* **Restricted Admin Access:**
  Always follow the principle of least privilege to make sure that you are always granting the minimum permissions to your DBAs and other privileged users on your Azure SQL Managed Instance.
   [T-SQL Script to create Restricted Admin role](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/Restricted%20Admin.sql)
   
   For your Power users who need sysadmin access, here are some guidelienes
   
* **Use Transparent Data Encryption (TDE):**
TDE helps protect Azure SQL Managed Instance against the threat of malicious offline activity by encrypting data at rest. It performs real-time encryption and decryption of the database, associated backups, and transaction log files at rest without requiring changes to the application. TDE is either enabled by using Service Managed Keys(where Microsoft manages the Key which is default) or Customer Managed Keys (where you as a customer point to a key in Azure Key vault). 

COPY_ONLY backups are not allowed when using Service Managed Keys(Ofcourse because Microsoft manages the Key). They can only work with Customer Managed keys which means that in order for someone to restore the backup, the target SQL instance needs to have access to the original key(TDE Protector) in Azure key vault. Azure key vault has an access policy which is managed by Azure AD and hence it acts as security boundary by making sure that any Azure SQL instance which is not part of the Access policy is denied access and hence that backup will be rendered useless preventing data exfiltration.

Here are instructions on [how to backup and restore databases in Azure SQL Database Managed Instance using Customer Managed Keys](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/BackupRestoreusingCMK.md)
 
### Controls
* **Setting Auditing Alerts:**
You need to make sure that you have enabled auditing on the Azure SQL Managed Instance to capture all backup and restore activities. Auditing can write to your storage accounts or to Log Analytics workspaces. By writing to Log Analytics workspace, you can create Alerts and notifications to make sure that you get alerted on all the backup and restore activities to\from Unauthorized locations.

Please follow this link to [enable Auditing on Azure SQL Managed Instance and get alerted for suspicious backup activities](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/SQLMIAuditforBackuprestore.md)

* **Azure Policy to enforce TDE:**
Azure policies enforce different rules and effects over your resources, so those resources stay compliant with your corporate standards and service level agreements. Azure Policy meets this need by evaluating your resources for non-compliance with assigned policies. They have a built-in policy called **"SQL managed instance TDE protector should be encrypted with your own key"**. This policy enforces that you need to encrypt your databases with Customer managed keys located in Azure Key Vault.

Please follow the instructions at this link to enable [Azure policy across your subscription for Managed Instances](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/azurepolicytdecmk.md)

* **ATP Threat detection for Data Exfiltration:**

* **ATP Vulnerability assessments:**

# Copying Data through Linked Servers
### Preventive Actions
* **Restricted Admin Access:**
  Always follow the principle of least privilege to make sure that you are always granting the minimum permissions to your DBAs and other privileged users on your Azure SQL Managed Instance.
   [T-SQL Script to create Restricted Admin role](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/Restricted%20Admin.sql)
   
### Controls
* **Setting Auditing Alerts:**
You need to make sure that you have enabled auditing on the Azure SQL Managed Instance to capture all linked server activities. Auditing can write to your storage accounts or to Log Analytics workspaces. By writing to Log Analytics workspace, you can create Alerts and notifications to make sure that you get alerted on all the linked server activities.

Please follow this link to [enable Auditing on Azure SQL Managed Instance and get alerted for linked server creation](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/SQLMIauditingforLinkedServer.md)

# Outbound Calls through CLR Integration
### Preventive Actions
* **Restricted Admin Access:**
  Always follow the principle of least privilege to make sure that you are always granting the minimum permissions to your DBAs and other privileged users on your Azure SQL Managed Instance.
   [T-SQL Script to create Restricted Admin role](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/Restricted%20Admin.sql)
   
* **Turn off CLR Integration**
 Always make sure that you are disabling CLR on Azure SQL Managed Instance unless you really need it for a very specific purpose. Please follow this link on the instructions on how to disable DBMail. 
  [Disable CLR on Azure SQL managed instance](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/SQLMIDisableclr.md)
  
### Controls
* **Setting Auditing Alerts:**
You need to make sure that you have enabled auditing on the Azure SQL Managed Instance to capture all sp_configure activities. Auditing can write to your storage accounts or to Log Analytics workspaces. By writing to Log Analytics workspace, you can create Alerts and notifications to make sure that you get alerted on all the sp_configure activities happening on the SQL MI instance.

Please follow this link to [Enable Auditing on Azure SQL Managed Instance and get alerted for someone executing sp_configure](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/SPconfigureAuditingSQLMI.md)

# Sending Data through DBMail
### Preventive Actions
* **Restricted Admin Access:**
  Always follow the principle of least privilege to make sure that you are always granting the minimum permissions to your DBAs and other privileged users on your Azure SQL Managed Instance.
   [T-SQL Script to create Restricted Admin role](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/Restricted%20Admin.sql)
 * **Turn off DBMail**
 Always make sure that you are disabling DBMail unless you really need it. Please follow this link on the instructions on how to disable DBMail. 
  [Disable DB Mail on Azure SQL managed instance](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/DisableDBMail.md)
 
 
### Controls
* **Setting Auditing Alerts:**
You need to make sure that you have enabled auditing on the Azure SQL Managed Instance to capture all sp_configure activities. Auditing can write to your storage accounts or to Log Analytics workspaces. By writing to Log Analytics workspace, you can create Alerts and notifications to make sure that you get alerted on all the sp_configure activities happening on the SQL MI instance.

Please follow this link to [Enable Auditing on Azure SQL Managed Instance and get alerted for someone executing sp_configure](https://github.com/raghavender7/Prevent-Data-Exfiltration-in-Azure-SQL-Managed-Instance/blob/master/SPconfigureAuditingSQLMI.md)


# Reading Data from Audit Logs
### Preventive Actions
* **Locking storage firewall to Managed Instance subnet**

### Controls
* **Storage Access controls:**





