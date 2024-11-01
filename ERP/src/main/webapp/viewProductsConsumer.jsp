<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Products"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Products - PortSync ERP</title>
<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Font Awesome for Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Google Font for Professional Text -->
<link
	href="https://fonts.googleapis.com/css2?family=Merriweather:wght@700&display=swap"
	rel="stylesheet">

<style>
/* Global Styling */
body {
	font-family: 'Arial', sans-serif;
	background-color: #FFFFFF;
	color: #4B4B7C;
}

.wrapper {
	display: flex;
	width: 100%;
}

/* Enhanced Navbar Styling */
.navbar {
	background: linear-gradient(90deg, #001F3F 0%, #003366 100%);
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.navbar-title {
	font-size: 1.3em;
	font-weight: 700;
	font-family: 'Merriweather', serif;
	color: #FFFFFF;
	margin-left: 45px;
	transition: color 0.3s;
}

.navbar-title:hover {
	color: #A8DADC;
}

.navbar .nav-link {
	color: #FFFFFF !important;
	font-weight: bold;
}

.navbar .nav-link:hover {
	color: #A8DADC !important;
}

/* Enhanced Sidebar Styling */
#sidebar {
	width: 250px;
	background: linear-gradient(180deg, #001F3F 0%, #003366 100%);
	color: #FFFFFF;
	position: fixed;
	height: 100%;
	z-index: 1000;
	padding-top: 20px;
	box-shadow: 2px 0px 10px rgba(0, 0, 0, 0.2);
}

#sidebar .sidebar-header {
	font-size: 1.6em;
	font-weight: bold;
	text-align: center;
	color: #FFFFFF;
	padding-bottom: 15px;
	margin-bottom: 20px;
}

#sidebar ul.components {
	padding: 0;
}

#sidebar ul li a, #sidebar ul li button {
	padding: 12px 20px;
	font-size: 1em;
	display: flex;
	align-items: center;
	color: #FFFFFF;
	background: none;
	width: 100%;
	border: none;
	transition: background 0.3s, color 0.3s;
	cursor: pointer;
	text-align: left;
}

#sidebar ul li a:hover, #sidebar ul li button:hover {
	background: rgba(255, 255, 255, 0.1);
	color: #A8DADC;
	border-radius: 4px;
}

#sidebar ul li i {
	margin-right: 10px;
	transition: transform 0.3s;
	color: #A8DADC;
}

#sidebar ul li:hover i {
	transform: scale(1.2);
}

/* Sidebar Toggle Button */
#sidebarCollapse {
	background: #457B9D;
	color: #FFFFFF;
	border: none;
	position: fixed;
	top: 15px;
	left: 15px;
	z-index: 1050;
	cursor: pointer;
	border-radius: 5px;
	transition: background 0.3s;
}

#sidebarCollapse:hover {
	background: #5A73B8;
}

/* Content Area Styling */
#content {
	width: calc(100% - 250px);
	min-height: 100vh;
	margin-left: 250px;
	padding: 20px;
	transition: margin-left 0.3s ease;
}

/* Products Table Styling */
.table {
	background-color: #F7F9FC;
	color: #4B4B7C;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
}

.table thead th {
	background-color: #001F3F;
	color: #FFFFFF;
	border-bottom: none;
	padding: 15px;
}

.table tbody td {
	padding: 12px 15px;
	vertical-align: middle;
}

.table-hover tbody tr:hover {
	background-color: #E1E4F1;
}

/* Button Styling */
.btn-manage {
	background-color: #457B9D;
	color: #FFFFFF;
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	transition: background-color 0.3s;
}

.btn-manage:hover {
	background-color: #5A73B8;
	color: #FFFFFF;
}

/* Modal Styling */
.modal-content {
	border-radius: 8px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
}

