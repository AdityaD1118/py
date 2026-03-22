package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.db.DBConnection;
import com.google.gson.Gson;
import java.util.Map;

@WebServlet("/SaveUserServlet")
public class SaveUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // ✅ Read JSON data
            BufferedReader reader = request.getReader();
            Map<?, ?> payload = new Gson().fromJson(reader, Map.class);

            String name = (String) payload.get("name");
            String email = (String) payload.get("email");
            String paymentId = (String) payload.get("payment_id");
            int amount = ((Number) payload.get("amount")).intValue();
            String courseName = (String) payload.get("course_name"); // optional

            // ✅ DB Connection (PostgreSQL via DBConnection)
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO paid_users (username, email, payment_id, amount, course_name) " +
                         "VALUES (?, ?, ?, ?, ?) " +
                         "ON CONFLICT (email) DO UPDATE SET " +
                         "username = EXCLUDED.username, " +
                         "payment_id = EXCLUDED.payment_id, " +
                         "amount = EXCLUDED.amount, " +
                         "course_name = EXCLUDED.course_name";

            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, paymentId);
            pst.setInt(4, amount);
            pst.setString(5, courseName);

            int result = pst.executeUpdate();

            if (result > 0) {
                // ✅ Update session
                HttpSession session = request.getSession();
                session.setAttribute("paidUser", true);

                out.write("{\"status\":\"success\"}");
            } else {
                out.write("{\"status\":\"fail\",\"message\":\"Insert failed\"}");
            }

            pst.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        }

        out.flush();
    }
}