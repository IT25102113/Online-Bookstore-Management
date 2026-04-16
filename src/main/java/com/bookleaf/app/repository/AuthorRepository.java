package com.bookleaf.app.repository;

import com.bookleaf.app.model.Author;
import com.bookleaf.app.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;


public interface AuthorRepository extends JpaRepository<Author, Long> {
    Optional<Author> findByUser(User user);
}
