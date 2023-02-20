pipeline{
    agent any
    environment {
        PATH = "$PATH:/apache-maven-3.6/bin"
    }
    stages{
       stage('GetCode'){
           steps{
               git 'https://github.com/ranjithk9/cubegen.git'
           }  
        }
        stage('Build'){
            steps{
              sh 'mvn clean install package'
            }
        }
    }    
}        