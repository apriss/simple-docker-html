pipeline {

  environment {
    dockerimagename = "apriss/tesnginx:v2.0"
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
               registryCredential = 'goharbor'
           }
      steps{
        script {
          docker.withRegistry( 'https://demo.goharbor.io/', registryCredential ) {
            dockerImage.push("v2.0")
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
          withKubeCredentials(kubectlCredentials: [[credentialsId: 'kubetoday', serverUrl: 'https://10.1.1.30:6443']]) {
             sh 'kubectl apply -f application.yml'
           }
          }
        }
      }
   }
}

