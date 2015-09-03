#!/bin/bash
set -e

export IP=$(ping -c1 -t1 -W0 $RN 2>&1 | tr -d '():' | awk '/^PING/{print $3}')

exec "$@"