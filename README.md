# **News Aggregator Scheduling**

This repository contains various scripts supporting the **NewsAggregator Project**, which operates on a $5/month virtual machine with very limited resources. The project ensures stable deployments through **Docker containerization** and leverages Linux's built-in **cron engine** for scheduling tasks.

The `cron.txt` file defines the entire pipeline scheduling, including essential utilities like **backups** and **system cleanup**.

---

## 🚀 **Scripts Overview**

### 🗂️ **backup.sh**
- **Purpose:** Creates a backup of the PostgreSQL database and uploads it to an **S3 bucket**.

### 🧹 **clean.sh**
- **Purpose:** Cleans temporary and unnecessary files from the VM.
- Prunes outdated **Docker artifacts**.

### 📊 **newsaggregate_process_features.sh**
- **Purpose:** Processes news data to **extract and analyze specific features**.

### 📝 **newsaggregate_reprocess_text.sh**
- **Purpose:** Reprocesses text data in batches to **clean** and **enhance** the dataset (e.g., deduplication, filtering invalid data).

### 🌐 **newsaggregate_rss.sh**
- **Purpose:** Fetches and aggregates news data from multiple **RSS feeds** using a web crawler.

---

## 🛠️ **How to Use**

1. **Sync the Git Repository:**
   ```bash
   git pull
   ```

2. **Sync the Cron File:**
   ```bash
   cp /var/spool/cron/crontabs/root cron.txt
   # -> This updates the cron configuration in the repository.
   ```
