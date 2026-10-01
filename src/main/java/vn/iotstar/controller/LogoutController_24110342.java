package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.util.Constant_24110342;

import java.io.IOException;

@WebServlet(urlPatterns = {"/logout"})
public class LogoutController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.removeAttribute(Constant_24110342.SESSION_ACCOUNT);
            session.invalidate();
        }
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
