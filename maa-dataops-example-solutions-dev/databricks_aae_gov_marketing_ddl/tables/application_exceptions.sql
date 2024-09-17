--liquibase formatted sql
--changeset C7G3T3:1
 create table aae_gov_marketing.application_exceptions (
   Id STRING,
   Application_ID__C STRING,
   Cust_Id STRING,
   DATE_OF_SIGNATURE__C TIMESTAMP,
   Lead__c STRING,
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
 -- rollback DROP TABLE aae_gov_marketing.application_exceptions;


--changeset C7G3T3:2
CREATE TABLE IF NOT EXISTS aae_gov_marketing.application_exceptions (
   Id STRING,
   Application_ID__C STRING,
   Cust_Id STRING,
   DATE_OF_SIGNATURE__C TIMESTAMP,
   Lead__c STRING,
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
 -- rollback DROP TABLE aae_gov_marketing.application_exceptions;
 