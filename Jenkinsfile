pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    disableConcurrentBuilds()
  }
  agent any
  environment {
    IMAGE      = "dpkg-debian"
    TEMP_IMAGE = "${IMAGE}_${BUILD_NUMBER}"
    TAG        = "9"
    TAG2       = "stretch"
  }
  stages {
    stage('Prepare') {
      steps {
        sh 'docker pull debian:9'
      }
    }
    stage('Build') {
      steps {
        ansiColor('xterm') {
          sh 'docker build --no-cache --squash --compress -t ${TEMP_IMAGE} .'
        }
      }
    }
    stage('Publish') {
      steps {
        ansiColor('xterm') {
          // Dockerhub
          sh 'docker tag ${TEMP_IMAGE} docker.io/jc21/${IMAGE}:${TAG}'
          sh 'docker tag ${TEMP_IMAGE} docker.io/jc21/${IMAGE}:${TAG2}'
          withCredentials([usernamePassword(credentialsId: 'jc21-dockerhub', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
            sh "docker login -u '${duser}' -p '${dpass}'"
            sh 'docker push docker.io/jc21/${IMAGE}:${TAG}'
            sh 'docker push docker.io/jc21/${IMAGE}:${TAG2}'

            sh 'docker rmi docker.io/jc21/${IMAGE}:${TAG}'
            sh 'docker rmi docker.io/jc21/${IMAGE}:${TAG2}'
          }
        }
      }
    }
  }
  post {
    success {
      build job: 'Docker/docker-dpkg-debian9/golang', wait: false
      build job: 'Docker/docker-dpkg-debian9/rust', wait: false
      juxtapose event: 'success'
      sh 'figlet "SUCCESS"'
    }
    failure {
      juxtapose event: 'failure'
      sh 'figlet "FAILURE"'
    }
    always {
      sh 'docker rmi  ${TEMP_IMAGE}'
    }
  }
}

