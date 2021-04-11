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
              sh """#!/bin/bash -e
            # Wait for chromemode to be up and execute selenium tests in robottests container
            docker-compose run robottests robot -t 15 -d tests -x xunit --variable BROWSER:chrome tests/
          """

              sh """#!/bin/bash
                          # Stop and remove the containers
                          docker-compose down
                      """
        }
    }
  }
}
