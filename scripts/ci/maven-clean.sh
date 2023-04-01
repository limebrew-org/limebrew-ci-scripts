#!/bin/bash

#? Clean the target/ directory 
mvn -B clean -DskipTests -DBUILD_NUMBER=${{ github.run_number }}