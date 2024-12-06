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
                withCredentials([
                    string(credentialsId: 'dockerhub-token', variable: 'DOCKERHUB_TOKEN'),
                    sshUserPrivateKey(credentialsId: 'devops-project-key', keyFileVariable: 'PEM_FILE')]) 
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