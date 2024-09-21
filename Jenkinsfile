pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Running script for Building...'
            }
        }
        stage('update') {
            steps {
                echo 'updating the this part...'
            }
        }
    }
    
    post {
        always {
            emailext(
                subject: "Auto Trigger Jenkins Build",
                body: "Auto Trigger Jenkins Build has completed sucessfully",
                to: "aravinddevopslearning@gmail.com"
            )
        }
    }
}
