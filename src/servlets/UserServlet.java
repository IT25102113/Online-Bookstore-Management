package servlets;

import models.Customer;
import models.User;
import utils.FileHandler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // ==========================================
        // 1. REGISTRATION ක්‍රියාවලිය (Create Operation)
        // ==========================================
        if ("register".equals(action)) {
            String userId = "U" + System.currentTimeMillis();
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User newCustomer = new Customer(userId, name, email, password);
            boolean isSaved = FileHandler.writeToFile("users.txt", newCustomer.toFileString());

            if (isSaved) {
                out.println("<script>alert('Registration Successful! Please Login.'); window.location.href='login.jsp';</script>");
            } else {
                out.println("<script>alert('Error in Registration.'); window.location.href='register.jsp';</script>");
            }
        }
        // ==========================================
        // 2. LOGIN ක්‍රියාවලිය (Read Operation)
        // ==========================================
        else if ("login".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Text file එකේ තියෙන ඔක්කොම දත්ත ටික කියවලා ගන්නවා
            List<String> users = FileHandler.readFromFile("users.txt");
            boolean isValidUser = false;
            String loggedInUserName = "";

            // පේළියෙන් පේළිය චෙක් කරනවා
            for (String userRecord : users) {
                String[] details = userRecord.split(","); // කොමාවෙන් දත්ත වෙන් කරනවා

                // details[2] කියන්නේ Email එක, details[3] කියන්නේ Password එක
                if (details.length >= 5 && details[2].equals(email) && details[3].equals(password)) {
                    isValidUser = true;
                    loggedInUserName = details[1]; // details[1] කියන්නේ නම
                    break;
                }
            }

            if (isValidUser) {
                // පාස්වර්ඩ් හරි නම් Dashboard එකට යවනවා
                out.println("<script>alert('Welcome " + loggedInUserName + "!'); window.location.href='dashboard.jsp';</script>");
            } else {
                // පාස්වර්ඩ් වැරදි නම් ආයෙත් Login එකට යවනවා
                out.println("<script>alert('Invalid Email or Password! Try again.'); window.location.href='login.jsp';</script>");
            }
        }
    }
}