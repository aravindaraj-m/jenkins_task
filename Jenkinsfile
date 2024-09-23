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
		def buildStatus = currentBuild.currentResult
                mail (
    		    bcc: '',
    		    body: """\
        		Build Name: ${JOB_NAME}
        		Build Number: ${BUILD_NUMBER}
        		Build Status: ${buildStatus}
        		Build URL: ${BUILD_URL}
        		""",
    		    cc: '',
    		    from: '',
    		    replyTo: '',
    		    subject: "Jenkins Build #${BUILD_NUMBER} - ${buildStatus}",
    		    to: 'aravinddevopslearning@gmail.com'
		)
	    }
        }
    }
}
