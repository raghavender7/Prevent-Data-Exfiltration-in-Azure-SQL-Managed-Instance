Here are instructions on how to manually backup and restore a sql database from one SQL Managed Instance to the other instane within the same Azure AD tenant. These instructions have been put together by my peer Karthik Yella 

Once a database is encrypted with TDE using a key from Key Vault, any generated backups are also encrypted with the same **TDE Protector**.

To restore a backup encrypted with a TDE Protector from Key Vault, we need to make sure that the key material is still in the original vault under the original key name. Also, the target instance needs to have access to the TDE protector from the source instance. 

You need to add that key on the target instance, but don't need to check the checkbox at the bottom of the blade -'Make the selected key the default protector’. That way, key can be used for restoring on the target instance, without being used as a default protector.

In the below example, I am trying to restore a database backup from **vyelsqlmi2** to **vyelsqlmi3**. 

vyelsqlmi2 has been encrypted with the TDE protector- **MyTDEKey2** from the keyvault - **vyelkeyvault**. So, all the backups taken on the instance will be encrypted with this TDE protector.




