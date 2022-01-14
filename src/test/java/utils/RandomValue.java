package utils;

import org.apache.commons.lang.RandomStringUtils;

public class RandomValue {

    public String createRandomString(int createRandomValueLength, String randomValue) {
        String result = null;
        if (randomValue.equalsIgnoreCase("email"))
            result = RandomStringUtils.randomAlphanumeric(createRandomValueLength).toLowerCase() + "@grr.la";
        else
            result = RandomStringUtils.randomAlphanumeric(createRandomValueLength).toLowerCase();
        return result;
    }

    public String createInt(int value) {
        return RandomStringUtils.randomNumeric(value);
    }
}
