<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Certificate Generator</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }
    
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #e6f2ff 0%, #f0f8ff 100%);
      color: #333;
      line-height: 1.6;
      padding: 20px;
      min-height: 100vh;
    }
    
    .container {
      max-width: 1200px;
      margin: 0 auto;
    }
    
    header {
      text-align: center;
      margin-bottom: 30px;
    }
    
    .logo {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 20px;
    }
    
    .logo img {
      height: 40px;
      margin-right: 15px;
    }
    
    h1 {
      color: #0078d4;
      font-weight: 600;
      font-size: 2.5rem;
      margin-bottom: 10px;
    }
    
    .subtitle {
      color: #737373;
      font-size: 1.2rem;
      margin-bottom: 30px;
    }
    
    .content {
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
    }
    
    .form-container {
      flex: 1;
      min-width: 350px;
      background: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    }
    
    .preview-container {
      flex: 1;
      min-width: 350px;
      background: white;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
      display: flex;
      flex-direction: column;
    }
    
    .preview-title {
      text-align: center;
      margin-bottom: 20px;
      color: #0078d4;
      font-weight: 600;
    }
    
    .certificate-preview {
      border: 1px dashed #ccc;
      border-radius: 8px;
      padding: 20px;
      flex-grow: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      background: #f9f9f9;
      min-height: 400px;
    }
    
    .preview-content {
      text-align: center;
      color: #666;
    }
    
    .preview-content i {
      font-size: 3rem;
      color: #0078d4;
      margin-bottom: 15px;
    }
    
    h2 {
      color: #0078d4;
      margin-bottom: 20px;
      text-align: center;
      font-weight: 600;
    }
    
    .form-group {
      margin-bottom: 20px;
    }
    
    label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: #555;
    }
    
    input, select {
      width: 100%;
      padding: 14px;
      border: 1px solid #ddd;
      border-radius: 6px;
      font-size: 16px;
      transition: border 0.3s;
    }
    
    input:focus, select:focus {
      outline: none;
      border-color: #0078d4;
      box-shadow: 0 0 0 2px rgba(0, 120, 212, 0.2);
    }
    
    button {
      background: #0078d4;
      color: white;
      font-size: 18px;
      padding: 16px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      width: 100%;
      font-weight: 600;
      transition: background 0.3s;
      margin-top: 10px;
    }
    
    button:hover {
      background: #0062aa;
    }
    
    .secondary-btn {
      background: #f0f0f0;
      color: #333;
    }
    
    .secondary-btn:hover {
      background: #e0e0e0;
    }
    
    .button-group {
      display: flex;
      gap: 10px;
    }
    
    .button-group button {
      width: auto;
      flex: 1;
    }
    
    .certificate {
      border: 15px solid #0078d4;
      padding: 40px;
      width: 100%;
      background: #fff;
      border-radius: 5px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    }
    
    .certificate-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
    }
    
    .verified-badge {
      color: #107c10;
      font-weight: bold;
      font-size: 18px;
    }
    
    .certificate-title {
      font-size: 28px;
      font-weight: bold;
      color: #0078d4;
      margin: 20px 0;
      text-align: center;
    }
    
    .recipient-name {
      font-size: 32px;
      font-weight: bold;
      margin: 25px 0;
      text-align: center;
      color: #222;
    }
    
    .course-info {
      font-size: 18px;
      margin: 15px 0;
      text-align: center;
    }
    
    .signatures {
      margin-top: 50px;
      display: flex;
      justify-content: space-around;
    }
    
    .signature {
      text-align: center;
      font-size: 14px;
    }
    
    .signature-line {
      border-top: 1px solid #000;
      width: 200px;
      margin-bottom: 8px;
      padding-top: 5px;
    }
    
    .certificate-footer {
      margin-top: 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 14px;
      color: #555;
    }
    
    @media (max-width: 900px) {
      .content {
        flex-direction: column;
      }
    }
    
    .error-message {
      color: #d13438;
      font-size: 14px;
      margin-top: 5px;
      display: none;
    }
  </style>
