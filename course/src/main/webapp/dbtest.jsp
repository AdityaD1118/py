<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:postgresql://dpg-d6rrmgua2pns73ftebpg-a.postgres.render.com:5432/course_e20q?sslmode=require";
    String user = "root";       // your Render DB username
    String password = "3QFGQMx0HgBY1jQIsqw7rFuplgbfSqas"; // your Render DB password
    try {
        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection(url, user, password);
        out.println("✅ Connected to Render DB successfully!");
        con.close();
    } catch(Exception e) {
        out.println("❌ Connection failed: " + e.getMessage());
    }
%>