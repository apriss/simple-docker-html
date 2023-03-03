pipeline {

  environment {
    dockerimagename = "apriss/tesnginx:v1.0"
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
               registryCredential = 'dockerku'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("v1.0")
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
          withKubeCredentials(kubectlCredentials: [[credentialsId: 'rke2ku', serverUrl: 'https://10.1.1.30:6443']]) {
             sh 'kubectl delete deployment --force tesnginx'
             sh 'kubectl delete svc --force tesnginx'
             sh 'kubectl apply -f application.yml'
           }
          }
        }
      }
   }
}

