package com.bookleaf.app.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;


@Entity
@Table(name = "wishlist_items")
public class WishlistItem implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "book_id", nullable = false)
    private Book book;

    @Column(name = "added_at")
    private LocalDateTime addedAt;

    public WishlistItem() {}

    public WishlistItem(User user, Book book) {
        this.user = user;
        this.book = book;
    }

    @PrePersist
    protected void onCreate() {
        this.addedAt = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }

    public LocalDateTime getAddedAt() { return addedAt; }
    public void setAddedAt(LocalDateTime addedAt) { this.addedAt = addedAt; }

    @Override
    public String toString() {
        return "WishlistItem{id=" + id + ", user=" + user.getFullName() + ", book=" + book.getTitle() + "}";
    }
}
