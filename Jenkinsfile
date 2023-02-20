pipeline{
    agent any
    environment {
        PATH = "$PATH:/apache-maven-3.6/bin"
    }
    tools {
        maven 'Maven 3.6.0'
        jdk 'jdk8'
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