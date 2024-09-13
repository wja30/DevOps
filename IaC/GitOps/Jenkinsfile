pipeline {
  agent any
  stages {
    stage('Deploy start') {
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
    stage('send diff') {
      steps {
        script {
          def publisher = LastChanges.getLastChangesPublisher "PREVIOUS_REVISION", "SIDE", "LINE", true, true, "", "", "", "", ""
          publisher.publishLastChanges()
          def htmlDiff = publisher.getHtmlDiff()
          writeFile file: "deploy-diff-${env.BUILD_NUMBER}.html", text: htmlDiff
        }
        slackSend(message: """${env.JOB_NAME} #${env.BUILD_NUMBER} End
        (<${env.BUILD_URL}/last-changes|Check Last changed>)"""
        , color: 'good', tokenCredentialId: 'slack-key')             
      }
    }
  }
}
