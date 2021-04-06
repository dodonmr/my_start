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
      steps {
        try {
          sh """#!/bin/bash -e
            # Build, create and start containers in a background
            docker-compose up -d --build
          """
          sh """#!/bin/bash -e
            # Wait for chromemode to be up and execute selenium tests in robottests container
            docker-compose run robottests -t 15 chromenode:9001 -- robot -d reports -x xunit --variablefile variables/config.py --variable BROWSER:chrome tests/
          """
          sh """#!/bin/bash
                          # Stop and remove the containers
                          docker-compose down
                      """
        }   
      }
    }
  }
}
