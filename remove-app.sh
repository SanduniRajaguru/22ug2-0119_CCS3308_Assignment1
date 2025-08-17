#!/bin/bash
set -e
source .env

echo "Removing app..."
docker rm -f $WEB_CONTAINER $DB_CONTAINER || true
docker rmi $WEB_IMAGE || true
docker network rm $APP_NETWORK || true
docker volume rm $DB_VOLUME || true
echo "Removed all resources."
