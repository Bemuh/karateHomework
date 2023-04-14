Feature: Removes a product from the order

  Background:
    Given url URL

  Scenario:
    Given path order + '/' + orderId + '/product/' + productId
    When method DELETE
    Then status 200