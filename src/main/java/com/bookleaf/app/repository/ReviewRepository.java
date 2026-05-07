package com.bookleaf.app.repository;

import com.bookleaf.app.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;


public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByBookIdOrderByCreatedAtDesc(Long bookId);

    @Query("SELECT COALESCE(AVG(r.rating), 0) FROM Review r WHERE r.book.id = :bookId")
    double getAverageRatingByBookId(@Param("bookId") Long bookId);

    @Query("SELECT COUNT(r) FROM Review r WHERE r.book.id = :bookId")
    long getReviewCountByBookId(@Param("bookId") Long bookId);
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
