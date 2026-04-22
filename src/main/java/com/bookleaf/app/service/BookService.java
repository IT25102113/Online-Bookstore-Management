package com.bookleaf.app.service;

import com.bookleaf.app.model.Book;
import java.util.List;
import java.util.Optional;


public interface BookService {
    List<Book> getAllBooks();
    Optional<Book> getBookById(Long id);
    Book saveBook(Book book);
    void deleteBook(Long id);
    List<Book> searchBooks(String query);
    List<Book> getBooksByCategory(String category);
    List<String> getAllCategories();
}
