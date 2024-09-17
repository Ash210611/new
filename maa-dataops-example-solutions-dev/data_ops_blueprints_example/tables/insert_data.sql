INSERT INTO some_table (batchID, seq_no, process_flag, sql_content, current_timestamp)
VALUES
('ID001', 12345, 'processed', 'SELECT', CURRENT_TIMESTAMP),
('ID002', 12347, 'completed', 'INSERT', CURRENT_TIMESTAMP)
