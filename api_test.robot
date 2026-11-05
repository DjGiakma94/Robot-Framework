*** Settings ***
Library    RequestsLibrary
Library    Collections

Suite Setup       Crea Sessione API
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com
${API_SESSION}    jsonplaceholder

*** Test Cases ***
Verifica Utente Post E Commenti Correlati
    [Tags]    api    integration
    ${response}=    GET On Session    ${API_SESSION}    /users/1
    Should Be Equal As Integers    ${response.status_code}    200
    ${user}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${user}[name]        Leanne Graham
    Should Be Equal As Strings    ${user}[email]       Sincere@april.biz
    Should Be Equal As Strings    ${user}[address][city]    Gwenborough

    &{query}=    Create Dictionary    userId=1
    ${posts_response}=    GET On Session    ${API_SESSION}    /posts    params=${query}
    Should Be Equal As Integers    ${posts_response.status_code}    200
    ${posts}=    Set Variable    ${posts_response.json()}
    Length Should Be    ${posts}    10
    FOR    ${post}    IN    @{posts}
        Should Be Equal As Integers    ${post}[userId]    1
    END

    ${first_post}=    Get From List    ${posts}    0
    ${comments_response}=    GET On Session    ${API_SESSION}    /posts/${first_post}[id]/comments
    Should Be Equal As Integers    ${comments_response.status_code}    200
    ${comments}=    Set Variable    ${comments_response.json()}
    Length Should Be    ${comments}    5
    FOR    ${comment}    IN    @{comments}
        Should Be Equal As Integers    ${comment}[postId]    ${first_post}[id]
        Should Not Be Empty    ${comment}[email]
    END

Creazione Post Tramite API
    [Tags]    api    integration
    &{payload}=    Create Dictionary
    ...    title=Robot Framework API test
    ...    body=Post creato durante il test di integrazione
    ...    userId=1

    ${response}=    POST On Session    ${API_SESSION}    /posts    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    201
    ${created_post}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${created_post}[title]    ${payload}[title]
    Should Be Equal As Strings    ${created_post}[body]     ${payload}[body]
    Should Be Equal As Integers    ${created_post}[userId]  ${payload}[userId]
    Should Be Equal As Integers    ${created_post}[id]      101

*** Keywords ***
Crea Sessione API
    Create Session    ${API_SESSION}    ${BASE_URL}    verify=True