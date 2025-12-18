pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "eu-north-1"
        TF = "C:\\Program Files\\terraform\\terraform.exe"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat '"%TF%" init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat '"%TF%" plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat '"%TF%" apply -auto-approve'
                }
            }
        }

        stage('Show Output') {
            steps {
                bat '"%TF%" output'
            }
        }
    }
}


