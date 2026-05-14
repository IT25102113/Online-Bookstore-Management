package com.bookleaf.app.service;

import com.bookleaf.app.model.Discount;
import com.bookleaf.app.model.DiscountType;
import com.bookleaf.app.model.User;

import java.util.List;
import java.util.Optional;


public interface DiscountService {
    List<Discount> getAllDiscounts();
    Optional<Discount> getDiscountById(Long id);
    Discount saveDiscount(Discount discount);
    void deleteDiscount(Long id);
    void toggleDiscount(Long id);
    List<Discount> getActiveDiscounts();
    Optional<Discount> getBestDiscount(User user, double cartTotal);
    double calculateDiscountedTotal(double originalTotal, User user);
}
