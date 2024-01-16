node {
    checkout scm
    stage('Build') {
        steps {
            script {
                docker.image('maven:3.8.6-eclipse-temurin-18-alpine').inside('-v /root/.m2:/root/.m2') {
                    sh 'mvn -B -DskipTests clean package'
                }
            }
        }
    }
    stage('Test') {
        steps {
            script {
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
        }
    }
}
