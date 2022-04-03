#!/bin/bash

set -e

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-EOSQL
    CREATE USER authelia;
    CREATE DATABASE authelia;
    ALTER USER authelia WITH PASSWORD '<AUTHELIA_PASSWORD>';
    GRANT ALL PRIVILEGES ON DATABASE authelia TO authelia;
EOSQL
