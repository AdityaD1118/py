package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DBConnection {

    // 1️⃣ Get Connection to Render PostgreSQL
    public static Connection getConnection() {
        Connection con = null;

        try {
            String url = "jdbc:postgresql://dpg-d6rrmgua2pns73ftebpg-a.postgres.render.com:5432/course_e20q?sslmode=require";
            String user = "root";
            String password = "3QFGQMx0HgBY1jQIsqw7rFuplgbfSqas";

            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(url, user, password);

            System.out.println("✅ Connected to Render PostgreSQL successfully!");
        } catch (Exception e) {
            System.out.println("❌ Connection failed!");
            e.printStackTrace();
        }

        return con;
    }

    // 2️⃣ Main method to insert test user
    public static void main(String[] args) {

        Connection con = getConnection();

        if (con != null) {
            try {
                String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
                PreparedStatement pst = con.prepareStatement(sql);

                // ⚡ Change these values if needed
                pst.setString(1, "aditya");
                pst.setString(2, "aditya@gmail.com");
                pst.setString(3, "1234");

                int rows = pst.executeUpdate();

                if (rows > 0) {
                    System.out.println("✅ User inserted successfully into Render DB!");
                } else {
                    System.out.println("❌ Insert failed!");
                }

                pst.close();
                con.close();

            } catch (Exception e) {
                System.out.println("❌ Error inserting user!");
                e.printStackTrace();
            }
        } else {
            System.out.println("❌ DB Connection Failed!");
        }
    }
}