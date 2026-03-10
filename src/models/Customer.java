package models;

public class Customer extends User {

    public Customer(String userId, String name, String email, String password) {
        super(userId, name, email, password);
    }

    // Polymorphism: Overriding the abstract method
    @Override
    public String getUserRole() {
        return "Customer";
    }
}