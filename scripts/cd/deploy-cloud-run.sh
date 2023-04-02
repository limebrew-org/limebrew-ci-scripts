#!/bin/bash

SERVICE_IMAGE_NAME=$1
TAG_NAME=$2
ENVS=$3
SERVICE_ACCOUNT=$4


#? Set the image
GCR_IMAGE_NAME=$GCLOUD_LOCATION-docker.pkg.dev/$GCLOUD_PROJECT_ID/$GCLOUD_DOCKER_REPO_NAME/$SERVICE_IMAGE_NAME:$TAG_NAME
GCR_IMAGE_NAME_WITH_TAG=$GCR_IMAGE_NAME:$TAG_NAME

gcloud_list_image(){
    gcloud artifacts docker images list $GCR_IMAGE_NAME --include-tags
}

#? Push image to cloud run
gcloud_deploy_cloud_run(){
    gcloud run deploy $SERVICE_NAME --region $GCLOUD_LOCATION --image $GCR_IMAGE_NAME_WITH_TAG --allow-unauthenticated --set-env-vars $ENVS --service-account $SERVICE_ACCOUNT
}

gcloud_list_image
gcloud_deploy_cloud_run