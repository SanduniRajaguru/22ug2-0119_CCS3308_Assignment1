#!/bin/bash
set -e
source .env

echo "Preparing app..."
docker network create $APP_NETWORK || true
docker volume create $DB_VOLUME || true
docker build -t $WEB_IMAGE ./web
echo "App prepared!"
