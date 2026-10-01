package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Book_24110342;
import vn.iotstar.service.IBookService_24110342;
import vn.iotstar.service.impl.BookServiceImpl_24110342;
import vn.iotstar.util.Constant_24110342;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/home", "/"})
public class HomeController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IBookService_24110342 bookService = new BookServiceImpl_24110342();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Math.max(1, Integer.parseInt(pageParam));
            } catch (NumberFormatException ignored) {}
        }

        int pageSize = Constant_24110342.DEFAULT_PAGE_SIZE; // Đúng 6 sản phẩm / trang theo Câu 3
        long totalBooks = bookService.count();
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize);
        if (totalPages < 1) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Book_24110342> books = bookService.findAll(page, pageSize);

        req.setAttribute("books", books);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalBooks", totalBooks);

        req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
    }
}
