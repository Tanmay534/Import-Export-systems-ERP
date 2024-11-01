<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Products"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Products</title>

<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome for Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

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
	width: 100%;
	padding: 30px;
	background-color: #FFFFFF;
	color: #4B4B7C;
	min-height: 100vh; /* Maintains full height */
	margin-left: 250px;
	transition: margin-left 0.3s ease;
	display: flex;
	flex-direction: column;
	align-items: center; /* Center horizontally */
	text-align: center;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	justify-content: flex-start; /* Aligns content to the top */
}

h2 {
	color: #1D3557;
	font-weight: bold;
}

button {
	background-color: #457B9D;
	color: #FFFFFF;
	border: none;
	padding: 10px 20px;
	font-size: 1em;
	border-radius: 5px;
	transition: background 0.3s;
}

button:hover {
	background-color: #5A73B8;
}

.table {
	background-color: #F7F9FC;
	color: #4B4B7C;
}

.table thead th {
	color: #1D3557;
}

.table-hover tbody tr:hover {
	background-color: #E1E4F1;
}

/* Dropdown Menu Button Styling */
.dropdown-item {
	color: #457B9D;
	transition: background 0.3s, color 0.3s;
}

.dropdown-item:hover {
	background: rgba(255, 255, 255, 0.2);
	color: #1D3557;
}

.dropdown-item:active {
	background: rgba(0, 0, 0, 0.1);
}

.modal-label {
	text-align: left;
}
</style>
</head>
<body>

	<!-- Top Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark">
		<button type="button" id="sidebarCollapse" class="btn">
			<i class="fas fa-bars"></i>
		</button>
		<a class="navbar-brand ml-3" href="#"></a>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="profileDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> Profile </a>
					<div class="dropdown-menu dropdown-menu-right"
						aria-labelledby="profileDropdown">
						<a class="dropdown-item" href="editProfileSeller.jsp">Edit
							Profile</a>
						<form action="UserController" method="post" style="margin: 0;"
							onsubmit="return confirmDelete();">
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

	<!-- Main Content Area -->
	<div class="wrapper">
		<nav id="sidebar">
			<div class="sidebar-header">
				<h3>PortSync ERP</h3>
			</div>
			<ul class="list-unstyled components">
				<li><form action="ProductController" method="post">
						<input type="hidden" name="action" value="manageProducts">
						<button type="submit" class="nav-link btn btn-link">
							<i class="fas fa-boxes"></i>Manage Products
						</button>
					</form></li>
				<li><form action="ViewController" method="post">
						<input type="hidden" name="action" value="viewOrders">
						<button type="submit" class="nav-link btn btn-link">
							<i class="fas fa-shopping-cart"></i>View Placed Orders
						</button>
					</form></li>
				<li><form action="ReportController" method="post">
						<input type="hidden" name="action" value="viewReportedProducts">
						<button type="submit" class="nav-link btn btn-link">
							<i class="fas fa-exclamation-circle"></i>View Reported Products
						</button>
					</form></li>
			</ul>
		</nav>
	</div>
	<!-- Content -->
	<div id="content">
		<div class="container">
			<h2>Available Products</h2>

			<!-- Add Product Button -->
			<button type="button" class="btn btn-add" data-toggle="modal"
				data-target="#productModal" onclick="showAddForm()">
				<i class="fas fa-plus"></i> Add New Product
			</button>

			<!-- Product List (Server-Side Logic Here) -->
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
							<th>Actions</th>
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
								<button type="button" class="btn btn-edit btn-action"
									onclick="showUpdateForm('<%=product.getProductId()%>', '<%=product.getProductName()%>', <%=product.getPrice()%>, <%=product.getQuantity()%>)">
									<i class="fas fa-edit"></i> Update
								</button>
								<form action="ProductController" method="post"
									style="display: inline;">
									<input type="hidden" name="action" value="removeProduct">
									<input type="hidden" name="productId"
										value="<%=product.getProductId()%>">
									<button type="submit" class="btn btn-delete btn-action">
										<i class="fas fa-trash"></i> Delete
									</button>
								</form>
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

			<!-- Product Modal -->
			<div class="modal fade" id="productModal">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalTitle">Manage Product</h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<!-- Add Product Form -->
							<form action="ProductController" method="post"
								id="addProductForm">
								<input type="hidden" name="action" value="addProduct">
								<div class="form-group">
									<label>Product ID</label> <input type="text" name="productId"
										class="form-control" required>
								</div>
								<div class="form-group">
									<label>Product Name</label> <input type="text"
										name="productName" class="form-control" required>
								</div>
								<div class="form-group">
									<label>Price</label> <input type="number" name="price"
										class="form-control" required>
								</div>
								<div class="form-group">
									<label>Quantity</label> <input type="number" name="quantity"
										class="form-control" required>
								</div>
								<button type="submit" class="btn btn-add">Add Product</button>
							</form>

							<!-- Update Product Form -->
							<form action="ProductController" method="post"
								id="updateProductForm" style="display: none;">
								<input type="hidden" name="action" value="updateProduct">
								<input type="hidden" name="productId" id="updateProductId">
								<div class="form-group">
									<label>Product Name</label> <input type="text"
										name="productName" class="form-control" id="updateProductName"
										required>
								</div>
								<div class="form-group">
									<label>Price</label> <input type="number" name="price"
										class="form-control" id="updatePrice" required>
								</div>
								<div class="form-group">
									<label>Quantity</label> <input type="number" name="quantity"
										class="form-control" id="updateQuantity" required>
								</div>
								<button type="submit" class="btn btn-edit">Update
									Product</button>

							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<%
	String resultMessage = (String) request.getAttribute("resultMessage");
	String alertType = (String) request.getAttribute("alertType"); // "success" or "error"
	%>
	<script type="text/javascript">
    window.onload = function() {
        var resultMessage = "<%=resultMessage != null ? resultMessage : ""%>";
        var alertType = "<%=alertType != null ? alertType : ""%>";

        if (resultMessage) {
            var alertDiv = document.getElementById("alertMessage");
            alertDiv.style.display = "block";
            alertDiv.innerHTML = resultMessage;
            if (alertType === "success") {
                alertDiv.classList.add("alert-success");
            } else if (alertType === "error") {
                alertDiv.classList.add("alert-danger");
            }
        }
    }
</script>

	<!-- jQuery and Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<script>
$(document).ready(function () {
    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });
});

// Show add product form
function showAddForm() {
    document.getElementById('modalTitle').innerHTML = "Add Product";
    document.getElementById('addProductForm').style.display = "block";
    document.getElementById('updateProductForm').style.display = "none";
}

// Show update product form with pre-filled data
function showUpdateForm(productId, productName, price, quantity) {
    document.getElementById('modalTitle').innerHTML = "Update Product";
    document.getElementById('addProductForm').style.display = "none";
    document.getElementById('updateProductForm').style.display = "block";

    document.getElementById('updateProductId').value = productId;
    document.getElementById('updateProductName').value = productName;
    document.getElementById('updatePrice').value = price;
    document.getElementById('updateQuantity').value = quantity;

    $('#productModal').modal('show');
}
</script>
	<%
	String successMessage = (String) request.getAttribute("successMessage");
	%>
	<%
	if (successMessage != null) {
	%>
	<script type="text/javascript">
    alert("<%=successMessage%>");
    // Optionally redirect after the alert
    window.location.href = "<%=request.getContextPath()%>/ProductController?action=manageProducts";
</script>
	<%
	}
	%>

</body>
</html>
