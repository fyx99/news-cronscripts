# News Operations Cronscripts

Various files supporting the NewsAggregator Project. Project is operated on a small 5$ month machine with very limited capacities. Basis for stable deployments is a Docker containerisation. This repo consists of multiple bash scripts running different components of the aggregation and feature engineering pipeline. All powered by the inbuilt cron engine from linux. The cron.txt file holds the entirety of the pipeline scheduling, including operation utilities like backups and cleaning of the file system.

## Scripts:

**backup.sh**

Purpose: Creates a backup of the postgres database to a S3 bucket using psql.

**clean.sh**

Purpose: Cleans temporary and unnecessary files from the VM + prunes all old Docker artefacts.

**newsaggregate_process_features.**

Purpose: Processes news data to extract and analyze specific features.

**newsaggregate_reprocess_text.sh**

Purpose: Reprocesses text data in batches to clean and enhance the overall dataset (dedupe, filter out bad data etc.).

**newsaggregate_rss.sh**

Purpose: Fetches and aggregates news data from many RSS feeds using a Crawler.

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
