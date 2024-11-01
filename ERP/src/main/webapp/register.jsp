<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register</title>

<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome for Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #1D3557; /* Navy blue background */
    color: white;
}

.container {
    margin-top: 50px;
    max-width: 600px;
    padding: 30px;
    background-color: rgba(255, 255, 255, 0.9); /* White with slight opacity */
    border-radius: 10px;
    color: #1D3557; /* Navy blue text for container */
}

h2 {
    text-align: center;
    margin-bottom: 30px;
    color: #1D3557;
    font-weight: bold;
}

label {
    font-weight: bold;
    color: #1D3557;
}

.form-control {
    border-radius: 5px;
    border: 1px solid #1D3557;
    color: #1D3557;
}

.btn-primary {
    width: 100%;
    background-color: #1D3557;
    border: none;
    color: white;
    padding: 10px 15px;
    border-radius: 5px;
}

.btn-primary:hover {
    background-color: #457b9d;
}

.login-link p {
    text-align: center;
    margin-top: 20px;
    color: #1D3557;
}

.login-link a {
    color: #1D3557;
    text-decoration: underline;
}

.form-group.hidden {
    display: none;
}
</style>

<script>
// Toggle location field based on role (Consumer/Seller)
function toggleLocationField() {
    const role = document.getElementById('role').value;
    const locationField = document.getElementById('locationField');
    if (role === 'CONSUMER') {
        locationField.classList.remove('hidden');
    } else {
        locationField.classList.add('hidden');
    }
}

// Form validation for password length and match
function validateForm() {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    if (password.length < 8) {
        alert("Password must be at least 8 characters long.");
        return false; // Prevent form submission
    }

    if (password !== confirmPassword) {
        alert("Password and Confirm Password do not match.");
        return false; // Prevent form submission
    }
    
    return true; // Allow form submission if validation passes
}
</script>
</head>
<body>

	<div class="container">
		<h2>
			<i class="fas fa-user-plus"></i> Register
		</h2>

		<form action="UserController" method="post" onsubmit="return validateForm()">
			<input type="hidden" name="action" value="register">

			<!-- Port ID -->
			<div class="form-group">
				<label for="portId">User ID</label> <input type="text"
					class="form-control" id="portId" name="portId" required>
			</div>

			<!-- Password -->
			<div class="form-group">
				<label for="password">Password</label> <input type="password"
					class="form-control" id="password" name="password" required>
			</div>

			<!-- Confirm Password -->
			<div class="form-group">
				<label for="confirmPassword">Confirm Password</label> <input
					type="password" class="form-control" id="confirmPassword"
					name="confirmPassword" required>
			</div>

			<!-- Role (Consumer or Seller) -->
			<div class="form-group">
				<label for="role">Role</label> <select class="form-control"
					id="role" name="role" onchange="toggleLocationField()" required>
					<option value="CONSUMER">Consumer</option>
					<option value="SELLER">Seller</option>
				</select>
			</div>

			<!-- Location (only for Consumer) -->
			<div class="form-group" id="locationField">
				<label for="location">Location</label> <input type="text"
					class="form-control" id="location" name="location">
			</div>

			<!-- Submit Button -->
			<button type="submit" class="btn btn-primary">
				<i class="fas fa-sign-in-alt"></i> Register
			</button>
		</form>

		<!-- Login link -->
		<div class="login-link">
			<p>
				Already have an account? <a href="login.jsp">Login here</a>
			</p>
		</div>
	</div>

	<script>
// Check if there is a success message in the session
<%String successMessage = (String) session.getAttribute("successMessage");%>
<%if (successMessage != null) {%>
   alert("<%=successMessage%>");
   <%session.removeAttribute("successMessage");%> // Remove it after displaying
<%}%>

// Check if there is an error message in the session
<%String errorMessage = (String) session.getAttribute("errorMessage");%>
<%if (errorMessage != null) {%>
   alert("<%=errorMessage%>");
   <%session.removeAttribute("errorMessage");%> // Remove it after displaying
<%}%>
		
	</script>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
