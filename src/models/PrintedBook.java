package models;

public class PrintedBook extends Book {
    public PrintedBook(String bookId, String title, String author, double price, String imageUrl) {
        super(bookId, title, author, price, imageUrl);
    }

    @Override
    public String getBookType() {
        return "Printed Book";
    }
}