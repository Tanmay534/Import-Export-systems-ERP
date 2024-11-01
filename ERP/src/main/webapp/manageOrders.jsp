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
/* Custom styling */
body {
	font-family: 'Arial', sans-serif;
	background-color: white;
	color: #003366;
}

.container {
	padding: 20px;
	background-color: #FFFFFF; /* Set background to white */
	border-radius: 8px;
	margin-top: 30px;
}

h2 {
	color: #003366;
	font-weight: bold;
	margin-bottom: 20px;
}

.btn-back {
	background-color: #003366;
	color: #fff;
	margin-bottom: 20px;
}

.btn-back:hover {
	background-color: #002244;
}

.table th, .table td {
	color: #003366;
}

.table thead th {
	background-color: #003366;
	color: #fff;
}

.table-bordered {
	border: 1px solid #003366;
}

.btn-primary {
	background-color: #003366;
	border-color: #003366;
}

.btn-primary:hover {
	background-color: #002244;
	border-color: #002244;
}

.btn-warning {
	color: #003366;
	background-color: #ffcc00;
	border-color: #ffcc00;
}

.btn-warning:hover {
	color: #fff;
	background-color: #cc9900;
	border-color: #cc9900;
}

.btn-success {
	background-color: #28a745;
	border-color: #28a745;
}

.btn-success:hover {
	background-color: #218838;
	border-color: #218838;
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
							<input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
							<input type="hidden" id="actionInput_<%=order.getOrderId()%>" name="action" value="">

							<button type="button" class="btn btn-primary"
								onclick="submitForm('<%=order.getOrderId()%>', 'shipped')">
								<i class="fas fa-truck"></i> Shipped
							</button>
							<button type="button" class="btn btn-warning"
								onclick="submitForm('<%=order.getOrderId()%>', 'outForDelivery')">
								<i class="fas fa-shipping-fast"></i> Out for Delivery
							</button>
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
		function submitForm(orderId, action) {
			document.getElementById('actionInput_' + orderId).value = action;
			alert("Status updated successfully to " + action + "!");
			document.querySelector('[action="OrderController"]').submit();
		}

		function goBack() {
			window.location.href = "SellerDashboard.jsp";
		}
	</script>

</body>
</html>