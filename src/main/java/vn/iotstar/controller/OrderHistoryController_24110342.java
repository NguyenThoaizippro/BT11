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
import vn.iotstar.util.Constant_24110342;
import vn.iotstar.util.OrderStatus_24110342;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/orders"})
public class OrderHistoryController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IOrderService_24110342 orderService = new OrderServiceImpl_24110342();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User_24110342 user = (session != null)
                ? (User_24110342) session.getAttribute(Constant_24110342.SESSION_ACCOUNT)
                : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=" + req.getContextPath() + "/orders");
            return;
        }

        String status = req.getParameter("status");
        if (status != null && status.isEmpty()) {
            status = null;
        }
        if (status != null && !OrderStatus_24110342.isValid(status)) {
            status = null;
        }

        List<Order_24110342> orders = orderService.findByUser(user.getId(), status);

        req.setAttribute("orders", orders);
        req.setAttribute("statusMap", OrderStatus_24110342.LABELS);
        req.setAttribute("statusLabel", (status != null) ? OrderStatus_24110342.label(status) : null);
        req.getRequestDispatcher("/views/orders.jsp").forward(req, resp);
    }
}
