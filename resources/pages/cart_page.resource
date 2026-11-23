*** Settings ***
Documentation    Azioni e verifiche della pagina del carrello SauceDemo.
Library          Browser

*** Keywords ***
Open Cart Page
    Click    a.shopping_cart_link
    Get Text    span.title    ==    Your Cart
