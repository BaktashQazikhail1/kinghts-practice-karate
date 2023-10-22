package data;

public class DataGenerator {

    public static String getEmail() {

        // baktash_qz11@yahoo.com

        String email = "baktash_qz11";
        int random = (int) (Math.random() * 8921000);
        return email + random + "@yahoo.com";

    }
}
