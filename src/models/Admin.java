package models;

public class Admin extends User {

    public Admin(String userId, String name, String email, String password) {
        // super() මගින් Parent class (User) එකේ constructor එක call කරයි
        super(userId, name, email, password);
    }

    // Polymorphism: Overriding the abstract method
    @Override
    public String getUserRole() {
        return "Admin";
    }
}