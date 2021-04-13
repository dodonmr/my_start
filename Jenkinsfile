pipeline {
  agent any

  stages {
    stage("Checkout") {
      steps {
        checkout scm
      }
    }

    stage("Cleaning and preparing") {
      steps {
        sh """#!/bin/bash -e
          git clean -dfx
          mkdir reports
        """
      }
    }

    stage('Run Selenium Tests') {
        steps{
        // Build, create and start containers in a background
              sh "docker-compose up -d --build --no-color"

        // Check that Selenium Grid is up
              sh './tests_robotframework/healthcheck.sh'

        // Execute selenium tests in robottests container

              sh "docker-compose run robottests robot -d reports -x xunit --variable BROWSER:chrome /scripts/tests/"

        // Stop and remove the containers
              sh " docker-compose down"


        }
    }
   }

        post{
        		always{
        			archiveArtifacts artifacts: 'reports'
        			sh "docker-compose down"
//         			sh "sudo rm -rf reports/"
        		}
        	}

}
