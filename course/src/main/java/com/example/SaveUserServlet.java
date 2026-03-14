package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Map;
import com.google.gson.Gson;

@WebServlet("/SaveUserServlet")
public class SaveUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        BufferedReader reader = request.getReader();
        Map<?, ?> payload = new Gson().fromJson(reader, Map.class);

        String name = (String) payload.get("name");
        String email = (String) payload.get("email");
        String paymentId = (String) payload.get("payment_id");
        int amount = ((Number) payload.get("amount")).intValue();
        // Ignore course_name since the column doesn't exist

        String jdbcURL = "jdbc:mysql://localhost:3306/microsoft_learn_db";
        String dbUser = "root";
        String dbPassword = "root";

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            // Insert into paid_users table without course_name
            String sql = "INSERT INTO paid_users (email, payment_id, amount) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, paymentId);
            stmt.setInt(3, amount);
            stmt.executeUpdate();

            response.setStatus(HttpServletResponse.SC_OK);
            PrintWriter out = response.getWriter();
            out.write("{\"status\":\"success\",\"message\":\"Payment saved successfully\"}");
            out.flush();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter out = response.getWriter();
            out.write("{\"status\":\"error\",\"message\":\"Error saving payment: " + e.getMessage() + "\"}");
            out.flush();
        }
    }
}