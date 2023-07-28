pipeline {
    agent { label 'slave01' }
    stages {
        stage("Clone Git Repository") {
            steps {
                git(
                    url: "https://github.com/sohanmer/simple-cicd-pipeline.git",
                    branch: "main",
                    changelog: true,
                    poll: true
                )
            }
        }
        stage('Build Image') {
            steps {
                dir('/home/ubuntu/workspace/flask_app_build_pipeline/flask-project') {
                    sh 'docker build -t sohanmer/flask-app .'
                }
            }
        }
        stage('Create container') {
            steps {
                sh 'docker run -d -p 3000:80 --name flask-app sohanmer/flask-app'
            }
        }
    }
}