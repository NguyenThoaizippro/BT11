package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User_24110342;
import vn.iotstar.service.IUserService_24110342;
import vn.iotstar.service.impl.UserServiceImpl_24110342;
import vn.iotstar.util.Constant_24110342;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet(urlPatterns = {"/login"})
public class LoginController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService_24110342 userService = new UserServiceImpl_24110342();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String success = req.getParameter("success");
        if ("registered".equals(success)) {
            req.setAttribute("message", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
        }
        String error = req.getParameter("error");
        if ("unauthorized".equals(error)) {
            req.setAttribute("error", "Vui lòng đăng nhập để tiếp tục!");
        }
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User_24110342 user = userService.login(email, password);

        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute(Constant_24110342.SESSION_ACCOUNT, user);

            user.setLastLogin(new Timestamp(System.currentTimeMillis()));
            userService.update(user);

            // User_24110342 đăng nhập thành công vào trang chủ, Admin vào trang quản trị
            if (user.getIsAdmin() != null && user.getIsAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin/books");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không chính xác!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
