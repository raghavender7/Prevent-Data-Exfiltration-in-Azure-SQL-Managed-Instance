# Enabling Advanced Threat protection and Vulnerability assessments on Azure SQL Managed Instances

Advanced Threat Protection for a managed instance detects anomalous activities indicating unusual and potentially harmful attempts to access or exploit databases. Advanced Threat Protection can identify Potential SQL injection, Access from unusual location and Data exfiltration activities. You can receive notifications directly from this service in addition to the audit logs you are capturing on your instance.

Vulnerability Assessment is a scanning service built into the Azure SQL Database service. The service employs a knowledge base of rules that flag security vulnerabilities and highlight deviations from best practices, such as misconfigurations, excessive permissions, and unprotected sensitive data. The rules are based on Microsoft’s best practices and focus on the security issues that present the biggest risks to your database and its valuable data.

They are part of the “Advanced Data Security” under SQL managed instances

![image](https://user-images.githubusercontent.com/22504173/75548542-874f3580-59fb-11ea-94eb-10a9e66ebc26.png)

Under the Advanced Threat protection types list, I would recommend enabling all the options especially the **“Data exfiltration”** option

![image](https://user-images.githubusercontent.com/22504173/75548547-8c13e980-59fb-11ea-92b5-7e475296c26e.png)


Finally, Hit the save button to Save these settings.


Link: https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security
