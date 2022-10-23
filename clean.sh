#!/bin/sh
docker system prune --all --force
docker volume rm $(docker volume ls -qf dangling=true)
rm -rf /var/lib/snapd/cache/*
journalctl --vacuum-size=100M
find /var/log -type f -name "*.gz" -delete
docker pull fxxy/news-aggregate-rss
docker pull fxxy/news-aggregate-feed
docker pull fxxy/news-aggregate-reprtxt
docker pull fxxy/news-aggregate-srv
docker pull fxxy/news-aggregate-cleanup

docker run -d --network=dropnetwork --env-file /env/drop.env fxxy/news-aggregate-cleanup


 #Removes old revisions of snaps

set -eu
LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
   while read snapname revision; do
       snap remove "$snapname" --revision="$revision"
   done
