*** Settings ***
Library    Browser

*** Test Cases ***
Prova Apertura Browser
    New Browser    browser=chromium    headless=False
    New Page       https://www.google.com
    Take Screenshot
    Close Browser