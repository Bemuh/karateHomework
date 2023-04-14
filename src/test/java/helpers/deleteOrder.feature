Feature: Deletes the order previously made

  Background:
    Given url URL

  Scenario:
    Given path order + '/' + orderId
    When method DELETE
    Then status 200
    * def deleteResponse = response