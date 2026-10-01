package vn.iotstar.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Author_24110342;
import vn.iotstar.service.IAuthorService_24110342;
import vn.iotstar.service.impl.AuthorServiceImpl_24110342;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/authors", "/admin/authors/add", "/admin/authors/edit", "/admin/authors/delete"})
public class AdminAuthorController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IAuthorService_24110342 authorService = new AuthorServiceImpl_24110342();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/authors/delete".equals(path)) {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    authorService.delete(id);
                } catch (Exception ignored) {}
            }
            resp.sendRedirect(req.getContextPath() + "/admin/authors?msg=deleted");
            return;
        }

        if ("/admin/authors/add".equals(path)) {
            req.setAttribute("action", "add");
            req.getRequestDispatcher("/views/admin/author-form.jsp").forward(req, resp);
            return;
        }

        if ("/admin/authors/edit".equals(path)) {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    Author_24110342 author = authorService.findById(id);
                    if (author != null) {
                        req.setAttribute("author", author);
                        req.setAttribute("action", "edit");
                        req.getRequestDispatcher("/views/admin/author-form.jsp").forward(req, resp);
                        return;
                    }
                } catch (Exception ignored) {}
            }
            resp.sendRedirect(req.getContextPath() + "/admin/authors");
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
        long totalAuthors = authorService.count();
        int totalPages = (int) Math.ceil((double) totalAuthors / pageSize);
        if (totalPages < 1) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Author_24110342> authors = authorService.findAll(page, pageSize);

        req.setAttribute("authors", authors);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalAuthors", totalAuthors);

        req.getRequestDispatcher("/views/admin/author-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        String idParam = req.getParameter("authorId");
        String authorName = req.getParameter("authorName");
        String dobStr = req.getParameter("dateOfBirth");

        Date dob = null;
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try { dob = Date.valueOf(dobStr.trim()); } catch (Exception ignored) {}
        }

        if ("/admin/authors/add".equals(path)) {
            Author_24110342 author = Author_24110342.builder()
                    .authorName(authorName)
                    .dateOfBirth(dob)
                    .build();
            authorService.insert(author);
            resp.sendRedirect(req.getContextPath() + "/admin/authors?msg=added");
        } else if ("/admin/authors/edit".equals(path)) {
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                Author_24110342 author = authorService.findById(id);
                if (author != null) {
                    author.setAuthorName(authorName);
                    author.setDateOfBirth(dob);
                    authorService.update(author);
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/authors?msg=updated");
        }
    }
}
