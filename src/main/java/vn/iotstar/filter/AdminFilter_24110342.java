package vn.iotstar.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User_24110342;
import vn.iotstar.util.Constant_24110342;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*"})
public class AdminFilter_24110342 implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User_24110342 user = (session != null) ? (User_24110342) session.getAttribute(Constant_24110342.SESSION_ACCOUNT) : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=unauthorized");
            return;
        }

        if (user.getIsAdmin() == null || !user.getIsAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/home?error=forbidden");
            return;
        }

        chain.doFilter(request, response);
    }
}
