package com.bookleaf.app.service;

import com.bookleaf.app.model.User;
import java.util.List;
import java.util.Optional;


public interface UserService {
    User registerUser(User user);
    User registerAuthor(User user, String bio);
    Optional<User> login(String email, String rawPassword);
    Optional<User> findByEmail(String email);
    Optional<User> findById(Long id);
    List<User> getAllUsers();
    User updateUser(User user);
    void deleteUser(Long id);
    boolean emailExists(String email);
    List<User> getPendingAuthors();
    long countPendingAuthors();
    void approveAuthor(Long userId);
    void rejectAuthor(Long userId);
}
