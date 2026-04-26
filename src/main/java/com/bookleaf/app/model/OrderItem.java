package com.bookleaf.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "order_items")
public class OrderItem implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "book_id", nullable = false)
    private Book book;

    @Column(nullable = false)
    private int quantity = 1;

    @Column(length = 20)
    private String format = "HARDCOPY";

    @Column(name = "unit_price", nullable = false)
    private double unitPrice;

    public OrderItem() {}

    public OrderItem(Order order, Book book, int quantity, String format, double unitPrice) {
        this.order = order;
        this.book = book;
        this.quantity = quantity;
        this.format = format;
        this.unitPrice = unitPrice;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Order getOrder() { return order; }
    public void setOrder(Order order) { this.order = order; }

    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getFormat() { return format; }
    public void setFormat(String format) { this.format = format; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public double getSubtotal() {
        return unitPrice * quantity;
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
