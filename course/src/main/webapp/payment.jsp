<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Secure Payment | Learn Platform</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
}

body {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.payment-container {
    display: flex;
    max-width: 1000px;
    width: 100%;
    background: white;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2);
    animation: fadeIn 0.5s ease-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.payment-left {
    flex: 1;
    background: linear-gradient(135deg, #0078d4 0%, #005a9e 100%);
    color: white;
    padding: 40px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.payment-right {
    flex: 1.2;
    padding: 40px;
}

.logo-section {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 30px;
}

.logo-circle {
    width: 50px;
    height: 50px;
    background: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #0078d4;
    font-size: 24px;
    font-weight: bold;
}

.logo-text {
    font-size: 24px;
    font-weight: 700;
    letter-spacing: 0.5px;
}

.course-info {
    margin-top: 40px;
}

.course-info h3 {
    font-size: 22px;
    margin-bottom: 20px;
    font-weight: 600;
}

.feature-list {
    list-style: none;
}

.feature-list li {
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 12px;
    font-size: 15px;
}

.feature-list i {
    color: #4cd964;
    background: rgba(255, 255, 255, 0.1);
    width: 24px;
    height: 24px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.price-tag {
    background: rgba(255, 255, 255, 0.1);
    padding: 20px;
    border-radius: 12px;
    margin-top: 30px;
    text-align: center;
}

.original-price {
    text-decoration: line-through;
    color: rgba(255, 255, 255, 0.7);
    font-size: 16px;
}

.current-price {
    font-size: 36px;
    font-weight: 700;
    margin: 10px 0;
}

.discount-badge {
    background: #4cd964;
    color: white;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
    display: inline-block;
    margin-top: 5px;
}

.payment-header {
    margin-bottom: 30px;
}

.payment-header h1 {
    font-size: 28px;
    color: #2c3e50;
    margin-bottom: 10px;
    font-weight: 700;
}

.payment-header p {
    color: #7f8c8d;
    font-size: 15px;
}

.user-info-section {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 25px;
    border-left: 4px solid #0078d4;
}

.user-detail {
    display: flex;
    margin-bottom: 10px;
}

.user-label {
    font-weight: 600;
    color: #2c3e50;
    min-width: 80px;
}

.user-value {
    color: #34495e;
}

.input-group {
    margin-bottom: 20px;
}

.input-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #2c3e50;
    font-size: 14px;
}

.input-with-icon {
    position: relative;
}

.input-with-icon i {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #7f8c8d;
}

.input-with-icon input {
    width: 100%;
    padding: 15px 15px 15px 45px;
    border: 2px solid #e1e5e9;
    border-radius: 10px;
    font-size: 15px;
    transition: all 0.3s;
    background: white;
}

.input-with-icon input:focus {
    border-color: #0078d4;
    box-shadow: 0 0 0 3px rgba(0, 120, 212, 0.1);
    outline: none;
}

.input-with-icon input[readonly] {
    background: #f8f9fa;
    color: #6c757d;
    cursor: not-allowed;
}

.payment-details {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 25px;
}

.payment-summary {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    padding-bottom: 15px;
    border-bottom: 1px solid #dee2e6;
}

.payment-summary:last-child {
    border-bottom: none;
    margin-bottom: 0;
    padding-bottom: 0;
    font-weight: 700;
    font-size: 18px;
    color: #2c3e50;
}

.pay-button {
    background: linear-gradient(135deg, #0078d4 0%, #005a9e 100%);
    color: white;
    border: none;
    padding: 18px;
    width: 100%;
    border-radius: 12px;
    font-size: 17px;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    transition: all 0.3s;
    box-shadow: 0 4px 15px rgba(0, 120, 212, 0.3);
}

.pay-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 120, 212, 0.4);
}

.pay-button:active {
    transform: translateY(0);
}

.security-note {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-top: 20px;
    color: #27ae60;
    font-size: 14px;
    padding: 10px;
    background: rgba(39, 174, 96, 0.1);
    border-radius: 8px;
}

.security-note i {
    font-size: 16px;
}

.loading-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.7);
    justify-content: center;
    align-items: center;
    z-index: 1000;
}

