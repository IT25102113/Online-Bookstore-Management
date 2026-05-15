package com.bookleaf.app.controller;

import com.bookleaf.app.model.Role;
import com.bookleaf.app.model.User;
import com.bookleaf.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole() == Role.ADMIN) {
                return "redirect:/admin/dashboard";
            }
            if (user.getRole() == Role.AUTHOR) {
                return "redirect:/author/dashboard";
            }
            return "redirect:/";
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {

        if ("admin@gmail.com".equals(email) && "oop".equals(password)) {
            var adminOpt = userService.findByEmail("admin@gmail.com");
            User admin;
            if (adminOpt.isPresent()) {
                admin = adminOpt.get();
                if (admin.getRole() != Role.ADMIN) {
                    admin.setRole(Role.ADMIN);
                    userService.updateUser(admin);
                }
            } else {
                admin = new User();
                admin.setFullName("Administrator");
                admin.setEmail("admin@gmail.com");
                admin.setPassword("oop");
                admin.setRole(Role.ADMIN);
                admin.setApproved(true);
                admin = userService.updateUser(admin); // update bypasses the customer role enforcement
            }
            session.setAttribute("user", admin);
            return "redirect:/admin/dashboard";
        }

        var userOpt = userService.login(email, password);
        if (userOpt.isPresent()) {
            User user = userOpt.get();

            if (user.getRole() == Role.AUTHOR && !user.isApproved()) {
                redirectAttributes.addFlashAttribute("error",
                        "Your author account is pending approval. Please wait for admin to approve your registration.");
                return "redirect:/login";
            }

            session.setAttribute("user", user);

            if (user.getRole() == Role.AUTHOR) {
                return "redirect:/author/dashboard";
            }
            return "redirect:/";
        }

        redirectAttributes.addFlashAttribute("error", "Invalid email or password. Please try again.");
        return "redirect:/login";
    }

    @GetMapping("/register")
    public String showRegisterPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/";
        }
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String fullName,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam(required = false) String phone,
                           @RequestParam(required = false) String address,
                           @RequestParam(defaultValue = "CUSTOMER") String registerAs,
                           @RequestParam(required = false) String bio,
                           RedirectAttributes redirectAttributes) {

        if (fullName == null || fullName.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Full name is required.");
            return "redirect:/register";
        }
        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            redirectAttributes.addFlashAttribute("error", "Please enter a valid email address.");
            return "redirect:/register";
        }
        if (password == null || password.length() < 6) {
            redirectAttributes.addFlashAttribute("error", "Password must be at least 6 characters.");
            return "redirect:/register";
        }
        if (userService.emailExists(email)) {
            redirectAttributes.addFlashAttribute("error", "This email is already registered.");
            return "redirect:/register";
        }

        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(email.trim().toLowerCase());
        user.setPassword(password);
        user.setPhone(phone);
        user.setAddress(address);

        if ("AUTHOR".equals(registerAs)) {
            userService.registerAuthor(user, bio != null ? bio.trim() : "");
            redirectAttributes.addFlashAttribute("success",
                    "Author account created! Please wait for admin approval before logging in.");
        } else {
            userService.registerUser(user);
            redirectAttributes.addFlashAttribute("success", "Account created successfully! Please login.");
        }

        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
