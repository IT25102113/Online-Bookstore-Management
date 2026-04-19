package com.bookleaf.app.service;

import com.bookleaf.app.model.Author;
import com.bookleaf.app.model.Role;
import com.bookleaf.app.model.User;
import com.bookleaf.app.repository.AuthorRepository;
import com.bookleaf.app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AuthorRepository authorRepository;

    @Autowired
    private FileHandlingService fileHandlingService;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public User registerUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.CUSTOMER); // Force CUSTOMER role
        user.setApproved(true); // Customers are auto-approved
        User savedUser = userRepository.save(user);

        fileHandlingService.writeUsersToFile(userRepository.findAll());

        return savedUser;
    }

    @Override
    @Transactional
    public User registerAuthor(User user, String bio) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.AUTHOR);
        user.setApproved(false); // Authors need admin approval
        User savedUser = userRepository.save(user);

        Author author = new Author();
        author.setName(user.getFullName());
        author.setBio(bio);
        author.setUser(savedUser);
        authorRepository.save(author);

        fileHandlingService.writeUsersToFile(userRepository.findAll());
        fileHandlingService.writeAuthorsToFile(authorRepository.findAll());

        return savedUser;
    }

    @Override
    public Optional<User> login(String email, String rawPassword) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (passwordEncoder.matches(rawPassword, user.getPassword())) {
                return Optional.of(user);
            }
        }
        return Optional.empty();
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public User updateUser(User user) {
        User updated = userRepository.save(user);
        fileHandlingService.writeUsersToFile(userRepository.findAll());
        return updated;
    }

    @Override
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
        fileHandlingService.writeUsersToFile(userRepository.findAll());
    }

    @Override
    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    public List<User> getPendingAuthors() {
        return userRepository.findByRoleAndApprovedFalse(Role.AUTHOR);
    }

    @Override
    public long countPendingAuthors() {
        return userRepository.countByRoleAndApprovedFalse(Role.AUTHOR);
    }

    @Override
    @Transactional
    public void approveAuthor(Long userId) {
        userRepository.findById(userId).ifPresent(user -> {
            user.setApproved(true);
            userRepository.save(user);
            fileHandlingService.writeUsersToFile(userRepository.findAll());
        });
    }

    @Override
    @Transactional
    public void rejectAuthor(Long userId) {
        userRepository.findById(userId).ifPresent(user -> {
            authorRepository.findByUser(user).ifPresent(authorRepository::delete);
            userRepository.delete(user);
            fileHandlingService.writeUsersToFile(userRepository.findAll());
            fileHandlingService.writeAuthorsToFile(authorRepository.findAll());
        });
    }
}
