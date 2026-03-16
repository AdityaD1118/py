<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.db.DBConnection" %>

<%
String msg = "";
boolean success = false;

if(request.getMethod().equalsIgnoreCase("POST")) {
    String fullname = request.getParameter("fullname");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm_password");

    // Basic validation
    if(fullname == null || fullname.trim().isEmpty() || 
       email == null || email.trim().isEmpty() ||
       password == null || password.trim().isEmpty() ||
       confirmPassword == null || confirmPassword.trim().isEmpty()) {
        msg = "All fields are required.";
    } else if(!password.equals(confirmPassword)) {
        msg = "Passwords do not match.";
    } else if(password.length() < 6) {
        msg = "Password must be at least 6 characters.";
    } else {
        try (Connection con = DBConnection.getConnection()) {
            
            // Check if email already exists
            String emailCheckSql = "SELECT * FROM users WHERE email=?";
            PreparedStatement pstEmailCheck = con.prepareStatement(emailCheckSql);
            pstEmailCheck.setString(1, email);
            ResultSet rsEmail = pstEmailCheck.executeQuery();
            
            if(rsEmail.next()) {
                msg = "That email is already registered. Please use a different email.";
            } else {
                // Insert new user (matches your users table structure)
                String insertSql = "INSERT INTO users (fullname, email, password, username) VALUES (?, ?, ?, ?)";
                PreparedStatement pstInsert = con.prepareStatement(insertSql);
                pstInsert.setString(1, fullname);
                pstInsert.setString(2, email);
                pstInsert.setString(3, password);
                pstInsert.setString(4, email.split("@")[0]); // username from email prefix
                
                int rowsAffected = pstInsert.executeUpdate();
                
                if(rowsAffected > 0) {
                    msg = "Account created successfully! Please sign in.";
                    success = true;
                } else {
                    msg = "Registration failed. Please try again.";
                }
            }
        } catch (Exception e) {
            msg = "Database error. Please try again later.";
        }
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign Up - ClassBridge</title>
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
.btn-text { background:none; border:none; color:#0078d4; font-size:14px; cursor:pointer; transition:0.3s; }
.btn-text:hover { text-decoration:underline; }
.actions { display:flex; justify-content:space-between; align-items:center; margin-top:12px; }
.msg { margin-top:15px; padding:12px; border-radius:6px; font-size:14px; font-weight:600; }
.msg-error { color:#a80000; background:#fed9cc; border:1px solid #d13438; }
.msg-success { color:#107c10; background:#dff6dd; border:1px solid #107c10; }
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
    <h1>Create account</h1>
    <p class="subtitle">Start learning Python with ClassBridge</p>
    
    <form method="post">
        <input class="input" type="text" name="fullname" placeholder="Full Name" value="<%= request.getParameter("fullname") != null ? request.getParameter("fullname") : "" %>" required>
        <input class="input" type="email" name="email" placeholder="Email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" required>
        <input class="input" type="password" name="password" placeholder="Password" required minlength="6">
        <input class="input" type="password" name="confirm_password" placeholder="Confirm Password" required>
        
        <div class="actions">
            <button class="btn-text" type="button" onclick="location.href='login.jsp'">Have account</button>
            <button class="btn-primary" type="submit">Create account</button>
        </div>
    </form>
    
    <% if (!msg.isEmpty()) { %>
        <div class="msg <%= success ? "msg-success" : "msg-error" %>"><%= msg %></div>
        <% if (success) { %>
            <div style="margin-top:10px;">
                <a href="login.jsp" class="btn-text">Go to Sign In</a>
            </div>
        <% } %>
    <% } %>
</div>

<div class="footer">
    <p>Need help? <a href="#">Contact Support</a></p>
    <p>© 2026 ClassBridge. All rights reserved.</p>
</div>
</body>
</html>
