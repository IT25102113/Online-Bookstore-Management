package com.bookleaf.app.controller;

import com.bookleaf.app.repository.ReviewRepository;
import com.bookleaf.app.repository.ReviewRepository;
import com.bookleaf.app.service.FileHandlingService;
import com.bookleaf.app.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("/admin/reviews")
public class AdminReviewController {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private FileHandlingService fileHandlingService;

    @Autowired
    private NotificationService notificationService;

    @GetMapping
    public String manageReviews(Model model) {
        model.addAttribute("reviews", reviewRepository.findAll());
        model.addAttribute("page", "manageReviews");
        return "admin/reviews";
    }

    @PostMapping("/delete/{id}")
    public String deleteReview(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        reviewRepository.deleteById(id);
        fileHandlingService.writeReviewsToFile(reviewRepository.findAll());
        redirectAttributes.addFlashAttribute("success", "Review deleted successfully!");
        return "redirect:/admin/reviews";
    }

    @PostMapping("/reply")
    public String replyToReview(@RequestParam Long reviewId, @RequestParam String reply, RedirectAttributes redirectAttributes) {
        reviewRepository.findById(reviewId).ifPresent(review -> {
            review.setAdminReply(reply);
            reviewRepository.save(review);
            fileHandlingService.writeReviewsToFile(reviewRepository.findAll());
            notificationService.createNotification(review.getUser(), "Admin has replied to your review for '" + review.getBook().getTitle() + "'.", "REVIEW_REPLY", "/book/" + review.getBook().getId());
        });
        redirectAttributes.addFlashAttribute("success", "Reply submitted successfully!");
        return "redirect:/admin/reviews";
    }
}
