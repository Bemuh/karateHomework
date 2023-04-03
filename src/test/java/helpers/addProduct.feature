Feature: add a product to an existing order

  Background: valores aleatorios y de entorno
    Given url URL

  Scenario:
    Given path order + '/' + orderId + '/product'
    And request
    """
      {
        "productId": "#(productId)",
        "amount": #(quantity)
      }
    """
    When method POST
    Then status 201