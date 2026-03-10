package models;

public abstract class Book {
    private String bookId;
    private String title;
    private String author;
    private double price;

    public Book(String bookId, String title, String author, double price) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.price = price;
    }

    // Getters and Setters
    public String getBookId() { return bookId; }
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public double getPrice() { return price; }

    // Abstract method
    public abstract String getBookType();

    public String toFileString() {
        return bookId + "," + title + "," + author + "," + price + "," + getBookType();
    }
}