package com.bookleaf.app.service;

import com.bookleaf.app.model.Notification;
import com.bookleaf.app.model.User;
import com.bookleaf.app.repository.NotificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificationServiceImpl implements NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private FileHandlingService fileHandlingService;

    @Override
    public void createNotification(User user, String message, String type, String targetUrl) {
        Notification notification = new Notification(user, message, type, targetUrl);
        notificationRepository.save(notification);
        fileHandlingService.writeNotificationsToFile(notificationRepository.findAll());
    }

    @Override
    public List<Notification> getUserNotifications(Long userId) {
        return notificationRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    @Override
    public List<Notification> getUnreadNotifications(Long userId) {
        return notificationRepository.findByUserIdAndIsReadFalse(userId);
    }

    @Override
    public void markAsRead(Long notificationId) {
        notificationRepository.findById(notificationId).ifPresent(notification -> {
            notification.setRead(true);
            notificationRepository.save(notification);
            fileHandlingService.writeNotificationsToFile(notificationRepository.findAll());
        });
    }

    @Override
    public void markAllAsRead(Long userId) {
        List<Notification> unread = notificationRepository.findByUserIdAndIsReadFalse(userId);
        unread.forEach(n -> n.setRead(true));
        notificationRepository.saveAll(unread);
        fileHandlingService.writeNotificationsToFile(notificationRepository.findAll());
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
