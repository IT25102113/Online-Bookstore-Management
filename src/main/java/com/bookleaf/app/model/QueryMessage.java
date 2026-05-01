package com.bookleaf.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "query_messages")
public class QueryMessage extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "query_id", nullable = false)
    private Query query;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "sender_id", nullable = false)
    private User sender;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String message;

    public QueryMessage() {}

    public QueryMessage(Query query, User sender, String message) {
        this.query = query;
        this.sender = sender;
        this.message = message;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Query getQuery() { return query; }
    public void setQuery(Query query) { this.query = query; }

    public User getSender() { return sender; }
    public void setSender(User sender) { this.sender = sender; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    @Override
    public String getDisplayDetail() {
        return "Message by " + sender.getFullName() + ": " + message;
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
