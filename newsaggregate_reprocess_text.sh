#!/bin/sh


qdocker pull fxxy/news-aggregate ;
containerid=$(docker run -d -e TASK='REPROCESS_TEXT' -e DB_NAME='newsaggregate' -e DB_HOST='172.17.0.2' -e DB_USER='postgres' -e DB_PW='u3fph3ßü98fg43f34f3' -e DB_PORT='5432' fxxy/news-aggregate)
echo $containerid
docker wait $containerid &&
docker exec postgres psql -U postgres -d newsaggregate -c "INSERT INTO Runs (task, status) values ('REPROCESS_TEXT', '`docker container inspect -f '{{.State.ExitCode}}' ${containerid}`');"

