*** Settings ***
Documentation    A file with reusable keywords and variables for the Home page.
Library          SeleniumLibrary
Library          Collections

*** Variables ***
#${TIMEOUT}    2

*** Keywords ***
Open Browser To Home Page
    Open Browser    ${APP_URL}    ${BROWSER}    remote_url=${SELENIUM_HUB}


A Home Page Is Open
    ${Title}=    Get Title
    Should Be Equal As Strings   ${Title}  Google
