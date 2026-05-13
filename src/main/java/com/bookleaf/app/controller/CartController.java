package com.bookleaf.app.controller;

import com.bookleaf.app.model.Book;
import com.bookleaf.app.model.CartItem;
import com.bookleaf.app.model.User;
import com.bookleaf.app.service.BookService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private BookService bookService;

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<CartItem> cart = getCart(session);
        double total = cart.stream().mapToDouble(CartItem::getSubtotal).sum();

        model.addAttribute("cart", cart);
        model.addAttribute("cartTotal", total);
        model.addAttribute("page", "cart");
        return "cart";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam Long bookId,
                            @RequestParam(defaultValue = "HARDCOPY") String format,
                            @RequestParam(defaultValue = "1") int quantity,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Optional<Book> bookOpt = bookService.getBookById(bookId);
        if (bookOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Book not found.");
            return "redirect:/";
        }

        Book book = bookOpt.get();
        if (quantity > book.getQuantity()) {
            redirectAttributes.addFlashAttribute("error", "Not enough stock available.");
            return "redirect:/book/" + bookId;
        }

        double unitPrice = book.getPrice();
        if ("EBOOK".equals(format) && book.isHasEbook()) {
            unitPrice = book.getPrice() * 0.80;
        }

        List<CartItem> cart = getCart(session);

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getBookId().equals(bookId) && item.getFormat().equals(format)) {
                item.setQuantity(item.getQuantity() + quantity);
                found = true;
                break;
            }
        }

        if (!found) {
            String authorName = book.getAuthor() != null ? book.getAuthor().getName() : "Unknown Author";
            CartItem newItem = new CartItem(book.getId(), book.getTitle(), book.getImageUrl(),
                    authorName, format, unitPrice, quantity);
            cart.add(newItem);
        }

        session.setAttribute("cart", cart);
        redirectAttributes.addFlashAttribute("success", "\"" + book.getTitle() + "\" added to cart!");
        return "redirect:/book/" + bookId;
    }

    @PostMapping("/remove")
    public String removeFromCart(@RequestParam int index,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        List<CartItem> cart = getCart(session);
        if (index >= 0 && index < cart.size()) {
            String title = cart.get(index).getBookTitle();
            cart.remove(index);
            session.setAttribute("cart", cart);
            redirectAttributes.addFlashAttribute("success", "\"" + title + "\" removed from cart.");
        }
        return "redirect:/cart";
    }

    @PostMapping("/update")
    public String updateQuantity(@RequestParam int index,
                                  @RequestParam int quantity,
                                  HttpSession session) {
        List<CartItem> cart = getCart(session);
        if (index >= 0 && index < cart.size() && quantity > 0) {
            cart.get(index).setQuantity(quantity);
            session.setAttribute("cart", cart);
        }
        return "redirect:/cart";
    }

    @PostMapping("/clear")
    public String clearCart(HttpSession session, RedirectAttributes redirectAttributes) {
        session.removeAttribute("cart");
        redirectAttributes.addFlashAttribute("success", "Cart cleared successfully.");
        return "redirect:/cart";
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }
}
