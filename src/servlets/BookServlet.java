package servlets;

import models.PrintedBook;
import utils.FileHandler;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/BookServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class BookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // 1. පින්තූරය සේව් කරන තැන හැදීම
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            // 2. File එක upload කරලා නමක් දීම
            Part filePart = request.getPart("image");
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            filePart.write(uploadPath + File.separator + fileName);
            String imageUrl = "uploads/" + fileName;

            // 3. අනෙක් දත්ත ලබා ගැනීම
            String bookId = "B" + System.currentTimeMillis();
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            double price = Double.parseDouble(request.getParameter("price"));

            PrintedBook newBook = new PrintedBook(bookId, title, author, price, imageUrl);
            FileHandler.writeToFile("books.txt", newBook.toFileString());

            response.sendRedirect("manage_books.jsp");
        }
        else if ("delete".equals(action)) {
            String oldData = request.getParameter("oldData");
            FileHandler.modifyFile("books.txt", oldData, "");
            response.sendRedirect("manage_books.jsp");
        }
        else if ("update".equals(action)) {
            String oldData = request.getParameter("oldData");
            String[] oldParts = oldData.split(",");

            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String price = request.getParameter("price");
            String type = request.getParameter("type");
            String bookId = request.getParameter("bookId");

            // අලුත් පින්තූරයක් තෝරා තිබේදැයි බලයි
            Part filePart = request.getPart("image");
            String imageUrl;

            if (filePart != null && filePart.getSize() > 0) {
                // අලුත් එකක් තියෙනවා නම් ඒක upload කරයි
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                filePart.write(uploadPath + File.separator + fileName);
                imageUrl = "uploads/" + fileName;
            } else {
                // නැත්නම් පරණ image URL එකම තබා ගනී (පරණ දත්ත වල Index 5 හි ඇත)
                imageUrl = oldParts[5];
            }

            String newData = bookId + "," + title + "," + author + "," + price + "," + type + "," + imageUrl;
            FileHandler.modifyFile("books.txt", oldData, newData);
            response.sendRedirect("manage_books.jsp");
        }
    }
}