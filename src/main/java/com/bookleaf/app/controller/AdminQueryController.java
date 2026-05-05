package com.bookleaf.app.controller;

import com.bookleaf.app.model.Query;
import com.bookleaf.app.model.QueryMessage;
import com.bookleaf.app.model.User;
import com.bookleaf.app.repository.QueryRepository;
import com.bookleaf.app.service.NotificationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/queries")
public class AdminQueryController {

    @Autowired
    private QueryRepository queryRepository;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private com.bookleaf.app.service.FileHandlingService fileHandlingService;

    @GetMapping
    public String manageQueries(Model model) {
        model.addAttribute("queries", queryRepository.findAllByOrderByCreatedAtDesc());
        model.addAttribute("page", "manageQueries");
        return "admin/queries";
    }

    @PostMapping("/reply")
    public String replyToQuery(@RequestParam Long queryId, @RequestParam String reply, HttpSession session, RedirectAttributes redirectAttributes) {
        User adminUser = (User) session.getAttribute("user");
        if (adminUser == null || adminUser.getRole().name().equals("CUSTOMER")) return "redirect:/login";

        queryRepository.findById(queryId).ifPresent(query -> {
            QueryMessage qm = new QueryMessage(query, adminUser, reply);
            query.addReply(qm);
            query.setStatus("ANSWERED");
            queryRepository.save(query);
            fileHandlingService.writeQueriesToFile(queryRepository.findAll());
            notificationService.createNotification(query.getUser(), "Admin has replied to your query regarding '" + query.getSubject() + "'.", "QUERY_REPLY", "/queries");
        });
        redirectAttributes.addFlashAttribute("success", "Reply submitted successfully!");
        return "redirect:/admin/queries";
    }

    @PostMapping("/delete/{id}")
    public String deleteQuery(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        queryRepository.deleteById(id);
        fileHandlingService.writeQueriesToFile(queryRepository.findAll());
        redirectAttributes.addFlashAttribute("success", "Query deleted successfully!");
        return "redirect:/admin/queries";
    }
}
