#!/bin/sh

qdocker pull fxxy/news-aggregate

CONTAINERID=$(docker run -d -e TASK='REPROCESS_TEXT' -e DB_NAME='newsaggregate' -e DB_HOST='172.17.0.2' -e DB_USER='postgres' -e DB_PW='u3fph3ßü98fg43f34f3' -e DB_PORT='5432' fxxy/news-aggregate)
echo $CONTAINERID
docker wait $CONTAINERID

START=$(docker inspect --format='{{.State.StartedAt}}' ${CONTAINERID})
STOP=$(docker inspect --format='{{.State.FinishedAt}}' ${CONTAINERID})
STATUS=$(docker container inspect -f '{{.State.ExitCode}}' ${CONTAINERID})
START_TIMESTAMP=$(date --date=$START +%s)
STOP_TIMESTAMP=$(date --date=$STOP +%s)
MINUTES=$(( ($STOP_TIMESTAMP - $START_TIMESTAMP) / 60 ))

docker exec postgres psql -U postgres -d newsaggregate -c "INSERT INTO Runs (task, containerid, status, duration) values ('REPROCESS_TEXT', '${CONTAINERID}', '${STATUS}', '${MINUTES}');"
