*** Settings ***
Documentation    Azioni e verifiche della pagina dei prodotti SauceDemo.

*** Keywords ***
Add Product To Cart
    [Arguments]    ${product_id}
    Click    id=add-to-cart-${product_id}

Cart Badge Should Show
    [Arguments]    ${expected_count}
    Get Text    span.shopping_cart_badge    ==    ${expected_count}
