package com.bookleaf.app.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * DataDownloadServlet - Demonstrates the use of standard Java Servlets (HttpServlet)
 * as requested in the project requirements.
 * This servlet allows admins to download the text database files directly.
 */
@WebServlet(urlPatterns = "/api/data/download")
public class DataDownloadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String type = request.getParameter("type");
        if (type == null || !type.matches("^[a-zA-Z0-9_]+$")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid or missing file type parameter.");
            return;
        }

        String fileName = type + ".txt";
        File file = new File("src/data/" + fileName);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Requested file not found on the server.");
            return;
        }

        response.setContentType("text/plain");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        try (FileInputStream inStream = new FileInputStream(file);
             OutputStream outStream = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }
        }
    }
}
