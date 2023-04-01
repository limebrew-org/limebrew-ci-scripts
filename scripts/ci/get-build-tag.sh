#!/bin/bash

PROJECT_VERSION=$(mvn -q \
                  -Dexec.executable="echo" \
                  -DBUILD_NUMBER=${{ github.run_number }} \
                  -Dexec.args='${project.version}' \
                  --non-recursive \
                  org.codehaus.mojo:exec-maven-plugin:1.6.0:exec)
export PROJECT_VERSION

create_tag_name()
{
  DEPLOY_TAG_NAME="limebrew-$PROJECT_VERSION"; export DEPLOY_TAG_NAME
  echo "$DEPLOY_TAG_NAME"
}

######
#
#######
create_tag_name