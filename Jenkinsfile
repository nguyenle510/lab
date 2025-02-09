pipeline{
    agent{
        label "jenkins-agent"
    }
    tools{
        jdk 'Java17'
        maven 'Maven3'
    }

    environment {
        APP_NAME = "lab"
        RELEASE = "1.0.0"
        DOCKER_USER = "nguyenle510"
        DOCKER_PASS = 'dockerhub'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
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
                script {
                    withSonarQubeEnv(credentialsId: 'sonarqube') {
                    sh "mvn sonar:sonar"
                    }
                }
            }
        }

        stage("Quality Gate"){
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube'
                }
            }
        }

/*        stage("Build Docker Image"){
            agent{
                label "docker-agent"
            }
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }
                }
            }
        }

        stage("Push Docker Image"){
            agent{
                label "docker-agent"
            }
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
        }
*/
        stage("Deploy to Server"){
            steps {
                sshagent(['ssh-remote']) {
                    sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 18.139.208.206 docker run -d --name lab-deploy -p 8080:8080 nguyenle510/lab:latest'
                }
            }
        }

    }

}
