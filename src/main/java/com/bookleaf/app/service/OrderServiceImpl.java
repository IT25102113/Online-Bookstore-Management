package com.bookleaf.app.service;

import com.bookleaf.app.model.Order;
import com.bookleaf.app.model.User;
import com.bookleaf.app.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private FileHandlingService fileHandlingService;

    @Override
    public Order createOrder(Order order) {
        Order saved = orderRepository.save(order);
        fileHandlingService.writeOrdersToFile(orderRepository.findAll());
        return saved;
    }

    @Override
    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findByUserOrderByCreatedAtDesc(user);
    }

    @Override
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    @Override
    public double getTotalRevenue() {
        return orderRepository.getTotalRevenue();
    }

    @Override
    public long getTotalOrders() {
        return orderRepository.getTotalOrders();
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
