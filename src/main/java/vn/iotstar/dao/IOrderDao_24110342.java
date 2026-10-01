package vn.iotstar.dao;

import vn.iotstar.entity.Order_24110342;

import java.util.List;

public interface IOrderDao_24110342 {
    Order_24110342 insert(Order_24110342 order);
    Order_24110342 findById(int orderId);
    List<Order_24110342> findByUserId(int userId);
    List<Order_24110342> findByUserIdAndStatus(int userId, String status);
}
