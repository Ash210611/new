--liquibase formatted sql
--changeset C7V5Z6:8
CREATE TABLE IF NOT EXISTS aae_gov_marketing.adhoc_tracker (
    load_date STRING,
    file_name STRING,
    schema STRING,
    file_path STRING,
    PRIMARY KEY(file_path)
) USING DELTA
TBLPROPERTIES (delta.enableChangeDataCapture=true,delta.autooptimize.optimizewrite=true,delta.minReaderVersion='2',delta.minWriterVersion='5',delta.columnMapping.mode='name');
-- rollback DROP TABLE aae_gov_marketing.adhoc_tracker;  