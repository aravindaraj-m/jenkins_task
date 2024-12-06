pipeline {
    agent any

    stages {
        stage('Build a Docker Image and Push the image to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'DOCKERHUB_TOKEN')]) {
                    sh './build.sh'
                    }
                }
            }
        stage('Deploy the file in server') {
            steps {
                withCredentials([
                    string(credentialsId: 'dockerhub-token', variable: 'DOCKERHUB_TOKEN'),
                    sshUserPrivateKey(credentialsId: 'devops-project-key', keyFileVariable: 'PEM_FILE')]) 
                    {
                        sh './deploy.sh'
                    }
                }
            }
        }
}