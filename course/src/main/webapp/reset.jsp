<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String msg = "";
String email = (String) session.getAttribute("resetEmail");

if(email == null) {
    response.sendRedirect("forgot.jsp");
    return;
}

if(request.getMethod().equalsIgnoreCase("POST")) {
    String newPass = request.getParameter("password");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/microsoft_learn_db", "root", "root")) {

            String sql = "UPDATE users SET password=? WHERE email=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, newPass);
            pst.setString(2, email);

            int rows = pst.executeUpdate();
            if(rows > 0) {
                session.removeAttribute("resetEmail");
                response.sendRedirect("login.jsp?msg=Password reset successful");
                return;
            } else {
                msg = "Failed to reset password!";
            }
        }
    } catch(Exception e) {
        msg = "Error: " + e.getMessage();
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Reset Password</title>
<style>
  body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background: #f3f2f1;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
  }
  .card {
    background: #fff;
    padding: 40px 35px;
    width: 400px;
    border: 1px solid #ddd;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }
  .brand {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 25px;
  }
  .m-logo {
    width: 28px;
    height: 28px;
  }
  h2 {
    margin: 0 0 10px;
    font-size: 22px;
    font-weight: 600;
  }
  p {
    font-size: 14px;
    color: #605e5c;
    margin-bottom: 20px;
  }
  .input {
    width: 100%;
    padding: 10px;
    font-size: 15px;
    border: 1px solid #ccc;
    margin-bottom: 16px;
  }
  .input:focus {
    border-color: #0078d4;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0,120,212,.2);
  }
  .btn-primary {
    background: #0078d4;
    color: #fff;
    border: none;
    padding: 10px 20px;
    font-size: 15px;
    cursor: pointer;
    font-weight: 500;
  }
  .btn-primary:hover {
    background: #106ebe;
  }
  .msg {
    margin-top: 12px;
    color: #a80000;
    font-size: 14px;
    font-weight: 600;
  }
  .footer {
    margin-top: 20px;
    font-size: 13px;
  }
  .footer a {
    color: #0078d4;
    text-decoration: none;
  }
  .footer a:hover {
    text-decoration: underline;
  }
</style>
</head>
<body>
  <div class="card">
    <div class="brand">
      <img src="https://img.icons8.com/color/48/microsoft.png" alt="Microsoft" class="m-logo"/>
      <span style="font-size:18px;font-weight:600;color:#323130;">Microsoft</span>
    </div>
    <h2>Reset your password</h2>
    <p>Choose a new password for your Microsoft account.</p>
    <form method="post">
      <input class="input" type="password" name="password" placeholder="New password" required>
      <button class="btn-primary" type="submit">Reset Password</button>
    </form>
    <div class="msg"><%= msg %></div>
    <div class="footer">
      <a href="login.jsp">Back to sign in</a>
    </div>
  </div>
</body>
</html>
