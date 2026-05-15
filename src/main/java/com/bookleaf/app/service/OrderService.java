package com.bookleaf.app.service;

import com.bookleaf.app.model.Order;
import com.bookleaf.app.model.User;
import java.util.List;


public interface OrderService {
    Order createOrder(Order order);
    List<Order> getOrdersByUser(User user);
    List<Order> getAllOrders();
    double getTotalRevenue();
    long getTotalOrders();
}
