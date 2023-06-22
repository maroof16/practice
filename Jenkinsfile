pipeline {
    agent any

    stages {
        stage('pulling code') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/maroof16/practice.git'
            }
        }

        stage('build docker file and tag') {
            steps {
                sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                sh 'docker image tag $JOB_NAME:v1.$BUILD_ID maroofshaikh09/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker image tag $JOB_NAME:v1.$BUILD_ID maroofshaikh09/$JOB_NAME:latest'
            }
        }
        
        stage('docker login and push') {
            steps {
                withCredentials([string(credentialsId: 'DOCKERHUBPASSWORD', variable: 'DOCKERHUB_PASSWORD')]) {
                    sh 'docker login -u maroofshaikh09 -p ${DOCKERHUB_PASSWORD}'
                    sh 'docker image push maroofshaikh09/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker image push maroofshaikh09/$JOB_NAME:latest'
                    sh 'docker image rmi maroofshaikh09/$JOB_NAME:latest'
                    sh 'docker image rmi maroofshaikh09/$JOB_NAME:v1.$BUILD_ID'
                }
            }
        }

        stage('deploying docker container') {
            steps {
                script {
                    def dockerrun = 'docker run -p 8000:80 -d --name practice maroofshaikh09/groovy:latest'
                    def dockerrm = 'docker rm practice '
                    def dockerstop = 'docker stop practice'
                    def dockerimagerm = 'docker rmi maroofshaikh09/groovy:latest'
                    sshagent(['docker-host-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.15.24 ${dockerstop}"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.15.24 ${dockerrm}"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.15.24 ${dockerimagerm}"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.15.24 ${dockerrun}"
                        
                    }
                }
            }
        }
    }
}

