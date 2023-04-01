#!/bin/bash

BUILD_NUMBER=$1

#? set the Secret to push to artifact registry
export MAVEN_ARTIFACT_CREDENTIALS=$MAVEN_SECRET

#? Push artifact to artifact registry
mvn -s settings.xml -X -B deploy -DskipTests -DBUILD_NUMBER=$BUILD_NUMBER -e