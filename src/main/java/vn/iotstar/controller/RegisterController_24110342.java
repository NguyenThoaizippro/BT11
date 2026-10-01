package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User_24110342;
import vn.iotstar.service.EmailService_24110342;
import vn.iotstar.service.IUserService_24110342;
import vn.iotstar.service.impl.EmailServiceImpl_24110342;
import vn.iotstar.service.impl.UserServiceImpl_24110342;
import vn.iotstar.util.Constant_24110342;
import vn.iotstar.util.PasswordUtil_24110342;

import java.io.IOException;
import java.util.Random;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService_24110342 userService = new UserServiceImpl_24110342();
    private final EmailService_24110342 emailService = new EmailServiceImpl_24110342();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phoneStr = req.getParameter("phone");
        String password = req.getParameter("password");
        String repassword = req.getParameter("repassword");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ email và mật khẩu!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(repassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.setAttribute("fullname", fullname);
            req.setAttribute("email", email);
            req.setAttribute("phone", phoneStr);
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (userService.getByEmail(email.trim()) != null) {
            req.setAttribute("error", "Email này đã được đăng ký trong hệ thống!");
            req.setAttribute("fullname", fullname);
            req.setAttribute("phone", phoneStr);
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        Integer phone = null;
        if (phoneStr != null && !phoneStr.trim().isEmpty()) {
            try {
                phone = Integer.parseInt(phoneStr.trim());
            } catch (NumberFormatException ignored) {}
        }

        String otp = String.format("%06d", new Random().nextInt(1000000));

        User_24110342 pendingUser = User_24110342.builder()
                .fullname(fullname)
                .email(email.trim().toLowerCase())
                .phone(phone)
                .passwd(PasswordUtil_24110342.hashPassword(password))
                .isAdmin(false)
                .build();

        HttpSession session = req.getSession();
        session.setAttribute(Constant_24110342.SESSION_PENDING_USER, pendingUser);
        session.setAttribute(Constant_24110342.SESSION_OTP, otp);
        session.setAttribute(Constant_24110342.SESSION_OTP_TIME, System.currentTimeMillis());

        // Send OTP email (and log to console for grading)
        emailService.sendOtp(email.trim(), otp, "Kích hoạt tài khoản Đăng ký");

        resp.sendRedirect(req.getContextPath() + "/verify-otp");
    }
}
