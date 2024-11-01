<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Track Order</title>
<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome CSS for Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f0f4f8; /* Lighter background for contrast */
    color: #343a40;
}

.container {
    margin-top: 50px;
    max-width: 700px; /* Increased width for a more spacious layout */
    padding: 30px;
    background-color: #ffffff; /* White background for better readability */
    border-radius: 15px;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
}

h2 {
    text-align: center;
    color: #1D3557;
    margin-bottom: 20px;
    font-size: 2rem; /* Increased font size for the header */
}

.timeline {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 20px;
    position: relative;
}

.status-step {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    position: relative;
    color: #343a40;
}

.status-step .icon {
    width: 40px; /* Increased size for better visibility */
    height: 40px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 20px; /* Increased font size for icons */
    margin-bottom: 5px;
}

.status-step.completed .icon {
    background-color: #28a745; /* Green for completed steps */
    color: white;
}

.status-step:not(.completed) .icon {
    background-color: #dee2e6; /* Gray for uncompleted steps */
    color: #343a40;
}

/* Line segment will only appear in completed steps */
.status-step.completed + .status-step::before {
    content: "";
    position: absolute;
    top: 20px; /* Adjusted for better alignment */
    left: -50%;
    height: 4px;
    width: 100%;
    background-color: #28a745; /* Green line for completed steps */
    z-index: -1;
}

.status-step.active .icon {
    animation: blink 1s infinite;
}

@keyframes blink {
    50% { opacity: 0.5; }
}

.status-label {
    font-size: 14px;
    color: #343a40;
    font-weight: bold; /* Bold for better visibility */
}

.order-details {
    margin-bottom: 20px;
    padding: 15px; /* Padding for a more spacious layout */
    background-color: #f8f9fa; /* Light background for details */
    border-radius: 10px; /* Rounded corners for details box */
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.btn-back {
     margin-top: 20px;
    background-color: #007bff; /* Blue background color */
    color: white; /* White text color */
    border: none; /* Remove border for a cleaner look */
}

.btn-back:hover {
    background-color: #0056b3; /* Navy blue on hover */
    color: white; /* Ensure text color remains white */
}
</style>
</head>
<body>

    <div class="container">
        <h2>Track Order</h2>

        <!-- Order Details -->
        <div class="order-details">
            <p><strong>Order ID:</strong> <%=request.getAttribute("orderId")%></p>
            <p><strong>Product Name:</strong> <%=request.getAttribute("productName")%></p>
            <p><strong>Quantity:</strong> <%=request.getAttribute("quantity")%></p>
            <p><strong>Order Date:</strong> <%=request.getAttribute("orderDate")%></p>
        </div>

        <!-- Timeline for Order Status -->
        <div class="timeline">
            <% 
                // Determine the most recent status
                boolean orderPlaced = request.getAttribute("orderPlaced") != null && (boolean) request.getAttribute("orderPlaced");
                boolean shipped = request.getAttribute("shipped") != null && (boolean) request.getAttribute("shipped");
                boolean outForDelivery = request.getAttribute("outForDelivery") != null && (boolean) request.getAttribute("outForDelivery");
                boolean delivered = request.getAttribute("delivered") != null && (boolean) request.getAttribute("delivered");

                // Determine the most recent status
                String activeStep = "";
                if (delivered) {
                    activeStep = "delivered";
                } else if (outForDelivery) {
                    activeStep = "outForDelivery";
                } else if (shipped) {
                    activeStep = "shipped";
                } else if (orderPlaced) {
                    activeStep = "orderPlaced";
                }
            %>
            
            <div class="status-step <%= orderPlaced ? "completed" : "" %> <%= activeStep.equals("orderPlaced") ? "active" : "" %>">
                <div class="icon"><i class="fas fa-clipboard-check"></i></div>
                <span class="status-label">Order Placed</span>
            </div>

            <div class="status-step <%= shipped ? "completed" : "" %> <%= activeStep.equals("shipped") ? "active" : "" %>">
                <div class="icon"><i class="fas fa-shipping-fast"></i></div>
                <span class="status-label">Shipped</span>
            </div>

            <div class="status-step <%= outForDelivery ? "completed" : "" %> <%= activeStep.equals("outForDelivery") ? "active" : "" %>">
                <div class="icon"><i class="fas fa-truck"></i></div>
                <span class="status-label">Out for Delivery</span>
            </div>

            <div class="status-step <%= delivered ? "completed" : "" %> <%= activeStep.equals("delivered") ? "active" : "" %>">
                <div class="icon"><i class="fas fa-box-open"></i></div>
                <span class="status-label">Delivered</span>
            </div>
        </div>

        <!-- Back Button -->
        <a href="ViewController?action=viewOrders" class="btn btn-back btn-block">Back to View Orders</a>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
