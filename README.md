# News Operations Cronscripts

Various files supporting the NewsAggregator Project. Project is operated on a small 5$ month machine with very limited capacities. Basis for stable deployments is a Docker containerisation. This repo consists of multiple bash scripts running different components of the aggregation and feature engineering pipeline. All powered by the inbuilt cron engine from linux. The cron.txt file holds the entirety of the pipeline scheduling, including operation utilities like backups and cleaning of the file system.

## Scripts:

1. backup.sh

Purpose: Creates a backup of essential project files and databases.

2. clean.sh

Purpose: Cleans temporary and unnecessary files from the project directory.

3. newsaggregate_process_features.sh

Purpose: Processes news data to extract and analyze specific features.

4. newsaggregate_reprocess_text.sh

Purpose: Reprocesses text data for normalization and consistency.

5. newsaggregate_rss.sh

Purpose: Fetches and aggregates news data from RSS feeds.

## How to use:

1. Sync Git Repo to machine using:
   
```bash
git pull
```
2. Navigate to the cron file and sync:
   
 ```bash
 cp /var/spool/cron/crontabs/root cron.txt
# -> to get cron file in repo
```
