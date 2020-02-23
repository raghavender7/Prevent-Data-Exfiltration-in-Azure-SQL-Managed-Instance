# Prevent Data Exfiltration in Azure SQL Database Managed Instance
This repo provides documentation on how to tighten your security surface area on Azure SQL Database Managed Instances to prevent and protect and against any Data exfiltration scenarios

As part of your Network Infrastructure, you might have tightened your security to make sure you have all the bells and whistles to lock down your Azure SQL Instance to be accessed by your application only and not exposed to Internet or any other traffic. However, this doesn’t stop a malicious admin to take a backup or create a linked server to some other resource outside your enterprise subscription. This is called Data Exfiltration. In a typical On-prem Infrastructure, you can lock down access to make sure that the data never leaves your network. However, In a cloud setup, there is a possibility that someone with elevated privileges can export data or perform any malicious activity which can compromise your enterprise data. Hence, it is important to understand different data exfiltration scenarios and make sure that you are taking steps to both prevent and monitor such activities.

Here are different different Exfiltration scenarios.

https://user-images.githubusercontent.com/22504173/75120368-4b158100-5659-11ea-8a34-8a05440158e1.png


# Restricted Admin Access



# Setting Auditing Alerts



