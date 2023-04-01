#!/bin/bash

#? set the Secret to push to artifact registry
export MAVEN_ARTIFACT_CREDENTIALS=${{ secrets.MAVEN_ARTIFACT_CREDENTIALS }}

#? Push artifact to artifact registry
mvn -s settings.xml -X -B deploy -DskipTests -DBUILD_NUMBER=${{ github.run_number }} -e