pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sshagent(credentials: ['webuxlab-blog']) {
                    withCredentials([string(credentialsId: 'webuxlab-blog-ssh', variable: 'SSHINFO')]) {
                        sh "scp -v -r -o StrictHostKeyChecking=no ./index.html ${SSHINFO}:/srv/portfolio/www/"
                        sh "scp -v -r -o StrictHostKeyChecking=no ./assets/ ${SSHINFO}:/srv/portfolio/www/"
                        sh "scp -v -r -o StrictHostKeyChecking=no ./docker-compose.yml ${SSHINFO}:/srv/portfolio/"
                        sh "ssh -o StrictHostKeyChecking=no $SSHINFO 'pushd /srv/portfolio; docker compose build; popd;'"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sshagent(credentials: ['webuxlab-blog']) {
                    withCredentials([string(credentialsId: 'webuxlab-blog-ssh', variable: 'SSHINFO')]) {
                        sh "ssh -o StrictHostKeyChecking=no $SSHINFO 'pushd /srv/portfolio; docker compose up -d; popd;'"
                    }
                }
            }
        }
    }
}
