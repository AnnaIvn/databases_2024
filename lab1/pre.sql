psql \! chcp 1251
\l    -- to see list of existing databases
CREATE DATABASE lab1_wood;
\l

\du    -- to see list of roles
CREATE USER user1 WITH PASSWORD '1111';
CREATE USER user2 WITH PASSWORD '1111';
\du

\c lab1_wood;   -- to connect to database lab1_wood as user postgres (do by hands)

-- grant all privileges on schema 
GRANT ALL ON DATABASE lab1_wood TO user2;
GRANT ALL ON SCHEMA public TO user2;

-- grant read-only access to user1 to a schema. Do, after creating such schema (if it's custom)
GRANT USAGE ON SCHEMA public TO user1;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user1;

\c lab1_wood user2;

-- example on how to execute an .sql file
-- \i d:/code.sql;