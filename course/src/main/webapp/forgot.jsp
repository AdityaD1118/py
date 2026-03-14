<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String msg = "";
if(request.getMethod().equalsIgnoreCase("POST")) {
    String email = request.getParameter("email");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/microsoft_learn_db", "root", "root")) {
            
            String sql = "SELECT * FROM users WHERE email=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            
            if(rs.next()) {
                session.setAttribute("resetEmail", email);
                response.sendRedirect("reset.jsp");
                return;
            } else {
                msg = "That Microsoft account doesn’t exist. Enter a different account.";
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
<title>Forgot Password</title>
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
    <h2>Forgot Password</h2>
    <p>Enter your Microsoft account email and we’ll help you reset your password.</p>
    <form method="post">
      <input class="input" type="email" name="email" placeholder="Email address" required>
      <button class="btn-primary" type="submit">Next</button>
    </form>
    <div class="msg"><%= msg %></div>
    <div class="footer">
      <a href="login.jsp">Back to sign in</a>
    </div>
  </div>
</body>
</html>
