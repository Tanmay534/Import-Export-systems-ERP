<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PortSync ERP</title>
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
	background-color: #FFFFFF; /* White background */
	color: #4B4B7C;
}

.wrapper {
	display: flex;
	width: 100%;
}

/* Enhanced Navbar Styling */
.navbar {
	background: linear-gradient(90deg, #001F3F 0%, #003366 100%);
	/* Navy blue gradient */
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
	/* Navy blue gradient */
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
	background-color: #FFFFFF; /* White background */
	color: #4B4B7C;
	min-height: 100vh;
	margin-left: 250px;
	transition: margin-left 0.3s ease;
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
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
	color: #457B9D; /* Navy blue color */
	transition: background 0.3s, color 0.3s;
}

.dropdown-item:hover {
	background: rgba(255, 255, 255, 0.2); /* Light background on hover */
	color: #1D3557; /* Darker navy blue color */
}

.dropdown-item:active {
	background: rgba(0, 0, 0, 0.1); /* Darker background when active */
}
</style>
</head>
<body>

	<!-- Navbar with Profile and Logout at the top -->
	<nav class="navbar navbar-expand-lg navbar-dark">
		<div class="navbar-left">
			<button type="button" id="sidebarCollapse" class="btn">
				<i class="fas fa-bars"></i>
			</button>
			<span class="navbar-title"></span>
			<!-- Removed "PortSync ERP" from here -->
		</div>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown"> Profile </a>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" href="editProfileConsumer.jsp">Edit Profile</a>
						<form action="UserController" method="post"
							style="display: inline;" onsubmit="return confirmDelete();">
							<input type="hidden" name="action" value="deleteProfile">
							<button type="submit" class="dropdown-item"
								style="background: none; border: none; cursor: pointer;">Delete
								Profile</button>
						</form>
					</div></li>
				<li class="nav-item"><a class="nav-link"
					href="UserController?action=logout">Logout</a></li>
			</ul>
		</div>
	</nav>

	<!-- Sidebar with "PortSync ERP" Title and Functionalities -->
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

		<!-- Content Area Centered Welcome Message -->
		<div id="content">
			<div class="text-center">
				<h2>Welcome Consumer!</h2>
				<p>Explore available products in the inventory, track orders, or report
					issues—all from this centralized dashboard.</p>

			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$('#sidebarCollapse').on('click', function() {
				$('#sidebar').toggleClass('active');
				if ($('#sidebar').hasClass('active')) {
					$('#sidebar').css('transform', 'translateX(-250px)');
					$('#content').css('margin-left', '0');
				} else {
					$('#sidebar').css('transform', 'translateX(0)');
					$('#content').css('margin-left', '250px');
				}
			});
		});
		function confirmDelete() {
			return confirm("Are you sure you want to delete your profile?");
		}
	</script>
</body>
</html>