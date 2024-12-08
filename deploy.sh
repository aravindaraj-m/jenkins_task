#!/bin/bash

# Exit on any error
set -e

echo "CONFIGURATION FILE"
DEPLOY_CONFIG_FILE="./config.ini"

echo "Loading configuration from $DEPLOY_CONFIG_FILE..."
source "$DEPLOY_CONFIG_FILE"

echo "CREATE A TEMP FILE TO WRITE PRIVATE KEY
echo "$PEM_FILE" | tr -d '\r' > /tmp/key.pem
chmod 600 /tmp/key.pem

echo "Key location"
pwd /tmp/key.pem

echo "private file created"
cat /tmp/key.pem

echo "content verification"
echo "$PEM_FILE" | awk '{print NR ":" $0}'

# echo "LOGIN TO EC2 INSTANCE"
# ssh -t -i /tmp/key.pem "$EC2_USER@$EC2_HOST" << EOF
  
#   echo "Docker Images"
#   sudo docker images
#   echo "Login to Docker Hub"
#   echo "$DOCKERHUB_TOKEN" | docker login -username "$DOCKER_USERNAME" --password-stdin
#   echo "Logout of Docker Hub"
#   sudo docker logout
# EOF

# echo "COPY FILES TO EC2 INSTANCE DIRECTORY."
# scp -i /tmp/key.pem textfile.txt "$EC2_USER@$EC2_HOST:$REMOTE_DIR"

# echo "CLEAN UP OF TEMP PRIVATE KEY FILE
# rm /tmp/key.pem