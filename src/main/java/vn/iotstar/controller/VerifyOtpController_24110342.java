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

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOtpController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService_24110342 userService = new UserServiceImpl_24110342();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant_24110342.SESSION_PENDING_USER) == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant_24110342.SESSION_PENDING_USER) == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        String inputOtp = req.getParameter("otp");
        String expectedOtp = (String) session.getAttribute(Constant_24110342.SESSION_OTP);
        Long otpTime = (Long) session.getAttribute(Constant_24110342.SESSION_OTP_TIME);

        long now = System.currentTimeMillis();
        boolean isExpired = (otpTime == null || (now - otpTime) > (5 * 60 * 1000)); // 5 minutes

        if (inputOtp != null && inputOtp.trim().equals(expectedOtp) && !isExpired) {
            User_24110342 pendingUser = (User_24110342) session.getAttribute(Constant_24110342.SESSION_PENDING_USER);
            pendingUser.setSignupDate(new Timestamp(now));
            pendingUser.setLastLogin(new Timestamp(now));

            userService.insert(pendingUser);

            // Clean up session
            session.removeAttribute(Constant_24110342.SESSION_PENDING_USER);
            session.removeAttribute(Constant_24110342.SESSION_OTP);
            session.removeAttribute(Constant_24110342.SESSION_OTP_TIME);

            resp.sendRedirect(req.getContextPath() + "/login?success=registered");
        } else {
            req.setAttribute("error", isExpired ? "Mã OTP đã hết hạn! Vui lòng đăng ký lại." : "Mã OTP không chính xác, vui lòng thử lại!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}
