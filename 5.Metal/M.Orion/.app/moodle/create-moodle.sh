#!/bin/bash

# usage: bash create-moodle.sh qa

NS=${1:-default}
APP=moodle

## Version using Full Index
#HELM_VERSION=13.0.3
#HELM_REPO=bitnami-full-index

## Latest Version
HELM_VERSION=14.3.14
HELM_REPO=bitnami


helm install ${APP} ${HELM_REPO}/${APP} \
  --namespace ${NS} \
  --values values.yaml \
  --version ${HELM_VERSION}
