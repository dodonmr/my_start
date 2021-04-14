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
           sh './tests_robotframework/tools/healthcheck.sh'

        // Execute selenium tests in robottests container

           sh "docker-compose run robottests robot -d reports -x xunit --variable BROWSER:chrome /scripts/tests/"

      }
    }
  }

  post {
    always {
      step([$class: 'RobotPublisher',
           disableArchiveOutput: false,
           logFileName: 'reports/log.html',
           onlyCritical: true,
           otherFiles: 'reports/*.png',
           outputFileName: 'reports/output.xml',
           outputPath: '.',
           passThreshold: 90,
           reportFileName: 'reports/report.html',
           unstableThreshold: 100
      ])
         // Stop and remove the containers and remove "reports" folder
            sh "docker-compose down"
            sh "sudo rm -rf reports/"
    }
  }
}
