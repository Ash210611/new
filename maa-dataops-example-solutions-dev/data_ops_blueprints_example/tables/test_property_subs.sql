--liquibase formatted sql
--changeset Zach:1
CREATE TABLE IF NOT EXISTS some_table (
    batchID STRING, seq_no BIGINT,
    process_flag STRING,
    sql_content STRING,
    current_timestamp TIMESTAMP
);
-- rollback DROP TABLE some_table;

--changeset Zach:2
ALTER TABLE some_table
ADD COLUMN extract_dt TIMESTAMP;
-- rollback ALTER TABLE some_table DROP COLUMN extract_dt;
