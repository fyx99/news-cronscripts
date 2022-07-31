#!/bin/sh
docker system prune --all --force
docker volume rm $(docker volume ls -qf dangling=true)
rm -rf /var/lib/snapd/cache/*
journalctl --vacuum-size=100M
find /var/log -type f -name "*.gz" -delete
docker pull fxxy/news-rss
docker pull fxxy/news-feed
docker pull fxxy/news-reprtxt
docker pull fxxy/news-aggregate-srv
