<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Report Product Issue</title>
<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #001f3f;
	color: white;
	font-family: Arial, sans-serif;
}

.container {
	margin-top: 50px;
	max-width: 600px;
	padding: 20px;
	background-color: #0056b3;
	border-radius: 10px;
}

h2 {
	text-align: center;
	margin-bottom: 30px;
}

.form-group input, .form-group select {
	border-radius: 5px;
}

.btn-primary {
	width: 100%;
}
</style>
</head>
<body>
	<div class="container mt-5">
		<h2>Report Product Issue</h2>
		<!-- Form to capture issue details -->
		<form action="UserController" method="post">
			<!-- Hidden action to specify report issue -->
			<input type="hidden" name="action" value="reportProductIssue">

			<!-- Consumer Port ID -->
			<div class="form-group">
				<label for="consumerPortId">Consumer Port ID</label> <input
					type="text" class="form-control" id="consumerPortId"
					name="consumerPortId" required>
			</div>

			<!-- Product ID -->
			<div class="form-group">
				<label for="productId">Product ID</label> <input type="text"
					class="form-control" id="productId" name="productId" required>
			</div>

			<!-- Issue Type -->
			<div class="form-group">
				<label for="issueType">Issue Type</label> <select
					class="form-control" id="issueType" name="issueType" required>
					<option value="DAMAGED">Damaged</option>
					<option value="WRONG">Wrong Product</option>
					<option value="DELAYED">Delayed</option>
					<option value="STILL_NOT_RECEIVED">Still Not Received</option>
					<option value="MISSING">Missing</option>
				</select>
			</div>

			<!-- Submit button -->
			<button type="submit" class="btn btn-primary">Submit Issue</button>
		</form>
	</div>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>