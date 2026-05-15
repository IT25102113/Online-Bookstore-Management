package com.bookleaf.app.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;


@Entity
@Table(name = "discounts")
public class Discount extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(name = "discount_type", nullable = false)
    private DiscountType discountType;

    @Column(nullable = false)
    private double percentage;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "end_date")
    private LocalDate endDate;

    @Column(name = "price_cap")
    private Double priceCap;

    @Column(nullable = false)
    private boolean active = true;



    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Discount() {}

    public Discount(String name, DiscountType discountType, double percentage) {
        this.name = name;
        this.discountType = discountType;
        this.percentage = percentage;
    }

    @PrePersist
    protected void onCreate() {
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    /**
     * Check if this discount is currently valid based on dates
     */
    public boolean isCurrentlyValid() {
        if (!active) return false;
        LocalDate today = LocalDate.now();
        if (discountType == DiscountType.SEASONAL) {
            return startDate != null && endDate != null
                    && !today.isBefore(startDate) && !today.isAfter(endDate);
        }
        return true;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public DiscountType getDiscountType() { return discountType; }
    public void setDiscountType(DiscountType discountType) { this.discountType = discountType; }

    public double getPercentage() { return percentage; }
    public void setPercentage(double percentage) { this.percentage = percentage; }

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

    public Double getPriceCap() { return priceCap; }
    public void setPriceCap(Double priceCap) { this.priceCap = priceCap; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }



    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "Discount{id=" + getId() + ", name='" + name + "', type=" + discountType + ", percentage=" + percentage + "%}";
    }

    @Override
    public String getDisplayDetail() {
        return "Discount: " + name + " (" + percentage + "%)";
    }
}
