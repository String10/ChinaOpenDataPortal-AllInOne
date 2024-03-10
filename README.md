# ChinaOpenDataPortal All in One

Use this command to create a basic `env.custom.sh`:

```bash
echo "PYTHON_PATH=$(realpath $(which python))" >> ./scripts/env.custom.sh
```

## API Server & Backend

Github Repo: cqsss/ChinaOpenDataPortal, based on Sprint Boot and Thymeleaf.
Provide basic Web Page service and ability of acting as API server for other frontend service.
Default index path is `indices/current`.

### Script Usage

Use `scripts/start-server.sh` to start a process as API server and backend.
Append more arguments as you need like `./scripts/start-server.sh --server.port=9998`.

Environmet variables you may want to specify in `env.custom.sh`:

1. MAVEN_PATH
1. JAVA_PATH (Java 11 Recommended)
1. ADMIN_USER
1. ADMIN_PSWD

## Data Processor

Github Repos:

1. String10/ChinaOpenDataPortal-Metadata:
   Python scripts crawling metadata from each portals, multi-threads supported.
   Crawled metadata will be written to database for next step usage.
2. String10/ChinaOpenDataPortal-IndexBuilder

### Metadata

Use `scripts/fetch-data.sh` to start a process for metadata fetching.
PS: There is one table that serves as an archive table for each metadata crawl and another table for index building.

Environmet variables you may want to specify in `env.custom.sh`:

1. About Crawler Control:
   1. CRAWL_WORKERS
   1. CRAWL_FILES (whether or not to download datafiles)
1. About database (Only MySQL Supported):
   1. DB_ADDR
   1. DB_PORT
   1. DB_USER
   1. DB_PSWD
   1. DATABASE_NAME
   1. REF_TABLE_NAME (specify a table as template)
   1. PRD_TABLE_NAME (specift a table which used in production)
1. Others:
   1. PYTHON_PATH (Python 3.6 Recommended)

### Lucene Index

After writing into database, the index builder will be started.
If necessary, it will link the latest index to the path `indices/current`.
If current index has been updated,the server will receive a POST request and refresh index path.

Environmet variables you may want to specify in `env.custom.sh`:

1. BACKEND_URL

## Appendix

### Metadata Table Template

```
+-------------------+--------------+------+-----+---------+----------------+
| Field             | Type         | Null | Key | Default | Extra          |
+-------------------+--------------+------+-----+---------+----------------+
| dataset_id        | int          | NO   | PRI | NULL    | auto_increment |
| title             | varchar(255) | YES  |     | NULL    |                |
| description       | text         | YES  |     | NULL    |                |
| tags              | text         | YES  |     | NULL    |                |
| department        | varchar(255) | YES  |     | NULL    |                |
| category          | varchar(255) | YES  |     | NULL    |                |
| publish_time      | varchar(255) | YES  |     | NULL    |                |
| update_time       | varchar(255) | YES  |     | NULL    |                |
| is_open           | varchar(255) | YES  |     | NULL    |                |
| data_volume       | varchar(255) | YES  |     | NULL    |                |
| industry          | varchar(255) | YES  |     | NULL    |                |
| update_frequency  | varchar(255) | YES  |     | NULL    |                |
| telephone         | varchar(255) | YES  |     | NULL    |                |
| email             | varchar(255) | YES  |     | NULL    |                |
| data_formats      | varchar(255) | YES  |     | NULL    |                |
| url               | text         | YES  |     | NULL    |                |
| province          | varchar(255) | YES  |     | NULL    |                |
| city              | varchar(255) | YES  |     | NULL    |                |
| standard_industry | varchar(255) | YES  |     | NULL    |                |
+-------------------+--------------+------+-----+---------+----------------+
```

### Metadata Table for Production Template

```
+-------------------+--------------+------+-----+---------+----------------+
| Field             | Type         | Null | Key | Default | Extra          |
+-------------------+--------------+------+-----+---------+----------------+
| dataset_id        | int          | NO   | PRI | NULL    | auto_increment |
| title             | varchar(255) | YES  |     | NULL    |                |
| description       | text         | YES  |     | NULL    |                |
| tags              | text         | YES  |     | NULL    |                |
| department        | varchar(255) | YES  |     | NULL    |                |
| category          | varchar(255) | YES  |     | NULL    |                |
| publish_time      | varchar(255) | YES  |     | NULL    |                |
| update_time       | varchar(255) | YES  |     | NULL    |                |
| is_open           | varchar(255) | YES  |     | NULL    |                |
| data_volume       | varchar(255) | YES  |     | NULL    |                |
| industry          | varchar(255) | YES  |     | NULL    |                |
| update_frequency  | varchar(255) | YES  |     | NULL    |                |
| telephone         | varchar(255) | YES  |     | NULL    |                |
| email             | varchar(255) | YES  |     | NULL    |                |
| data_formats      | varchar(255) | YES  |     | NULL    |                |
| url               | text         | NO   |     | NULL    |                |
| province          | varchar(255) | YES  |     | NULL    |                |
| city              | varchar(255) | YES  |     | NULL    |                |
| standard_industry | varchar(255) | YES  |     | NULL    |                |
| url_hash          | varchar(255) | NO   | UNI | NULL    |                |
+-------------------+--------------+------+-----+---------+----------------+
```

### Script Usages

#### start-server.sh

Recommended:

```bash
nohup bash ./scripts/start-server.sh >> ./logs/server.txt 2>&1 &
```

#### fetch-data.sh

Recommended:

```bash
# the first of every month at 0:00
echo "0 0 1 */1 * __ROOT=\"`realpath .`\"; bash \${__ROOT}/scripts/fetch-data.sh > \"\${__ROOT}/logs/fd-\`date --i\`.txt\" 2>&1" >> logs/auto-task.txt
crontab logs/auto-task.txt
```
