<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    // Get session info from login
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    
    // Redirect to login if not authenticated
    if(email == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String orderId = "COURSE-" + System.currentTimeMillis();
    String date = new SimpleDateFormat("MMMM dd, yyyy").format(new java.util.Date());
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Course Access Successful | Learn Platform</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script>
    // Set localStorage for loggedInUser immediately
    const emailFromSession = '<%= email %>';
    if(emailFromSession) {
        localStorage.setItem('loggedInUser', emailFromSession);
        console.log('User session stored in localStorage:', emailFromSession);
    }
</script>
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif; }

html, body { 
    height:100%; 
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

body { 
    display:flex; 
    flex-direction:column; 
    justify-content:center; 
    align-items:center; 
    min-height:100vh; 
    padding: 20px;
}

.success-wrapper {
    background:#fff; 
    border-radius:20px; 
    box-shadow:0 15px 50px rgba(0,0,0,0.2); 
    width:500px; 
    max-width:95%; 
    padding:40px 35px; 
    text-align:center;
    animation: fadeIn 0.5s ease-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.logo { 
    display:flex; 
    justify-content:center; 
    align-items:center; 
    gap:10px; 
    margin-bottom:25px; 
}

.logo img { 
    height:40px; 
    width:40px;
}

.logo span { 
    font-size:24px; 
    font-weight:700; 
    color:#2c3e50; 
    letter-spacing: 0.5px;
}

.checkmark { 
    width:100px; 
    height:100px; 
    border-radius:50%; 
    background: linear-gradient(135deg, #107c10 0%, #0a5c0a 100%);
    display:flex; 
    align-items:center; 
    justify-content:center; 
    margin:0 auto 25px; 
    box-shadow: 0 10px 20px rgba(16, 124, 16, 0.3);
    animation: scaleIn 0.5s ease-out 0.2s both;
}

@keyframes scaleIn {
    from { transform: scale(0); }
    to { transform: scale(1); }
}

.checkmark i { 
    color:#fff; 
    font-size:50px; 
}

h1 { 
    font-size:32px; 
    font-weight:700; 
    margin-bottom:15px; 
    color:#2c3e50; 
}

.welcome-badge {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 8px 20px;
    border-radius: 30px;
    display: inline-block;
    margin-bottom: 20px;
    font-weight: 600;
    font-size: 16px;
}

p { 
    font-size:16px; 
    color:#34495e; 
    margin-bottom:25px; 
    line-height:1.6; 
}

.course-name { 
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    padding: 15px;
    border-radius: 12px;
    font-size:20px; 
    font-weight:700; 
    color:#0078d4; 
    margin-bottom:25px;
    border-left: 4px solid #0078d4;
    text-align: left;
}

.course-name i {
    margin-right: 10px;
    color: #0078d4;
}

.order-details { 
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    border-radius:12px; 
    padding:25px; 
    text-align:left; 
    margin-bottom:25px; 
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
}

.detail-row { 
    display:flex; 
    justify-content:space-between; 
    margin-bottom:15px; 
    font-size:15px; 
    padding-bottom: 10px;
    border-bottom: 1px solid #dee2e6;
}

.detail-row:last-child {
    border-bottom: none;
    margin-bottom: 0;
    padding-bottom: 0;
}

.detail-label { 
    color:#7f8c8d; 
    font-weight:500;
}

.detail-label i {
    margin-right: 5px;
    width: 18px;
    color: #0078d4;
}

.detail-value { 
    font-weight:600; 
    color:#2c3e50;
}

.payment-id {
    font-family: monospace;
    background: #fff;
    padding: 3px 8px;
    border-radius: 4px;
    font-size: 13px;
}

.btn-group {
    display: flex;
    gap: 15px;
    margin-top: 20px;
}

.btn { 
    flex: 1;
    display:inline-block; 
    background: linear-gradient(135deg, #0078d4 0%, #005a9e 100%);
    color:#fff; 
    padding:15px 24px; 
    border-radius:10px; 
    text-decoration:none; 
    font-weight:600; 
    transition: all 0.3s;
    box-shadow: 0 4px 15px rgba(0, 120, 212, 0.3);
    border: none;
    cursor: pointer;
    font-size: 16px;
}

.btn:hover { 
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 120, 212, 0.4);
}

.btn-secondary {
    background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
    box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
}

.btn-secondary:hover {
    box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4);
}

.footer {
    text-align:center;
    font-size:14px;
    color:rgba(255,255,255,0.8);
    padding:20px 0;
    margin-top:20px;
    width:100%;
}

.footer a { 
    color:#fff; 
    text-decoration:none;
    font-weight: 500;
}

.footer a:hover { 
    text-decoration:underline; 
}

.quick-actions {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 20px;
}

.quick-action-item {
    text-align: center;
    color: #fff;
    font-size: 13px;
    cursor: pointer;
    transition: all 0.3s;
}

.quick-action-item:hover {
    transform: translateY(-3px);
}

.quick-action-item i {
    font-size: 20px;
    margin-bottom: 5px;
    display: block;
}

.access-note {
    background: rgba(0, 120, 212, 0.1);
    padding: 12px;
    border-radius: 8px;
    font-size: 14px;
    margin-top: 20px;
    border: 1px dashed #0078d4;
}

.access-note i {
    color: #0078d4;
    margin-right: 8px;
}

.session-info {
    font-size: 12px;
    color: #95a5a6;
    margin-top: 10px;
    padding: 5px;
    border-top: 1px solid #ecf0f1;
}

@media(max-width:500px) {
    .success-wrapper { padding:30px 20px; }
    .btn-group { flex-direction: column; }
    .quick-actions { flex-wrap: wrap; }
}
</style>
</head>
<body>

<div class="success-wrapper">
    <div class="logo">
        <img src="https://img.icons8.com/color/96/000000/checked--v1.png" alt="Success Logo">
        <span>Learn Platform</span>
    </div>

    <div class="checkmark"><i class="fas fa-check"></i></div>
    
    <div class="welcome-badge">
        <i class="fas fa-star"></i> Welcome Back! <i class="fas fa-star"></i>
    </div>
    
    <h1><%= username != null ? username : "Learner" %>!</h1>
    
    <p>
        <i class="fas fa-envelope" style="color: #0078d4; margin-right: 5px;"></i>
        Your course access has been sent to <strong><%= email %></strong>
    </p>

    <div class="course-name">
        <i class="fas fa-robot"></i>
        Learn Python Using AI
    </div>

    <div class="order-details">
        <div class="detail-row">
            <span class="detail-label"><i class="fas fa-hashtag"></i> Order ID:</span>
            <span class="detail-value payment-id"><%= orderId %></span>
        </div>
        <div class="detail-row">
            <span class="detail-label"><i class="far fa-calendar-alt"></i> Date:</span>
            <span class="detail-value"><%= date %></span>
        </div>
        <div class="detail-row">
            <span class="detail-label"><i class="fas fa-check-circle"></i> Payment Status:</span>
            <span class="detail-value" style="color:#107c10;"><i class="fas fa-check-circle"></i> Completed</span>
        </div>
        <div class="detail-row">
            <span class="detail-label"><i class="fas fa-hourglass-half"></i> Access Duration:</span>
            <span class="detail-value">Lifetime Access</span>
        </div>
    </div>

    <div class="btn-group">
        <a href="course.html" class="btn">
            <i class="fas fa-play-circle"></i> Start Learning
        </a>
        <a href="dashboard.jsp" class="btn btn-secondary">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
    </div>
    
    <div class="access-note">
        <i class="fas fa-info-circle"></i>
        Your course is now available. You can access it anytime from your dashboard.
    </div>
    
    <div class="quick-actions">
        <div class="quick-action-item" onclick="window.location.href='resources.jsp'">
            <i class="fas fa-download"></i>
            Resources
        </div>
        <div class="quick-action-item" onclick="window.location.href='community.jsp'">
            <i class="fas fa-users"></i>
            Community
        </div>
        <div class="quick-action-item" onclick="window.location.href='support.jsp'">
            <i class="fas fa-headset"></i>
            Support
        </div>
    </div>
    
    <div class="session-info">
        <i class="fas fa-database"></i> Session stored for: <%= email %>
    </div>
</div>

<div class="footer">
    <p>
        <i class="fas fa-question-circle"></i> Need help? 
        <a href="#"><i class="fas fa-envelope"></i> Contact Support</a>
    </p>
    <p>© 2025 Learn Platform. All rights reserved.</p>
</div>

<script>
// Ensure localStorage is set (redundant but safe)
localStorage.setItem('loggedInUser', '<%= email %>');

// Log for debugging
console.log('Dashboard loaded for user:', '<%= email %>');
console.log('localStorage loggedInUser:', localStorage.getItem('loggedInUser'));

// Add animation to checkmark
document.addEventListener('DOMContentLoaded', function() {
    const checkmark = document.querySelector('.checkmark');
    if(checkmark) {
        checkmark.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.1)';
            this.style.transition = 'transform 0.3s';
        });
        
        checkmark.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
        });
    }
});

// Optional: Keyboard shortcuts
document.addEventListener('keydown', function(e) {
    // Press 'S' to start learning
    if (e.key === 's' || e.key === 'S') {
        window.location.href = 'course.html';
    }
    // Press 'D' for dashboard
    if (e.key === 'd' || e.key === 'D') {
        window.location.href = 'dashboard.jsp';
    }
});
</script>

</body>
</html>