package com.bookleaf.app.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;


@Entity
@Table(name = "books")
public class Book extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 200)
    private String title;

    @Column(length = 20)
    private String isbn;

    @Column(length = 50)
    private String category;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private double price;

    @Column(nullable = false)
    private int quantity;

    @Column(name = "image_url", length = 500)
    private String imageUrl;

    @Column(name = "has_ebook")
    private boolean hasEbook = false;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author_id")
    private Author author;

    @OneToMany(mappedBy = "book", cascade = CascadeType.ALL, orphanRemoval = true)
    private java.util.List<Review> reviews;

    @OneToMany(mappedBy = "book", cascade = CascadeType.ALL, orphanRemoval = true)
    private java.util.List<WishlistItem> wishlistItems;

    @OneToMany(mappedBy = "book", cascade = CascadeType.ALL, orphanRemoval = true)
    private java.util.List<OrderItem> orderItems;


    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Book() {}

    public Book(String title, String isbn, String category, String description, double price, int quantity) {
        this.title = title;
        this.isbn = isbn;
        this.category = category;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
    }

    @PrePersist
    protected void onCreate() {
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public boolean isHasEbook() { return hasEbook; }
    public void setHasEbook(boolean hasEbook) { this.hasEbook = hasEbook; }

    public Author getAuthor() { return author; }
    public void setAuthor(Author author) { this.author = author; }


    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "Book{id=" + getId() + ", title='" + title + "', price=" + price + "}";
    }

    @Override
    public String getDisplayDetail() {
        return "Book: " + this.title + " (Category: " + this.category + ")";
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
