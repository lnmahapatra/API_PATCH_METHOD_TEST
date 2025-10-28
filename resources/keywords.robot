*** Settings ***
Library    RequestsLibrary
Library    BuiltIn
Library    Collections
Library    OperatingSystem

*** Variables ***
${BASE_URL}=    https://restful-api.dev

*** Keywords ***
Create User Session
    Create Session    restful    ${BASE_URL}

GET Object
    [Arguments]    ${id}
    ${response}=    GET On Session    restful    /objects/${payload}
    RETURN   ${response}

PATCH Object
    [Arguments]    ${id}    ${payload}
    ${response}=    PATCH On Session    restful    /objects/${id}    json=${payload}
    RETURN    ${response}
