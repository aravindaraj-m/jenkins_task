#!/bin/bash

# Exit on any error
set -e

echo "CONFIGURATION FILE"
DEPLOY_CONFIG_FILE="config.ini"

echo "Loading configuration from $DEPLOY_CONFIG_FILE..."
source "$DEPLOY_CONFIG_FILE"

echo "CREATE A TEMP FILE TO WRITE PRIVATE KEY"
echo "$PEM_KEY" | tr -d '\r' > /tmp/key.pem
chmod 600 /tmp/key.pem

echo "private file created"
cat /tmp/key.pem

echo "Key location"
pwd /tmp/key.pem

# Check required variables
REQUIRED_VARS=("EC2_USER" "EC2_HOST" "IMAGE_TAG" "DOCKER_USERNAME" "REMOTE_DIR")
for var in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!var}" ]; then
    echo "Error: Required variable $var is not set in $DEPLOY_CONFIG_FILE!"
    exit 1
  else
    echo "$var = ${!var}"
  fi
done

# echo "PEM Key File permission"
# chmod 600 $PEM_KEY

echo "LOGIN TO EC2 INSTANCE"
ssh -i /tmp/key.pem "$EC2_USER@$EC2_HOST" << EOF
  echo "Login to Docker Hub"
  echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin
  docker pull nginx
  echo "Docker Images"
  docker images
  sleep 2
  docker images -q | xargs -r docker rmi -f
  #docker images -q | tee >(xargs -r echo) | xargs -r docker rmi -f
  sleep 2
  docker images
  sleep 2
  echo "Logout of Docker Hub"
  docker logout
EOF

echo "Deleting Private Key file"
#rm /tmp/key.pem

# echo "COPY FILES TO EC2 INSTANCE DIRECTORY."
# scp -i /tmp/key.pem textfile.txt "$EC2_USER@$EC2_HOST:$REMOTE_DIR"

# echo "CLEAN UP OF TEMP PRIVATE KEY FILE
