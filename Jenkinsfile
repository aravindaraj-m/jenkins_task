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
	   script{
		def buildStatus = currentBuild.result
                mail subject: "Jenkins Build ${JOB_NAME} #${BUILD_NUMBER}: ${BUILD_STATUS}",
                body: """
                <p>Build Name: ${JOB_NAME}</p>
                <p>Build Number: ${BUILD_NUMBER}</p>
                <p>Build Status: ${BUILD_STATUS}</p>
                <p>Build URL: <a href="${BUILD_URL}">${BUILD_URL}</a></p>
                """,
                to: 'aravinddevopslearning@gmail.com'
        }
    }
}
