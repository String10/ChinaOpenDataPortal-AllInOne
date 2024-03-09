#!/usr/bin/bash

echo "================================`date -I`================================"

SCRIPT_DIR=$(dirname $(readlink -f $0))
source ${SCRIPT_DIR}/env.sh

# fetch metadata & write to database
CRAWLER_MODULE="crawler"
DBWRITER_MODULE="db-writer"

DATE_SUFFIX=`date +"%Y-%m-%d"`
METADATA_SAVING_PATH="${METADATA_PATH}/metadata-${DATE_SUFFIX}"
DATAFILE_SAVING_PATH="${DATAFILE_PATH}/datafile-${DATE_SUFFIX}"

    ## fetch metadata from websites
    echo "[LOG `date`] Fetching METADATA..."
    mkdir -p ${METADATA_SAVING_PATH}
    pushd ${METADATA_REPO_PATH}
        ${PYTHON_PATH} -m ${CRAWLER_MODULE} --all --workers ${CRAWL_WORKERS} \
            ${CRAWL_FILES} --files-output ${DATAFILE_SAVING_PATH} \
            --metadata-output ${METADATA_SAVING_PATH}
    popd

    ## write metadata into database
    echo "[LOG `date`] Writing Database..."
    pushd ${METADATA_REPO_PATH}

        ### save a copy of crawled metadata
        ARC_TABLE_NAME=`echo metadata-${DATE_SUFFIX} | sed 's/-/_/g'`
        echo "[LOG `date`] Writing to TABLE ${ARC_TABLE_NAME}"
        ${PYTHON_PATH} -m ${DBWRITER_MODULE} \
            --db-host ${DB_ADDR} \
            --db-port ${DB_PORT} \
            --db-user ${DB_USER} \
            --db-pswd ${DB_PSWD} \
            --database ${DATABASE_NAME} \
            --ref-table ${REF_TABLE_NAME} \
            --table ${ARC_TABLE_NAME} \
            --metadata-path ${METADATA_SAVING_PATH}

        ### merge into a single table
        echo "[LOG `date`] Writing to TABLE ${PRD_TABLE_NAME}"
        ${PYTHON_PATH} -m ${DBWRITER_MODULE} \
            --db-host ${DB_ADDR} \
            --db-port ${DB_PORT} \
            --db-user ${DB_USER} \
            --db-pswd ${DB_PSWD} \
            --database ${DATABASE_NAME} \
            --table ${PRD_TABLE_NAME} \
            --url-hash \
            --metadata-path ${METADATA_SAVING_PATH}

    popd

echo "[LOG `date`] Finish Data Fetching."
