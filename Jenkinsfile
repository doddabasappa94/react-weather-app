pipeline {
    agent any

    stages{
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t amatbasu/weather-app:${BUILD_NUMBER} .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'DOCKERPWD')]) {
                   sh 'docker login -u amatbasu -p ${DOCKERPWD}'
                   }
                   sh 'docker push amatbasu/weather-app:${BUILD_NUMBER}'
                }
            }
        }
    }
}