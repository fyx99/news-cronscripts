
#!/bin/sh


docker pull fxxy/news-aggregate-feed

docker stop $(docker ps -q --filter ancestor=fxxy/news-aggregate-feed)

CONTAINERID=$(docker run -d -m 700m --memory-swap="2000m" --network=dropnetwork --env-file /env/drop.env fxxy/news-aggregate-feed)
echo $CONTAINERID
docker wait $CONTAINERID

START=$(docker inspect --format='{{.State.StartedAt}}' ${CONTAINERID})
STOP=$(docker inspect --format='{{.State.FinishedAt}}' ${CONTAINERID})
STATUS=$(docker container inspect -f '{{.State.ExitCode}}' ${CONTAINERID})
START_TIMESTAMP=$(date --date=$START +%s)
STOP_TIMESTAMP=$(date --date=$STOP +%s)
MINUTES=$(( ($STOP_TIMESTAMP - $START_TIMESTAMP) / 60 ))

docker exec postgres psql -U postgres -d newsaggregate -c "INSERT INTO Runs (task, containerid, status, duration) values ('FEATURE', '${CONTAINERID}', '${STATUS}', '${MINUTES}');"
