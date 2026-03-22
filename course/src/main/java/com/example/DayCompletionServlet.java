package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Map;
import com.db.DBConnection;
import com.google.gson.Gson;

@WebServlet("/DayCompletionServlet")
public class DayCompletionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "POST");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type");

        BufferedReader reader = req.getReader();
        Map<?, ?> payload = new Gson().fromJson(reader, Map.class);

        String email = (String) payload.get("email");
        int lectureDay = ((Number) payload.get("lecture_day")).intValue();
        boolean completed = (Boolean) payload.get("completed");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "INSERT INTO user_day_completion (email, lecture_day, completed) " +
                         "VALUES (?, ?, ?) " +
                         "ON CONFLICT (email, lecture_day) DO UPDATE SET completed = EXCLUDED.completed";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setInt(2, lectureDay);
            stmt.setBoolean(3, completed);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }
        resp.setStatus(HttpServletResponse.SC_OK);
    }
}