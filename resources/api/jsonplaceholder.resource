*** Settings ***
Library    RequestsLibrary

*** Variables ***
${API_BASE_URL}       https://jsonplaceholder.typicode.com
${API_SESSION_NAME}   jsonplaceholder

*** Keywords ***
Open JSONPlaceholder Session
    Create Session    ${API_SESSION_NAME}    ${API_BASE_URL}    verify=True

Close API Sessions
    Delete All Sessions

Get User By Id
    [Arguments]    ${user_id}
    ${response}=    GET On Session    ${API_SESSION_NAME}    /users/${user_id}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}

Get Posts For User
    [Arguments]    ${user_id}
    &{query}=    Create Dictionary    userId=${user_id}
    ${response}=    GET On Session    ${API_SESSION_NAME}    /posts    params=${query}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}

Get Comments For Post
    [Arguments]    ${post_id}
    ${response}=    GET On Session    ${API_SESSION_NAME}    /posts/${post_id}/comments
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}

Create Post
    [Arguments]    ${payload}
    ${response}=    POST On Session    ${API_SESSION_NAME}    /posts    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    201
    RETURN    ${response.json()}
