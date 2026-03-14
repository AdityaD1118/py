<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Master Python - Register</title>
  <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Arial, sans-serif;
      background-color: #f3f2f1;
      color: #323130;
    }

    /* Navbar */
    header {
      background-color: #0078D4;
      padding: 12px 24px;
      color: white;
      font-size: 18px;
      font-weight: 600;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    header img {
      height: 28px;
    }

    nav a {
      color: white;
      text-decoration: none;
      margin-left: 20px;
      font-weight: 500;
    }

    nav a:hover {
      text-decoration: underline;
    }

    /* Register Form */
    .register-container {
      max-width: 450px;
      margin: 80px auto;
      background: white;
      padding: 40px 30px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      text-align: center;
    }

    .register-container h2 {
      margin-bottom: 25px;
      font-size: 28px;
      color: #0078D4;
    }

    .register-container form {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    .register-container input {
      padding: 12px 15px;
      font-size: 15px;
      border: 1px solid #ccc;
      border-radius: 6px;
      transition: 0.3s;
    }

    .register-container input:focus {
      border-color: #0078D4;
      outline: none;
      box-shadow: 0 0 5px rgba(0,120,212,0.3);
    }

    .register-container button {
      padding: 12px 20px;
      font-size: 16px;
      background: #0078D4;
      color: white;
      border: none;
      border-radius: 6px;
      font-weight: 600;
      cursor: pointer;
      transition: 0.3s;
    }

    .register-container button:hover {
      background: #005a9e;
    }

    .register-container p {
      margin-top: 15px;
      font-size: 14px;
      color: #605e5c;
    }

    .register-container p a {
      color: #0078D4;
      text-decoration: none;
      font-weight: 600;
    }

    .register-container p a:hover {
      text-decoration: underline;
    }

    /* Footer */
    footer {
      background: #0078D4;
      color: white;
      text-align: center;
      padding: 15px;
      margin-top: 60px;
    }
  </style>
</head>
<body>
  <!-- Navbar -->
  <header>
    <div style="display: flex; align-items: center;">
      <img src="https://upload.wikimedia.org/wikipedia/commons/4/44/Microsoft_logo.svg" alt="Logo">
      &nbsp; Master Python
    </div>
    <nav>
      <a href="index.html">Home</a>
      <a href="courses.html">Courses</a>
      <a href="login.jsp">Log In</a>
      <a href="register.jsp">Sign Up</a>
    </nav>
  </header>

  <!-- Register Form -->
  <div class="register-container">
    <h2>Create Account</h2>
    <form action="register.jsp" method="POST">
      <input type="text" name="fullname" placeholder="Full Name" required>
      <input type="email" name="email" placeholder="Email Address" required>
      <input type="password" name="password" placeholder="Password" required>
      <input type="password" name="confirm_password" placeholder="Confirm Password" required>
      <button type="submit">Sign Up</button>
    </form>
    <p>Already have an account? <a href="login.jsp">Log In</a></p>
  </div>

  <!-- Footer -->
  <footer>
    © 2025 Master Python. All rights reserved.
  </footer>
</body>
</html>