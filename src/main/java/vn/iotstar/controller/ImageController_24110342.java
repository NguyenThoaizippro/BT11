package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import vn.iotstar.util.Constant_24110342;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@WebServlet(urlPatterns = {"/image"})
public class ImageController_24110342 extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.trim().isEmpty()) {
            return;
        }

        // If URL online, redirect directly
        if (fileName.startsWith("http://") || fileName.startsWith("https://")) {
            resp.sendRedirect(fileName);
            return;
        }

        // Prevent Path Traversal
        String safeFileName = new File(fileName).getName();
        String uploadRoot = req.getServletContext().getRealPath("/" + Constant_24110342.UPLOAD_DIR);
        File file = new File(uploadRoot, safeFileName);

        if (!file.exists()) {
            // Fallback default upload folder
            file = new File(System.getProperty("user.home") + "/uploads", safeFileName);
        }

        if (file.exists()) {
            String mimeType = req.getServletContext().getMimeType(file.getName());
            if (mimeType == null) {
                mimeType = "image/jpeg";
            }
            resp.setContentType(mimeType);
            resp.setContentLength((int) file.length());

            try (FileInputStream in = new FileInputStream(file)) {
                IOUtils.copy(in, resp.getOutputStream());
            }
        }
    }
}
