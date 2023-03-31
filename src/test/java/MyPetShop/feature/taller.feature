Feature: taller de mystoreapi.com

  Background: valores aleatorios
    Given url URL

    # Crear orden
    * def newOrder = callonce read('classpath:helpers/newOrder.feature')
    * def orderId = newOrder.orderId
    * def customer = newOrder.customer

    # Crear producto
    * def product = callonce read('classpath:helpers/newProduct.feature')
    * def productId = product.productId
    * def productName = product.productName
    * def productPrice = product.productPrice

    # Variables aleatorias
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def quantity = dataGenerator.getRandomQuantity()

  Scenario: 3. Verificar la orden
    Given path order + '/' + orderId
    When method GET
    Then status 200
    * match response.order.customer == customer

    # 4. Añadir el producto a la orden
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

    # 5. Verificar la adición del producto a la orden
    Given path order + '/' + orderId
    When method GET
    Then status 200
    * match response.order.customer == customer
    * match response.items[0].name == productName
    * def totalCost = quantity * productPrice
    * match response.summary.totalCost == totalCost

    # 6. Eliminar el producto de la orden
    Given path order + '/' + orderId + '/product/' + productId
    When method DELETE
    Then status 200

    # 7. Corroborar que no hayan productos en la orden
    Given path order + '/' + orderId
    When method GET
    Then status 200
    * match response.order.customer == customer
    * match response.items == '#[0]'

    # 8. Eliminar la orden y corroborar el mensaje de estado
    Given path order + '/' + orderId
    When method DELETE
    Then status 200
    * match response.status == 'deleted'

    # 9. Corroborar el estado de la respuesta y el mensaje
    Given path order + '/' + orderId
    When method GET
    Then status 404
    * def message = 'Order with id ' + orderId + ' not found'
    * print message
    * match response == {"statusCode":404,"message": "#(message)"}



