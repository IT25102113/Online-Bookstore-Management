package com.bookleaf.app.repository;

import com.bookleaf.app.model.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QueryRepository extends JpaRepository<Query, Long> {
    List<Query> findByUserIdOrderByCreatedAtDesc(Long userId);
    List<Query> findAllByOrderByCreatedAtDesc();
}
