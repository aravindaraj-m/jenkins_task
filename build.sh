#!/bin/bash

# Exit on any error
set -e

# Check if image tag is provided
if [ -z "$1" ]; then
  echo "Error: Image tag argument is missing."
  exit 1
fi

IMAGE_TAG=$1
# Configuration file
CONFIG_FILE="config.ini"

# Create or update the config.ini file
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Configurations file $CONFIG_FILE not found!"
  exit 1
fi

# Add or update the image tag
if grep -q "IMAGE_TAG" "$CONFIG_FILE"; then
  sed -i "s/^IMAGE_TAG=.*/IMAGE_TAG=$IMAGE_TAG/" "$CONFIG_FILE"
else
  echo "IMAGE_TAG=$IMAGE_TAG" >> "$CONFIG_FILE"
fi

echo "Updated $CONFIG_FILE with IMAGE_TAG=$IMAGE_TAG"

# Load variables from the config file
echo "Loading configuration from $DEPLOY_CONFIG_FILE..."
source "$CONFIG_FILE"

# Check required variables
REQUIRED_VARS=("EC2_USER" "EC2_HOST" "IMAGE_TAG" "DOCKER_USERNAME" "REMOTE_DIR" "PEM_KEY)
for var in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!var}" ]; then
    echo "Error: Required variable $var is not set in $DEPLOY_CONFIG_FILE!"
    exit 1
  else
    echo "$var = ${!var}"
  fi
done

#login into docker hub with docker credentials
echo "logining into docker hub..."
echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "List of docker images created"
docker images

echo "List of docker containers"
docker ps -a

echo "Logout of Docker Hub"
docker logout