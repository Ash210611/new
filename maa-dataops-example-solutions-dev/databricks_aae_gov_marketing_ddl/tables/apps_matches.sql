--liquibase formatted sql
--changeset C7V5Z6:8
 
CREATE TABLE IF NOT EXISTS aae_gov_marketing.apps_matches (
  SF_APP_ID STRING,
  MATCHED_DATE TIMESTAMP,
  ACCOUNTID STRING,
  Application_ID__C STRING,
  Cust_Id STRING,
  DATE_OF_SIGNATURE__C TIMESTAMP,
  Lead__c STRING,
  CreatedDate TIMESTAMP,
  LastModifiedDate TIMESTAMP,
  Datasource STRING,
  Project STRING,
  IND_PID STRING,
  INDID STRING,
  INHOMEDATE TIMESTAMP,
  SOURCE_FILE_NAME STRING,
  PassNum STRING,
  PRIMARY KEY(SF_APP_ID)
) USING DELTA
TBLPROPERTIES (delta.enableChangeDataCapture=true,delta.autooptimize.optimizewrite=true,delta.minReaderVersion='2',delta.minWriterVersion='5',delta.columnMapping.mode='name');
-- rollback DROP TABLE aae_gov_marketing.apps_matches;  

--changeset C7V5Z6L:9
ALTER TABLE apps_matches
ADD COLUMN TDV_LOAD_DATE TIMESTAMP;
-- rollback ALTER TABLE apps_matches DROP COLUMN TDV_LOAD_DATE;