*** Settings ***
Documentation    Azioni e verifiche della pagina di accesso SauceDemo.
Library          Browser
Resource         ../common/browser.resource

*** Keywords ***
Open SauceDemo Login Page
    [Arguments]    ${url}
    Start Browser Session
    Open Browser Page    ${url}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Fill Text    id=user-name    ${username}
    Fill Text    id=password    ${password}
    Click    id=login-button
    Get Text    span.title    ==    Products
