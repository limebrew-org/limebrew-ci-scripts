#!/bin/bash

BUILD_NUMBER=$1

#? Clean the target/ directory 
mvn -B clean -DskipTests -DBUILD_NUMBER=$BUILD_NUMBER