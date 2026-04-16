package com.bookleaf.app.repository;

import com.bookleaf.app.model.Role;
import com.bookleaf.app.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;


public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    boolean existsByEmail(String email);
    List<User> findByRoleAndApprovedFalse(Role role);
    long countByRoleAndApprovedFalse(Role role);
}
