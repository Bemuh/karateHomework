Feature: Crear un producto

  Background: elementos previos a la ejecución
    Given url URL

    # Data generators
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def product = dataGenerator.getRandomProduct()
    * def price = dataGenerator.getRandomValue()
    * def manufacturer = dataGenerator.getRandomManufacturer()
    * def category = dataGenerator.getRandomCategory()
    * def description = dataGenerator.getRandomDescription()
    * def tag = dataGenerator.getRandomTags()

    # Respuesta esperada
    * def productSuccess = {"id":'#number',"name":'#string',"description":'#string',"manufacturer":'#string',"category":'#string',"price":'#number',"created":'#string',"status":'#string',"tags":'#string'}

  Scenario: 2. Crear un producto

    Given path '/catalog/product'
    And request
    """
    {
      "name": "#(product)",
      "price": #(price),
      "manufacturer": "#(manufacturer)",
      "category": "#(category)",
      "description": "#(description)",
      "tags": "#(tag)"
    }
    """
    When method POST
    Then status 201
    * match response == productSuccess
    * def productId = response.id
    * def productName = response.name
    * def productPrice = response.price