pipeline {
    agent any
    environment {
        REPO_NAME = "cicd.git"
        REGION = "ap-south-1" 
        name = "tomcat"
    }
    stages { 

        stage('Checkout Source code') {
            steps {
                git branch: 'main',                    
                    url: "https://github.com/ajitkumar-tech/${REPO_NAME}"
            }
        }  
      stage('generate artifact') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('static code analysis') {
            steps {
                sh ''' 
                mvn clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar \
                 -Dsonar.projectKey=sonar \
                 -Dsonar.projectName='sonar' \
                 -Dsonar.host.url=http://43.205.243.23:9000 \
                 -Dsonar.token=sqp_8506887d1060e499fafb5081ded02669dfb33cb5
                 '''
            }
        }

       stage('Terraform Init') {
            steps {
                sh '''
                    terraform init
                '''
            }
        }

        
        stage('Terraform Plan') {
            steps {
                sh '''
                    terraform plan 
                '''
            }
        }

        stage('create Eks cluster') {
            steps {
                
                sh '''
                    terraform apply -auto-approve 
                '''
            }
        }       

         stage('login to ecr') {
            steps {
                sh """
                    aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin 748716953870.dkr.ecr.${REGION}.amazonaws.com
                """
            }
        }

      stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t ${name} .
                """
            }
        }

     stage('Tag Image for ECR') {
            steps {
                sh """
                    docker tag ${name}:latest 748716953870.dkr.ecr.${REGION}.amazonaws.com/${name}:latest
                """
            }
        }

     stage('Push Image to ECR') {
            steps {
                sh """
                    docker push 748716953870.dkr.ecr.${REGION}.amazonaws.com/${name}:latest
                """
            }
        }
     stage('deploy to eks cluster') {
            steps {
                ansiblePlaybook credentialsId: 'ansible', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts', playbook: 'playbook.yml', vaultTmpPath: ''
            }
        }
    }
}    

