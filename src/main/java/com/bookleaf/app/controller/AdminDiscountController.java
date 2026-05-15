package com.bookleaf.app.controller;

import com.bookleaf.app.model.Discount;
import com.bookleaf.app.model.DiscountType;
import com.bookleaf.app.service.DiscountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;


@Controller
@RequestMapping("/admin/discounts")
public class AdminDiscountController {

    @Autowired
    private DiscountService discountService;

    @GetMapping
    public String manageDiscounts(Model model) {
        model.addAttribute("discounts", discountService.getAllDiscounts());
        model.addAttribute("page", "manageDiscounts");
        return "admin/discounts";
    }

    @PostMapping("/add")
    public String addDiscount(@RequestParam String name,
                              @RequestParam String discountType,
                              @RequestParam double percentage,
                              @RequestParam(required = false) String description,
                              @RequestParam(required = false) String startDate,
                              @RequestParam(required = false) String endDate,
                              @RequestParam(required = false) Double priceCap,
                              RedirectAttributes redirectAttributes) {

        Discount discount = new Discount();
        discount.setName(name.trim());
        discount.setDiscountType(DiscountType.valueOf(discountType));
        discount.setPercentage(percentage);
        discount.setDescription(description);
        discount.setActive(true);

        if (startDate != null && !startDate.isEmpty()) {
            discount.setStartDate(LocalDate.parse(startDate));
        }
        if (endDate != null && !endDate.isEmpty()) {
            discount.setEndDate(LocalDate.parse(endDate));
        }
        if (priceCap != null) {
            discount.setPriceCap(priceCap);
        }

        discountService.saveDiscount(discount);
        redirectAttributes.addFlashAttribute("success", "Discount \"" + name + "\" created successfully!");
        return "redirect:/admin/discounts";
    }

    @PostMapping("/update")
    public String updateDiscount(@RequestParam Long id,
                                 @RequestParam String name,
                                 @RequestParam String discountType,
                                 @RequestParam double percentage,
                                 @RequestParam(required = false) String description,
                                 @RequestParam(required = false) String startDate,
                                 @RequestParam(required = false) String endDate,
                                 @RequestParam(required = false) Double priceCap,
                                 RedirectAttributes redirectAttributes) {

        var discountOpt = discountService.getDiscountById(id);
        if (discountOpt.isPresent()) {
            Discount discount = discountOpt.get();
            discount.setName(name.trim());
            discount.setDiscountType(DiscountType.valueOf(discountType));
            discount.setPercentage(percentage);
            discount.setDescription(description);

            if (startDate != null && !startDate.isEmpty()) {
                discount.setStartDate(LocalDate.parse(startDate));
            } else {
                discount.setStartDate(null);
            }
            if (endDate != null && !endDate.isEmpty()) {
                discount.setEndDate(LocalDate.parse(endDate));
            } else {
                discount.setEndDate(null);
            }
            discount.setPriceCap(priceCap);

            discountService.saveDiscount(discount);
            redirectAttributes.addFlashAttribute("success", "Discount updated successfully!");
        }
        return "redirect:/admin/discounts";
    }

    @PostMapping("/delete/{id}")
    public String deleteDiscount(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        discountService.deleteDiscount(id);
        redirectAttributes.addFlashAttribute("success", "Discount deleted successfully!");
        return "redirect:/admin/discounts";
    }

    @PostMapping("/toggle/{id}")
    public String toggleDiscount(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        discountService.toggleDiscount(id);
        redirectAttributes.addFlashAttribute("success", "Discount status updated!");
        return "redirect:/admin/discounts";
    }
}
