*** Settings ***
Documentation    Azioni e verifiche della pagina del carrello SauceDemo.

*** Keywords ***
Open Cart Page
    Click    a.shopping_cart_link
    Get Text    span.title    ==    Your Cart
