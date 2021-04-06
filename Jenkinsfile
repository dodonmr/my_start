pipeline {
  agent any

  environment {
    TAG = "demo_robot"
  }

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
      steps {
        try {
          sh """#!/bin/bash -e
            # Build, create and start containers in a background
            docker-compose -p ${TAG} up -d --build
          """
          sh """#!/bin/bash -e
            # Wait for chromemode to be up and execute selenium tests in robottests container
            docker-compose -p ${TAG} run robottests -t 15 chromenode:9001 -- robot -d reports -x xunit --variablefile variables/config.py --variable BROWSER:chrome tests/
          """
        } finally {
          publishHTML target: [
          allowMissing: false,
          alwaysLinkToLastBuild: true,
          keepAll: true,
          reportDir: 'reports',
          reportFiles: 'report.html',
          reportName: 'Robot Framework Test Execution Report'
          ]
          junit 'reports/*.xml'

          sh """#!/bin/bash
            # Stop and remove the containers
            docker-compose -p ${TAG} down
          """
        }
      }
    }
  }
}
