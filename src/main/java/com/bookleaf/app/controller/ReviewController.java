package com.bookleaf.app.controller;

import com.bookleaf.app.model.Book;
import com.bookleaf.app.model.Review;
import com.bookleaf.app.model.User;
import com.bookleaf.app.repository.ReviewRepository;
import com.bookleaf.app.service.BookService;
import com.bookleaf.app.service.FileHandlingService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;


@Controller
public class ReviewController {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private BookService bookService;

    @Autowired
    private FileHandlingService fileHandlingService;

    @PostMapping("/review/submit")
    public String submitReview(@RequestParam Long bookId,
                                @RequestParam int rating,
                                @RequestParam(required = false) String comment,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        if (rating < 1 || rating > 5) {
            redirectAttributes.addFlashAttribute("error", "Rating must be between 1 and 5 stars.");
            return "redirect:/book/" + bookId;
        }

        Optional<Book> bookOpt = bookService.getBookById(bookId);
        if (bookOpt.isEmpty()) {
            return "redirect:/";
        }

        Review review = new Review();
        review.setUser(user);
        review.setBook(bookOpt.get());
        review.setRating(rating);
        review.setComment(comment != null ? comment.trim() : "");

        reviewRepository.save(review);
        fileHandlingService.writeReviewsToFile(reviewRepository.findAll());

        redirectAttributes.addFlashAttribute("success", "Thank you for your review!");
        return "redirect:/book/" + bookId;
    }
}
