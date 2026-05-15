package com.bookleaf.app.controller;

import com.bookleaf.app.model.Author;
import com.bookleaf.app.model.Book;
import com.bookleaf.app.model.Role;
import com.bookleaf.app.model.User;
import com.bookleaf.app.repository.AuthorRepository;
import com.bookleaf.app.repository.BookRepository;
import com.bookleaf.app.service.BookService;
import com.bookleaf.app.service.FileHandlingService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;


@Controller
@RequestMapping("/author")
public class AuthorDashboardController {

    @Autowired
    private BookService bookService;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private AuthorRepository authorRepository;

    @Autowired
    private FileHandlingService fileHandlingService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.AUTHOR) {
            return "redirect:/login";
        }

        Author author = authorRepository.findByUser(user).orElse(null);
        if (author == null) {
            return "redirect:/login";
        }

        List<Book> authorBooks = bookRepository.findByAuthor(author);
        model.addAttribute("author", author);
        model.addAttribute("books", authorBooks);
        model.addAttribute("totalBooks", authorBooks.size());
        model.addAttribute("page", "authorDashboard");
        return "author/dashboard";
    }

    @PostMapping("/books/add")
    public String addBook(@RequestParam String title,
                          @RequestParam(required = false) String isbn,
                          @RequestParam(required = false) String category,
                          @RequestParam(required = false) String description,
                          @RequestParam double price,
                          @RequestParam int quantity,
                          @RequestParam(required = false) String imageUrl,
                          @RequestParam(required = false) Boolean hasEbook,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.AUTHOR) {
            return "redirect:/login";
        }

        Author author = authorRepository.findByUser(user).orElse(null);
        if (author == null) {
            return "redirect:/login";
        }

        Book book = new Book();
        book.setTitle(title.trim());
        book.setIsbn(isbn);
        book.setCategory(category);
        book.setDescription(description);
        book.setPrice(price);
        book.setQuantity(quantity);
        book.setImageUrl(imageUrl);
        book.setHasEbook(hasEbook != null && hasEbook);
        book.setAuthor(author);

        bookService.saveBook(book);
        redirectAttributes.addFlashAttribute("success", "Book \"" + title + "\" added successfully!");
        return "redirect:/author/dashboard";
    }

    @PostMapping("/books/update")
    public String updateBook(@RequestParam Long id,
                             @RequestParam String title,
                             @RequestParam(required = false) String isbn,
                             @RequestParam(required = false) String category,
                             @RequestParam(required = false) String description,
                             @RequestParam double price,
                             @RequestParam int quantity,
                             @RequestParam(required = false) String imageUrl,
                             @RequestParam(required = false) Boolean hasEbook,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.AUTHOR) {
            return "redirect:/login";
        }

        Author author = authorRepository.findByUser(user).orElse(null);
        if (author == null) return "redirect:/login";

        var bookOpt = bookService.getBookById(id);
        if (bookOpt.isPresent()) {
            Book book = bookOpt.get();
            if (book.getAuthor() != null && book.getAuthor().getId().equals(author.getId())) {
                book.setTitle(title.trim());
                book.setIsbn(isbn);
                book.setCategory(category);
                book.setDescription(description);
                book.setPrice(price);
                book.setQuantity(quantity);
                book.setImageUrl(imageUrl);
                book.setHasEbook(hasEbook != null && hasEbook);

                bookService.saveBook(book);
                redirectAttributes.addFlashAttribute("success", "Book updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "You can only edit your own books.");
            }
        }
        return "redirect:/author/dashboard";
    }

    @PostMapping("/books/delete/{id}")
    public String deleteBook(@PathVariable Long id,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.AUTHOR) {
            return "redirect:/login";
        }

        Author author = authorRepository.findByUser(user).orElse(null);
        if (author == null) return "redirect:/login";

        var bookOpt = bookService.getBookById(id);
        if (bookOpt.isPresent()) {
            Book book = bookOpt.get();
            if (book.getAuthor() != null && book.getAuthor().getId().equals(author.getId())) {
                bookService.deleteBook(id);
                redirectAttributes.addFlashAttribute("success", "Book deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "You can only delete your own books.");
            }
        }
        return "redirect:/author/dashboard";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String name,
                                @RequestParam(required = false) String bio,
                                @RequestParam(required = false) String imageUrl,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.AUTHOR) {
            return "redirect:/login";
        }

        Author author = authorRepository.findByUser(user).orElse(null);
        if (author == null) return "redirect:/login";

        author.setName(name.trim());
        author.setBio(bio != null ? bio.trim() : null);
        author.setImageUrl(imageUrl != null && !imageUrl.trim().isEmpty() ? imageUrl.trim() : null);
        authorRepository.save(author);

        fileHandlingService.writeAuthorsToFile(authorRepository.findAll());
        redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
        return "redirect:/author/dashboard";
    }
}
