Feature: Get an order from mystoreapi.com

  Background:
    Given url URL

  Scenario: get order

    Given path order + '/' + orderId
    When method GET
    * def orderResponse = response
    * def getStatus = responseStatus