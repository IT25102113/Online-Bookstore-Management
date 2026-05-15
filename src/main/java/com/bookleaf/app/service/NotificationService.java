package com.bookleaf.app.service;

import com.bookleaf.app.model.Notification;
import com.bookleaf.app.model.User;

import java.util.List;

public interface NotificationService {
    void createNotification(User user, String message, String type, String targetUrl);
    List<Notification> getUserNotifications(Long userId);
    List<Notification> getUnreadNotifications(Long userId);
    void markAsRead(Long notificationId);
    void markAllAsRead(Long userId);
}
