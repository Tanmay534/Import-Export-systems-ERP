<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - ERP Import-Export System</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome for Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #1D3557; /* Navy blue background */
        color: white;
        background-size: cover;
        background-position: center;
        height: 100vh;
    }

    .login-container {
        background-color: rgba(255, 255, 255, 0.9); /* White background with slight opacity */
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
        max-width: 400px;
        margin: auto;
        margin-top: 10%;
    }

    h2 {
        color: #1D3557; /* Dark blue for heading */
        font-size: 1.8rem;
        font-weight: bold;
        text-align: center;
        margin-bottom: 30px;
    }

    .form-label {
        font-weight: bold;
        color: #1D3557; /* Dark blue for labels */
    }

    .form-control, .form-select {
        border-radius: 5px;
        border: 1px solid #457b9d;
    }

    .btn-primary {
        width: 100%;
        background-color: #1D3557; /* Dark blue for button */
        border: none;
        padding: 10px;
        border-radius: 5px;
        color: white;
    }

    .btn-primary:hover {
        background-color: #2A9D8F; /* Dark teal for hover */
    }

    .register-link {
        color: #1D3557; /* Dark blue for register link */
        text-decoration: none;
    }

    .register-link:hover {
        color: #2A9D8F; /* Teal for hover effect on register link */
    }

    .text-center.mt-3 {
        margin-top: 15px;
    }
</style>

<script>
    function showAlert(message) {
        alert(message);
    }
</script>
</head>
<body>

    <div class="login-container">
        <h2>
            <i class="fas fa-lock"></i> Login
        </h2>

        <form action="UserController" method="post">
            <input type="hidden" name="action" value="login">

            <!-- Port ID Field -->
            <div class="mb-3">
                <label for="portId" class="form-label">Port ID</label>
                <input type="text" name="portId" class="form-control" id="portId" placeholder="Enter Port ID" required>
            </div>

            <!-- Password Field -->
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" name="password" class="form-control" id="password" placeholder="Password" required>
            </div>

            <!-- Role Selection (Consumer or Seller) -->
            <div class="mb-3">
                <label for="role" class="form-label">Role</label>
                <select name="role" class="form-select" id="role" required>
                    <option value="CONSUMER">Consumer</option>
                    <option value="SELLER">Seller</option>
                </select>
            </div>

            <!-- Login Button -->
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-sign-in-alt"></i> Login
            </button>

            <!-- Registration Link -->
            <div class="text-center mt-3">
                <a href="register.jsp" class="register-link">Register as a new user</a>
            </div>
        </form>
    </div>

    <!-- Display alert if errorMessage or successMessage is set -->
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
    String redirectUrl = (String) request.getAttribute("redirectUrl");

    if (errorMessage != null) {
%>
    <script>
        showAlert("<%=errorMessage%>");
    </script>
<%
    }
    if (successMessage != null) {
%>
    <script>
        showAlert("<%=successMessage%>");
        setTimeout(function() {
            window.location.href = "<%=redirectUrl%>";
        });
    </script>
<%
    }
%>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
</body>
</html>