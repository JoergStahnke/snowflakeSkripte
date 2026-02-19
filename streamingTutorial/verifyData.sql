use database PIPE_DATABASE;
use role pipe_role;
use schema pipe_schema;

SELECT COUNT(*) FROM pipe_TABLE;
SELECT * FROM pipe_TABLE LIMIT 100;

SELECT
    data,
    TYPEOF(data) as data_type
FROM pipe_TABLE
LIMIT 100;