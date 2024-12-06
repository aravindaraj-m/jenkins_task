pipeline {
    agent any

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
                        string(credentialsId: 'dockerhub-token', variable: 'DOCKERHUB_TOKEN'),
                        sshagent(credentials: ['devops-project-key']) ])
                        {
                            sh """
                            chmod +x deploy.sh
                            ./deploy.sh
                            """
                        }
                }
            }
        }
    }
}