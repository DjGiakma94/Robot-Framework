*** Settings ***
Documentation    Test di integrazione per gli endpoint JSONPlaceholder.
Library          Collections
Resource         ../resources/api/jsonplaceholder.resource

Suite Setup       Open JSONPlaceholder Session
Suite Teardown    Close API Sessions

*** Test Cases ***
Verifica Utente Post E Commenti Correlati
    [Tags]    api    integration
    ${user}=    Get User By Id    1
    Should Be Equal As Strings    ${user}[name]        Leanne Graham
    Should Be Equal As Strings    ${user}[email]       Sincere@april.biz
    Should Be Equal As Strings    ${user}[address][city]    Gwenborough

    ${posts}=    Get Posts For User    1
    Length Should Be    ${posts}    10
    FOR    ${post}    IN    @{posts}
        Should Be Equal As Integers    ${post}[userId]    1
    END

    ${first_post}=    Get From List    ${posts}    0
    ${comments}=    Get Comments For Post    ${first_post}[id]
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

    ${created_post}=    Create Post    ${payload}
    Should Be Equal As Strings    ${created_post}[title]    ${payload}[title]
    Should Be Equal As Strings    ${created_post}[body]     ${payload}[body]
    Should Be Equal As Integers    ${created_post}[userId]  ${payload}[userId]
    Should Be Equal As Integers    ${created_post}[id]      101