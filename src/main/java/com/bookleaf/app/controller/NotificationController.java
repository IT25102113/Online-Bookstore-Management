package com.bookleaf.app.controller;

import com.bookleaf.app.model.User;
import com.bookleaf.app.service.NotificationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/notifications")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @GetMapping
    public String viewNotifications(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        model.addAttribute("notifications", notificationService.getUserNotifications(user.getId()));
        model.addAttribute("page", "notifications");
        return "notifications";
    }

    @PostMapping("/read")
    public String markAsRead(@RequestParam Long notificationId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        
        notificationService.markAsRead(notificationId);
        
        return notificationService.getUserNotifications(user.getId()).stream()
                .filter(n -> n.getId().equals(notificationId))
                .findFirst()
                .map(n -> n.getTargetUrl() != null ? "redirect:" + n.getTargetUrl() : "redirect:/notifications")
                .orElse("redirect:/notifications");
    }

    @PostMapping("/read-all")
    public String markAllAsRead(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        
        notificationService.markAllAsRead(user.getId());
        return "redirect:/notifications";
    }
}
