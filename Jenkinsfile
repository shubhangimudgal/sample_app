pipeline {
    agent {
      kubernetes {
        label "sample-app-builder"
        yaml '''
          apiVersion: v1
          kind: Pod
          spec:
            containers:
            - name: docker
              image: docker:latest
              envFrom:
                - secretRef:
                    name: docker-secret
                - secretRef:
                    name: rails-secret
              command:
              - cat
              tty: true
              volumeMounts:
              - mountPath: /var/run/docker.sock
                name: docker-sock
            volumes:
            - name: docker-sock
              hostPath:
                path: /var/run/docker.sock  
          '''
      }
    }

    stages {
        stage('Build-docker-image') {
            steps {
	              container('docker') {
                    sh 'docker build --file Dockerfile.production --tag smudgal2964/sample_app:1.0-jenkins --build-arg RAILS_MASTER_KEY=$RAILS_MASTER_KEY .'
                }
            }
        }
        stage('Login-Into-Docker') {
           steps {
               container('docker') {
                   sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
               }
           }  
        } 
        stage('Push to registry') {
            steps {
                container('docker') {
                    sh 'docker push smudgal2964/sample_app:1.0-jenkins'
                }
            }
        }
    }
    post {
        always {
            container('docker') {
	        sh 'docker logout'
            }
        }
    }
 }
