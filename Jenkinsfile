pipeline {
    agent any
    stages {
        stage('Build Images') {
            agent {
                docker {
                    image 'docker:20.10.23-dind'
                }
            }               
            steps {
                sh 'docker version'
                sh 'cd backend && docker build -t django-react-app_backend:1 .'
                sh 'cd frontend && docker build -t django-react-app_client:1 .'
                withCredentials([
                    usernamePassword(credentials: 'dockerhub', usernameVariable: USER, passwordVariable: PWD)
                ])
                sh "docker login -u ${USER} -p ${PWD} && docker push django-react-app_backend:1" 
                sh "docker login -u ${USER} -p ${PWD} && docker push django-react-app_client:1"                    }                
                       
        }          
        stage('Deploy to Staging') {
            steps{
            sshagent(credentials:['server_ssh_key']){
               sh 'ssh  -o StrictHostKeyChecking=no  gerrome@52.188.172.231 uptime "cd Django-React-App && docker-compose up -d"'
                  }
            }
        }   
}
}
