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

import java.io.IOException;

@WebServlet(urlPatterns = {"/order-detail"})
public class OrderDetailController_24110342 extends HttpServlet {

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

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/orders");
            return;
        }

        try {
            Order_24110342 order = orderService.findById(Integer.parseInt(idParam));
            if (order == null || order.getUser() == null || !user.getId().equals(order.getUser().getId())) {
                resp.sendRedirect(req.getContextPath() + "/orders");
                return;
            }
            req.setAttribute("order", order);
            req.getRequestDispatcher("/views/order-detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/orders");
        }
    }
}
