pipeline {
    agent any

    environment {
        rname = "back"
        rurl = "mghirbirahma"
        imagename = "back"
        dockerhubCredentials = "dockerhub"  // Replace with your Docker Hub credentials ID
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Use an official Maven image for building the Spring Boot application
                    def builderImage = 'maven:3.8.4-openjdk-17-slim'
                    def imageName = "${rurl}/${imagename}:latest"

                    // Build the Spring Boot application and create a thin JAR file
                    sh 'mvn clean package -DskipTests'

                    // Use a smaller base image for the runtime
                    sh 'docker build -t ${imageName} .'

                    // Use Docker Hub credentials to log in
                    withCredentials([usernamePassword(credentialsId: dockerhubCredentials, passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                        // Log in to Docker Hub
                        sh "docker login -u ${env.DOCKERHUB_USERNAME} -p ${env.DOCKERHUB_PASSWORD}"

                        // Push the Docker image to Docker Hub
                        sh "docker push ${imageName}"
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Add your actual test commands here
                    sh 'echo "Running tests"'
                }
            }
        }
        stage('cleanup') {
            steps {
                script {
                    def imageName = "${rurl}/${imagename}:latest"
                    
                 
                    
                    sh "docker image rmi ${imageName}"
                      sh "docker logout"
                }
            }
        }
    }
}
