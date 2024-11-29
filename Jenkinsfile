pipeline {
    agent any

    stages {
        stage('Cloner le Code') {
            steps {
                git branch: 'main', url: 'https://github.com/JohanaJimenez1/Jenkins_Docker.git'
            }
        }

        stage('Construire l\'Image Docker') {
            steps {
                script {
                    dockerImage = docker.build("calculatricejenkins:${env.BUILD_ID}")
                }
            }
        }

        stage('Déployer en Test') {
            steps {
                script {
                    bat 'docker run -d -p 3001:3000 -e MESSAGE="Environnement de Test" --name calculatricejenkins-test calculatricejenkins:%BUILD_ID%'

                }
            }
        }

        stage('Tests') {
            steps {
                bat 'ping -n 6 127.0.0.1 > nul'
                bat 'curl http://localhost:3001'
            }
        }

        stage('Déployer en Production') {
            steps {
                script {
                    def userInput = input(
                        message: "Voulez-vous déployer en production ?",
                        ok: "Déployer"
                    )
                    bat 'docker run -d -p 3000:3000 -e MESSAGE="Environnement de Production" --name calculatricejenkins-prod calculatricejenkins:%BUILD_ID%'
                }
            }
        }
    }

    post {
        always {
            script {
                bat 'docker rm -f calculatricejenkins-test || exit 0'
            }
        }
    }
}

