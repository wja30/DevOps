pipeline {
  agent any
  stages {
    stage('deploy start') {
      steps {
        slackSend(message: "Deploy ${env.BUILD_NUMBER} Started"
        , color: 'good', tokenCredentialId: 'slack-key')
      }
    }  
    stage('git pull') {
      steps {
        // https://github.com/wja30/GitOps.git will replace by sed command before RUN
        git url: 'https://github.com/wja30/GitOps.git', branch: 'master'
      }
    }
    stage('Apply Kubernetes files') {
	steps{
    		withKubeConfig([credentialsId: 'kubeconfig']) {
      		sh 'kubectl apply -f deployment.yaml'
    		}
	}
  }
    stage('deploy end') {
      steps {
        slackSend(message: """${env.JOB_NAME} #${env.BUILD_NUMBER} End
        """, color: 'good', tokenCredentialId: 'slack-key')
      }
    }
  }
}
