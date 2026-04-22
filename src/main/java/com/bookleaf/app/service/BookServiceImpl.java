package com.bookleaf.app.service;

import com.bookleaf.app.model.Book;
import com.bookleaf.app.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private FileHandlingService fileHandlingService;

    @Override
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    @Override
    public Optional<Book> getBookById(Long id) {
        return bookRepository.findById(id);
    }

    @Override
    public Book saveBook(Book book) {
        Book saved = bookRepository.save(book);
        fileHandlingService.writeBooksToFile(bookRepository.findAll());
        return saved;
    }

    @Override
    public void deleteBook(Long id) {
        bookRepository.deleteById(id);
        fileHandlingService.writeBooksToFile(bookRepository.findAll());
    }

    @Override
    public List<Book> searchBooks(String query) {
        return bookRepository.searchBooks(query);
    }

    @Override
    public List<Book> getBooksByCategory(String category) {
        return bookRepository.findByCategory(category);
    }

    @Override
    public List<String> getAllCategories() {
        return bookRepository.findAllCategories();
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
