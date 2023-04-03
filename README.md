# MyStoreAPI Test Plan

This document outlines the steps required to test some of the services available in [MyStoreAPI](https://mystoreapi.com/).

## API Endpoints

The following API endpoints will be tested:

    POST /order/new
    POST /catalog/product
    GET /order/{id}
    POST /order/{id}/product
    DELETE /order/{id}/product/{productId}
    DELETE /order/{id}
    
## Test Steps

### Go to [MyStoreAPI](https://mystoreapi.com/)

1. Use `POST` `/order/new` to create a new order:
    - Use random values generated by Postman/Karate (through [JavaFaker](https://github.com/DiUS/java-faker)) for the fields depending on the type.
    - Catch the value of the `id` variable in the response to use later.
    - Catch the value of the `customer` variable to use later.
    - Validate the response code.
    - Validate the response body:
        - Postman: `status` and `user`.
        - Karate: the whole body with [fuzzy matching](https://github.com/karatelabs/karate#fuzzy-matching).

2. Use `POST` `/catalog/product` to create a new product:
    - Use random values generated by Postman/Karate (through [JavaFaker](https://github.com/DiUS/java-faker)) for the fields depending on the type.
    - Catch the value of the `id` variable in the response to use later. Save it as a different variable name from the previous `id`.
    - Catch the value of the `name` variable to use later.
    - Validate the response code.
    - Validate the response body:
        - Postman: `status` and `price`.
        - Karate: the whole body with [fuzzy matching](https://github.com/karatelabs/karate#fuzzy-matching).

3. Use `GET` `/order/{id}` to verify the order previously created:
    - Compare the `customer` value in the response body with the one created previously.
    - Validate the response code.

4. Use `POST` `/order/{id}/product` to add the product to the order:
    - The id in the URL is the order's id, while the one in the body is the product's id.
    - Use random values generated by Postman for the fields depending on the type.
    - Save the `amount` variable to compare it in the next step.

5. Use `GET` `/order/{id}` to verify the previously created order and its added product:
    - Compare the `customer` value in the response body with the one created previously.
    - Compare the `name` value of the product with the one obtained from the query.
    - Compare the total cost with the amount of products and the price.

6. Use `DELETE` `/order/{id}/product/{productId}` to remove the product from the order.

7. Use `GET` `/order/{id}` to verify the order:
    - Verify that there are no products in the order.

8. Use `DELETE` `/order/{id}`:
    - Verify the status message.

9. Use `GET` `/order/{id}` to verify the order:
    - Verify that the server response status is 404.
    - Verify the response message.
    
    
## Conclusion

Following these test steps will ensure that the MyStoreAPI is functioning as intended and that the whole homework was done successfully.
