#!/bin/bash
set -e
source .env

echo "Stopping containers..."
docker stop $WEB_CONTAINER $DB_CONTAINER || true
