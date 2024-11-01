package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Orders;
import model.SellerPort;
import operationImplementors.ConsumerOperationsImplementor;
import operationImplementors.SellerOperationsImplementor;

@WebServlet("/OrderController")
public class OrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ConsumerOperationsImplementor consumerOps = new ConsumerOperationsImplementor();
	private SellerOperationsImplementor sellerOps = new SellerOperationsImplementor();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		System.out.println("Received action: " + action);

		if ("shipped".equals(action)) {
			handleUpdateShipped(request, response); // View orders
		} else if ("outForDelivery".equals(action)) {
			handleUpdateOutForDilevery(request, response); // View orders
		} else if ("delivered".equals(action)) {
			handleUpdateDilevered(request, response); // View orders
		} else

		{
			System.out.println("form method Get");
			response.sendRedirect("login.jsp"); // Default redirect for other GET requests
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		System.out.println("Received action: " + action);

		if ("placeOrder".equals(action)) {
			handlePlaceOrder(request, response); // Place a new order
		} else if ("manageOrder".equals(action)) {
			handleManageOrder(request, response); // Manage specific order (update status)
		} else if ("trackOrder".equals(action)) {
			handleTrackOrder(request, response); // Track order
		} else if ("shipped".equals(action)) {
			handleUpdateShipped(request, response); // View orders
		} else if ("outForDelivery".equals(action)) {
			handleUpdateOutForDilevery(request, response); // View orders
		} else if ("delivered".equals(action)) {
			handleUpdateDilevered(request, response); // View orders
		}

	}

	private void handlePlaceOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get input from the form
		String productId = request.getParameter("productId");
		int quantity = Integer.parseInt(request.getParameter("quantity"));

		// Get the consumer's port ID from the session
		HttpSession session = request.getSession();
		String consumerPortId = (String) session.getAttribute("portId");

		// Create an order object (assuming you have an Orders model)
		Orders order = new Orders();
		order.setProductId(productId);
		order.setConsumerPortId(consumerPortId);
		order.setQuantity(quantity);

		// Call the consumerOps to place the order
		consumerOps.placeOrder(order);

		// Redirect back to the order confirmation or dashboard page
		response.sendRedirect("consumerDashboard.jsp?orderSuccess=true");
	}

	private void handleManageOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Logic for managing order status
	}

	private void handleTrackOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get order ID from the request
		String orderId = request.getParameter("orderId");
		System.out.println("consumer with " + orderId + " trying to track orders");

		// Call the consumerOps to track the order
		Orders orderStatus = consumerOps.trackOrder(orderId);

		// Set the order details as request attributes
		request.setAttribute("orderId", orderStatus.getOrderId());
		request.setAttribute("productName", orderStatus.getProductId()); // Assuming productId is replaced by
																			// productName
		request.setAttribute("quantity", orderStatus.getQuantity());
		request.setAttribute("orderDate", orderStatus.getOrderDate());
		request.setAttribute("orderPlaced", orderStatus.isOrderPlaced());
		request.setAttribute("shipped", orderStatus.isShipped());
		request.setAttribute("outForDelivery", orderStatus.isOutForDelivery());
		request.setAttribute("delivered", orderStatus.isDelivered());

		// Forward to trackOrder.jsp
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("trackOrder.jsp");
		dispatcher.forward(request, response);
	}

	private void handleUpdateShipped(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String orderId = request.getParameter("orderId");

		System.out.println("Updating order to shipped for Order ID: " + orderId);
		// Update order status using the seller operation implementor
		Orders order = new Orders();
		order.setOrderId(orderId);
		order.setShipped(true);
		order.setOutForDelivery(false);
		order.setDelivered(false);
		sellerOps.updateOrderStatus(order); // Shipped and Out for Delivery set to true
		request.getSession().setAttribute("statusMessage", "Status updated successfully");
		List<Orders> ordersList;

		String portId11 = (String) session.getAttribute("portId");
		SellerPort seller = new SellerPort();
		seller.setPortId(portId11);
		System.out.println("seller viewing orders");
		ordersList = sellerOps.viewOrders(seller);
		request.setAttribute("ordersList", ordersList);

		try {
			// Redirect to manage orders page after update
			RequestDispatcher dispatcher = request.getRequestDispatcher("SellerDashboard.jsp");
			request.getSession().setAttribute("statusMessage", "Status updated successfully");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (IOException e) {
			e.printStackTrace();
			// Optionally, handle the redirection failure (e.g., show error page)
		}

	}

	private void handleUpdateOutForDilevery(HttpServletRequest request, HttpServletResponse response) {
		String orderId = request.getParameter("orderId");

		System.out.println("Updating order to out for delivery for Order ID: " + orderId);
		// Update order status using the seller operation implementor
		Orders order = new Orders();
		order.setOrderId(orderId);
		order.setShipped(true);
		order.setOutForDelivery(true);
		order.setDelivered(false);
		sellerOps.updateOrderStatus(order); // Shipped and Out for Delivery set to true

		try {
			// Redirect to manage orders page after update
			RequestDispatcher dispatcher = request.getRequestDispatcher("SellerDashboard.jsp");
			request.getSession().setAttribute("statusMessage", "Status updated successfully");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (IOException e) {
			e.printStackTrace();
			// Optionally, handle the redirection failure (e.g., show error page)
		}

	}

	private void handleUpdateDilevered(HttpServletRequest request, HttpServletResponse response)
			throws ServletException {
		String orderId = request.getParameter("orderId");

		System.out.println("Updating order to delivered for Order ID: " + orderId);
		// Update order status using the seller operation implementor
		Orders order = new Orders();
		order.setOrderId(orderId);
		order.setShipped(true);
		order.setOutForDelivery(true);
		order.setDelivered(true);
		sellerOps.updateOrderStatus(order); // Shipped and Out for Delivery set to true
		try {
			// Redirect to manage orders page after update
			RequestDispatcher dispatcher = request.getRequestDispatcher("SellerDashboard.jsp");
			request.getSession().setAttribute("statusMessage", "Status updated successfully");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (IOException e) {
			e.printStackTrace();
			// Optionally, handle the redirection failure (e.g., show error page)
		}

	}
}
