*** Settings ***
Documentation    Test rapido per verificare l'apertura del browser.
Resource         ../resources/common/browser.resource
Test Setup       Start Browser Session
Test Teardown    Close Browser Session

*** Test Cases ***
Prova Apertura Browser
    Open Browser Page    https://www.google.com
    Take Screenshot