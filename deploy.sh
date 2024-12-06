#!/bin/bash

# Exit on any error
set -e

EC2_USER="ec2-user"
EC2_HOST=""
DOCKER_USERNAME="aravindmathes"
REMOTE_DIR="/home/$EC2_USER/deployment"

#login to EC2 Instance to stop running container and do clean up of old deployment files
ssh -i "$PEM_FILE" "$EC2_USER@$EC2_HOST" << EOF
  echo "Login to Docker Hub"
  echo "$DOCKERHUB_TOKEN" | docker login -username "$DOCKER_USERNAME" --password-stdin
  echo "Stopping and Deleting all the running Docker containers."
  sudo docker ps -q | xargs -r docker stop
  sudo docker ps -aq | xargs -r docker rm
  echo "Deleting all Docker Images."
  sudo docker images -q | xargs -r docker rmi
  echo "Logout of Docker Hub"
EOF

#copying the docker-compose and its dependent files to EC2 Instance
echo "Copying Docker-compose and its dependencies to EC2 deployment directory."
scp -i "$PEM_FILE" textfile.txt "$EC2_USER@$EC2_HOST:$REMOTE_DIR"
