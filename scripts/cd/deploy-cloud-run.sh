#!/bin/bash

#? Set the image
GCR_IMAGE_NAME=$GCLOUD_DOCKER_REPO_HOST_NAME/$GCLOUD_INFRA_CICD_PROJECT_ID/$GCLOUD_DOCKER_REPO_NAME/$SERVICE_IMAGE_NAME
GCR_IMAGE_NAME_WITH_TAG=$GCR_IMAGE_NAME:$TAG_NAME

gcloud_list_image(){
    gcloud artifacts docker images list $GCR_IMAGE_NAME --include-tags
}

#? Push image to cloud run
gcloud_deploy_cloud_run(){
    gcloud run deploy $SERVICE_NAME --region $GCLOUD_LOCATION --image $GCR_IMAGE_NAME_WITH_TAG --allow-unauthenticated --set-env-vars $ENVS --service-account $GCLOUD_APPLICATION_SERVICE_ACCOUNT_ID
}

gcloud_list_image
gcloud_deploy_cloud_run