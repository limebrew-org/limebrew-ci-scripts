#!/bin/bash

#? Build artifacts
mvn -B package -DskipTests -DBUILD_NUMBER=${{ github.run_number }}