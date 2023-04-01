#!/bin/bash

BUILD_NUMBER=$1

#? Build artifacts
mvn -B package -DskipTests -DBUILD_NUMBER=$BUILD_NUMBER