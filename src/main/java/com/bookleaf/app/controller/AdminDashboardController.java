package com.bookleaf.app.controller;

import com.bookleaf.app.model.Role;
import com.bookleaf.app.repository.BookRepository;
import com.bookleaf.app.repository.UserRepository;
import com.bookleaf.app.repository.ReviewRepository;
import com.bookleaf.app.service.DiscountService;
import com.bookleaf.app.service.OrderService;
import com.bookleaf.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin")
public class AdminDashboardController {

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private OrderService orderService;

    @Autowired
    private UserService userService;

    @Autowired
    private DiscountService discountService;

    private static double revenueDeduction = 0.0;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        double currentRevenue = orderService.getTotalRevenue() - revenueDeduction;
        if (currentRevenue < 0) currentRevenue = 0;

        model.addAttribute("totalBooks", bookRepository.count());
        model.addAttribute("totalUsers", userRepository.count());
        model.addAttribute("totalOrders", orderService.getTotalOrders());
        model.addAttribute("totalRevenue", currentRevenue);
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("pendingAuthors", userService.countPendingAuthors());
        model.addAttribute("activeDiscounts", discountService.getActiveDiscounts().size());
        model.addAttribute("page", "dashboard");
        return "admin/dashboard";
    }

    @PostMapping("/dashboard/reset-revenue")
    public String resetRevenue() {
        revenueDeduction = orderService.getTotalRevenue();
        return "redirect:/admin/dashboard";
    }
}
