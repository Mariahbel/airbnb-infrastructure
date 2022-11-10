def COLOR_MAP = [
    'SUCCESS': 'good',
    'FAILURE': 'danger',
]



pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                echo 'cloning project codebase...'
                git branch: 'main', url: 'https://github.com/Mariahbel/airbnb-infrastructure.git'
                sh 'ls'
            }
        }
        
        stage('verify Terraform version') {
            steps {
                echo 'Veryifying terraform Version'
                sh 'terraform --version'
                
            }
        }
        
        
       stage('Terraform init') {
            steps {
                echo 'Initiliazing terraform project...'
                sh 'terraform init'
                
            }
        }
        
                
            
            stage('Terraform validate') {
            steps {
                echo 'code syntax checking'
                sh 'terraform validate'
                
            }
        }
            
            stage('Terraform plan') {
            steps {
                echo 'terraform plan for dry run'
                sh 'terraform plan'
                
            }
        }
        
            stage('checkov scan') {
            steps {
                
                sh """
                sudo pip3 install checkov
                
                checkov -d . --skip-check CKV_AWS_79
                checkov -d . --skip-check CKV_AWS_41
                """
                
            }
        }
        
        
            
            stage('manual approver') {
            steps {
                input 'Approval require for deployment'
                
            }
        }
        
            
            stage('Terraform apply') {
            steps {
                echo 'terraform apply'
                sh 'sudo terraform apply --auto-approve'
                
            }
        }
            
        
    }
    post {
        always {
            echo 'I will always say Hello again!'
            slackSend channel: "glorious-w-f-devops-alerts", color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }
}


    
    


