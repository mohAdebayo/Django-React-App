pipeline {
    agent any
    stages {
      node {
        def remote = [:]
        remote.name = 'gerrome@52.188.172.231'
        remote.host = '52.188.172.231'
        remote.user = 'gerrome'
        remote.password = 'Ifah6354!'
        remote.allowAnyHosts = true        
        stage('Deploy to Staging') {
            agent {
                docker {
                    image 'ubuntu:latest'
                }
            }             
            steps {
                    sshCommand remote: remote, command: "ls -lrt"
                    sshCommand remote: remote, command: "for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done"
                  }
                }
            }
        }       
  
