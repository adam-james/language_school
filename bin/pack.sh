#!/usr/bin/env bash

source ./bin/env.sh

echo Logging into registry...
az acr login --name $REGISTRY

echo Building images...
echo WARNING: Using development builds.
# TODO use production builds
docker build -t teacher_service --target web_prod ./teacher_service/
docker build -t course_service --target web_prod ./course_service/
docker build -t course_worker --target worker_prod ./course_service/

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
