<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.db.DBConnection" %>

<%
String msg = "";

if(request.getMethod().equalsIgnoreCase("POST")) {
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try (Connection con = DBConnection.getConnection()) {

        // Check if email already exists
        String checkSql = "SELECT * FROM users WHERE email=?";
        PreparedStatement pstCheck = con.prepareStatement(checkSql);
        pstCheck.setString(1, email);
        ResultSet rsCheck = pstCheck.executeQuery();

        if(rsCheck.next()) {
            msg = "Email already registered. Please login.";
        } else {
            // Insert new user
            String insertSql = "INSERT INTO users(username, email, password) VALUES(?, ?, ?)";
            PreparedStatement pstInsert = con.prepareStatement(insertSql);
            pstInsert.setString(1, username);
            pstInsert.setString(2, email);
            pstInsert.setString(3, password); // ⚠️ Use hashed password for security later
            int inserted = pstInsert.executeUpdate();

            if(inserted > 0) {
                msg = "Registration successful! Please login.";
                response.sendRedirect("login.jsp");
                return;
            } else {
                msg = "Failed to register. Try again.";
            }

            pstInsert.close();
        }

        rsCheck.close();
        pstCheck.close();

    } catch(Exception e) {
        e.printStackTrace();
        msg = "Something went wrong. Please try again later.";
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif; }
html, body { height:100%; background:#f0f2f5; }
body { display:flex; flex-direction:column; justify-content:center; align-items:center; min-height:100vh; }
.login-wrapper { background:#fff; border-radius:12px; box-shadow:0 10px 25px rgba(0,0,0,0.2); width:400px; max-width:90%; padding:40px 35px; text-align:center; }
.logo { display:flex; justify-content:center; align-items:center; gap:10px; margin-bottom:25px; }
.logo img { height:32px; }
.logo span { font-size:20px; font-weight:600; color:#737373; }
h1 { font-size:28px; font-weight:600; margin-bottom:12px; color:#323130; }
p.subtitle { font-size:14px; color:#605e5c; margin-bottom:25px; }
.input { width:100%; padding:12px; font-size:15px; border:1px solid #ccc; border-radius:6px; margin-bottom:16px; }
.input:focus { border-color:#0078d4; outline:none; box-shadow:0 0 0 2px rgba(0,120,212,.2); }
.btn-primary { background:#0078d4; color:#fff; border:none; padding:12px; width:100%; font-size:16px; font-weight:600; border-radius:6px; cursor:pointer; transition:0.3s; }
.btn-primary:hover { background:#106ebe; transform:translateY(-1px); }
.msg { margin-top:15px; color:#a80000; font-weight:600; font-size:14px; }
.footer { text-align:center; font-size:14px; color:#605e5c; padding:15px 0; margin-top:20px; width:100%; }
.footer a { color:#0078d4; text-decoration:none; }
.footer a:hover { text-decoration:underline; }
@media(max-width:500px) { .login-wrapper { padding:30px 20px; } }
</style>
</head>
<body>
<div class="login-wrapper">
    <div class="logo">
        <img src="https://upload.wikimedia.org/wikipedia/commons/4/44/Microsoft_logo.svg" alt="Logo">
        <span>ClassBridge</span>
    </div>
    <h1>Create Account</h1>
    <p class="subtitle">Fill the details to register</p>
    <form method="post">
        <input class="input" type="text" name="username" placeholder="Username" required>
        <input class="input" type="email" name="email" placeholder="Email" required>
        <input class="input" type="password" name="password" placeholder="Password" required>
        <button class="btn-primary" type="submit">Register</button>
    </form>
    <% if(!msg.isEmpty()) { %>
        <div class="msg"><%= msg %></div>
    <% } %>
</div>

<div class="footer">
    <p>Need help? <a href="#">Contact Support</a></p>
    <p>© 2026 ClassBridge. All rights reserved.</p>
</div>
</body>
</html>