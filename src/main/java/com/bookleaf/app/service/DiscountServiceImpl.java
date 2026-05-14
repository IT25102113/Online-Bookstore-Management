package com.bookleaf.app.service;

import com.bookleaf.app.model.Discount;
import com.bookleaf.app.model.DiscountType;
import com.bookleaf.app.model.User;
import com.bookleaf.app.repository.DiscountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;


@Service
public class DiscountServiceImpl implements DiscountService {

    @Autowired
    private DiscountRepository discountRepository;

    @Autowired
    private FileHandlingService fileHandlingService;

    @Override
    public List<Discount> getAllDiscounts() {
        return discountRepository.findAll();
    }

    @Override
    public Optional<Discount> getDiscountById(Long id) {
        return discountRepository.findById(id);
    }

    @Override
    public Discount saveDiscount(Discount discount) {
        Discount saved = discountRepository.save(discount);
        fileHandlingService.writeDiscountsToFile(discountRepository.findAll());
        return saved;
    }

    @Override
    public void deleteDiscount(Long id) {
        discountRepository.deleteById(id);
        fileHandlingService.writeDiscountsToFile(discountRepository.findAll());
    }

    @Override
    public void toggleDiscount(Long id) {
        discountRepository.findById(id).ifPresent(discount -> {
            discount.setActive(!discount.isActive());
            discountRepository.save(discount);
            fileHandlingService.writeDiscountsToFile(discountRepository.findAll());
        });
    }

    @Override
    public List<Discount> getActiveDiscounts() {
        return discountRepository.findByActiveTrue();
    }

    /**
     * Find the best applicable discount for the given user and cart total.
     * Priority: PRICE_CAP > SEASONAL > NEW_USER_BONUS
     */
    @Override
    public Optional<Discount> getBestDiscount(User user, double cartTotal) {
        List<Discount> activeDiscounts = discountRepository.findByActiveTrue();
        Discount bestDiscount = null;
        double bestPercentage = 0;

        for (Discount discount : activeDiscounts) {
            if (!discount.isCurrentlyValid()) continue;

            switch (discount.getDiscountType()) {
                case PRICE_CAP:
                    if (discount.getPriceCap() != null && cartTotal >= discount.getPriceCap()) {
                        if (discount.getPercentage() > bestPercentage) {
                            bestDiscount = discount;
                            bestPercentage = discount.getPercentage();
                        }
                    }
                    break;

                case SEASONAL:
                    if (discount.getPercentage() > bestPercentage) {
                        bestDiscount = discount;
                        bestPercentage = discount.getPercentage();
                    }
                    break;

                case NEW_USER_BONUS:
                    if (user != null && user.getCreatedAt() != null) {
                        long daysSinceRegistration = ChronoUnit.DAYS.between(
                                user.getCreatedAt().toLocalDate(), LocalDate.now());
                        if (daysSinceRegistration <= 30) {
                            if (discount.getPercentage() > bestPercentage) {
                                bestDiscount = discount;
                                bestPercentage = discount.getPercentage();
                            }
                        }
                    }
                    break;
            }
        }

        return Optional.ofNullable(bestDiscount);
    }

    @Override
    public double calculateDiscountedTotal(double originalTotal, User user) {
        Optional<Discount> bestDiscount = getBestDiscount(user, originalTotal);
        if (bestDiscount.isPresent()) {
            double discountAmount = originalTotal * (bestDiscount.get().getPercentage() / 100.0);
            return Math.max(0, originalTotal - discountAmount);
        }
        return originalTotal;
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
