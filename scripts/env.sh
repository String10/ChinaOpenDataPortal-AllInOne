#!/usr/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))
THIS_REPO_PATH="${SCRIPT_DIR}/.."

SERVER_REPO_PATH="${THIS_REPO_PATH}/ChinaOpenDataPortal-Backend"
METADATA_REPO_PATH="${THIS_REPO_PATH}/ChinaOpenDataPortal-Metadata"
INDEXBUILDER_REPO_PATH="${THIS_REPO_PATH}/ChinaOpenDataPortal-IndexBuilder"

METADATA_PATH="${THIS_REPO_PATH}/metadata"
DATAFILE_PATH="${THIS_REPO_PATH}/datafile"
LUCENE_INDICES_PATH="${THIS_REPO_PATH}/indices"

BACKEND_URL=http://localhost:9999/cn-public

# Tools
MAVEN_PATH="mvn"
JAVA_PATH="java"
PYTHON_PATH="python"

# Common
LUCENE_CURRENT_INDEX_PATH="${LUCENE_INDICES_PATH}/current"
STOPWORDS_PATH="${SERVER_REPO_PATH}/src/main/resources/static/stopwords/nltk-chinese-stopwords.txt"

# Security
ADMIN_USER="****"
ADMIN_PSWD="****"

# Database
DB_ADDR="****"
DB_PORT="****"
DB_USER="****"
DB_PSWD="****"
DATABASE_NAME="****"
REF_TABLE_NAME="****"
PRD_TABLE_NAME="****"

# Options
CRAWL_WORKERS=60
CRAWL_FILES="" # OR "--download-files"

echo "[LOG] Environment loaded."

# Custom Environment
__CUSTOM_ENV_PATH="${SCRIPT_DIR}/env.custom.sh"
if [ -f "${__CUSTOM_ENV_PATH}" ]; then
    source ${__CUSTOM_ENV_PATH}
    echo "[LOG] Custom Environment loaded."
fi
