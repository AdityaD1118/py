package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;

        try {
            String url = "jdbc:postgresql://dpg-d6rrmgua2pns73ftebpg-a:5432/course_e20q";
            String user = "root";
            String password = "3QFGQMx0HgBY1jQIsqw7rFuplgbfSqas";

            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(url, user, password);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}