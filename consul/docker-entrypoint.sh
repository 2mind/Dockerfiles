#!/bin/bash
set -e

sleep 5

CI=`curl -s 'http://rancher-metadata/2015-07-25/self/container/create_index'`
NM=`curl -s 'http://rancher-metadata/2015-07-25/self/container/name'`
PI=`curl -s 'http://rancher-metadata/2015-07-25/self/container/primary_ip'`
SN=`curl -s 'http://rancher-metadata/2015-07-25/self/container/service_name'`
#JC=`nslookup $SN | grep  Address | tail +3 | awk -F ":" '{print $2}' | sed '/'$PI'/d' | tail -1`
JC=`dig $SN +short | sed '/'$PI'/d' | tail -1`

if [ -z "$CONSUL_NODES" ]; then    
    CONSUL_NODES=3   
fi

if [ "$CI" == 1 ]; then    
    echo "Start Consul cluster $CONSUL_NODES nodes..."
    exec consul agent -server -config-dir=/config -advertise $PI -bootstrap-expect $CONSUL_NODES -node $NM
else
	echo "Join Consul cluster ..."
	exec consul agent -server -config-dir=/config -advertise $PI -join $JC -node $NM
fi

exec "$@"
