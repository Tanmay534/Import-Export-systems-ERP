<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Orders"%>
<%
String role = (String) session.getAttribute("role");

// Check if there's a status update message
String statusMessage = (String) session.getAttribute("statusMessage");
if (statusMessage != null) {
	session.removeAttribute("statusMessage"); // Remove after displaying
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Orders</title>

<!-- Bootstrap CSS and scripts -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<style>
/* Add custom styling */
body {
	font-family: 'Arial', sans-serif;
	background-color: #f1fafe;
	color: #333;
}

.container {
	padding: 20px;
	background-color: rgba(241, 250, 238, 0.8);
	border-radius: 8px;
	margin-top: 30px;
}

h2 {
	color: #1D3557;
	font-weight: bold;
	margin-bottom: 20px;
}

.btn-back {
	background-color: #1D3557;
	color: #fff;
	margin-bottom: 20px;
}

.btn-back:hover {
	background-color: #16304A;
}
</style>
</head>
<body>

	<div class="container">
		<!-- Back Button -->
		<button class="btn btn-back" onclick="goBack()">
			<i class="fas fa-arrow-left"></i> Back
		</button>

		<h2>
			<i class="fas fa-box-open"></i> Manage Orders
		</h2>

		<%
		List<Orders> ordersList = (List<Orders>) request.getAttribute("ordersList");
		if (ordersList == null || ordersList.isEmpty()) {
		%>
		<div class="alert alert-warning text-center">No orders to manage
			yet.</div>
		<%
		} else {
		%>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>Order ID</th>
					<th>Product ID</th>
					<th>Quantity</th>
					<th>Order Date</th>
					<th>Status</th>
					<th>Update Status</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Orders order : ordersList) {
				%>
				<tr>
					<td><%=order.getOrderId()%></td>
					<td><%=order.getProductId()%></td>
					<td><%=order.getQuantity()%></td>
					<td><%=order.getOrderDate()%></td>
					<td><%=order.isDelivered()
		? "Delivered"
		: (order.isOutForDelivery() ? "Out for Delivery" : (order.isShipped() ? "Shipped" : "Placed"))%></td>

					<td>
						<form action="OrderController" method="post">
							<!-- Hidden field for the order ID -->
							<input type="hidden" name="orderId"
								value="<%=order.getOrderId()%>">
								
							<!-- Hidden field for dynamic action -->
							<input type="hidden" id="actionInput_<%=order.getOrderId()%>" name="action" value="">

							<!-- Shipped Button -->
							<button type="button" class="btn btn-primary"
								onclick="submitForm('<%=order.getOrderId()%>', 'shipped')">
								<i class="fas fa-truck"></i> Shipped
							</button>

							<!-- Out for Delivery Button -->
							<button type="button" class="btn btn-warning"
								onclick="submitForm('<%=order.getOrderId()%>', 'outForDelivery')">
								<i class="fas fa-shipping-fast"></i> Out for Delivery
							</button>

							<!-- Delivered Button -->
							<button type="button" class="btn btn-success"
								onclick="submitForm('<%=order.getOrderId()%>', 'delivered')">
								<i class="fas fa-check"></i> Delivered
							</button>
						</form>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		}
		%>
	</div>

	<!-- JavaScript for showing status update message and handling form submission -->
	<script>
		// Function to handle form submission and update action input value
		function submitForm(orderId, action) {
			// Set the value of the hidden input to the action (shipped, outForDelivery, or delivered)
			document.getElementById('actionInput_' + orderId).value = action;

			// Show the popup message
			alert("Status updated successfully to " + action + "!");

			// Submit the form after showing the alert
			document.querySelector('[action="OrderController"]').submit();
		}

		// Function to go back to the previous page
		function goBack() {
			window.location.href = "SellerDashboard.jsp";
		}
	</script>

</body>
</html>
