package vn.iotstar.service.impl;

import vn.iotstar.dao.IOrderDao_24110342;
import vn.iotstar.dao.impl.OrderDaoImpl_24110342;
import vn.iotstar.entity.Order_24110342;
import vn.iotstar.entity.OrderDetail_24110342;
import vn.iotstar.entity.User_24110342;
import vn.iotstar.service.IOrderService_24110342;
import vn.iotstar.util.CartItem_24110342;
import vn.iotstar.util.Cart_24110342;
import vn.iotstar.util.OrderStatus_24110342;

import java.sql.Timestamp;
import java.util.List;

public class OrderServiceImpl_24110342 implements IOrderService_24110342 {

    private final IOrderDao_24110342 orderDao = new OrderDaoImpl_24110342();

    @Override
    public Order_24110342 placeOrder(User_24110342 user, Cart_24110342 cart,
                                     String receiverName, String receiverPhone,
                                     String receiverAddress, String note) {
        if (user == null) {
            throw new IllegalArgumentException("Vui lòng đăng nhập để đặt hàng.");
        }
        if (cart == null || cart.isEmpty()) {
            throw new IllegalArgumentException("Giỏ hàng trống. Vui lòng thêm sản phẩm trước khi thanh toán.");
        }
        if (receiverName == null || receiverName.trim().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập họ tên người nhận.");
        }
        if (receiverName.trim().length() > 50) {
            throw new IllegalArgumentException("Họ tên người nhận không được quá 50 ký tự.");
        }
        if (receiverPhone == null || !receiverPhone.trim().matches("\\d{9,11}")) {
            throw new IllegalArgumentException("Số điện thoại phải gồm 9 đến 11 chữ số.");
        }
        if (receiverAddress == null || receiverAddress.trim().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập địa chỉ giao hàng.");
        }
        if (receiverAddress.trim().length() > 255) {
            throw new IllegalArgumentException("Địa chỉ giao hàng không được quá 255 ký tự.");
        }
        if (note != null && note.trim().length() > 255) {
            throw new IllegalArgumentException("Ghi chú không được quá 255 ký tự.");
        }

        Order_24110342 order = Order_24110342.builder()
                .user(user)
                .receiverName(receiverName.trim())
                .receiverPhone(receiverPhone.trim())
                .receiverAddress(receiverAddress.trim())
                .note((note == null || note.trim().isEmpty()) ? null : note.trim())
                .paymentMethod("COD")
                .totalAmount(cart.totalPrice())
                .status(OrderStatus_24110342.NEW)
                .createdAt(new Timestamp(System.currentTimeMillis()))
                .build();

        for (CartItem_24110342 item : cart.getItems()) {
            order.getDetails().add(OrderDetail_24110342.builder()
                    .order(order)
                    .bookId(item.getBookId())
                    .bookTitle(item.getTitle())
                    .quantity(item.getQuantity())
                    .unitPrice(item.getUnitPrice())
                    .build());
        }

        return orderDao.insert(order);
    }

    @Override
    public Order_24110342 findById(int orderId) {
        return orderDao.findById(orderId);
    }

    @Override
    public List<Order_24110342> findByUser(int userId, String status) {
        if (status == null || status.isEmpty()) {
            return orderDao.findByUserId(userId);
        }
        return orderDao.findByUserIdAndStatus(userId, status);
    }
}
