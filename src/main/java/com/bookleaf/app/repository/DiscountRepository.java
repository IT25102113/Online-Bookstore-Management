package com.bookleaf.app.repository;

import com.bookleaf.app.model.Discount;
import com.bookleaf.app.model.DiscountType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface DiscountRepository extends JpaRepository<Discount, Long> {
    List<Discount> findByActiveTrue();
    List<Discount> findByDiscountTypeAndActiveTrue(DiscountType discountType);
}
