package com.bookleaf.app.controller;

import com.bookleaf.app.model.Book;
import com.bookleaf.app.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Controller
public class LandingController {

    @Autowired
    private BookService bookService;

    @GetMapping("/")
    public String index(Model model,
                        @RequestParam(required = false) String query,
                        @RequestParam(required = false) String category) {
        List<Book> books;

        if (query != null && !query.trim().isEmpty()) {
            books = bookService.searchBooks(query.trim());
            model.addAttribute("searchQuery", query);
        } else if (category != null && !category.trim().isEmpty()) {
            books = bookService.getBooksByCategory(category);
            model.addAttribute("selectedCategory", category);
        } else {
            books = bookService.getAllBooks();
        }

        model.addAttribute("books", books);
        model.addAttribute("categories", bookService.getAllCategories());
        model.addAttribute("page", "home");
        return "index";
    }

    @GetMapping("/books")
    public String browseBooks(Model model,
                              @RequestParam(required = false) String query,
                              @RequestParam(required = false) String category) {
        return index(model, query, category);
    }

    @GetMapping("/about")
    public String aboutPage(Model model) {
        model.addAttribute("page", "about");
        return "about";
    }
}
