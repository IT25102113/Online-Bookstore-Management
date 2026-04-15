package com.bookleaf.app.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * BaseEntity - Abstract base class to demonstrate Inheritance and Polymorphism.
 * Provides common fields (createdAt) and abstract methods for subclass implementation.
 */
@MappedSuperclass
public abstract class BaseEntity implements Serializable {

    @Column(name = "created_at", updatable = false)
    protected LocalDateTime createdAt;

    @PrePersist
    protected void onBaseCreate() {
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }
    }

    public LocalDateTime getCreatedAt() { 
        return createdAt; 
    }
    
    public void setCreatedAt(LocalDateTime createdAt) { 
        this.createdAt = createdAt; 
    }

    /**
     * Abstract method to force subclasses to implement their own display logic.
     * Demonstrates Polymorphism through method overriding.
     */
    public abstract String getDisplayDetail();
}
