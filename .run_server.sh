#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ENV_FILE="${SCRIPT_DIR}/.env"
SERVER_AUTH="${SCRIPT_DIR}/target/release/auth_server &"
SERVER_RESOURCE="${SCRIPT_DIR}/target/release/resource_server &"

set -o allexport
source <(sed -e "s/\r//" -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/=\"\1\"/g" "${ENV_FILE}")
set +o allexport

eval "$SERVER_AUTH"

if [ -n "$BIND_ADDRESS_AUTH" ]; then
	CNT=0
	while [ $CNT -eq 0 ]
	do
		CNT=$(ss -tulpn | grep $BIND_ADDRESS_AUTH -c) && sleep 0.1
	done
fi

eval "$SERVER_RESOURCE"
