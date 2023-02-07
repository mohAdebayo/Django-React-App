pipeline {
    agent any
    stages {
        stage('Test-Frontend') {
            agent {
                docker {
                   image 'node:13.12.0-alpine'
                 }
            }            
            steps {
                sh 'cd frontend'
                sh 'npm install'            
            }
        }
        stage('Test-Backend') {
            agent {
                docker {
                    image 'python:3.12.0a4-slim-buster'
                }
            }             
            steps {
                sh 'cd backend/accounts'
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
                sh 'cd backend && docker build -t gerrome/django-react-app_backend:1 .'
                sh 'cd frontend && docker build -t gerrome/django-react-app_client:1 .'
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
  
