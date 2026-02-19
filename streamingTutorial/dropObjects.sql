use role accountadmin;
drop WAREHOUSE if exists pipe_wh;
use role useradmin;
drop USER if exists PIPE_USER;
drop ROLE IF EXISTS PIPE_ROLE;

USE ROLE sysadmin;
drop DATABASE if exists PIPE_DATABASE;