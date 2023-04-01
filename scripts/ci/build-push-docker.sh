#!/bin/bash

GCLOUD_SERVICE_IMAGE_NAME=$1
GCLOUD_TMP_JSON_PATH="/tmp/gcloud-api-key.json"

#? Decode the service account JSON from github secrets
gcloud_decode_service_account (){
    echo ${{ secrets.GCLOUD_ENCODED_API_KEY_LIMEBREW }} | base64 -d > $GCLOUD_TMP_JSON_PATH
}

#? Login to Docker using the service account
gcloud_docker_login(){
    cat $GCLOUD_TMP_JSON_PATH | docker login -u _json_key --password-stdin https://${{ secrets.GCLOUD_DOCKER_REGISTRY_HOSTNAME }}
}

#? Set the image name and tag
gcloud_set_image_tag() {
    export SERVICE_IMAGE_NAME=$GCLOUD_SERVICE_IMAGE_NAME
    export TAG_NAME=1.0.${{ github.run_number }}
    export GCR_IMAGE_NAME=${{ secrets.GCLOUD_DOCKER_REGISTRY_HOSTNAME }}/${{ secrets.GCLOUD_PROJECT_ID_LIMEBREW }}/${{ secrets.GCLOUD_DOCKER_REPO_NAME }}/$SERVICE_IMAGE_NAME
}

#? Build the docker image and set tag
gcloud_docker_build(){
    docker build --no-cache -t $SERVICE_IMAGE_NAME .
    docker tag $SERVICE_IMAGE_NAME $GCR_IMAGE_NAME:$TAG_NAME
}

#? Push to Docker Artifact Registry
gcloud_push_docker_artifact(){
    docker push $GCR_IMAGE_NAME:$TAG_NAME
}



gcloud_decode_service_account
gcloud_docker_login
gcloud_set_image_tag
gcloud_docker_build
gcloud_push_docker_artifact