package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Map;
import com.db.DBConnection;
import com.google.gson.Gson;

@WebServlet("/SSaveProgressServlet")
public class SSaveProgressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");

        BufferedReader reader = request.getReader();
        Map<?, ?> payload = new Gson().fromJson(reader, Map.class);

        String email = (String) payload.get("email");
        int lectureDay = ((Number) payload.get("lecture_day")).intValue();
        int lectureNum = ((Number) payload.get("lecture_num")).intValue();
        int progress = ((Number) payload.get("progress")).intValue();

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "INSERT INTO user_progress (email, lecture_day, lecture_num, progress) " +
                         "VALUES (?, ?, ?, ?) " +
                         "ON CONFLICT (email, lecture_day, lecture_num) DO UPDATE SET progress = EXCLUDED.progress";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setInt(2, lectureDay);
            stmt.setInt(3, lectureNum);
            stmt.setInt(4, progress);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }
        response.setStatus(HttpServletResponse.SC_OK);
    }
}