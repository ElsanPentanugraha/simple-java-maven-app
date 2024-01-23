node {
    checkout scm
    stage('Build') {
        docker.image('maven:3.8.6-eclipse-temurin-18-alpine').inside('-v /root/.m2:/root/.m2') {
                sh 'mvn -B -DskipTests clean package'
        }
    }
    stage('Test') {
        try {
                docker.image('maven:3.8.6-eclipse-temurin-18-alpine').inside('-v /root/.m2:/root/.m2') {
                        sh 'mvn test'
                }
        } catch (e) {
                echo "Test Stage Failed!"
        } finally {
                junit 'target/surefire-reports/*.xml'
        }
    }
    stage('Manual Approval'){
            input message: 'Lanjutkan ke tahap Deploy?', ok: 'Proceed'
    }
    stage('Deploy') {
            archiveArtifacts 'target/submission-elsan-1.0-SNAPSHOT.jar'
            docker.build("submission-elsan:latest");
            sh "ssh-keyscan -H 18.139.84.168 >> ~/.ssh/known_hosts"
            sh "/usr/bin/scp -i /var/jenkins_home/implementasi-cicd-elsan.pem /var/jenkins_home/workspace/submission-cicd-pipeline-elsan/target/submission-elsan-1.0-SNAPSHOT.jar  ec2-user@18.139.84.168:/home/elsan/submission-elsan-1.0-SNAPSHOT.jar"
            sh 'docker run --rm submission-elsan'
            sleep 60
    }
}
