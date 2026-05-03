package com.petsupply.service;

import com.petsupply.dao.OrderDao;
import com.petsupply.dao.OrderDaoImpl;
import com.petsupply.model.Order;
import java.util.List;

public class OrderService {

    private final OrderDao orderDao;

    public OrderService() {
        this.orderDao = new OrderDaoImpl();
    }

    public boolean placeOrder(Order order) {
        return orderDao.insertOrder(order);
    }

    public List<Order> getUserOrders(int userId) {
        return orderDao.findByUserId(userId);
    }

    public Order getOrderDetails(int orderId) {
        return orderDao.findById(orderId);
    }

    public List<Order> getAllOrders() {
        return orderDao.findAll();
    }

    public boolean updateOrderStatus(int orderId, String status) {
        return orderDao.updateStatus(orderId, status);
    }

    public java.util.Map<String, java.math.BigDecimal> getSalesData() {
        return orderDao.getSalesByDate();
    }

    public boolean deleteOrder(int id) {
        return orderDao.deleteOrder(id);
    }
}
