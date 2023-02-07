pipeline {
    agent {
        docker {
           image 'node:13.12.0-alpine'
           label 'node-template' 
       }
     }  
    stages {
        stage('Test-Frontend') {
            agent {
                docker {
                   image 'node:13.12.0-alpine'
                   label 'node-template'                 }
            }            
            steps {
                sh 'cd frontend-folder'
                sh 'npm install'
                sh 'npm test'              
            }
        }
        stage('Test-Backend') {
            agent {
                docker {
                    image 'python:3.12.0a4-slim-buster'
                }
            }             
            steps {
                sh 'cd backend-folder'
                sh 'python test.py'           
            }
        }        
        stage('Build Images') {
            agent {
                docker {
                    image 'docker:20.10.16'
                }
            }               
            steps {
                sh 'cd backend-folder && docker build -t backend-image:tag .'
                sh 'cd frontend-folder && docker build -t frontend-image:tag .'
                withCredentials([
                    usernamePassword(credentials: 'dockerhub', usernameVariable: USER, passwordVariable: PWD)
                ])
                sh "docker login -u ${USER} -p ${PWD} && docker push backend-image:tag" 
                sh "docker login -u ${USER} -p ${PWD} && docker push frontend-image:tag"                    }                
                       
        }  

        stage('Deploy to Staging') {
            agent {
                docker {
                    image 'ubuntu:latest'
                }
            }             
            steps {
                withCredentials([file(credentialsId: 'server_ssh_key', fileVariable: 'KEYFILE')]) {
                    sshagent(credentials: ['server_ssh_key']) {
                        sh 'ssh -i ${KEYFILE} -o StrictHostKeyChecking=no user@remote_server "cd project_directory && docker-compose up -d"'
                    }
                }
            }
        }
        stage('Deploy to Production') {
            agent {
                docker {
                    image 'ubuntu:latest'
                }
            }           
            steps {
                withCredentials([file(credentialsId: 'server_ssh_key', fileVariable: 'KEYFILE')]) {
                    sshagent(credentials: ['server_ssh_key']) {
                        sh 'ssh -i ${KEYFILE} -o StrictHostKeyChecking=no user@remote_server "cd project_directory && docker-compose up -d"'
                    }
                }
            }
        }        
    }
}
  
