package utils;

import com.github.javafaker.Faker;

public class Extension {

    public String randomFirstName(){
        Faker faker = new Faker();
        return faker.name().fullName();
    }
}
