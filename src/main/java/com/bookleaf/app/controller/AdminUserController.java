package com.bookleaf.app.controller;

import com.bookleaf.app.model.User;
import com.bookleaf.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("/admin/users")
public class AdminUserController {

    @Autowired
    private UserService userService;

    @GetMapping
    public String manageUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        model.addAttribute("pendingAuthorsList", userService.getPendingAuthors());
        model.addAttribute("pendingAuthors", userService.countPendingAuthors());
        model.addAttribute("page", "manageUsers");
        return "admin/users";
    }

    @PostMapping("/delete/{id}")
    public String deleteUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        userService.deleteUser(id);
        redirectAttributes.addFlashAttribute("success", "User deleted successfully!");
        return "redirect:/admin/users";
    }

    @PostMapping("/update")
    public String updateUser(@RequestParam Long id,
                              @RequestParam String fullName,
                              @RequestParam String email,
                              @RequestParam(required = false) String phone,
                              @RequestParam(required = false) String address,
                              RedirectAttributes redirectAttributes) {
        var userOpt = userService.findById(id);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setFullName(fullName.trim());
            user.setEmail(email.trim().toLowerCase());
            if (phone != null) user.setPhone(phone.trim());
            if (address != null) user.setAddress(address.trim());
            userService.updateUser(user);
            redirectAttributes.addFlashAttribute("success", "User \"" + fullName + "\" updated successfully!");
        }
        return "redirect:/admin/users";
    }

    @PostMapping("/approve/{id}")
    public String approveAuthor(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        userService.approveAuthor(id);
        redirectAttributes.addFlashAttribute("success", "Author approved successfully! They can now login.");
        return "redirect:/admin/users";
    }

    @PostMapping("/reject/{id}")
    public String rejectAuthor(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        userService.rejectAuthor(id);
        redirectAttributes.addFlashAttribute("success", "Author registration rejected and removed.");
        return "redirect:/admin/users";
    }
}
