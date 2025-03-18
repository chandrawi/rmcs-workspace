#!/bin/bash

BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && dirname $PWD )
ENV_FILE="${BASE_DIR}/.env"
if [ $# -gt 0 ]; then
	ENV_FILE="${BASE_DIR}$1"
fi
SERVER_AUTH="${BASE_DIR}/target/debug/test_auth_server &"
SERVER_RESOURCE="${BASE_DIR}/target/debug/test_resource_server &"

set -o allexport
source <(sed -e "s/\r//" -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/=\"\1\"/g" "${ENV_FILE}")
set +o allexport

eval "$SERVER_AUTH"

eval "$SERVER_RESOURCE"
