pipeline {
    agent any
    stages {        
        stage('Deploy to Staging') {
            agent {
                docker {
                    image 'ubuntu:latest'
                }
            }             
            steps {
                    publishOverSSH(
                        target: '52.188.172.231',
                        username: 'gerrome',
                        credentialsId: 'server_ssh_key',
                        sourceFiles: 'Django-React-App',
                        execCommand: 'docker-compose up -d'
                )
                }
            }
        }       
    }
  
