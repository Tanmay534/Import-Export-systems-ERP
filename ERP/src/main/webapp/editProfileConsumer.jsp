<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Profile - Consumer</title>

<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome for Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f5f7;
            color: #333;
        }

        .container {
            margin-top: 50px;
            max-width: 500px;
            background-color: #ffffff;
            padding: 40px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #343a40;
            font-weight: 700;
        }

        .form-group label {
            color: #343a40;
            font-weight: 500;
        }

        .form-control {
            border: 1px solid #ced4da;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: #495057;
            box-shadow: none;
        }

        .btn-primary {
            width: 100%;
            background-color: #343a40f;
            border: none;
            padding: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>

</head>
<body>

	<div class="container">
		<h2>
			<i class="fas fa-user-edit"></i> Edit Profile
		</h2>

		<!-- Form for editing profile -->
		<form action="UserController" method="post"
			onsubmit="return validateForm();">
			<!-- Hidden field for action -->
			<input type="hidden" name="action" value="editProfile">

			<!-- New Password (optional) -->
			<div class="form-group">
				<label for="password">New Password (leave blank if no
					change)</label> <input type="password" class="form-control" id="password"
					name="password">
			</div>

			<!-- New Location (only for Consumer, optional) -->
			<div class="form-group">
				<label for="location">New Location (leave blank if no
					change)</label> <input type="text" class="form-control" id="location"
					name="location">
			</div>

			<!-- Submit Button -->
			<button type="submit" class="btn btn-primary">
				<i class="fas fa-save"></i> Update Profile
			</button>
		</form>
	</div>

	<script>
		// Function to validate the form and confirm submission
		function validateForm() {
			const password = document.getElementById("password").value;

			// Check if the password is provided and if it meets the minimum length
			if (password && password.length < 8) {
				alert("Password must be at least 8 characters long.");
				return false; // Prevent form submission
			}

			// Ask for confirmation before submitting the form
			if (confirm("Are you sure you want to update your profile?")) {
				return true; // If confirmed, proceed with form submission
			} else {
				return false; // If canceled, prevent form submission
			}
		}
	</script>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
