package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import com.db.DBConnection;
import com.google.gson.Gson;

@WebServlet("/ProgressServlet")
public class ProgressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        Map<String, Integer> progressMap = new HashMap<>();
        Map<String, Boolean> dayCompletionMap = new HashMap<>();

        try (Connection conn = DBConnection.getConnection()) {

            // Get individual lecture progress
            String sql1 = "SELECT lecture_day, lecture_num, progress FROM user_progress WHERE email = ?";
            PreparedStatement stmt1 = conn.prepareStatement(sql1);
            stmt1.setString(1, email);
            ResultSet rs1 = stmt1.executeQuery();
            while (rs1.next()) {
                String key = rs1.getInt("lecture_day") + "-" + rs1.getInt("lecture_num");
                int progress = rs1.getInt("progress");
                progressMap.put(key, progress);
            }

            // Get day completion status
            String sql2 = "SELECT lecture_day, completed FROM user_day_completion WHERE email = ? AND completed = true";
            PreparedStatement stmt2 = conn.prepareStatement(sql2);
            stmt2.setString(1, email);
            ResultSet rs2 = stmt2.executeQuery();
            while (rs2.next()) {
                String day = String.valueOf(rs2.getInt("lecture_day"));
                dayCompletionMap.put(day, rs2.getBoolean("completed"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        // Combine both maps into one response
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("lectureProgress", progressMap);
        responseData.put("dayCompletion", dayCompletionMap);

        String json = new Gson().toJson(responseData);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.write(json);
        out.flush();
    }
}