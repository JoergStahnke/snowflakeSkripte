-- 1. Create a dedicated role and user (Run with a highly-privileged role)
use role accountadmin;
CREATE OR REPLACE WAREHOUSE pipe_wh WAREHOUSE_SIZE = XSMALL;
use role useradmin;
CREATE OR REPLACE USER PIPE_USER;
CREATE ROLE IF NOT EXISTS PIPE_ROLE;
GRANT ROLE PIPE_ROLE TO USER PIPE_USER;
grant role PIPE_ROLE TO role sysadmin;

-- 2. Set the public key for key-pair authentication
-- siehe rsa_key.pub
ALTER USER PIPE_USER SET RSA_PUBLIC_KEY='MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3ZD/f+IgeXXD7CbANnx8
3Ks6OmMe9H+F3SSEEhZFxHb4+fikzYDlt7WhpggQc3J9AKjlFpP9x6fjX5SeaTru
YKz3xYAwEkKU/zIzAqmPYXzBZsnal+w3Unr8kvWgFLaTN/BINBcyyvt9eK2uoK3x
z2t13nLwa93rBL2RxqnRnVliKXwMuusSqvZDMSPIUeTAiGBoXF39vnfZOtP8xV3z
8ShYAJtQMlnO2JJOcUhjEma3xc5ZSIL2WHcXPDfJfMG8xIRNZyeoKmzYWvQyli9g
g6ZEd+1NiA3tZ27OYhgWdrkKMIaNlfRoNU6X+/H0rgO06g/utgMlo4zBj5SVeT3x
gQIDAQAB';

-- 3. Set the default values
ALTER USER PIPE_USER SET DEFAULT_ROLE=PIPE_ROLE;
alter user pipe_user set default_warehouse = pipe_wh;
grant usage on warehouse pipe_wh to PIPE_ROLE;


-- Create database
use role sysadmin;
CREATE OR REPLACE DATABASE PIPE_DATABASE;
grant ownership on database pipe_database to pipe_role;

-- 4. Switch to the new role and create objects
USE ROLE PIPE_ROLE;

CREATE OR REPLACE SCHEMA PIPE_SCHEMA WITH MANAGED ACCESS ;
use schema PIPE_SCHEMA;
-- Create a target table
CREATE OR REPLACE TABLE PIPE_TABLE (
    data VARIANT,
    c1 NUMBER,
    c2 STRING
);
