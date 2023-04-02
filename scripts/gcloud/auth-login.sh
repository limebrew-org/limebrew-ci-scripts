#!/bin/bash

GCLOUD_TMP_JSON_PATH="/tmp/gcloud-api-key.json"

#? Decode the service account JSON
echo $GCLOUD_ENCODED_SERVICE_ACCOUNT_JSON | base64 -d > $GCLOUD_TMP_JSON_PATH

#? Run gcloud auth
gcloud info --run-diagnostics
gcloud auth activate-service-account $GCLOUD_PROJECT_SERVICE_ACCOUNT_ID --key-file $GCLOUD_TMP_JSON_PATH
gcloud config set project $GCLOUD_PROJECT_ID