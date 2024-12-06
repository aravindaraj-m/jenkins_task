pipeline {
    agent any

    environment {
        EC2_USER = "ec2-user"
        EC2_HOST = "54.91.155.225"
        DOCKER_USERNAME = "aravindmathes"
        REMOTE_DIR="/home/$EC2_USER/deployment"
    }

    stages {
        stage('Build a Docker Image and Push the image to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'DOCKERHUB_TOKEN')]) {
                    sh """
                    chmod +x build.sh
                    ./build.sh
                    """
                    }
                }
            }
        stage('Deploy the file in server') {
            steps {
                script {
                    withCredentials([
                        string(credentialsId: 'dockerhub-token', variable: 'DOCKERHUB_TOKEN')
                    ]) {
                        sshagent(['devops-project-key']) {
                            sh """
                                ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} << EOF
                                    echo "Docker Images"
                                    sudo docker images
                                EOF

                                chmod +x deploy.sh
                                ./deploy.sh

                                echo "Copying Docker-compose and its dependencies to EC2 deployment directory."
                                scp -o StrictHostKeyChecking=no textfile.txt ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}
                            """
                        }
                    }
                }
            }
        }
    }
}