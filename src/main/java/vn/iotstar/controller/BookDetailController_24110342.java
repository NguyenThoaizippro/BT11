package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.Book_24110342;
import vn.iotstar.entity.Rating_24110342;
import vn.iotstar.entity.User_24110342;
import vn.iotstar.service.IBookService_24110342;
import vn.iotstar.service.IRatingService_24110342;
import vn.iotstar.service.impl.BookServiceImpl_24110342;
import vn.iotstar.service.impl.RatingServiceImpl_24110342;
import vn.iotstar.util.Constant_24110342;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/book-detail"})
public class BookDetailController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IBookService_24110342 bookService = new BookServiceImpl_24110342();
    private final IRatingService_24110342 ratingService = new RatingServiceImpl_24110342();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        try {
            int bookId = Integer.parseInt(idParam);
            Book_24110342 book = bookService.findById(bookId);
            if (book == null) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }

            List<Rating_24110342> ratings = ratingService.findByBookId(bookId);
            long reviewCount = ratingService.countByBookId(bookId);

            req.setAttribute("book", book);
            req.setAttribute("ratings", ratings);
            req.setAttribute("reviewCount", reviewCount);

            req.getRequestDispatcher("/views/book-detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        User_24110342 user = (session != null) ? (User_24110342) session.getAttribute(Constant_24110342.SESSION_ACCOUNT) : null;

        String bookIdParam = req.getParameter("bookId");
        if (bookIdParam == null || bookIdParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        int bookId = Integer.parseInt(bookIdParam);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=login_required&redirect=" + req.getContextPath() + "/book-detail?id=" + bookId);
            return;
        }

        String ratingParam = req.getParameter("rating");
        String reviewText = req.getParameter("reviewText");

        int ratingValue = 5;
        if (ratingParam != null) {
            try {
                ratingValue = Integer.parseInt(ratingParam);
            } catch (NumberFormatException ignored) {}
        }

        ratingService.addOrUpdateReview(user.getId(), bookId, ratingValue, reviewText);
        resp.sendRedirect(req.getContextPath() + "/book-detail?id=" + bookId + "&success=reviewed");
    }
}
