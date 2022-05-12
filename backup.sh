#!/bin/sh
docker exec -t postgres pg_dumpall -c -U postgres | /usr/local/bin/aws s3 cp - s3://hcp-1a9ec634-dfdf-40cd-8a08-d40904f2d00e/pgdumps/dump_`date +%d-%m-%Y`.sql && docker exec postgres psql -U postgres -d newsaggregate -c "INSERT INTO Backups (file_name) values ('dump_`date +%d-%m-%Y`.sql');"
