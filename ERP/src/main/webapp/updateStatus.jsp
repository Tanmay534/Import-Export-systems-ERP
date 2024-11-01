<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Track Order</title>
<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	font-family: Arial, sans-serif;
	background-image:
		url('/path-to-image/A_clean,_modern_background_image_for_an_ERP_system.png');
	background-size: cover;
	background-position: center;
	color: #ffffff;
}

.container {
	margin-top: 50px;
	max-width: 600px;
	padding: 30px;
	background-color: rgba(241, 250, 238, 0.9);
	/* Light transparent background */
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Light shadow for depth */
}

h2 {
	text-align: center;
	color: #1D3557; /* Darker blue for the title */
	margin-bottom: 30px;
	font-weight: bold;
}

.status-step {
	padding: 10px;
	border: 2px solid #1D3557; /* Dark blue border */
	border-radius: 5px;
	margin-bottom: 10px;
	position: relative;
	background-color: rgba(29, 53, 87, 0.1); /* Light blue background */
}

.status-step.completed {
	border-color: #28a745; /* Green for completed steps */
	background-color: rgba(40, 167, 69, 0.1); /* Light green background */
}

.status-step.completed:before {
	content: '\2714'; /* Tick mark */
	color: #28a745;
	position: absolute;
	left: -30px;
	top: 10px;
	font-size: 24px;
}

.status-label {
	display: inline-block;
	padding-left: 30px;
	color: #1D3557; /* Dark blue for status labels */
	font-weight: bold;
}

.order-details p {
	color: #1D3557; /* Dark blue for order details */
	font-weight: bold;
}

.btn-back {
	margin-top: 20px;
	background-color: #00bcd4; /* Consistent cyan color */
	border: none;
	padding: 12px;
	font-size: 1.1rem;
	width: 100%;
	border-radius: 5px;
}

.btn-back:hover {
	background-color: #00a3bb;
}
</style>
</head>
<body>

	<div class="container">
		<h2>Track Order</h2>

		<!-- Order Details -->
		<div class="order-details">
			<p>
				<strong>Order ID:</strong>
				<%=request.getAttribute("orderId")%></p>
			<p>
				<strong>Product Name:</strong>
				<%=request.getAttribute("productName")%></p>
			<p>
				<strong>Quantity:</strong>
				<%=request.getAttribute("quantity")%></p>
			<p>
				<strong>Order Date:</strong>
				<%=request.getAttribute("orderDate")%></p>
		</div>

		<!-- Order Status Steps -->
		<div
			class="status-step <%=(request.getAttribute("orderPlaced") != null && (boolean) request.getAttribute("orderPlaced")) ? "completed"
		: ""%>">
			<span class="status-label">Order Placed</span>
		</div>
		<div
			class="status-step <%=(request.getAttribute("shipped") != null && (boolean) request.getAttribute("shipped")) ? "completed" : ""%>">
			<span class="status-label">Shipped</span>
		</div>
		<div
			class="status-step <%=(request.getAttribute("outForDelivery") != null && (boolean) request.getAttribute("outForDelivery"))
		? "completed"
		: ""%>">
			<span class="status-label">Out for Delivery</span>
		</div>
		<div
			class="status-step <%=(request.getAttribute("delivered") != null && (boolean) request.getAttribute("delivered")) ? "completed" : ""%>">
			<span class="status-label">Delivered</span>
		</div>

		<!-- Back Button -->
		<a href="UserController?action=viewOrders" class="btn btn-back">Back
			to View Orders</a>
	</div>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
