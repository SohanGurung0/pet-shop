package com.petsupply.dao;

import com.petsupply.model.Order;
import java.util.List;

public interface OrderDao {
    boolean insertOrder(Order order);
    Order findById(int id);
    List<Order> findByUserId(int userId);
    List<Order> findAll();
    boolean updateStatus(int orderId, String status);
    java.util.Map<String, java.math.BigDecimal> getSalesByDate();
    boolean deleteOrder(int id);
}
