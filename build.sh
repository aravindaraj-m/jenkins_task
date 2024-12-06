#!/bin/bash

# Exit on any error
set -e

#login into docker hub with docker credentials
echo "logining into docker hub..."
echo "$DOCKERHUB_TOKEN" | docker login -u aravindmathes --password-stdin

echo "List of docker images created"
docker images

echo "List of docker containers"
docker ps -a

echo "Logout of Docker Hub"
docker logout