#!/bin/bash

# Exit on any error
set -e

# EC2_USER="ec2-user"
# EC2_HOST="54.91.155.225"
# DOCKER_USERNAME="aravindmathes"
# REMOTE_DIR="/home/$EC2_USER/deployment"

# #Temp file for private key
# echo "$PEM_FILE" | tr -d '\r' > /tmp/devops_project_key.pem
# chmod 600 /tmp/devops_project_key.pem

# echo "private file created"

# cat -e /tmp/devops_project_key.pem

# echo "content verification"
# echo "$PEM_FILE" | awk '{print NR ":" $0}'

# #login to EC2 Instance to stop running container and do clean up of old deployment files
# ssh -t -i /tmp/devops_project_key.pem "$EC2_USER@$EC2_HOST" << EOF
#   echo "Login to Docker Hub"
#   echo "$DOCKERHUB_TOKEN" | docker login -username "$DOCKER_USERNAME" --password-stdin
#   echo "Stopping and Deleting all the running Docker containers."
#   sudo docker ps -q | xargs -r docker stop
#   sudo docker ps -aq | xargs -r docker rm
#   echo "Deleting all Docker Images."
#   sudo docker images -q | xargs -r docker rmi
#   echo "Docker Images"
#   sudo docker images
#   echo "Logout of Docker Hub"
# EOF

# #copying the docker-compose and its dependent files to EC2 Instance
# echo "Copying Docker-compose and its dependencies to EC2 deployment directory."
# scp -i /tmp/devops_project_key.pem textfile.txt "$EC2_USER@$EC2_HOST:$REMOTE_DIR"

# #Clean up temp private key file
# rm /tmp/devops_project_key.pem

echo "$DOCKERHUB_TOKEN" | docker login -username "$DOCKER_USERNAME" --password-stdin
echo "Stopping and Deleting all the running Docker containers."
docker ps -q | xargs -r docker stop
docker ps -aq | xargs -r docker rm
echo "Deleting all Docker Images."
docker images -q | xargs -r docker rmi
echo "Cleaning up old files in $REMOTE_DIR."
sudo rm -rf $REMOTE_DIR
echo "Recreating the directory $REMOTE_DIR."
mkdir -p $REMOTE_DIR
chmod 755 $REMOTE_DIR