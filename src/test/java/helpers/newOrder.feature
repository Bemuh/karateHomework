Feature: Crear una orden

  Background: Elementos previos a la solicitud
    Given url URL

    # Data generators
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomAddress = dataGenerator.getRandomAddress()
    * def randomCustomer = dataGenerator.getRandomCustomer()

    #Respuesta esperada
    * def orderSuccess = {"id": '#number' ,"created": '#string',"customer": '#string',"address": '#string',"status":"open","user":null}


  Scenario: 1. Crear una nueva orden, guardar el ID y el customer
    Given path order + '/new'
    And request
    """
    {
      "customer": "#(randomCustomer)",
      "address": "#(randomAddress)"
    }
    """
    When method POST
    Then status 201
    * def orderId = response.id
    * def customer = response.customer
    * match response == orderSuccess