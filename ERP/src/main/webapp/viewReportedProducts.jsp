<%@ page import="java.util.List"%>
<%@ page import="model.ReportProducts"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Reported Products</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #FFFFFF;
	color: #4B4B7C;
}

.container {
	margin-top: 50px;
	padding: 30px;
	background-color: rgba(241, 250, 238, 0.9);
	/* Light Container Background */
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

h2 {
	color: #1D3557; /* Dark Blue for Header */
	text-align: center;
	margin-bottom: 30px;
}

.table {
	margin-top: 20px;
}

th {
	background-color: #001F3F; /* Forest Green for Table Header */
	color: white; /* White Text for Table Header */
}

td {
	background-color: white; /* White Background for Table Cells */
}

tr:nth-child(even) td {
	background-color: #f2f2f2; /* Light Gray for even rows */
}

tr:hover {
	background-color: #e9ecef; /* Light hover effect */
}

.btn-back {
	background-color: #1D3557; /* Dark Blue for Back Button */
	color: white;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<div class="container mt-5">
		<h2>Reported Products</h2>

		<!-- Back Button -->
		<form action="UserController" method="post">
			<a href="SellerDashboard.jsp" class="btn btn-back">Back</a>
			
		</form>

		<!-- Table to display reported products -->
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Report ID</th>
					<th>Product ID</th>
					<th>Issue Type</th>
					<th>Solution</th>
					<th>Report Date</th>
					<th>Consumer ID</th>
				</tr>
			</thead>
			<tbody>
				<%
				// Retrieve the reported products list from the request attribute
				List<model.ReportProducts> reportedProducts = (List<model.ReportProducts>) request.getAttribute("reportedProducts");
				if (reportedProducts != null && !reportedProducts.isEmpty()) {
					for (model.ReportProducts rp : reportedProducts) {
				%>
				<tr>
					<td><%=rp.getReportId()%></td>
					<td><%=rp.getProductId()%></td>
					<td><%=rp.getIssueType()%></td>
					<td><%=rp.getSolution()%></td>
					<td><%=rp.getReportDate()%></td>
					<td><%=rp.getConsumerPortId()%></td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="6" class="text-center">No reported products
						available</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
