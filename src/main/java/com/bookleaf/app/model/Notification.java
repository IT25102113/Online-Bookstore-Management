package com.bookleaf.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "notifications")
public class Notification extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false)
    private String message;

    @Column(nullable = false)
    private String type; // ORDER_UPDATE, REVIEW_REPLY, QUERY_REPLY

    @Column
    private String targetUrl;

    @Column(nullable = false)
    private boolean isRead = false;

    public Notification() {}

    public Notification(User user, String message, String type, String targetUrl) {
        this.user = user;
        this.message = message;
        this.type = type;
        this.targetUrl = targetUrl;
        this.isRead = false;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getTargetUrl() { return targetUrl; }
    public void setTargetUrl(String targetUrl) { this.targetUrl = targetUrl; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { isRead = read; }

    @Override
    public String getDisplayDetail() {
        return "Notification: " + message + " (" + (isRead ? "Read" : "Unread") + ")";
    }
}
