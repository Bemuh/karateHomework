Feature: deletes the order previously made

  Background: valores aleatorios y de entorno
    Given url URL

  Scenario:
    Given path order + '/' + orderId
    When method DELETE
    Then status 200
    * def deleteResponse = response