#!/bin/sh

date | aws s3 cp - s3://hcp-1a9ec634-dfdf-40cd-8a08-d40904f2d00e/pgdumps/dump_test.sql > crontest.txt && docker exec postgres psql -U postgres -d newsaggregate -c "INSERT INTO Backups (file_name) values ('dump_`date +%d-%m-%Y`.sql');"