.modal-header {
	background: linear-gradient(90deg, #001F3F 0%, #003366 100%);
	color: #FFFFFF;
	border-bottom: none;
}

.modal-footer {
	border-top: none;
	background-color: #F7F9FC;
}

.form-control {
	border-radius: 4px;
	border: 1px solid #DDE2E5;
	padding: 8px 12px;
}

.alert-warning {
	background-color: #FFF3CD;
	color: #856404;
	border-color: #FFEEBA;
	border-radius: 4px;
}

.bold-text {
	color: #1D3557;
	font-weight: 600;
}

/* Dropdown Menu Styling */
.dropdown-menu {
	background-color: #FFFFFF;
	border: none;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	border-radius: 4px;
}

.dropdown-item {
	color: #4B4B7C;
	transition: background-color 0.3s;
}

.dropdown-item:hover {
	background-color: #E1E4F1;
	color: #1D3557;
}
</style>
</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark">
		<div class="navbar-left">
			<button type="button" id="sidebarCollapse" class="btn">
				<i class="fas fa-bars"></i>
			</button>
			<span class="navbar-title"></span>
		</div>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown"> Profile </a>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" href="editProfile.jsp">Edit Profile</a>
						<form action="UserController" method="post"
							style="display: inline;">
							<input type="hidden" name="action" value="deleteProfile">
							<button type="submit" class="dropdown-item">Delete
								Profile</button>
						</form>
					</div></li>
				<li class="nav-item"><a class="nav-link"
					href="UserController?action=logout">Logout</a></li>
			</ul>
		</div>
	</nav>

	<!-- Sidebar -->
	<div class="wrapper">
		<nav id="sidebar">
			<div class="sidebar-header">PortSync ERP</div>
			<ul class="list-unstyled components">
				<li>
					<form action="ViewController" method="post">
						<input type="hidden" name="action" value="viewProducts">
						<button type="submit" class="nav-link btn btn-link">
							<i class="fas fa-box"></i> View Listed Products
						</button>
					</form>
				</li>
				<li>
					<form action="ViewController" method="post">
						<input type="hidden" name="action" value="viewOrders">
						<button type="submit" class="nav-link btn btn-link">
							<i class="fas fa-shopping-cart"></i> View Your Orders
						</button>
					</form>
				</li>
				<li>
					<form action="ReportController" method="post">
						<input type="hidden" name="action" value="reportProduct">
						<button type="submit" class="nav-link btn btn-link">
							<i class="fas fa-exclamation-triangle"></i>Report Product Issue
						</button>
					</form>
				</li>
			</ul>
		</nav>

		<!-- Content Area -->
		<div id="content">
			<div class="container-fluid">
				<h2 class="mb-4">Available Products</h2>

				<%
				List<Products> productList = (List<Products>) request.getAttribute("productList");
				if (productList == null || productList.isEmpty()) {
				%>
				<div class="alert alert-warning text-center">No products
					available at the moment.</div>
				<%
				} else {
				%>
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Product ID</th>
								<th>Product Name</th>
								<th>Price</th>
								<th>Quantity</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Products product : productList) {
							%>
							<tr>
								<td><%=product.getProductId()%></td>
								<td><%=product.getProductName()%></td>
								<td>$<%=product.getPrice()%></td>
								<td><%=product.getQuantity()%></td>
								<td>
									<button type="button" class="btn btn-manage"
										data-toggle="modal" data-target="#orderModal"
										data-id="<%=product.getProductId()%>"
										data-name="<%=product.getProductName()%>"
										data-quantity="<%=product.getQuantity()%>">
										<i class="fas fa-shopping-cart"></i> Order
									</button>
								</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<!-- Order Modal -->
	<div class="modal fade" id="orderModal" tabindex="-1" role="dialog"
		aria-labelledby="orderModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="orderModalLabel">Place Order</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="orderForm" action="OrderController" method="post"
						onsubmit="return submitOrderForm();">
						<input type="hidden" name="action" value="placeOrder">
						<div class="form-group">
							<p id="productId" class="bold-text"></p>
							<input type="hidden" name="productId">
						</div>
						<div class="form-group">
							<p id="productName" class="bold-text"></p>
							<input type="hidden" name="productName">
						</div>
						<div class="form-group">
							<label for="quantity" class="bold-text">Quantity</label> <input
								type="number" class="form-control" id="quantity" name="quantity"
								required> <input type="hidden" id="availableQuantity"
								name="availableQuantity">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-manage">Place Order</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document)
				.ready(
						function() {
							$('#sidebarCollapse').on(
									'click',
									function() {
										$('#sidebar').toggleClass('active');
										if ($('#sidebar').hasClass('active')) {
											$('#sidebar').css('transform',
													'translateX(-250px)');
											$('#content').css('margin-left',
													'0');
										} else {
											$('#sidebar').css('transform',
													'translateX(0)');
											$('#content').css('margin-left',
													'250px');
										}
									});

							$('#orderModal')
									.on(
											'show.bs.modal',
											function(event) {
												var button = $(event.relatedTarget);
												var productId = button
														.data('id');
												var productName = button
														.data('name');
												var availableQuantity = button
														.data('quantity');

												var modal = $(this);
												modal.find('#productId').text(
														"Product ID: "
																+ productId);
												modal
														.find('#productName')
														.text(
																"Product Name: "
																		+ productName);
												modal
														.find(
																'input[name="productId"]')
														.val(productId);
												modal
														.find(
																'input[name="productName"]')
														.val(productName);
												modal
														.find(
																'#availableQuantity')
														.val(availableQuantity);
											});
						});

		function submitOrderForm() {
			var enteredQuantity = parseInt($('#quantity').val());
			var availableQuantity = parseInt($('#availableQuantity').val());

			if (enteredQuantity > availableQuantity) {
				alert("Order quantity cannot exceed available quantity.");
				return false;
			}

			alert("Order placed successfully!");
			return true;
		}
	</script>

</body>
</html>