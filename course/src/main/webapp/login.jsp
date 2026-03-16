<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.db.DBConnection" %> <!-- Update this with your actual package -->

<%
String msg = "";

// 🔹 Database validation section
if(request.getMethod().equalsIgnoreCase("POST")) {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try (Connection con = DBConnection.getConnection()) {

        String emailCheckSql = "SELECT * FROM users WHERE email=?";
        PreparedStatement pstEmail = con.prepareStatement(emailCheckSql);
        pstEmail.setString(1, email);
        ResultSet rsEmail = pstEmail.executeQuery();

        if (!rsEmail.next()) {
            msg = "That account doesn't exist. Enter a different account.";
        } else {
            String passwordCheckSql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement pstPass = con.prepareStatement(passwordCheckSql);
            pstPass.setString(1, email);
            pstPass.setString(2, password);
            ResultSet rsPass = pstPass.executeQuery();

            if (rsPass.next()) {
                // ✅ Save user info in session
                session.setAttribute("username", rsPass.getString("username"));
                session.setAttribute("email", email);
                session.setAttribute("userEmail", email);

                // ✅ Check paid user status
                String paidUserCheckSql = "SELECT * FROM paid_users WHERE email=?";
                PreparedStatement pstPaid = con.prepareStatement(paidUserCheckSql);
                pstPaid.setString(1, email);
                ResultSet rsPaid = pstPaid.executeQuery();
                boolean isPaidUser = rsPaid.next();

%>
                <script>
                    localStorage.setItem('loggedInUser', '<%= email.replace("\\", "\\\\").replace("'", "\\'") %>');
                </script>
<%
                // Server-side redirect
                response.sendRedirect(isPaidUser ? "next.jsp" : "payment.jsp");
                return;
            } else {
                msg = "Your account or password is incorrect.";
            }
        }
    } catch (Exception e) {
        msg = "Error: " + e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign In</title>
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
    <h1>Sign in</h1>
    <p class="subtitle">Use your account to access courses</p>
    <form method="post">
        <input class="input" type="email" name="email" placeholder="Email" required>
        <input class="input" type="password" name="password" placeholder="Password" required>
        <div style="margin-bottom:16px; text-align:left;">
            <a href="forgot.jsp" class="btn-text">Forgot password?</a>
        </div>
        <div class="actions">
            <button class="btn-text" type="button" onclick="location.href='register.jsp'">Create account</button>
            <button class="btn-primary" type="submit">Next</button>
        </div>
    </form>
    <% if (!msg.isEmpty()) { %>
        <div class="msg"><%= msg %></div>
    <% } %>
</div>

<div class="footer">
    <p>Need help? <a href="#">Contact Support</a></p>
    <p>© 2026 ClassBridge. All rights reserved.</p>
</div>
</body>
</html>