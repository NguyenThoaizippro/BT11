package vn.iotstar.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Author_24110342;
import vn.iotstar.entity.Book_24110342;
import vn.iotstar.service.IAuthorService_24110342;
import vn.iotstar.service.IBookService_24110342;
import vn.iotstar.service.impl.AuthorServiceImpl_24110342;
import vn.iotstar.service.impl.BookServiceImpl_24110342;
import vn.iotstar.util.Constant_24110342;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = {"/admin/books", "/admin/books/add", "/admin/books/edit", "/admin/books/delete"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class AdminBookController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IBookService_24110342 bookService = new BookServiceImpl_24110342();
    private final IAuthorService_24110342 authorService = new AuthorServiceImpl_24110342();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/books/delete".equals(path)) {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    bookService.delete(id);
                } catch (Exception ignored) {}
            }
            resp.sendRedirect(req.getContextPath() + "/admin/books?msg=deleted");
            return;
        }

        if ("/admin/books/add".equals(path)) {
            List<Author_24110342> authors = authorService.findAll();
            req.setAttribute("authors", authors);
            req.setAttribute("action", "add");
            req.getRequestDispatcher("/views/admin/book-form.jsp").forward(req, resp);
            return;
        }

        if ("/admin/books/edit".equals(path)) {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    Book_24110342 book = bookService.findById(id);
                    if (book != null) {
                        List<Author_24110342> authors = authorService.findAll();
                        req.setAttribute("book", book);
                        req.setAttribute("authors", authors);
                        req.setAttribute("action", "edit");
                        req.getRequestDispatcher("/views/admin/book-form.jsp").forward(req, resp);
                        return;
                    }
                } catch (Exception ignored) {}
            }
            resp.sendRedirect(req.getContextPath() + "/admin/books");
            return;
        }

        // List with pagination
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Math.max(1, Integer.parseInt(pageParam));
            } catch (NumberFormatException ignored) {}
        }

        int pageSize = 6;
        long totalBooks = bookService.count();
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize);
        if (totalPages < 1) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Book_24110342> books = bookService.findAll(page, pageSize);

        req.setAttribute("books", books);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalBooks", totalBooks);

        req.getRequestDispatcher("/views/admin/book-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        String idParam = req.getParameter("bookid");
        String title = req.getParameter("title");
        String isbnStr = req.getParameter("isbn");
        String publisher = req.getParameter("publisher");
        String priceStr = req.getParameter("price");
        String quantityStr = req.getParameter("quantity");
        String publishDateStr = req.getParameter("publishDate");
        String description = req.getParameter("description");
        String coverImageUrl = req.getParameter("coverImageUrl");
        String[] authorIdStrs = req.getParameterValues("authorIds");

        Integer isbn = null;
        if (isbnStr != null && !isbnStr.trim().isEmpty()) {
            try { isbn = Integer.parseInt(isbnStr.trim()); } catch (Exception ignored) {}
        }

        BigDecimal price = null;
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try { price = new BigDecimal(priceStr.trim()); } catch (Exception ignored) {}
        }

        Integer quantity = null;
        if (quantityStr != null && !quantityStr.trim().isEmpty()) {
            try { quantity = Integer.parseInt(quantityStr.trim()); } catch (Exception ignored) {}
        }

        Date publishDate = null;
        if (publishDateStr != null && !publishDateStr.trim().isEmpty()) {
            try { publishDate = Date.valueOf(publishDateStr.trim()); } catch (Exception ignored) {}
        }

        List<Integer> authorIds = new ArrayList<>();
        if (authorIdStrs != null) {
            for (String s : authorIdStrs) {
                try { authorIds.add(Integer.parseInt(s.trim())); } catch (Exception ignored) {}
            }
        }

        // Handle image upload or image URL
        String coverImage = coverImageUrl;
        try {
            Part filePart = req.getPart("coverImageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String ext = "";
                int dotIdx = submittedName.lastIndexOf('.');
                if (dotIdx > 0) ext = submittedName.substring(dotIdx);

                String newFileName = UUID.randomUUID().toString() + ext;
                String uploadPath = req.getServletContext().getRealPath("/" + Constant_24110342.UPLOAD_DIR);
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                filePart.write(new File(uploadDir, newFileName).getAbsolutePath());
                coverImage = newFileName;
            }
        } catch (Exception ignored) {}

        if ("/admin/books/add".equals(path)) {
            Book_24110342 book = Book_24110342.builder()
                    .title(title)
                    .isbn(isbn)
                    .publisher(publisher)
                    .price(price)
                    .quantity(quantity)
                    .publishDate(publishDate)
                    .description(description)
                    .coverImage(coverImage)
                    .build();
            bookService.insert(book, authorIds);
            resp.sendRedirect(req.getContextPath() + "/admin/books?msg=added");
        } else if ("/admin/books/edit".equals(path)) {
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                Book_24110342 book = bookService.findById(id);
                if (book != null) {
                    book.setTitle(title);
                    book.setIsbn(isbn);
                    book.setPublisher(publisher);
                    book.setPrice(price);
                    book.setQuantity(quantity);
                    book.setPublishDate(publishDate);
                    book.setDescription(description);
                    if (coverImage != null && !coverImage.trim().isEmpty()) {
                        book.setCoverImage(coverImage);
                    }
                    bookService.update(book, authorIds);
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/books?msg=updated");
        }
    }
}
