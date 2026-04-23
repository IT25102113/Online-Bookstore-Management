package com.bookleaf.app.controller;

import com.bookleaf.app.model.Author;
import com.bookleaf.app.model.Book;
import com.bookleaf.app.repository.AuthorRepository;
import com.bookleaf.app.service.BookService;
import com.bookleaf.app.service.FileHandlingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("/admin/books")
public class AdminBookController {

    @Autowired
    private BookService bookService;

    @Autowired
    private AuthorRepository authorRepository;

    @GetMapping
    public String manageBooks(Model model) {
        model.addAttribute("books", bookService.getAllBooks());
        model.addAttribute("authors", authorRepository.findAll());
        model.addAttribute("page", "manageBooks");
        return "admin/books";
    }

    @PostMapping("/add")
    public String addBook(@RequestParam String title,
                           @RequestParam(required = false) String isbn,
                           @RequestParam(required = false) String category,
                           @RequestParam(required = false) String description,
                           @RequestParam double price,
                           @RequestParam int quantity,
                           @RequestParam(required = false) String imageUrl,
                           @RequestParam(required = false) Long authorId,
                           @RequestParam(required = false) Boolean hasEbook,
                           RedirectAttributes redirectAttributes) {
        Book book = new Book();
        book.setTitle(title.trim());
        book.setIsbn(isbn);
        book.setCategory(category);
        book.setDescription(description);
        book.setPrice(price);
        book.setQuantity(quantity);
        book.setImageUrl(imageUrl);
        book.setHasEbook(hasEbook != null && hasEbook);

        if (authorId != null) {
            authorRepository.findById(authorId).ifPresent(book::setAuthor);
        }

        bookService.saveBook(book);
        redirectAttributes.addFlashAttribute("success", "Book \"" + title + "\" added successfully!");
        return "redirect:/admin/books";
    }

    @PostMapping("/update")
    public String updateBook(@RequestParam Long id,
                              @RequestParam String title,
                              @RequestParam(required = false) String isbn,
                              @RequestParam(required = false) String category,
                              @RequestParam(required = false) String description,
                              @RequestParam double price,
                              @RequestParam int quantity,
                              @RequestParam(required = false) String imageUrl,
                              @RequestParam(required = false) Long authorId,
                              @RequestParam(required = false) Boolean hasEbook,
                              RedirectAttributes redirectAttributes) {
        var bookOpt = bookService.getBookById(id);
        if (bookOpt.isPresent()) {
            Book book = bookOpt.get();
            book.setTitle(title.trim());
            book.setIsbn(isbn);
            book.setCategory(category);
            book.setDescription(description);
            book.setPrice(price);
            book.setQuantity(quantity);
            book.setImageUrl(imageUrl);
            book.setHasEbook(hasEbook != null && hasEbook);

            if (authorId != null) {
                authorRepository.findById(authorId).ifPresent(book::setAuthor);
            } else {
                book.setAuthor(null);
            }

            bookService.saveBook(book);
            redirectAttributes.addFlashAttribute("success", "Book updated successfully!");
        }
        return "redirect:/admin/books";
    }

    @PostMapping("/delete/{id}")
    public String deleteBook(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        bookService.deleteBook(id);
        redirectAttributes.addFlashAttribute("success", "Book deleted successfully!");
        return "redirect:/admin/books";
    }
}
