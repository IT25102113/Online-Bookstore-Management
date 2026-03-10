package models;

public abstract class User {
    // Encapsulation: Making fields private
    private String userId;
    private String name;
    private String email;
    private String password;

    // Constructor
    public User(String userId, String name, String email, String password) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // Getters and Setters
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    // Abstraction & Polymorphism setup: Abstract method to be overridden by subclasses
    public abstract String getUserRole();

    // Text file එකට ලියන්න ලේසි වෙන්න String එකක් විදියට දත්ත සකස් කිරීම
    public String toFileString() {
        return userId + "," + name + "," + email + "," + password + "," + getUserRole();
    }
}