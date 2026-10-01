package vn.iotstar.service;

import vn.iotstar.entity.Order_24110342;
import vn.iotstar.entity.User_24110342;
import vn.iotstar.util.Cart_24110342;

import java.util.List;

public interface IOrderService_24110342 {
    Order_24110342 placeOrder(User_24110342 user, Cart_24110342 cart,
                              String receiverName, String receiverPhone,
                              String receiverAddress, String note);
    Order_24110342 findById(int orderId);
    List<Order_24110342> findByUser(int userId, String status);
}
