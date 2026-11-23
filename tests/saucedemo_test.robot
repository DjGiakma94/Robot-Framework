*** Settings ***
Documentation    Test E2E per il flusso di acquisto su SauceDemo.
Resource         ../resources/saucedemo.resource
Test Setup       Open SauceDemo Login Page
Test Teardown    Close Browser Session

*** Test Cases ***
Login E Aggiunta Prodotti Al Carrello
    [Tags]    ui    e2e
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Add Product To Cart    sauce-labs-backpack
    Add Product To Cart    sauce-labs-bike-light
    Cart Badge Should Show    2
    Open Cart Page
    Take Screenshot