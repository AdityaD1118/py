<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    // Get session info from login
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String orderId = "COURSE-" + System.currentTimeMillis();
    String date = new SimpleDateFormat("MMMM dd, yyyy").format(new java.util.Date());
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Course Access Successful</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif; }

html, body { height:100%; background:#f0f2f5; }

body { display:flex; flex-direction:column; justify-content:center; align-items:center; min-height:100vh; }

.success-wrapper {
    background:#fff; 
    border-radius:12px; 
    box-shadow:0 10px 25px rgba(0,0,0,0.2); 
    width:450px; 
    max-width:95%; 
    padding:40px 35px; 
    text-align:center;
}

.logo { display:flex; justify-content:center; align-items:center; gap:10px; margin-bottom:25px; }
.logo img { height:32px; }
.logo span { font-size:20px; font-weight:600; color:#737373; }

.checkmark { width:80px; height:80px; border-radius:50%; background:#107c10; display:flex; align-items:center; justify-content:center; margin:0 auto 20px; }
.checkmark i { color:#fff; font-size:40px; }

h1 { font-size:28px; font-weight:600; margin-bottom:12px; color:#323130; }
p { font-size:15px; color:#605e5c; margin-bottom:20px; line-height:1.6; }

.course-name { font-size:18px; font-weight:600; color:#0078d4; margin-bottom:20px; }

.order-details { background:#f3f2f1; border-radius:6px; padding:20px; text-align:left; margin-bottom:20px; }
.detail-row { display:flex; justify-content:space-between; margin-bottom:10px; font-size:14px; }
.detail-label { color:#605e5c; }
.detail-value { font-weight:500; }

.btn { display:inline-block; background:#0078d4; color:#fff; padding:12px 24px; border-radius:6px; text-decoration:none; font-weight:600; margin-top:10px; }
.btn:hover { background:#106ebe; }

.footer {
    text-align:center;
    font-size:14px;
    color:#605e5c;
    padding:15px 0;
    margin-top:20px;
    width:100%;
}

.footer a { color:#0078d4; text-decoration:none; }
.footer a:hover { text-decoration:underline; }

@media(max-width:500px) {
    .success-wrapper { padding:30px 20px; }
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="success-wrapper">
    <div class="logo">
        <img src="https://img.icons8.com/color/96/000000/checked--v1.png" alt="Success Logo">
        <span>Learn Platform</span>
    </div>

    <div class="checkmark"><i class="fas fa-check"></i></div>
    <h1>Welcome, <%= username != null ? username : "User" %>!</h1>
    <p>Your payment was successful! Your course is now available at <b><%= email != null ? email : "your email" %></b>.</p>

    <div class="course-name">Learn Python Using AI</div>

    <div class="order-details">
        <div class="detail-row">
            <span class="detail-label">Order ID:</span>
            <span class="detail-value"><%= orderId %></span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Date:</span>
            <span class="detail-value"><%= date %></span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Payment Status:</span>
            <span class="detail-value">Completed</span>
        </div>
    </div>

    <a href="course.html" class="btn">Start Learning</a>
</div>

<div class="footer">
    <p>Need help? <a href="#">Contact Support</a></p>
    <p>© 2025 All rights reserved.</p>
</div>

</body>
</html>