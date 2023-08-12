pipeline {
    agent any

    stages{
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t amatbasu/weather-app .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'DOCKERPWD')]) {
                   sh 'docker login -u amatbasu -p ${DOCKERPWD}'
                   }
                   sh 'docker push amatbasu/weather-app'
                }
            }
        }
        stage('Deploy to K8s'){
            steps{
                script{
                    sh 'kubectl config set-context --current --namespace=${NAMESPACE}'
                    sh 'kubectl apply -f deploymentservice.yaml'
                    sh 'kubectl get all'
                }
            }
        }
        stage('git tag'){
            steps {
               script{
                withCredentials([usernamePassword(credentialsId: 'gurhubgi', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                  sh 'git tag weather-ui-${BUILD_NUMBER}'
                  sh 'git push --tags'
               } 
               }
            }
        }
    }
}