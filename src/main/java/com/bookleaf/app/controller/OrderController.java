package com.bookleaf.app.controller;

import com.bookleaf.app.model.*;
import com.bookleaf.app.service.BookService;
import com.bookleaf.app.service.DiscountService;
import com.bookleaf.app.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private BookService bookService;

    @Autowired
    private DiscountService discountService;

    @GetMapping("/checkout")
    public String showCheckout(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<CartItem> cart = getCart(session);
        if (cart.isEmpty()) return "redirect:/cart";

        double total = cart.stream().mapToDouble(CartItem::getSubtotal).sum();

        Optional<Discount> bestDiscount = discountService.getBestDiscount(user, total);
        double discountedTotal = total;
        if (bestDiscount.isPresent()) {
            discountedTotal = discountService.calculateDiscountedTotal(total, user);
            model.addAttribute("discount", bestDiscount.get());
            model.addAttribute("discountAmount", total - discountedTotal);
        }

        model.addAttribute("cart", cart);
        model.addAttribute("cartTotal", total);
        model.addAttribute("discountedTotal", discountedTotal);
        model.addAttribute("page", "cart");
        return "checkout";
    }

    @PostMapping("/checkout/process")
    public String processCheckout(@RequestParam String paymentMethod,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<CartItem> cart = getCart(session);
        if (cart.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Your cart is empty.");
            return "redirect:/cart";
        }

        double total = cart.stream().mapToDouble(CartItem::getSubtotal).sum();

        double finalTotal = discountService.calculateDiscountedTotal(total, user);

        Order order = new Order();
        order.setUser(user);
        order.setTotalAmount(finalTotal);
        order.setPaymentMethod(paymentMethod);
        order.setOrderStatus(OrderStatus.CONFIRMED);

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : cart) {
            Optional<Book> bookOpt = bookService.getBookById(cartItem.getBookId());
            if (bookOpt.isPresent()) {
                Book book = bookOpt.get();

                OrderItem orderItem = new OrderItem();
                orderItem.setOrder(order);
                orderItem.setBook(book);
                orderItem.setQuantity(cartItem.getQuantity());
                orderItem.setFormat(cartItem.getFormat());
                orderItem.setUnitPrice(cartItem.getUnitPrice());
                orderItems.add(orderItem);

                if ("HARDCOPY".equals(cartItem.getFormat())) {
                    book.setQuantity(Math.max(0, book.getQuantity() - cartItem.getQuantity()));
                    bookService.saveBook(book);
                }
            }
        }

        order.setItems(orderItems);
        orderService.createOrder(order);

        session.removeAttribute("cart");

        redirectAttributes.addFlashAttribute("success",
                "Order #" + order.getId() + " placed successfully! Total: LKR " + String.format("%.2f", finalTotal));
        return "redirect:/my-orders";
    }

    @GetMapping("/my-orders")
    public String myOrders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        if (user.getId() != null && user.getId() == 0L) {
            model.addAttribute("orders", new ArrayList<>());
        } else {
            List<Order> orders = orderService.getOrdersByUser(user);
            model.addAttribute("orders", orders);
        }

        model.addAttribute("page", "orders");
        return "my_orders";
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        return cart != null ? cart : new ArrayList<>();
    }
}
