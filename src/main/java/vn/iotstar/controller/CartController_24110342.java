package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.Book_24110342;
import vn.iotstar.service.IBookService_24110342;
import vn.iotstar.service.impl.BookServiceImpl_24110342;
import vn.iotstar.util.Cart_24110342;
import vn.iotstar.util.Constant_24110342;

import java.io.IOException;

@WebServlet(urlPatterns = {"/cart"})
public class CartController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IBookService_24110342 bookService = new BookServiceImpl_24110342();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getOrCreateCart(req);
        req.getRequestDispatcher("/views/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Cart_24110342 cart = getOrCreateCart(req);
        String action = req.getParameter("action");
        String bookIdParam = req.getParameter("bookId");

        if (action == null || bookIdParam == null) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        int bookId;
        try {
            bookId = Integer.parseInt(bookIdParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if ("delete".equals(action)) {
            cart.remove(bookId);
            resp.sendRedirect(req.getContextPath() + "/cart?success=delete");
            return;
        }

        Book_24110342 book = bookService.findById(bookId);
        if (book == null) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        int qty = 1;
        String qtyParam = req.getParameter("qty");
        if (qtyParam != null && !qtyParam.isEmpty()) {
            try {
                qty = Integer.parseInt(qtyParam);
            } catch (NumberFormatException e) {
                resp.sendRedirect(req.getContextPath() + "/cart?error=invalid");
                return;
            }
        }

        if ("add".equals(action)) {
            if (cart.add(book, qty)) {
                resp.sendRedirect(req.getContextPath() + "/cart?success=add");
            } else {
                resp.sendRedirect(req.getContextPath() + "/cart?error=stock");
            }
            return;
        }

        if ("update".equals(action)) {
            int stock = (book.getQuantity() != null) ? book.getQuantity() : 0;
            if (cart.updateQuantity(bookId, qty, stock)) {
                resp.sendRedirect(req.getContextPath() + "/cart?success=update");
            } else {
                resp.sendRedirect(req.getContextPath() + "/cart?error=stock");
            }
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private Cart_24110342 getOrCreateCart(HttpServletRequest req) {
        HttpSession session = req.getSession(true);
        Cart_24110342 cart = (Cart_24110342) session.getAttribute(Constant_24110342.SESSION_CART);
        if (cart == null) {
            cart = new Cart_24110342();
            session.setAttribute(Constant_24110342.SESSION_CART, cart);
        }
        return cart;
    }
}
