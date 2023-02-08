pipeline {
    agent any
    stages {        
        stage('Deploy to Staging') {
            steps{
                sshagent(credentials:['server_ssh_key']){
                   sh 'ssh  -o StrictHostKeyChecking=no  gerrome@52.188.172.231 uptime "cd Django-React-App && docker-compose up -d"'
                }   }
        }
    }
}
