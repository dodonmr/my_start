# Author        : Mihaela Dodon
# Date          : Dec 2nd 2020
# Description   : Fabric Domain Zone TestSuite
#
# Topology      : topo_lux_1
# VSP1100 Switch ----- Cloud

*** Variables ***
${DEVICE}                   VSP1100
${EXIT_LEVEL}               test_suite
${TESTBED}                  lux_tb_1
${TOPO}                     topo_lux_1
${DOMAIN}                   Automation_Domain
${DOMAIN2}                  Automation_Domain2
${NEW_DEF_DOMAIN}           Default_Domain_edited
${NEW_DEF_ZONE}             Default_Zone_edited
${ZONE}                     Automation_Zone-Default
${NEW_DOMAIN_ZONE}          Automation_Zone-Domain
${NEW_DOMAIN_ZONE2}         Automation_Zone-Domain2


*** Settings ***
Library     Collections
Library     common/Utils.py
Library     xiq/flows/common/Login.py
Library     xiq/flows/fabric/Fabric.py

Resource    testsuites/xiq/config/waits.robot
Resource    testsuites/xiq/topologies/${TESTBED}/${DEVICE}.robot
Resource    testsuites/xiq/topologies/${TESTBED}/${TOPO}.robot
Resource    testsuites/xiq/topologies/topology.robot


*** Test Cases ***

Test1: Check that Default domain and Default zone are predefined in Fabric tree
    [Documentation]         Add a new domain and zone to Default Domain in Fabric view
    [Tags]                  sanity    fabric    domain     zone
    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
    Navigate To Fabric
    Expand Fabric Domain Tree
    ${Predefined} =      Domain Zone Predefined
    Log     Predefined Domain and zone are ${Predefined}

    [Teardown]
    Logout User
    Quit Browser

Test2: Add new zone to Default Domain in Fabric tree view
    [Documentation]         Add a new zone to Default Domain in Fabric tree view
    [Tags]                  sanity    fabric    zone
    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
    Navigate To Fabric
    Expand Fabric Domain Tree
    ${PREDEFINED} =   Domain Zone Predefined
    ${Default_Domain} =     Get From List   ${PREDEFINED}   0
    Fabric Zone Add Default    ${ZONE}
    ${ADD_ZONE} =    Verify Zone Exists    ${ZONE}      ${Default_Domain}
    Dictionary Should contain value      ${ADD_ZONE}     Automation_Zone-Default

    [Teardown]
    Logout User
    Quit Browser

Test3: Add new domain and zone into it in Fabric tree view
    [Documentation]         Add new domain and zone to it in Fabric tree view
    [Tags]                  sanity    fabric    domain     zone
    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
    Navigate To Fabric
    Expand Fabric Domain Tree
    Fabric Domain Add     ${DOMAIN}
    ${ADD_DOMAIN} =     Verify Domain Exists     ${DOMAIN}
    Should Be Equal As Strings      ${ADD_DOMAIN}     Automation_Domain
    Create New Zone In New Domain   ${DOMAIN}   ${NEW_DOMAIN_ZONE}
    ${ADD_ZONE} =       Verify Zone Exists  ${NEW_DOMAIN_ZONE}  ${DOMAIN}
    Dictionary Should contain value      ${ADD_ZONE}     Automation_Zone-Domain

    [Teardown]
    Logout User
    Quit Browser

