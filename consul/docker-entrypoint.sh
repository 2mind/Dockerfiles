#!/bin/bash
set -e

sleep 3

CI=`curl -s 'http://rancher-metadata/2015-07-25/self/container/create_index'`
PI=`curl -s 'http://rancher-metadata/2015-07-25/self/container/primary_ip'`
SN=`curl -s 'http://rancher-metadata/2015-07-25/self/container/service_name'`
#JC=`nslookup $SN | grep  Address | tail +3 | awk -F ":" '{print $2}' | sed '/'$PIP'/d' | tail -1`
JC=`dig $SN +short | sed '/'$PIP'/d' | tail -1`

dig +short

if [ -z "$CONSUL_NODES" ]; then    
    CONSUL_NODES=3   
fi

if [ "$CI" == 1 ]; then    
    echo "Start Consul cluster $CONSUL_NODES nodes..."
    exec consul agent -server -config-dir=/config -advertise $PI -bootstrap-expect $CONSUL_NODES -ui-dir /ui
else
	echo "Join Consul cluster ..."
	exec consul agent -server -config-dir=/config -advertise $PI -join $JC -ui-dir /ui
fi

exec "$@"
