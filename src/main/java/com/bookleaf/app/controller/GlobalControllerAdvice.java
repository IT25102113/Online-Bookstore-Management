package com.bookleaf.app.controller;

import com.bookleaf.app.model.User;
import com.bookleaf.app.service.NotificationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    @Autowired
    private NotificationService notificationService;

    @ModelAttribute("unreadNotificationsCount")
    public int getUnreadNotificationsCount(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            return notificationService.getUnreadNotifications(user.getId()).size();
        }
        return 0;
    }
}
