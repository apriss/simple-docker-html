pipeline {

  environment {
    dockerimagename = "ekawafs/nginxweb:v3.0"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/ekazfarm/simple-docker-html.git'
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
               registryCredential = 'dockerhublogin'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("v3.0")
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
          withKubeCredentials(kubectlCredentials: [[credentialsId: 'kubernetesku', serverUrl: 'https://10.10.10.10:6443']]) {
             sh 'kubectl apply -f deploymentservice.yml'
           }
          }
        }
      }
   }
}

