#!/bin/bash
set -e
source .env

echo "Starting DB..."
docker run -d \
  --name $DB_CONTAINER \
  --network $APP_NETWORK \
  -e POSTGRES_DB=$POSTGRES_DB \
  -e POSTGRES_USER=$POSTGRES_USER \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -v $DB_VOLUME:/var/lib/postgresql/data \
  --restart unless-stopped \
  postgres:16

echo "Waiting for DB..."
until docker exec $DB_CONTAINER pg_isready -U $POSTGRES_USER > /dev/null 2>&1; do
  sleep 2
done

echo "Starting Web App..."
docker run -d \
  --name $WEB_CONTAINER \
  --network $APP_NETWORK \
  -p $WEB_PORT:5000 \
  -e DATABASE_URL=postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$DB_CONTAINER:5432/$POSTGRES_DB \
  --restart unless-stopped \
  $WEB_IMAGE

echo "App running at http://localhost:$WEB_PORT"
