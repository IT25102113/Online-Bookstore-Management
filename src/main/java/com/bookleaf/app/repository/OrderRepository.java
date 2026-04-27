package com.bookleaf.app.repository;

import com.bookleaf.app.model.Order;
import com.bookleaf.app.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserOrderByCreatedAtDesc(User user);

    @Query("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o")
    double getTotalRevenue();

    @Query("SELECT COUNT(o) FROM Order o")
    long getTotalOrders();
}