#Test4: Add duplicate zone to Default Domain and to new domain
#    [Documentation]         Add duplicate zone to Default Domain and to new domain
#    [Tags]                  sanity    fabric    domain     zone
#    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
#    Navigate To Fabric
#    Expand Fabric Domain Tree
#    ${PREDEFINED} =   Domain Zone Predefined
#    ${Default_Domain} =     Get From List   ${PREDEFINED}   0
#    Fabric Zone Add Default     ${ZONE}
#    ${ADD_ZONE} =       Verify Zone Exists    ${ZONE}      ${Default_Domain}
#    Dictionary Should contain value      ${ADD_ZONE}     Automation_Zone-Default
#    Create New Zone In New Domain   ${DOMAIN}   ${NEW_DOMAIN_ZONE}
#    ${ADD_ZONE} =       Verify Zone Exists    ${NEW_DOMAIN_ZONE}    ${DOMAIN}
#    Dictionary Should contain value      ${ADD_ZONE}     Automation_Zone-Domain
#
#    [Teardown]
#    Logout User
#    Quit Browser
#
#Test5: Add duplicate domain by using ADD option
#    [Documentation]         Add duplicate domain by using ADD option
#    [Tags]                  sanity    fabric    domain     zone
#    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
#    Navigate To Fabric
#    Expand Fabric Domain Tree
#    Fabric Domain Add     ${DOMAIN}
#    ${ADD_DOMAIN} =     Verify Domain Exists     ${DOMAIN}
#    Should Be Equal As Strings      ${ADD_DOMAIN}     Automation_Domain
#
#    [Teardown]
#    Logout User
#    Quit Browser
#
#Test6: Add duplicate domain by editing existing domain
#    [Documentation]         Add duplicate domain by editing existing domain
#    [Tags]                  sanity    fabric    domain     zone
#    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
#    Navigate To Fabric
#    Expand Fabric Domain Tree
#    ${PREDEFINED} =   Domain Zone Predefined
#    ${Default_Domain} =   Get From List   ${PREDEFINED}   0
#    Fabric Domain Name Edit    ${DOMAIN}  ${Default_Domain}
#    ${DOMAIN_UNEDITED} =  Verify Domain Exists  ${DOMAIN}
#    Should Be Equal As Strings      ${DOMAIN_UNEDITED}     Automation_Domain
#    ${DEFAULT_DOMAIN_UNEDITED} =  Verify Domain Exists  ${Default_Domain}
#    Should Be Equal As Strings      ${DEFAULT_DOMAIN_UNEDITED}     ${Default_Domain}
#
#    [Teardown]
#    Logout User
#    Quit Browser
#
#Test7: Add duplicate zone by editing existing zone
#    [Documentation]         Add duplicate zone by editing existing zone
#    [Tags]                  sanity    fabric    domain     zone
#    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
#    Navigate To Fabric
#    Expand Fabric Domain Tree
#    ${PREDEFINED} =   Domain Zone Predefined
#    ${Default_Domain} =   Get From List   ${PREDEFINED}   0
#    ${Default_Zone} =   Get From List   ${PREDEFINED}   1
#    Fabric Zone Name Edit   ${ZONE}  ${Default_Zone}
#    ${ZONE_UNEDITED} =  Verify Zone Exists    ${ZONE}    ${Default_Domain}
#    Dictionary Should contain value      ${ZONE_UNEDITED}    ${ZONE}
#    ${DEFAULT_ZONE_UNEDITED} =  Verify Zone Exists    ${Default_Zone}   ${Default_Domain}
#    Dictionary Should contain value      ${DEFAULT_ZONE_UNEDITED}    ${Default_Zone}
#
#    [Teardown]
#    Logout User
#    Quit Browser
#
#Test8: Edit domain name using edit option
#    [Documentation]         Edit domain name using edit option
#    [Tags]                  sanity    fabric    domain     zone
#    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
#    Navigate To Fabric
#    Expand Fabric Domain Tree
#    Fabric Domain Name Edit    ${DOMAIN}  ${DOMAIN2}
#    ${NEW_DOMAIN_NAME} =  Verify Domain Exists     ${DOMAIN2}
#    Should Be Equal As Strings      ${NEW_DOMAIN_NAME}     Automation_Domain2
#
#    [Teardown]
#    Logout User
#    Quit Browser
#
#Test9: Edit zone name using edit option
#    [Documentation]         Edit zone name using edit option
#    [Tags]                  sanity    fabric    domain     zone
#    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
#    Navigate To Fabric
#    Expand Fabric Domain Tree
#    Fabric Zone Name Edit  ${NEW_DOMAIN_ZONE}  ${NEW_DOMAIN_ZONE2}
#    ${NEW_ZONE_NAME} =  Verify Zone Exists  ${NEW_DOMAIN_ZONE2}    ${DOMAIN2}
#    Dictionary Should contain value      ${NEW_ZONE_NAME}     Automation_Zone-Domain2
#
#    [Teardown]
#    Logout User
#    Quit Browser
#
#Test10: Delete newly created zone in Default Domain
#    [Documentation]         Delete newly created zone in Default Domain
#    [Tags]                  sanity    fabric    domain     zone
#    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
#    Navigate To Fabric
#    Expand Fabric Domain Tree
#    ${PREDEFINED} =   Domain Zone Predefined
#    ${DEFAULT_DOMAIN} =     Get From List   ${PREDEFINED}   0
#    ${ZONE_EXISTS} =  Verify Zone Exists  ${ZONE}  ${DEFAULT_DOMAIN}
#    Dictionary Should contain value   ${ZONE_EXISTS}     ${ZONE}
#    Fabric Zone Delete  ${ZONE}
#    ${ZONE_EXISTS} =  Verify Zone Exists  ${ZONE}  ${DEFAULT_DOMAIN}
#    Should Be Equal As Strings  ${ZONE_EXISTS}      -1
#
#    [Teardown]
#    Logout User
#    Quit Browser
#
#Test11: Delete newly created domain
#    [Documentation]         Delete newly created domain
#    [Tags]                  sanity    fabric    domain     zone
#    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
#    Navigate To Fabric
#    Expand Fabric Domain Tree
#    ${DOMAIN_EXISTS} =  Verify Domain Exists  ${DOMAIN2}
#    Should Be Equal As Strings  ${DOMAIN_EXISTS}     ${DOMAIN2}
#    Fabric Domain Delete  ${DOMAIN2}
#    ${DOMAIN_EXISTS} =  Verify Domain Exists  ${DOMAIN2}
#    Should Be Equal As Strings  ${DOMAIN_EXISTS}    -1
#
#    [Teardown]
#    Logout User
#    Quit Browser
#
#Test12: Edit Default Zone name
#    [Documentation]         Edit Default Zone name
#    [Tags]                  sanity    fabric    domain     zone
#    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
#    Navigate To Fabric
#    Expand Fabric Domain Tree
#    ${PREDEFINED} =   Domain Zone Predefined
#    ${DEFAULT_DOMAIN} =     Get From List   ${PREDEFINED}   0
#    ${DEFAULT_ZONE} =     Get From List   ${PREDEFINED}   1
#    Fabric Zone Name Edit   ${DEFAULT_ZONE}  ${NEW_DEF_ZONE}
#    ${NEW_ZONE_NAME} =  Verify Zone Exists  ${NEW_DEF_ZONE}     ${DEFAULT_DOMAIN}
#    Dictionary Should contain value      ${NEW_ZONE_NAME}     Default_Zone_edited
#
#    [Teardown]
#    Logout User
#    Quit Browser
#
#Test13: Edit Default Domain name
#    [Documentation]         Edit Default Domain name
#    [Tags]                  sanity    fabric    domain     zone
#    Login User          ${TENANT_USERNAME}      ${TENANT_PASSWORD}
#    Navigate To Fabric
#    Expand Fabric Domain Tree
#    ${PREDEFINED} =   Domain Zone Predefined
#    ${DEFAULT_DOMAIN} =     Get From List   ${PREDEFINED}   0
#    Fabric Domain Name Edit    ${DEFAULT_DOMAIN}  ${NEW_DEF_DOMAIN}
#    ${NEW_DOMAIN_NAME} =  Verify Domain Exists  ${NEW_DEF_DOMAIN}
#    Should Be Equal As Strings      ${NEW_DOMAIN_NAME}     Default_Domain_edited
#
#    [Teardown]
#    Logout User
#    Quit Browser
