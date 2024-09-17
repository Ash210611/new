--liquibase formatted sql
 --changeset C7G3T3:2
CREATE TABLE IF NOT EXISTS  aae_gov_marketing.lead_exceptions (
   Id STRING,
   Lead__c STRING,
   Cust_Id STRING,
   CreatedDate TIMESTAMP,
   LastModifiedDate TIMESTAMP,
   Datasource STRING,
   Project STRING,
   perm_id INT,
   Individual STRING,
   fileDate TIMESTAMP,
   sourceFilename STRING,
   PRIMARY KEY(Id)
 ) USING DELTA
 TBLPROPERTIES (delta.enableChangeDataCapture=true,delta.autooptimize.optimizewrite=true,delta.minReaderVersion='2',delta.minWriterVersion='5',delta.columnMapping.mode='name');
 -- rollback DROP TABLE aae_gov_marketing.lead_exceptions;  