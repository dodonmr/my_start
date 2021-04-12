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
              sh """#!/bin/bash -e
            # Build, create and start containers in a background
            docker-compose up -d --build
          """
              sh './tests_robotframework/healthcheck.sh'

              sh """#!/bin/bash -e
            # Wait for chromemode to be up and execute selenium tests in robottests container
            docker-compose run robottests robot -d tests -x xunit --variable BROWSER:chrome /scripts/tests/
          """

              sh """#!/bin/bash
                          # Stop and remove the containers
                          docker-compose down
                      """
        }
    }
   }
//         stage("Start Grid"){
//         			steps{
//         				sh "docker-compose up -d hub chrome firefox"
//         			}
//         		}
//         stage("Run Test"){
//         		steps{
//         				sh "docker-compose run robottests"
//         			}
//         }
//       }
        post{
        		always{
        			archiveArtifacts artifacts: 'reports'
        			sh "docker-compose down"
//         			sh "sudo rm -rf reports/"
        		}
        	}

}
