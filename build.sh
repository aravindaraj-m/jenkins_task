#!/bin/bash

# Exit on any error
set -e

DOCKER_USERNAME="aravindmathes"

#login into docker hub with docker credentials
echo "logining into docker hub..."
echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "List of docker images created"
sudo docker images

echo "List of docker containers"
sudo docker ps -a

echo "Logout of Docker Hub"
suco docker logout