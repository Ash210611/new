--liquibase formatted sql
--changeset C7V5Z6:9
CREATE TABLE IF NOT EXISTS aae_gov_marketing.leads_matches (
  SF_LEAD_ID STRING,
  MATCHED_DATE TIMESTAMP,
  ACCOUNTID STRING,
  Lead__c STRING,
  Cust_Id STRING,
  CreatedDate TIMESTAMP,
  LastModifiedDate TIMESTAMP,
  Datasource STRING,
  Project STRING,
  IND_PID STRING,
  INDID STRING,
  INHOMEDATE TIMESTAMP,
  SOURCE_FILE_NAME STRING,
  PassNum STRING,
  PRIMARY KEY(SF_LEAD_ID)
) USING DELTA
TBLPROPERTIES (delta.enableChangeDataCapture=true,delta.autooptimize.optimizewrite=true,delta.minReaderVersion='2',delta.minWriterVersion='5',delta.columnMapping.mode='name');
-- rollback DROP TABLE aae_gov_marketing.leads_matches;  


--changeset C7V5Z6L:10
ALTER TABLE leads_matches
ADD COLUMN TDV_LOAD_DATE TIMESTAMP;
-- rollback ALTER TABLE leads_matches DROP COLUMN TDV_LOAD_DATE;