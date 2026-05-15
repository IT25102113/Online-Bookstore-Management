package com.bookleaf.app.controller;

import com.bookleaf.app.model.Book;
import com.bookleaf.app.model.Review;
import com.bookleaf.app.model.User;
import com.bookleaf.app.repository.ReviewRepository;
import com.bookleaf.app.service.BookService;
import com.bookleaf.app.service.WishlistService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.Optional;

@Controller
public class BookController {

    @Autowired
    private BookService bookService;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private WishlistService wishlistService;

    @GetMapping("/book/{id}")
    public String bookDetails(@PathVariable Long id, Model model, HttpSession session) {
        Optional<Book> bookOpt = bookService.getBookById(id);
        if (bookOpt.isEmpty()) {
            return "redirect:/";
        }

        Book book = bookOpt.get();
        List<Review> reviews = reviewRepository.findByBookIdOrderByCreatedAtDesc(id);
        double avgRating = reviewRepository.getAverageRatingByBookId(id);
        long reviewCount = reviewRepository.getReviewCountByBookId(id);

        model.addAttribute("book", book);
        model.addAttribute("reviews", reviews);
        model.addAttribute("avgRating", avgRating);
        model.addAttribute("reviewCount", reviewCount);
        model.addAttribute("page", "books");

        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("isInWishlist", wishlistService.isInWishlist(user, book));
        }

        return "book_details";
    }
}
