#!/usr/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))
SERVER_REPO_PATH="${SCRIPT_DIR}/../ChinaOpenDataPortal-Backend"
LUCENE_INDICES_PATH="${SCRIPT_DIR}/../indices"

# Tools
MAVEN_PATH="mvn"
JAVA_PATH="java"

# Common
ADMIN_USER="****"
ADMIN_PSWD="****"
LUCENE_INDICES_CURRENT_PATH="${LUCENE_INDICES_PATH}/current"

# For Backend Starter
STOPWORDS_PATH="${SERVER_REPO_PATH}/src/main/resources/static/stopwords/nltk-chinese-stopwords.txt"
PORTALS_PATH="${SERVER_REPO_PATH}/src/main/resources/data/portals.json"
NEWS_PATH="${SERVER_REPO_PATH}/src/main/resources/data/news.json"

echo "[LOG] Environment loaded."

# Custom Environment
__CUSTOM_ENV_PATH="${SCRIPT_DIR}/env.custom.sh"
if [ -f "${__CUSTOM_ENV_PATH}" ]; then
    source ${__CUSTOM_ENV_PATH}
    echo "[LOG] Custom Environment loaded."
fi
