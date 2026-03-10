package models;

public abstract class Book {
    protected String bookId;
    protected String title;
    protected String author;
    protected double price;
    protected String imageUrl; // අලුතින් එක් කළා

    public Book(String bookId, String title, String author, double price, String imageUrl) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.price = price;
        this.imageUrl = imageUrl;
    }

    public abstract String getBookType();

    public String toFileString() {
        // Image URL එක අන්තිමට එකතු කළා
        return bookId + "," + title + "," + author + "," + price + "," + getBookType() + "," + imageUrl;
    }
}