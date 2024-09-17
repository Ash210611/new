--liquibase formatted sql

 --changeset C7V5Z6:3
CREATE TABLE IF NOT EXISTS aae_gov_marketing.export_audit_table (
    Job_Id STRING,
    table_name STRING,
    refresh_type STRING,
    job_execution_start_date_time TIMESTAMP,
    source_schema STRING,
    target_schema STRING,
    source_count INT,
    target_insert_count INT,
    target_update_count INT,
    target_delete_count INT,
    job_status STRING,
    error_code STRING,
    error_desc STRING,
    job_execution_end_date_time TIMESTAMP,
    PRIMARY KEY(Job_Id)
) USING delta TBLPROPERTIES (
  delta.enableChangeDataFeed = true,
  delta.columnMapping.mode = 'name',
  delta.minReaderVersion = '2',
  delta.minWriterVersion = '5'
);
