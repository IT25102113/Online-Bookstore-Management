package com.bookleaf.app.controller;

import com.bookleaf.app.model.Book;
import com.bookleaf.app.model.User;
import com.bookleaf.app.service.BookService;
import com.bookleaf.app.service.WishlistService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;


@Controller
@RequestMapping("/wishlist")
public class WishlistController {

    @Autowired
    private WishlistService wishlistService;

    @Autowired
    private BookService bookService;

    @Autowired
    private com.bookleaf.app.service.UserService userService;

    @GetMapping("/share/{userId}")
    public String viewSharedWishlist(@PathVariable Long userId, Model model) {
        Optional<User> ownerOpt = userService.findById(userId);
        if (ownerOpt.isPresent()) {
            User owner = ownerOpt.get();
            model.addAttribute("ownerName", owner.getFullName());
            model.addAttribute("wishlistItems", wishlistService.getWishlist(owner));
        } else {
            model.addAttribute("error", "Wishlist not found.");
        }
        return "wishlist-share";
    }

    @GetMapping
    public String viewWishlist(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        model.addAttribute("wishlistItems", wishlistService.getWishlist(user));
        model.addAttribute("page", "wishlist");
        return "wishlist";
    }

    @PostMapping("/add")
    public String addToWishlist(@RequestParam Long bookId,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Optional<Book> bookOpt = bookService.getBookById(bookId);
        if (bookOpt.isPresent()) {
            wishlistService.addToWishlist(user, bookOpt.get());
            session.setAttribute("wishlistCount", wishlistService.getWishlistCount(user));
            redirectAttributes.addFlashAttribute("success", "\"" + bookOpt.get().getTitle() + "\" added to wishlist!");
        }
        return "redirect:/book/" + bookId;
    }

    @PostMapping("/remove")
    public String removeFromWishlist(@RequestParam Long bookId,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Optional<Book> bookOpt = bookService.getBookById(bookId);
        if (bookOpt.isPresent()) {
            wishlistService.removeFromWishlist(user, bookOpt.get());
            session.setAttribute("wishlistCount", wishlistService.getWishlistCount(user));
            redirectAttributes.addFlashAttribute("success", "Removed from wishlist.");
        }
        return "redirect:/wishlist";
    }

    @PostMapping("/toggle")
    public String toggleWishlist(@RequestParam Long bookId,
                                 @RequestParam(required = false) String redirectUrl,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Optional<Book> bookOpt = bookService.getBookById(bookId);
        if (bookOpt.isPresent()) {
            Book book = bookOpt.get();
            if (wishlistService.isInWishlist(user, book)) {
                wishlistService.removeFromWishlist(user, book);
                redirectAttributes.addFlashAttribute("success", "\"" + book.getTitle() + "\" removed from wishlist.");
            } else {
                wishlistService.addToWishlist(user, book);
                redirectAttributes.addFlashAttribute("success", "\"" + book.getTitle() + "\" added to wishlist!");
            }
            session.setAttribute("wishlistCount", wishlistService.getWishlistCount(user));
        }

        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            return "redirect:" + redirectUrl;
        }
        return "redirect:/";
    }
}
