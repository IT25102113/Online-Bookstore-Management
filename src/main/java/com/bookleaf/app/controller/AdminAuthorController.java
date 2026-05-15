package com.bookleaf.app.controller;

import com.bookleaf.app.model.Author;
import com.bookleaf.app.repository.AuthorRepository;
import com.bookleaf.app.service.FileHandlingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("/admin/authors")
public class AdminAuthorController {

    @Autowired
    private AuthorRepository authorRepository;

    @Autowired
    private FileHandlingService fileHandlingService;

    @GetMapping
    public String manageAuthors(Model model) {
        model.addAttribute("authors", authorRepository.findAll());
        model.addAttribute("page", "manageAuthors");
        return "admin/authors";
    }

    @PostMapping("/add")
    public String addAuthor(@RequestParam String name,
                             @RequestParam(required = false) String bio,
                             @RequestParam(required = false) String imageUrl,
                             RedirectAttributes redirectAttributes) {
        Author author = new Author();
        author.setName(name.trim());
        author.setBio(bio);
        author.setImageUrl(imageUrl);

        authorRepository.save(author);
        fileHandlingService.writeAuthorsToFile(authorRepository.findAll());

        redirectAttributes.addFlashAttribute("success", "Author \"" + name + "\" added successfully!");
        return "redirect:/admin/authors";
    }

    @PostMapping("/update")
    public String updateAuthor(@RequestParam Long id,
                                @RequestParam String name,
                                @RequestParam(required = false) String bio,
                                @RequestParam(required = false) String imageUrl,
                                RedirectAttributes redirectAttributes) {
        var authorOpt = authorRepository.findById(id);
        if (authorOpt.isPresent()) {
            Author author = authorOpt.get();
            author.setName(name.trim());
            author.setBio(bio);
            author.setImageUrl(imageUrl);
            authorRepository.save(author);
            fileHandlingService.writeAuthorsToFile(authorRepository.findAll());
            redirectAttributes.addFlashAttribute("success", "Author updated successfully!");
        }
        return "redirect:/admin/authors";
    }

    @PostMapping("/delete/{id}")
    public String deleteAuthor(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        authorRepository.deleteById(id);
        fileHandlingService.writeAuthorsToFile(authorRepository.findAll());
        redirectAttributes.addFlashAttribute("success", "Author deleted successfully!");
        return "redirect:/admin/authors";
    }
}
