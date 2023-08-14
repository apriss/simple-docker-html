pipeline {

  environment {
    dockerimagename = "demo/tesnginx:v2.1"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/apriss/simple-docker-html.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'harbor'
           }
      steps{
        script {
          docker.withRegistry( 'https://harbor.sentuy.lan', registryCredential ) {
            dockerImage.push("v2.1")
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
          withKubeCredentials(kubectlCredentials: [[credentialsId: 'kubeku', serverUrl: 'https://10.1.1.120:6443']]) {
             sh 'kubectl apply -f application.yml'
           }
          }
        }
      }
   }
}

