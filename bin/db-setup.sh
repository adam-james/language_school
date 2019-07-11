#!/usr/bin/env bash

source ./bin/env.sh

if [ $1 == "teachers" ]; then
  DB_USER=$TEACHERS_DB_USER
  DB_SERVER_NAME=$TEACHERS_DB_SERVER_NAME
  DB_HOST=$TEACHERS_DB_HOST
  DB_DATABASE=$TEACHERS_DB_DATABASE
  DB_USERNAME=$TEACHERS_DB_USERNAME
  DB_PASSWORD=$TEACHERS_DB_PASSWORD
elif [ $1 == "courses" ]; then
  DB_USER=$COURSES_DB_USER
  DB_SERVER_NAME=$COURSES_DB_SERVER_NAME
  DB_HOST=$COURSES_DB_HOST
  DB_DATABASE=$COURSES_DB_DATABASE
  DB_USERNAME=$COURSES_DB_USERNAME
  DB_PASSWORD=$COURSES_DB_PASSWORD
else
  echo 'No db specified. "teachers" or "courses" required.'
  exit 1
fi

echo Creating a resource group...
az group create --name $GROUP --location $LOCATION

echo Creating postgres server...
az postgres server create --location $LOCATION --resource-group $GROUP \
  --name $DB_SERVER_NAME --admin-user $ADMINUSER --admin-password $ADMINPWORD \
  --sku-name GP_Gen5_2

echo Configuring server firewall rule...
az postgres server firewall-rule create --resource-group $GROUP \
  --server $DB_SERVER_NAME --name AllowAllIps --start-ip-address 0.0.0.0 \
  --end-ip-address 255.255.255.255

# Set pg password
export PGPASSWORD=$ADMINPWORD

psql -U $ADMINUSER@$DB_SERVER_NAME -h $DB_SERVER_NAME.postgres.database.azure.com \
  -c "CREATE DATABASE $DB_DATABASE;" postgres

psql -U $ADMINUSER@$DB_SERVER_NAME -h $DB_SERVER_NAME.postgres.database.azure.com \
  -c "CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';" postgres

psql -U $ADMINUSER@$DB_SERVER_NAME -h $DB_SERVER_NAME.postgres.database.azure.com \
  -c "GRANT ALL PRIVILEGES ON DATABASE $DB_DATABASE TO $DB_USER;" postgres
