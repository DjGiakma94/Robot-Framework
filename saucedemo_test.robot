*** Settings ***
Documentation    Test E2E base per Sauce Demo con Robot Framework e Playwright
Library          Browser
Variables        env_variables.py

# Setup e Teardown per gestire apertura e chiusura del browser
Test Setup       Apri Pagina Saucedemo
Test Teardown    Close Browser

*** Keywords ***
Apri Pagina Saucedemo
    New Browser    browser=chromium    headless=False
    New Page       ${URL}

Effettua Login
    [Arguments]    ${user}    ${pass}
    Fill Text      id=user-name    ${user}
    Fill Text      id=password     ${pass}
    Click          id=login-button
    # Verifica di essere atterrato sulla pagina dei prodotti
    Get Text       span.title      ==    Products

*** Test Cases ***
Login E Aggiunta Prodotti Al Carrello
    # 1. Effettua il login
    Effettua Login    ${USERNAME}    ${PASSWORD}

    # 2. Aggiungi il primo prodotto (Backpack)
    Click    id=add-to-cart-sauce-labs-backpack

    # 3. Aggiungi il secondo prodotto (Bike Light)
    Click    id=add-to-cart-sauce-labs-bike-light

    # 4. Verifica che il contatore del carrello mostri '2'
    Get Text    span.shopping_cart_badge    ==    2

    # 5. Vai alla pagina del carrello e scatta uno screenshot
    Click       a.shopping_cart_link
    Get Text    span.title    ==    Your Cart
    Take Screenshot