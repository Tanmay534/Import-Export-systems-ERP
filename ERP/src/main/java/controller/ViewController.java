package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Orders;
import model.Products;
import model.SellerPort;
import operationImplementors.ConsumerOperationsImplementor;
import operationImplementors.SellerOperationsImplementor;
import operations.ConsumerOperations;
import operations.SellerOperations;

@WebServlet("/ViewController")
public class ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ConsumerOperations consumerOps = new ConsumerOperationsImplementor();
	private SellerOperations sellerOps = new SellerOperationsImplementor();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");

		System.out.println("Received action at ViewController: " + action); // Debugging action

		if ("viewProducts".equals(action)) {
			handleViewProducts(request, response);
		} else if ("viewOrders".equals(action)) {
			handleViewOrders(request, response); // View orders
		}
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		System.out.println("Received action at ViewController: " + action); // Debugging action

		if ("viewProducts".equals(action)) {
			handleViewProducts(request, response);
		} else if ("viewOrders".equals(action)) {
			handleViewOrders(request, response); // View orders
		}

	}

	private void handleViewProducts(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get the list of products from the SellerOperationsImplementor
		List<Products> productList = consumerOps.viewProducts();

		System.out.println("=== Products List (Using for loop) ===");
		for (Products product : productList) {
			System.out.println("Product ID: " + product.getProductId());
			System.out.println("Product Name: " + product.getProductName());
			System.out.println("Price: $" + product.getPrice());
			System.out.println("Quantity: " + product.getQuantity());
			System.out.println("------------------------");
		}
		// Set the product list as an attribute and forward to viewProducts.jsp
		request.setAttribute("productList", productList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("viewProductsConsumer.jsp");
		dispatcher.forward(request, response);
	}

	private void handleViewOrders(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get the consumer's port ID from the session
		HttpSession session = request.getSession();
		String portId = (String) session.getAttribute("portId");
		String role = (String) session.getAttribute("role");
		System.out.println(role);

		if ("consumer".equalsIgnoreCase(role)) {
			// Consumer role: handle for consumer
			System.out.println("consumer viewing orders");
			handleViewOrdersForConsumer(request, response, portId);
		} else if ("seller".equalsIgnoreCase(role)) {
			// Seller role: handle for seller
			System.out.println("seller viewing orders");
			handleViewOrdersForSeller(request, response, portId);
		}

	}

	private void handleViewOrdersForConsumer(HttpServletRequest request, HttpServletResponse response, String portId)
			throws ServletException, IOException {
		// Call the consumerOps to get the list of orders for the consumer
		System.out.println("Consumer viewing orders for portId: " + portId);

		HttpSession session = request.getSession();
		String portId1 = (String) session.getAttribute("portId");
		String role = (String) session.getAttribute("role");
		System.out.println(role);

		// Call the consumerOps to get the list of orders
		// List<Orders> ordersList = consumerOps.viewOrders(consumerPortId);
		// Check the role and call the appropriate operation
		List<Orders> ordersList;

		System.out.println("consumer viewing orders");
		ordersList = consumerOps.viewOrders(portId1);

		System.out.println("Orders List Size Before Setting: " + ordersList.size());
		// Set the orders list in the request attribute
		request.setAttribute("ordersList", ordersList);

		// Forward to the consumer-specific JSP page
		RequestDispatcher dispatcher = request.getRequestDispatcher("viewOrdersConsumer.jsp");
		dispatcher.forward(request, response);
	}

	private void handleViewOrdersForSeller(HttpServletRequest request, HttpServletResponse response, String portId)
			throws ServletException, IOException {
		// Call the sellerOps to get the list of orders for the seller
		HttpSession session = request.getSession();
		String portId11 = (String) session.getAttribute("portId");
		String role = (String) session.getAttribute("role");
		System.out.println(role);

		SellerPort seller = new SellerPort();
		seller.setPortId(portId11);
		// Call the consumerOps to get the list of orders
		// List<Orders> ordersList = consumerOps.viewOrders(consumerPortId);
		// Check the role and call the appropriate operation
		List<Orders> ordersList;

		System.out.println("seller viewing orders");
		ordersList = sellerOps.viewOrders(seller);
		request.setAttribute("ordersList", ordersList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("viewOrdersSeller.jsp");
		dispatcher.forward(request, response);
	}

}
