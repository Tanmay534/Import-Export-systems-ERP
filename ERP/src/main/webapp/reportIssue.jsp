<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Report Product Issue</title>

<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Font Awesome for Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Google Font for Professional Text -->
<link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@700&display=swap" rel="stylesheet">

<style>
/* Global Styling */
body {
    font-family: 'Arial', sans-serif;
    background-color: #FFFFFF;
    color: #4B4B7C;
    min-height: 100vh;
    position: relative;
    margin: 0;
    padding: 0;
}

.main-container {
    display: flex;
    min-height: calc(100vh - 56px);
    margin-top: 56px;
    position: relative;
}

/* Enhanced Navbar Styling */
.navbar {
    background: linear-gradient(90deg, #001F3F 0%, #003366 100%);
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 1030;
    height: 56px;
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
    min-height: 100%;
    transition: all 0.3s ease;
    position: relative;
    flex-shrink: 0;
}

#sidebar.active {
    margin-left: -250px;
}

#sidebar .sidebar-header {
    font-size: 1.6em;
    font-weight: bold;
    text-align: center;
    color: #FFFFFF;
    padding: 20px 0;
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
    text-decoration: none;
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
    padding: 8px 12px;
    border-radius: 4px;
    cursor: pointer;
    margin-right: 15px;
}

#sidebarCollapse:hover {
    background: #5A73B8;
}

/* Content Area Styling */
#content {
    flex-grow: 1;
    padding: 30px;
    background-color: #FFFFFF;
    transition: all 0.3s ease;
    width: 100%;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
}

h2 {
    color: #1D3557;
    font-weight: bold;
    margin-bottom: 30px;
}

/* Form Styling */
.form-group {
    margin-bottom: 20px;
}

.form-control {
    border: 1px solid #ced4da;
    border-radius: 4px;
    padding: 10px;
}

.form-control:focus {
    border-color: #457B9D;
    box-shadow: 0 0 0 0.2rem rgba(69, 123, 157, 0.25);
}

button.btn-primary {
    background-color: #457B9D;
    border: none;
    padding: 10px 20px;
    font-size: 1em;
    border-radius: 5px;
    transition: background 0.3s;
}

button.btn-primary:hover {
    background-color: #5A73B8;
}

/* Dropdown Styling */
.dropdown-menu {
    background-color: #FFFFFF;
    border: 1px solid rgba(0, 0, 0, 0.1);
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.dropdown-item {
    color: #4B4B7C;
    padding: 8px 20px;
}

.dropdown-item:hover {
    background-color: #f8f9fa;
    color: #1D3557;
}

/* Responsive Design */
@media (max-width: 768px) {
    #sidebar {
        position: fixed;
        height: 100%;
        z-index: 1020;
        margin-left: -250px;
    }
    
    #sidebar.active {
        margin-left: 0;
    }
    
    .main-container {
        margin-left: 0;
    }
    
    #content {
        width: 100%;
        margin-left: 0;
        padding: 15px;
    }
    
    .container {
        padding: 0 10px;
    }
    
    h2 {
        font-size: 1.5em;
    }
}
</style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <button type="button" id="sidebarCollapse" class="btn">
            <i class="fas fa-bars"></i>
        </button>
        <span class="navbar-title"></span>
        
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
                        Profile
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="editProfileConsumer.jsp">Edit Profile</a>
                        <form action="UserController" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="deleteProfile">
                            <button type="submit" class="dropdown-item">Delete Profile</button>
                        </form>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="UserController?action=logout">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="main-container">
        <!-- Sidebar -->
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

        <!-- Content -->
        <div id="content">
            <div class="container">
                <h2><i class="fas fa-exclamation-circle"></i> Report Product Issue</h2>

                <!-- Form for reporting product issue -->
                <form action="ReportController" method="post">
                    <input type="hidden" name="action" value="reportProductIssue">

                    <!-- Product Name Dropdown -->
                    <div class="form-group">
                        <label for="productName">Product Name</label>
                        <select class="form-control" id="productName" name="productId" required>
                            <option value="">Select a product</option>
                            <c:forEach var="order" items="${ordersList}">
                                <option value="${order.productId}">${order.productId}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Issue Type Dropdown -->
                    <div class="form-group">
                        <label for="issueType">Issue Type</label>
                        <select class="form-control" id="issueType" name="issueType" required>
                            <option value="DAMAGED">Damaged</option>
                            <option value="WRONG">Wrong Product</option>
                            <option value="DELAYED">Delayed</option>
                            <option value="STILL_NOT_RECEIVED">Still Not Received</option>
                            <option value="MISSING">Missing Items</option>
                        </select>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-primary">Submit Issue</button>
                </form>
            </div>
        </div>
    </div>

    <script>
    $(document).ready(function () {
        // Sidebar toggle
        $('#sidebarCollapse').on('click', function () {
            $('#sidebar').toggleClass('active');
        });

        // Responsive behavior
        function checkWidth() {
            if ($(window).width() < 768) {
                $('#sidebar').addClass('active');
            } else {
                $('#sidebar').removeClass('active');
            }
        }

        // Run on page load
        checkWidth();

        // Run on window resize
        $(window).resize(function() {
            checkWidth();
        });

        // Close sidebar when clicking outside on mobile
        $(document).click(function(e) {
            if ($(window).width() < 768) {
                if (!$(e.target).closest('#sidebar, #sidebarCollapse').length) {
                    $('#sidebar').addClass('active');
                }
            }
        });
    });
    </script>
</body>
</html>