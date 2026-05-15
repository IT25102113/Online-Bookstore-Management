package com.bookleaf.app.controller;

import com.bookleaf.app.model.Order;
import com.bookleaf.app.model.OrderStatus;
import com.bookleaf.app.model.Role;
import com.bookleaf.app.model.User;
import com.bookleaf.app.service.OrderService;
import com.bookleaf.app.service.NotificationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/orders")
public class AdminOrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private NotificationService notificationService;

    @GetMapping
    public String showOrders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.ADMIN) return "redirect:/login";

        List<Order> orders = orderService.getAllOrders();
        orders.sort((o1, o2) -> o2.getId().compareTo(o1.getId()));
        
        model.addAttribute("orders", orders);
        model.addAttribute("statuses", OrderStatus.values());
        model.addAttribute("page", "orders");
        return "admin/orders";
    }

    @PostMapping("/update-status")
    public String updateOrderStatus(@RequestParam Long orderId,
                                    @RequestParam String status,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.ADMIN) return "redirect:/login";

        List<Order> orders = orderService.getAllOrders();
        Optional<Order> orderOpt = orders.stream().filter(o -> o.getId().equals(orderId)).findFirst();
        
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            try {
                order.setOrderStatus(OrderStatus.valueOf(status));
                orderService.createOrder(order); 
                notificationService.createNotification(order.getUser(), "Your order #" + order.getId() + " is now " + order.getOrderStatus() + ".", "ORDER_UPDATE", "/orders");
                redirectAttributes.addFlashAttribute("success", "Order #" + orderId + " status updated to " + status);
            } catch (IllegalArgumentException e) {
                redirectAttributes.addFlashAttribute("error", "Invalid order status.");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Order not found.");
        }

        return "redirect:/admin/orders";
    }
}
