Feature: removes a product from the order

  Background: valores aleatorios y de entorno
    Given url URL

  Scenario:
    Given path order + '/' + orderId + '/product/' + productId
    When method DELETE
    Then status 200