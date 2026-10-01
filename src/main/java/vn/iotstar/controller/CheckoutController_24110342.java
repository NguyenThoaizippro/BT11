package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.Order_24110342;
import vn.iotstar.entity.User_24110342;
import vn.iotstar.service.IOrderService_24110342;
import vn.iotstar.service.impl.OrderServiceImpl_24110342;
import vn.iotstar.util.Cart_24110342;
import vn.iotstar.util.Constant_24110342;

import java.io.IOException;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IOrderService_24110342 orderService = new OrderServiceImpl_24110342();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User_24110342 user = getAccount(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=" + req.getContextPath() + "/checkout");
            return;
        }

        String successId = req.getParameter("success");
        if (successId != null && !successId.isEmpty()) {
            try {
                Order_24110342 order = orderService.findById(Integer.parseInt(successId));
                if (order == null || order.getUser() == null
                        || !user.getId().equals(order.getUser().getId())) {
                    resp.sendRedirect(req.getContextPath() + "/home");
                    return;
                }
                req.setAttribute("order", order);
                req.getRequestDispatcher("/views/order-success.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
            return;
        }

        Cart_24110342 cart = getCart(req);
        if (cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        req.setAttribute("receiverName", user.getFullname() != null ? user.getFullname() : "");
        req.setAttribute("receiverPhone", user.getPhone() != null ? String.valueOf(user.getPhone()) : "");
        req.setAttribute("receiverAddress", "");
        req.setAttribute("note", "");
        req.getRequestDispatcher("/views/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User_24110342 user = getAccount(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=" + req.getContextPath() + "/checkout");
            return;
        }

        Cart_24110342 cart = getCart(req);
        String receiverName = req.getParameter("receiverName");
        String receiverPhone = req.getParameter("receiverPhone");
        String receiverAddress = req.getParameter("receiverAddress");
        String note = req.getParameter("note");

        try {
            Order_24110342 order = orderService.placeOrder(
                    user, cart, receiverName, receiverPhone, receiverAddress, note);
            cart.clear();
            resp.sendRedirect(req.getContextPath() + "/checkout?success=" + order.getOrderId());
        } catch (IllegalArgumentException | IllegalStateException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("receiverName", receiverName);
            req.setAttribute("receiverPhone", receiverPhone);
            req.setAttribute("receiverAddress", receiverAddress);
            req.setAttribute("note", note);
            req.getRequestDispatcher("/views/checkout.jsp").forward(req, resp);
        }
    }

    private User_24110342 getAccount(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return (session != null)
                ? (User_24110342) session.getAttribute(Constant_24110342.SESSION_ACCOUNT)
                : null;
    }

    private Cart_24110342 getCart(HttpServletRequest req) {
        HttpSession session = req.getSession(true);
        Cart_24110342 cart = (Cart_24110342) session.getAttribute(Constant_24110342.SESSION_CART);
        if (cart == null) {
            cart = new Cart_24110342();
            session.setAttribute(Constant_24110342.SESSION_CART, cart);
        }
        return cart;
    }
}
