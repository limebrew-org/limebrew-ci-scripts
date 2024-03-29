#!/bin/bash

export GCLOUD_TMP_JSON_PATH="/tmp/gcloud-api-key.json"

#? Decode the service account JSON from github secrets
gcloud_decode_service_account (){
    echo $GCLOUD_ENCODED_SERVICE_ACCOUNT_JSON | base64 -d > $GCLOUD_TMP_JSON_PATH
}

#? Login to Docker using the service account
gcloud_docker_login(){
    cat $GCLOUD_TMP_JSON_PATH | sudo docker login -u _json_key --password-stdin https://$GCLOUD_DOCKER_REPO_HOST_NAME
}

#? Set the image name and tag
gcloud_set_image_tag() {
    export GCR_IMAGE_NAME=$GCLOUD_DOCKER_REPO_HOST_NAME/$GCLOUD_PROJECT_ID/$GCLOUD_DOCKER_REPO_NAME/$SERVICE_IMAGE_NAME
}

#? Build the docker image and set tag
gcloud_docker_build(){
    echo "GCR_IMAGE_NAME=$GCR_IMAGE_NAME"
    sudo docker build --no-cache -t $SERVICE_IMAGE_NAME .
    sudo docker tag $SERVICE_IMAGE_NAME $GCR_IMAGE_NAME:$TAG_NAME
}

#? Push to Docker Artifact Registry
gcloud_push_docker_artifact(){
    sudo docker push $GCR_IMAGE_NAME:$TAG_NAME
}



gcloud_decode_service_account
gcloud_docker_login
gcloud_set_image_tag
gcloud_docker_build
gcloud_push_docker_artifact