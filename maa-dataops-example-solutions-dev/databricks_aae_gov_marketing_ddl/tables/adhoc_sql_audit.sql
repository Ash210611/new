--liquibase formatted sql
--changeset C7H9RT:1

CREATE TABLE IF NOT EXISTS aae_gov_marketing.adhoc_sql_audit ( 
  batchID STRING, seq_no BIGINT, 
  process_flag STRING, 
  sql_content STRING, 
  current_timestamp TIMESTAMP
) USING delta 
TBLPROPERTIES (delta.enableChangeDataCapture=true,delta.autooptimize.optimizewrite=true,delta.minReaderVersion='2',delta.minWriterVersion='5',delta.columnMapping.mode='name');
-- rollback DROP TABLE usm_dev.aae_gov_marketing.adhoc_sql_audit;
