--liquibase formatted sql
--changeset C7V5Z6:9
CREATE TABLE IF NOT EXISTS aae_gov_marketing.adobe(
    date STRING,
    tracking_code STRING,
    campaign_name STRING,
    mrketing_channel STRING,
    category STRING,
    description STRING,
    visits STRING,
    unique_visitors STRING,
    file_name STRING,
    load_date STRING,
    PRIMARY KEY(tracking_code)
) USING DELTA
TBLPROPERTIES (delta.enableChangeDataCapture=true,delta.autooptimize.optimizewrite=true,delta.minReaderVersion='2',delta.minWriterVersion='5',delta.columnMapping.mode='name');
-- rollback DROP TABLE aae_gov_marketing.adobe;  