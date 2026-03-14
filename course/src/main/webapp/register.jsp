<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String msg = "";

if(request.getMethod().equalsIgnoreCase("POST")){
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/microsoft_learn_db", "root", "root")) {

            // 🔍 First check if email already exists
            String checkSql = "SELECT email FROM users WHERE email = ?";
            PreparedStatement checkPst = con.prepareStatement(checkSql);
            checkPst.setString(1, email);
            ResultSet rs = checkPst.executeQuery();

            if(rs.next()){  
                // Email already registered
                msg = "Email is already registered. Please login.";
            } else {
                // Insert new user
                String sql = "INSERT INTO users(username, email, password) VALUES(?,?,?)";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, email);
                pst.setString(3, password);

                int row = pst.executeUpdate();
                if(row > 0){
                    session.setAttribute("username", username);
                    session.setAttribute("email", email);
%>
                    <script>
                        localStorage.setItem('loggedInUser', '<%= email.replace("\\", "\\\\").replace("'", "\\'") %>');
                    </script>
<%
                    response.sendRedirect("payment.jsp");
                    return;
                } else {
                    msg = "Registration Failed!";
                }
            }
        }
    } catch(Exception e){
        msg = "Error: " + e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Your Account</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Arial, sans-serif;
      background: linear-gradient(135deg, #0078d4, #005a9e);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .card {
      background: #fff;
      padding: 40px 35px;
      width: 420px;
      max-width: 90vw;
      border: 1px solid #ddd;
      box-shadow: 0 6px 14px rgba(0,0,0,0.2);
      border-radius: 6px;
    }
    .brand {
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 20px;
      justify-content: center;
    }
    .logo {
      width: 28px;
      height: 28px;
    }
    .title {
      font-size: 22px;
      font-weight: 600;
      margin: 0 0 10px;
      text-align: center;
      color: #323130;
    }
    .subtitle {
      font-size: 14px;
      color: #605e5c;
      margin: 0 0 25px;
      text-align: center;
    }
    .form-group {
      margin-bottom: 18px;
    }
    label {
      display: block;
      font-size: 14px;
      color: #333;
      margin-bottom: 6px;
      font-weight: 500;
    }
    input {
      width: 100%;
      padding: 12px;
      font-size: 15px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
    }
    input:focus {
      border-color: #0078d4;
      outline: none;
      box-shadow: 0 0 0 2px rgba(0,120,212,.2);
    }
    .btn-primary {
      width: 100%;
      padding: 12px;
      font-size: 16px;
      font-weight: 500;
      background: #0078d4;
      color: #fff;
      border: none;
      cursor: pointer;
      margin-top: 10px;
      border-radius: 4px;
      transition: background 0.3s;
    }
    .btn-primary:hover {
      background: #106ebe;
    }
    .signin-link {
      margin-top: 18px;
      display: block;
      text-align: center;
      font-size: 14px;
      color: #0078d4;
      text-decoration: none;
    }
    .signin-link:hover {
      text-decoration: underline;
    }
    .msg {
      margin-top: 15px;
      text-align: try;
      font-size: 14px;
      font-weight: 600;
      color: #a80000;
    }
  </style>
</head>
<body>
  <div class="card">
    <div class="brand">
      <img src="https://img.icons8.com/color/48/000000/login-rounded-right.png" alt="Logo" class="logo"/>
      <span style="font-size:18px;font-weight:600;color:#323130;">ClassBridge</span>
    </div>
    <h1 class="title">Create Account</h1>
    <p class="subtitle">Use your email to create an account</p>
    <form method="post">
      <div class="form-group">
        <label for="username">Name</label>
        <input type="text" id="username" name="username" placeholder="Enter your name" required>
      </div>
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Enter your email" required>
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Create a password" required>
      </div>
      <button type="submit" class="btn-primary">Next</button>
    </form>
    <a class="signin-link" href="login.jsp">Already have an account? Sign in</a>
    <% if(!msg.isEmpty()) { %>
      <div class="msg"><%= msg %></div>
    <% } %>
  </div>
</body>
</html>
