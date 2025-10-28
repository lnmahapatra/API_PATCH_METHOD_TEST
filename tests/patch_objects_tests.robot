*** Settings ***
Library    RequestsLibrary
Library    BuiltIn
Library    Collections
Library    OperatingSystem
Resource          ../resources/keywords.robot
Suite Setup       Create User Session

*** Test Cases ***
Valid GetResponse Should Succeed
    [Documentation]    If required verify GET response
    Create Session    my_session    https://api.restful-api.dev
    ${response} =    GET On Session    my_session   /objects/7
    Status Should Be    200    ${response}
    Log    ${response.status_code}
    Log    ${response.json()}

Patch Without Auth (If Required)
    [Documentation]    If authentication is required, verify failure without auth headers
    Create Session    no_auth    ${BASE_URL}
    ${response}=    PATCH On Session    no_auth    ${OBJECT_ENDPOINT}/${VALID_ID}    json=${PATCH_PAYLOAD}
    Should Contain Any    ${response.status_code}    401    403

Valid PATCH Should Succeed
    [Documentation]    Create a valid Patch method to be success
    ${patch_payload}=    Create Dictionary    data={"generation": "4th", "CPU model":"Intel Core i9"}
    ${response}=    PATCH Object    7    ${patch_payload}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Response Status Code: ${response.status_code}
    Log    Response Reason: ${response.reason}
    Log    Response Body: ${response.text}
    Status Should Be    ${response}    200
    ${body}=    To Json    ${response.content}
    Log To Console    ${response.json()}
    Log    ${response.json()}[1]
    Dictionary Should Contain Value    ${body.data.price}    4th
    Dictionary Should Contain Value    ${body.data.CPU model}    Intel Core i9

Patch Non-existent ID Should Fail
    [Documentation]     Trying Patch with Non-existent ID
    ${patch_payload}=    Create Dictionary    data={"name": "Apple Maclittle Pro 16}
    ${response}=    PATCH Object    9999999    ${patch_payload}
    Status Should Be    ${response}   404

Invalid Payload Should Fail
    [Documentation]     Trying Patch with invalid payload
    ${invalid_payload}=    Set Variable    not-a-json
    ${response}=    PATCH On Session    restful    /objects/1    data=${invalid_payload}    headers={"Content-Type": "application/json"}
    Status Should Be    ${response}    404

Empty Payload Should Be Handled
    [Documentation]     Trying Patch with Empty Payload
    ${patch_payload}=    Create Dictionary
    ${response}=    PATCH Object    1    ${patch_payload}
    Status Should Be    ${response}    200

Verify Partial Update Persists
    [Documentation]    Verify only sent fields are updated
    ${partial_payload}=    Create Dictionary    data={"size": "large"}
    ${response}=    PATCH Object    6    ${partial_payload}
    Verify Response Status Code    ${response}    200
    Verify Response Body Contains    ${response}    name    Updated Robot Object
    ${status}=    Convert To Integer    ${response.status_code}
