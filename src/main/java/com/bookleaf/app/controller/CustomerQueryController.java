package com.bookleaf.app.controller;

import com.bookleaf.app.model.Query;
import com.bookleaf.app.model.QueryMessage;
import com.bookleaf.app.model.User;
import com.bookleaf.app.repository.QueryRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/queries")
public class CustomerQueryController {

    @Autowired
    private QueryRepository queryRepository;

    @Autowired
    private com.bookleaf.app.service.FileHandlingService fileHandlingService;

    @GetMapping
    public String viewQueries(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().name().equals("CUSTOMER")) return "redirect:/login";

        model.addAttribute("queries", queryRepository.findByUserIdOrderByCreatedAtDesc(user.getId()));
        model.addAttribute("page", "queries");
        return "queries";
    }

    @PostMapping("/submit")
    public String submitQuery(@RequestParam String subject, @RequestParam String message, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().name().equals("CUSTOMER")) return "redirect:/login";

        Query query = new Query(user, subject, message);
        queryRepository.save(query);
        fileHandlingService.writeQueriesToFile(queryRepository.findAll());

        redirectAttributes.addFlashAttribute("success", "Your query has been submitted successfully. We will get back to you soon!");
        return "redirect:/queries";
    }

    @PostMapping("/reply")
    public String replyToQuery(@RequestParam Long queryId, @RequestParam String reply, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().name().equals("CUSTOMER")) return "redirect:/login";

        queryRepository.findById(queryId).ifPresent(query -> {
            if (query.getUser().getId().equals(user.getId())) {
                QueryMessage qm = new QueryMessage(query, user, reply);
                query.addReply(qm);
                query.setStatus("PENDING"); // Customer replied, so it's pending admin review again
                queryRepository.save(query);
                fileHandlingService.writeQueriesToFile(queryRepository.findAll());
            }
        });
        redirectAttributes.addFlashAttribute("success", "Reply added successfully!");
        return "redirect:/queries";
    }
}
