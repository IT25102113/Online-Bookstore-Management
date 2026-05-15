package com.bookleaf.app.controller;

import com.bookleaf.app.model.User;
import com.bookleaf.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ProfileController {

    @Autowired
    private UserService userService;

    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        model.addAttribute("page", "profile");
        return "profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String fullName,
                                 @RequestParam String email,
                                 @RequestParam(required = false) String phone,
                                 @RequestParam(required = false) String address,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        if (user.getId() != null && user.getId() == 0L) {
            redirectAttributes.addFlashAttribute("error", "Admin profile cannot be edited.");
            return "redirect:/profile";
        }

        var userOpt = userService.findById(user.getId());
        if (userOpt.isPresent()) {
            User dbUser = userOpt.get();
            dbUser.setFullName(fullName.trim());
            dbUser.setEmail(email.trim().toLowerCase());
            if (phone != null) dbUser.setPhone(phone.trim());
            if (address != null) dbUser.setAddress(address.trim());

            User updated = userService.updateUser(dbUser);
            session.setAttribute("user", updated);

            redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
        }

        return "redirect:/profile";
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
