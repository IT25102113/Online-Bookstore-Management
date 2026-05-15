package com.bookleaf.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "queries")
public class Query extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false)
    private String subject;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String message;

    @OneToMany(mappedBy = "query", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private java.util.List<QueryMessage> replies = new java.util.ArrayList<>();

    @Column(nullable = false)
    private String status = "PENDING"; // PENDING, ANSWERED

    public Query() {}

    public Query(User user, String subject, String message) {
        this.user = user;
        this.subject = subject;
        this.message = message;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public java.util.List<QueryMessage> getReplies() { return replies; }
    public void setReplies(java.util.List<QueryMessage> replies) { this.replies = replies; }
    public void addReply(QueryMessage reply) { this.replies.add(reply); }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String getDisplayDetail() {
        return "Query: " + subject + " - " + status;
    }
}