.loading-spinner {
    background: white;
    padding: 30px;
    border-radius: 15px;
    text-align: center;
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

.spinner {
    width: 50px;
    height: 50px;
    border: 4px solid #f3f3f3;
    border-top: 4px solid #0078d4;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin: 0 auto 20px;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.back-link {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    color: #0078d4;
    text-decoration: none;
    font-weight: 500;
    margin-top: 20px;
    transition: color 0.3s;
}

.back-link:hover {
    color: #005a9e;
}

@media (max-width: 768px) {
    .payment-container {
        flex-direction: column;
        max-width: 500px;
    }
    
    .payment-left, .payment-right {
        padding: 30px;
    }
}
</style>
</head>
<body>
<div class="payment-container">
    <!-- Left Section: Course Details -->
    <div class="payment-left">
        <div>
            <div class="logo-section">
                <div class="logo-circle">LP</div>
                <div class="logo-text">Learn Platform</div>
            </div>
            
            <div class="course-info">
                <h3>Python & AI Mastery Course</h3>
                <ul class="feature-list">
                    <li><i class="fas fa-check"></i> 30 Days Comprehensive Learning</li>
                    <li><i class="fas fa-check"></i> 60+ Interactive Lectures</li>
                    <li><i class="fas fa-check"></i> Hands-on AI Projects</li>
                    <li><i class="fas fa-check"></i> Certificate of Completion</li>
                    <li><i class="fas fa-check"></i> Lifetime Access & Updates</li>
                    <li><i class="fas fa-check"></i> 24/7 Learning Support</li>
                </ul>
            </div>
        </div>
        
        <div class="price-tag">
            <div class="original-price">₹2,499</div>
            <div class="current-price">₹500</div>
            <div class="discount-badge">80% OFF Today Only</div>
        </div>
    </div>
    
    <!-- Right Section: Payment Form -->
    <div class="payment-right">
        <div class="payment-header">
            <h1>Complete Your Payment</h1>
            <p>Secure transaction powered by Razorpay</p>
        </div>
        
        <div class="user-info-section">
            <div class="user-detail">
                <span class="user-label">User:</span>
                <span class="user-value"><%= username != null ? username : "Guest" %></span>
            </div>
            <div class="user-detail">
                <span class="user-label">Email:</span>
                <span class="user-value"><%= email %></span>
            </div>
        </div>
        
        <form id="paymentForm" onsubmit="return false;">
            <div class="input-group">
                <label for="name">Full Name</label>
                <div class="input-with-icon">
                    <i class="fas fa-user"></i>
                    <input type="text" id="name" placeholder="Enter your full name" required 
                           value="<%= username != null ? username : "" %>">
                </div>
            </div>
            
            <div class="input-group">
                <label for="email">Email Address</label>
                <div class="input-with-icon">
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" placeholder="Enter your email" required 
                           value="<%= email %>" readonly>
                </div>
            </div>
            
            <div class="payment-details">
                <div class="payment-summary">
                    <span>Course Fee</span>
                    <span>₹2,499</span>
                </div>
                <div class="payment-summary">
                    <span>Discount (80%)</span>
                    <span style="color:#27ae60;">-₹1,999</span>
                </div>
                <div class="payment-summary">
                    <span>Total Amount</span>
                    <span>₹500</span>
                </div>
            </div>
            
            <button type="button" id="rzp-button" class="pay-button">
                <i class="fas fa-lock"></i>
                Pay Securely ₹500
            </button>
            
            <div class="security-note">
                <i class="fas fa-shield-alt"></i>
                <span>Your payment is secured with 256-bit SSL encryption</span>
            </div>
            
            <a href="javascript:history.back()" class="back-link">
                <i class="fas fa-arrow-left"></i>
                Back to Course Details
            </a>
        </form>
    </div>
</div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-spinner">
        <div class="spinner"></div>
        <h3>Processing Payment</h3>
        <p>Please wait while we securely process your payment...</p>
        <p><small>Do not close or refresh this window</small></p>
    </div>
</div>

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
document.getElementById('rzp-button').onclick = function(e){
    e.preventDefault();

    const name = document.getElementById('name').value.trim();
    const email = document.getElementById('email').value.trim();
    const loadingOverlay = document.getElementById('loadingOverlay');

    if(!name) {
        alert("Please enter your full name!");
        document.getElementById('name').focus();
        return;
    }

    // Show loading overlay
    loadingOverlay.style.display = 'flex';

    const fixedAmount = 500; // INR

    const options = {
        "key": "rzp_test_RJMwq4RGkNQLmY",
        "amount": fixedAmount * 100,
        "currency": "INR",
        "name": "Learn Python Platform",
        "description": "Python & AI Course - Full Access",
        "image": "https://img.icons8.com/color/96/000000/python.png",
        "handler": function (response){
            // Keep showing loading while processing
            loadingOverlay.querySelector('h3').textContent = "Payment Successful!";
            loadingOverlay.querySelector('p').textContent = "Saving your course access...";
            
            // Send payment data to SaveUserServlet
            fetch("SaveUserServlet", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    name: name,
                    email: email,
                    payment_id: response.razorpay_payment_id,
                    amount: fixedAmount,
                    course_name: "Python & AI Course"
                })
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === "success") {
                    // Redirect to success page after 2 seconds
                    setTimeout(() => {
                        window.location.href = "next.jsp";
                    }, 2000);
                } else {
                    loadingOverlay.style.display = 'none';
                    alert("Payment completed but there was an error: " + data.message);
                }
            })
            .catch(err => {
                console.error(err);
                loadingOverlay.style.display = 'none';
                alert('Payment completed but there was an error saving details. Please contact support.');
            });
        },
        "prefill": { 
            "name": name, 
            "email": email,
            "contact": "" // You can add phone field if needed
        },
        "theme": { 
            "color": "#0078d4",
            "backdrop_color": "#00000080"
        },
        "modal": {
            "ondismiss": function() {
                loadingOverlay.style.display = 'none';
            },
            "escape": false,
            "animation": true
        },
        "notes": {
            "course": "Python & AI Course",
            "user": email
        }
    };

    const rzp = new Razorpay(options);
    rzp.open();
    
    // Prevent closing during processing
    rzp.on('payment.failed', function(response){
        loadingOverlay.style.display = 'none';
        console.error(response.error);
        alert("Payment failed: " + response.error.description);
    });
}

// Smooth focus effect for inputs
document.querySelectorAll('input').forEach(input => {
    input.addEventListener('focus', function() {
        this.parentElement.style.transform = 'scale(1.02)';
    });
    
    input.addEventListener('blur', function() {
        this.parentElement.style.transform = 'scale(1)';
    });
});
</script>
</body>
</html>