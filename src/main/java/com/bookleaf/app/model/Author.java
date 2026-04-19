package com.bookleaf.app.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;


@Entity
@Table(name = "authors")
public class Author extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String bio;

    @Column(name = "image_url", length = 500)
    private String imageUrl;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User user;



    public Author() {}

    public Author(String name, String bio) {
        this.name = name;
        this.bio = bio;
    }



    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }



    @Override
    public String toString() {
        return "Author{id=" + getId() + ", name='" + name + "'}";
    }

    @Override
    public String getDisplayDetail() {
        return "Author: " + this.name;
    }
}
