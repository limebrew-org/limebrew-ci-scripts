#!/bin/bash

BUILD_NUMBER=$1

#? Push artifact to artifact registry
mvn -s settings.xml -X -B deploy -DskipTests -DBUILD_NUMBER=$BUILD_NUMBER -e