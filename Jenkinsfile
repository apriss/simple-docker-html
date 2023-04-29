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
               registryCredential = 'dockerhubku'
           }
      steps{
        script {
          docker.withRegistry( 'https://hub.docker.com', registryCredential ) {
            dockerImage.push("v2.0")
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
          withKubeCredentials(kubectlCredentials: [[credentialsId: 'kube-rook', serverUrl: 'https://10.1.1.41:6443']]) {
             sh 'kubectl apply -f application.yml'
           }
          }
        }
      }
   }
}

