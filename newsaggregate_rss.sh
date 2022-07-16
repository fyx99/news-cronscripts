#!/bin/sh


docker pull fxxy/news-aggregate

CONTAINERID=$(docker run -d -m 400m --memory-swap="400m" -e TASK='RSS' --network=dropnetwork --env-file /env/drop.env fxxy/news-aggregate)
echo $CONTAINERID
docker wait $CONTAINERID

START=$(docker inspect --format='{{.State.StartedAt}}' ${CONTAINERID})
STOP=$(docker inspect --format='{{.State.FinishedAt}}' ${CONTAINERID})
STATUS=$(docker container inspect -f '{{.State.ExitCode}}' ${CONTAINERID})
START_TIMESTAMP=$(date --date=$START +%s)
STOP_TIMESTAMP=$(date --date=$STOP +%s)
MINUTES=$(( ($STOP_TIMESTAMP - $START_TIMESTAMP) / 60 ))

docker exec postgres psql -U postgres -d newsaggregate -c "INSERT INTO Runs (task, containerid, status, duration) values ('RSS', '${CONTAINERID}', '${STATUS}', '${MINUTES}');"