</head>
<body>
  <div class="container">
    <header>
      <div class="logo">
        <img src="https://img.icons8.com/color/96/000000/certificate.png" alt="Certificate Logo">
        <h1>Certificate Generator</h1>
      </div>
      
      <p class="subtitle">Create your verified certificate of achievement for completed courses</p>
    </header>
    
    <div class="content">
      <div class="form-container">
        <h2>Enter Your Details</h2>
        <form id="certForm">
          <div class="form-group">
            <label for="fullname">Full Name:</label>
            <input type="text" id="fullname" placeholder="Enter your full name" required>
            <div class="error-message" id="nameError">Please enter a valid name</div>
          </div>
          
          <div class="form-group">
            <label for="course">Course Name:</label>
            <select id="course" required>
              <option value="Python using AI">Python using AI</option>
            </select>
            <div class="error-message" id="courseError">Please select a course</div>
          </div>
          
          <div class="form-group">
            <label for="date">Completion Date:</label>
            <input type="date" id="date" required>
            <div class="error-message" id="dateError">Please select a valid date</div>
          </div>
          
          <button type="submit">Generate Certificate</button>
          <button type="button" class="secondary-btn" id="resetBtn">Reset Form</button>
        </form>
      </div>
      
      <div class="preview-container">
        <h2 class="preview-title">Certificate Preview</h2>
        <div class="certificate-preview">
          <div class="preview-content">
            <i class="fas fa-certificate"></i>
            <p>Your certificate will appear here after generating</p>
          </div>
        </div>
        <div class="button-group">
          <button class="secondary-btn" id="downloadBtn" disabled>Download Certificate</button>
          <button class="secondary-btn" id="printBtn" disabled>Print Certificate</button>
        </div>
      </div>
    </div>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const today = new Date();
      const formattedDate = today.toISOString().split('T')[0];
      document.getElementById('date').value = formattedDate;
      
      const form = document.getElementById('certForm');
      const resetBtn = document.getElementById('resetBtn');
      const downloadBtn = document.getElementById('downloadBtn');
      const printBtn = document.getElementById('printBtn');
      const previewContainer = document.querySelector('.certificate-preview');
      const nameInput = document.getElementById('fullname');
      const courseSelect = document.getElementById('course');
      const dateInput = document.getElementById('date');
      
      form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const name = nameInput.value;
        const course = courseSelect.value;
        const date = dateInput.value;
        
        if (!name || !course || !date) {
          alert("Please fill in all fields");
          return;
        }
        
        const formattedDate = formatDate(date);
        
        const certificateHTML = `
          <div class="certificate">
            <div class="certificate-header">
              <div class="verified-badge">VERIFIED<br><span style="font-size:14px;color:#555;">CERTIFICATE of ACHIEVEMENT</span></div>
              <img src="https://img.icons8.com/color/96/000000/certificate.png" width="140" alt="Certificate Logo">
            </div>

            <p class="course-info">This is to certify that</p>
            <div class="recipient-name">${name}</div>
            <p class="course-info">successfully completed and received a passing grade in</p>
            <p class="course-info"><b>${course}</b></p>
            <p class="course-info">Completion Date: <b>${formattedDate}</b></p>
            <p class="course-info">a course of study offered by Learn Platform.</p>

            <div class="signatures">
              <div class="signature">
                <div class="signature-line"></div>
                <b>Course Director</b><br>
                Learn Platform
              </div>
              <div class="signature">
                <div class="signature-line"></div>
                <b>Head of Education</b><br>
                Learn Platform
              </div>
            </div>

            <div class="certificate-footer">
              <div>Issued: ${formattedDate}</div>
              <div>Certificate ID: CERT-${Date.now().toString().slice(-8)}</div>
            </div>
          </div>
        `;
        
        previewContainer.innerHTML = certificateHTML;
        
        downloadBtn.disabled = false;
        printBtn.disabled = false;
      });
      
      resetBtn.addEventListener('click', function() {
        form.reset();
        document.getElementById('date').value = formattedDate;
        previewContainer.innerHTML = `
          <div class="preview-content">
            <i class="fas fa-certificate"></i>
            <p>Your certificate will appear here after generating</p>
          </div>
        `;
        downloadBtn.disabled = true;
        printBtn.disabled = true;
      });
      
      printBtn.addEventListener('click', function() {
        const certificate = previewContainer.querySelector('.certificate');
        if (certificate) {
          const printWindow = window.open('', '_blank');
          printWindow.document.write(`
            <html>
              <head>
                <title>Print Certificate</title>
                <style>
                  body { 
                    font-family: Arial, sans-serif; 
                    display: flex; 
                    justify-content: center; 
                    align-items: center; 
                    height: 100vh; 
                    margin: 0; 
                  }
                  .certificate { 
                    border: 15px solid #0078d4; 
                    padding: 40px; 
                    width: 800px; 
                    background: #fff; 
                  }
                  .certificate-header { 
                    display: flex; 
                    justify-content: space-between; 
                    align-items: center; 
                    margin-bottom: 30px; 
                  }
                  .verified-badge { 
                    color: #107c10; 
                    font-weight: bold; 
                    font-size: 18px; 
                  }
                  .recipient-name { 
                    font-size: 32px; 
                    font-weight: bold; 
                    margin: 25px 0; 
                    text-align: center; 
                  }
                  .course-info { 
                    font-size: 18px; 
                    margin: 15px 0; 
                    text-align: center; 
                  }
                  .signatures { 
                    margin-top: 50px; 
                    display: flex; 
                    justify-content: space-around; 
                  }
                  .signature { 
                    text-align: center; 
                    font-size: 14px; 
                  }
                  .signature-line { 
                    border-top: 1px solid #000; 
                    width: 200px; 
                    margin-bottom: 8px; 
                    padding-top: 5px; 
                  }
                  .certificate-footer { 
                    margin-top: 40px; 
                    display: flex; 
                    justify-content: space-between; 
                    align-items: center; 
                    font-size: 14px; 
                    color: #555; 
                  }
                </style>
              </head>
              <body>
                ${certificate.outerHTML}
                <script>
                  window.onload = function() {
                    window.print();
                  };
                <\/script>
              </body>
            </html>
          `);
          printWindow.document.close();
        }
      });
      
      downloadBtn.addEventListener('click', function() {
        alert("In a real implementation, this would download your certificate as a PDF. For now, please use the print function and save as PDF.");
      });
      
      function formatDate(dateString) {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', { 
          year: 'numeric', 
          month: 'long', 
          day: 'numeric' 
        });
      }
    });
  </script>
</body>
</html>