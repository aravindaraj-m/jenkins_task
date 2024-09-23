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
            mail bcc: '', body: 'Build completed successfully', cc: '', from: '', replyTo: '', subject: 'Jenkins Build Completed', to: 'aravinddevopslearning@gmail.com'
        }
    }
}
