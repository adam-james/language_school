#!/usr/bin/env bash

source ./bin/env.sh

echo Creating group...
az group create --name $GROUP --location $LOCATION

echo Creating Azure container registry...
az acr create --resource-group $GROUP --location $LOCATION --name $REGISTRY --sku Basic
