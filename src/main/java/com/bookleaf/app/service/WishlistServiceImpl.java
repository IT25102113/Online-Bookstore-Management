package com.bookleaf.app.service;

import com.bookleaf.app.model.Book;
import com.bookleaf.app.model.User;
import com.bookleaf.app.model.WishlistItem;
import com.bookleaf.app.repository.WishlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class WishlistServiceImpl implements WishlistService {

    @Autowired
    private WishlistRepository wishlistRepository;

    @Autowired
    private FileHandlingService fileHandlingService;

    @Override
    public WishlistItem addToWishlist(User user, Book book) {
        if (wishlistRepository.existsByUserAndBook(user, book)) {
            return wishlistRepository.findByUserAndBook(user, book).orElse(null);
        }
        WishlistItem item = new WishlistItem(user, book);
        WishlistItem saved = wishlistRepository.save(item);
        fileHandlingService.writeWishlistToFile(wishlistRepository.findByUser(user), user);
        return saved;
    }

    @Override
    @Transactional
    public void removeFromWishlist(User user, Book book) {
        wishlistRepository.deleteByUserAndBook(user, book);
        fileHandlingService.writeWishlistToFile(wishlistRepository.findByUser(user), user);
    }

    @Override
    public List<WishlistItem> getWishlist(User user) {
        return wishlistRepository.findByUser(user);
    }

    @Override
    public boolean isInWishlist(User user, Book book) {
        return wishlistRepository.existsByUserAndBook(user, book);
    }

    @Override
    public long getWishlistCount(User user) {
        return wishlistRepository.countByUser(user);
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
