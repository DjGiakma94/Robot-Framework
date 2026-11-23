*** Settings ***
Library    Browser

*** Keywords ***
Start Browser Session
    New Browser    browser=chromium    headless=False

Open Browser Page
    [Arguments]    ${url}
    New Page    ${url}

Close Browser Session
    Close Browser
