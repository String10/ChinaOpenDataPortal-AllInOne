#!/usr/bin/bash

echo "================================`date -I`================================"

SCRIPT_DIR=$(dirname $(readlink -f $0))
source ${SCRIPT_DIR}/env.sh

${FLASK_PATH} --app app run -p ${FLASK_PORT} \
    "$@"