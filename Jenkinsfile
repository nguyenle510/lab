pipeline{
    agent{
        label "jenkins-agent"
    }
    tools{
        jdk 'Java17'
        maven 'Maven3'
    }
    stages{
        stage("Cleanup Workspace"){
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM"){
            steps {
                git branch: 'main' , credentialsId: 'github', url: 'https://github.com/nguyenle510/lab'
            }
        }

        stage("Build App"){
            steps {
                sh "mvn clean package"
            }
        }

        stage("Test App"){
            steps {
                sh "mvn test"
            }
        }

        stage("Sonar Analysis"){
            steps {
                withSonarQubeEnv(credentialsId: 'sonarqube') {
                sh "mvn sonar:sonar"
                }
            }
        }
    }

}
