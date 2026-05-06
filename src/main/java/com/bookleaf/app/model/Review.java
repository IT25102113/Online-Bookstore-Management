package com.bookleaf.app.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;


@Entity
@Table(name = "reviews")
public class Review extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "book_id", nullable = false)
    private Book book;

    @Column(nullable = false)
    private int rating;

    @Column(columnDefinition = "TEXT")
    private String comment;

    @Column(name = "admin_reply", columnDefinition = "TEXT")
    private String adminReply;



    public Review() {}

    public Review(User user, Book book, int rating, String comment) {
        this.user = user;
        this.book = book;
        this.rating = rating;
        this.comment = comment;
    }



    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public String getAdminReply() { return adminReply; }
    public void setAdminReply(String adminReply) { this.adminReply = adminReply; }


    @Override
    public String getDisplayDetail() {
        return "Review for " + (book != null ? book.getTitle() : "Unknown") + " - Rating: " + rating;
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
