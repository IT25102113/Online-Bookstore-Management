package com.bookleaf.app.model;

import java.io.Serializable;


public class CartItem implements Serializable {

    private Long bookId;
    private String bookTitle;
    private String bookImage;
    private String authorName;
    private String format;       // "HARDCOPY" or "EBOOK"
    private double unitPrice;
    private int quantity;

    public CartItem() {}

    public CartItem(Long bookId, String bookTitle, String bookImage, String authorName,
                    String format, double unitPrice, int quantity) {
        this.bookId = bookId;
        this.bookTitle = bookTitle;
        this.bookImage = bookImage;
        this.authorName = authorName;
        this.format = format;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }

    public double getSubtotal() {
        return unitPrice * quantity;
    }

    public Long getBookId() { return bookId; }
    public void setBookId(Long bookId) { this.bookId = bookId; }

    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }

    public String getBookImage() { return bookImage; }
    public void setBookImage(String bookImage) { this.bookImage = bookImage; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public String getFormat() { return format; }
    public void setFormat(String format) { this.format = format; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
