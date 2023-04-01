#!/bin/bash

SERVICE_IMAGE_NAME=$1
ENVS=$2
SERVICE_ACCOUNT=$4
TAG_NAME=$6
SERVICE_NAME=$5

GCR_LOCATION=${{ secrets.GCLOUD_DOCKER_REGISTRY_HOSTNAME }}; export GCR_LOCATION
GCLOUD_PROJECT_ID=${{ secrets.GCLOUD_PROJECT_ID_LIMEBREW }}; export GCLOUD_PROJECT_ID
DOCKER_REPO_NAME=${{ secrets.GCLOUD_DOCKER_REPO_NAME }}; export DOCKER_REPO_NAME

GCR_IMAGE_NAME=$GCR_LOCATION/$GCLOUD_PROJECT_ID/$DOCKER_REPO_NAME/$SERVICE_IMAGE_NAME:$TAG_NAME

gcloud_list_image(){
    gcloud container images list --repository=$GCR_LOCATION/$GCLOUD_PROJECT_ID/$DOCKER_REPO_NAME | grep $SERVICE_IMAGE_NAME
}

#? Push image to cloud run
gcloud_deploy_cloud_run(){
    gcloud run deploy $SERVICE_NAME --region asia-east1 --image $GCR_IMAGE_NAME --allow-unauthenticated --set-env-vars $ENVS --service-account $SERVICE_ACCOUNT
}

gcloud_list_image
gcloud_deploy_cloud_run