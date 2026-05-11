package com.bookleaf.app.service;

import com.bookleaf.app.model.Book;
import com.bookleaf.app.model.User;
import com.bookleaf.app.model.WishlistItem;

import java.util.List;


public interface WishlistService {
    WishlistItem addToWishlist(User user, Book book);
    void removeFromWishlist(User user, Book book);
    List<WishlistItem> getWishlist(User user);
    boolean isInWishlist(User user, Book book);
    long getWishlistCount(User user);
}
