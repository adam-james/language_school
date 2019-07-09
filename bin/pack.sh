#!/usr/bin/env bash

source ./bin/env.sh

echo Logging into registry...
az acr login --name $REGISTRY

echo Building images...
docker build -t teacher_service ./teacher_service/
docker build -t course_service ./course_service/
docker build -t course_worker ./course_service/

echo Fetching login server info...
loginServer=$(az acr list --resource-group $GROUP --query "[].{acrLoginServer:loginServer}" --output tsv)

echo Tagging images...
docker tag teacher_service $loginServer/teacher_service:latest
docker tag course_service $loginServer/course_service:latest
docker tag course_worker $loginServer/course_worker:latest

echo Pushing images...
docker push $loginServer/teacher_service:latest
docker push $loginServer/course_service:latest
docker push $loginServer/course_worker:latest
