#!/bin/bash

# usage: bash drop-moodle.sh qa

NS=${1:-default}

APP=moodle
DB=mariadb

helm delete ${APP} --namespace ${NS}

kubectl delete pvc data-${APP}-${DB}-0 --namespace ${NS}
