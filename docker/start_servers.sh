#!/bin/sh

auth_server &

if [ -n "$BIND_ADDRESS_AUTH" ]; then
	CNT=0
	while [ $CNT -eq 0 ]
	do
		CNT=$(ss -tulpn | grep $BIND_ADDRESS_AUTH -c) && sleep 0.1
	done
fi

resource_server
