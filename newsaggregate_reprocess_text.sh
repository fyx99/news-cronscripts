#!/bin/sh

qdocker pull fxxy/news-aggregate

CONTAINERID=$(docker run -d -e TASK='REPROCESS_TEXT' --network=dropnetwork --env-file /env/drop.env fxxy/news-aggregate)
echo $CONTAINERID
docker wait $CONTAINERID

START=$(docker inspect --format='{{.State.StartedAt}}' ${CONTAINERID})
STOP=$(docker inspect --format='{{.State.FinishedAt}}' ${CONTAINERID})
STATUS=$(docker container inspect -f '{{.State.ExitCode}}' ${CONTAINERID})
START_TIMESTAMP=$(date --date=$START +%s)
STOP_TIMESTAMP=$(date --date=$STOP +%s)
MINUTES=$(( ($STOP_TIMESTAMP - $START_TIMESTAMP) / 60 ))

docker exec postgres psql -U postgres -d newsaggregate -c "INSERT INTO Runs (task, containerid, status, duration) values ('REPROCESS_TEXT', '${CONTAINERID}', '${STATUS}', '${MINUTES}');"
