package helpers;

import com.github.javafaker.Faker;

public class DataGenerator {

    public static String  getRandomCustomer() {
        Faker faker = new Faker();
        String customer = faker.name().fullName();
        return customer;

    }

    public static String getRandomAddress() {
        Faker faker = new Faker();
        String address = faker.address().fullAddress();
        return address;

    }

    public static String getRandomProduct() {
        Faker faker = new Faker();
        String product = faker.commerce().productName();
        return product;

    }

    public static double getRandomValue() {
        Faker faker = new Faker();
        double price = faker.number().randomDouble(2, 0, 999);
        return price;

    }

    public static String getRandomManufacturer() {
        Faker faker = new Faker();
        String manufacturer = faker.company().name();
        return manufacturer;

    }

    public static String getRandomCategory() {
        Faker faker = new Faker();
        String category = faker.commerce().department();
        return category;

    }

    public static String getRandomDescription() {
        Faker faker = new Faker();
        String description = faker.rickAndMorty().quote();
        return description;

    }

    public static String getRandomTags() {
        Faker faker = new Faker();
        String tag = faker.commerce().material() + " " + faker.commerce().color();
        return tag;

    }

    public static Integer getRandomQuantity() {
        Faker faker = new Faker();
        Integer quantity = faker.number().numberBetween(1, 50);
        return quantity;

    }

}