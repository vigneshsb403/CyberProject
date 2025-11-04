#!/bin/bash

# Script to fix Docker Compose ContainerConfig error
# Run this on your Ubuntu server: ubuntu@ip-172-31-8-207

echo "Stopping and removing containers..."
docker-compose down --remove-orphans

echo "Removing web container if it exists..."
docker rm -f cyberproject_web_1 2>/dev/null || true

echo "Removing web image if it exists..."
docker rmi cyberproject_web 2>/dev/null || true

echo "Cleaning up dangling images..."
docker image prune -f

echo "Rebuilding and starting services..."
docker-compose up --build -d

echo "Done! Check logs with: docker-compose logs -f"

