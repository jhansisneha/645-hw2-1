// Group: Straw Hats
//Group Members: 
//•	Jhansi Sneha Kamsali (G01478467)
//•	Sheetal Sachidananda Harshini (G01464307)
//•	Gauthami Shravya Veerababu (G01461233)

pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker')  // Retrieve DockerHub credentials
        BUILD_TIMESTAMP = "${new Date().format('yyyyMMddHHmmss')}" // Use a timestamp for image tagging
		KUBECONFIG_CREDENTIALS = credentials('kubeconfig')
	}
    stages {
        stage("Build Survey Image") {
            steps {
                script {
                    // Fetch the current SCM and print the timestamp
                    checkout scm
                    sh 'echo ${BUILD_TIMESTAMP}'
                    
                    // Correctly login to DockerHub using the username and password
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                    
                    // Build the Docker image
                    def customImage = docker.build("jhansisneha/645-hw2:${BUILD_TIMESTAMP}")
                }
            }
        }
        stage("Push img to docker hub") {
            steps {
                script {
                    // Push the Docker image to DockerHub
                    sh "docker push jhansisneha/645-hw2:${BUILD_TIMESTAMP}"
                }
            }
        }
        stage("Deploy to kubernetes") {
			steps {
                withEnv(["KUBECONFIG=${KUBECONFIG_CREDENTIALS}"]) {
                    sh 'kubectl set image deployment/swe545-hw2-deployment container-0=jhansisneha/645-hw2:${BUILD_TIMESTAMP} -n default'
                }
            }
        }
    }
}
