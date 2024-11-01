package controller;

import model.ConsumerPort;
import model.Orders;
import model.Products;
import model.ReportProducts;
import model.SellerPort;
import operationImplementors.ConsumerOperationsImplementor;
import operationImplementors.SellerOperationsImplementor;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Operations Implementors
	private ConsumerOperationsImplementor consumerOps = new ConsumerOperationsImplementor();
	private SellerOperationsImplementor sellerOps = new SellerOperationsImplementor();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		System.out.println("Received action: " + action);

		if ("logout".equals(action)) {
			handleLogout(request, response);
		} else

		{
			System.out.println("form method Get");
			response.sendRedirect("login.jsp"); // Default redirect for other GET requests
		}
	}

	// Handle POST requests
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		System.out.println("Received action: " + action); // Debugging action

		if ("register".equals(action)) {
			handleRegistration(request, response);
		} else if ("login".equals(action)) {
			handleLogin(request, response);
		} else if ("logout".equals(action)) {
			handleLogout(request, response);
		} else if ("editProfile".equals(action)) {
			handleEditProfile(request, response);
		} else if ("deleteProfile".equals(action)) {
			handleDeleteProfile(request, response);
		}
	}

	// Handle Registration
	private void handleRegistration(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String role = request.getParameter("role");
		String portId = request.getParameter("portId");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String location = request.getParameter("location");

		System.out.println("Registration details: Role=" + role + ", Port ID=" + portId + ", Password=" + password);

		// Check if passwords match
		if (!password.equals(confirmPassword)) {
			request.getSession().setAttribute("errorMessage", "Passwords do not match!");
			
			return;
		}

		String result;
		// Register based on role (Consumer/Seller)
		if ("CONSUMER".equals(role)) {
			ConsumerPort consumer = new ConsumerPort();
			consumer.setPortId(portId);
			consumer.setPassword(password);
			consumer.setLocation(location);
			consumerOps.registerConsumer(consumer);
			result = "Consumer registration successful";
			System.out.println(result);
		} else if ("SELLER".equals(role)) {
			SellerPort seller = new SellerPort();
			seller.setPortId(portId);
			seller.setPassword(password);
			sellerOps.registerSeller(seller);
			result = "Seller registration successful";
			System.out.println(result);
		} else {
			result = "Invalid role!";
			System.out.println(result);
		}

		request.getSession().setAttribute("successMessage", result);
		response.sendRedirect("login.jsp");
	}

	// Handle Login
	private void handleLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String role = request.getParameter("role");
		String portId = request.getParameter("portId");
		String password = request.getParameter("password");

		System.out.println("Login attempt: Role=" + role + ", Port ID=" + portId);

		HttpSession session = request.getSession();
		boolean loginSuccessful;

		// Login based on role (Consumer/Seller)
		if ("CONSUMER".equals(role)) {
			ConsumerPort consumer = new ConsumerPort();
			consumer.setPortId(portId);
			consumer.setPassword(password);
			loginSuccessful = consumerOps.loginConsumer(consumer);
			if (loginSuccessful) {
				session.setAttribute("portId", portId);
				session.setAttribute("role", "CONSUMER");
				request.setAttribute("redirectUrl", "consumerDashboard.jsp");
				request.setAttribute("successMessage", "Login successful! ");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
				System.out.println("Session Created for Consumer with ID: " + portId);
				System.out.println("Session ID: " + session.getId());
			} else {
				System.out.println("Consumer login failed.");
				 request.setAttribute("errorMessage", "Invalid Consumer credentials!");
		            request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		} else if ("SELLER".equals(role)) {
			SellerPort seller = new SellerPort();
			seller.setPortId(portId);
			seller.setPassword(password);
			loginSuccessful = sellerOps.loginSeller(seller);
			if (loginSuccessful) {
				session.setAttribute("portId", portId);
				session.setAttribute("role", "SELLER");
				request.setAttribute("redirectUrl", "SellerDashboard.jsp");
				request.setAttribute("successMessage", "Login successful! ");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
				System.out.println("Session Created for Seller with ID: " + portId);
				System.out.println("Session ID: " + session.getId());
			} else {
				System.out.println("Seller login failed.");
				request.setAttribute("errorMessage", "Invalid seller credentials!");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}
	}

	// Handle Logout
	private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		if (session != null) {
			System.out.println("Invalidating session for Port ID: " + session.getAttribute("portId"));
			session.invalidate(); // Invalidate the session
		}
		response.sendRedirect("login.jsp");
		System.out.println("User logged out.");
	}

	// Utility method to forward request based on result
	private void forwardBasedOnResult(HttpServletRequest request, HttpServletResponse response, String result,
			String successPage, String failurePage) throws ServletException, IOException {
		RequestDispatcher dispatcher;
		System.out.println("Forwarding based on result: " + result);
		if (result.contains("successful")) {
			dispatcher = request.getRequestDispatcher(successPage);
		} else {
			dispatcher = request.getRequestDispatcher(failurePage);
		}
		dispatcher.forward(request, response);
	}

	private void handleEditProfile(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Retrieve portId and role from session
		System.out.println("edit profile method call");
		HttpSession session = request.getSession();
		String portId = (String) session.getAttribute("portId");
		String role = (String) session.getAttribute("role");

		// Retrieve new password and location from the form
		String newPassword = request.getParameter("password"); // May be null or empty
		String newLocation = null;

		if ("CONSUMER".equals(role)) {
			newLocation = request.getParameter("location"); // May be null or empty for consumers
		}

		// If the user has provided new values, pass them to the backend, otherwise pass
		// null
		if ("CONSUMER".equals(role)) {
			System.out.println("Consummer editing profile");
			ConsumerPort consumer = new ConsumerPort();
			consumer.setPortId(portId);
			if (newPassword != null && !newPassword.isEmpty()) {
				consumer.setPassword(newPassword);
			}
			if (newLocation != null && !newLocation.isEmpty()) {
				consumer.setLocation(newLocation);
			}
			consumerOps.editProfile(consumer);
		} else if ("SELLER".equals(role)) {
			System.out.println("seller edit call");
			SellerPort seller = new SellerPort();
			seller.setPortId(portId);
			if (newPassword != null && !newPassword.isEmpty()) {
				seller.setPassword(newPassword);
			}
			sellerOps.editProfile(seller);
		}

		// Redirect to the appropriate dashboard after editing profile
		if ("CONSUMER".equals(role)) {
			response.sendRedirect("consumerDashboard.jsp?editSuccess=true");
		} else if ("SELLER".equals(role)) {
			response.sendRedirect("SellerDashboard.jsp?editSuccess=true");
		}
	}

	private void handleDeleteProfile(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Retrieve portId from session
		HttpSession session = request.getSession();
		String portId = (String) session.getAttribute("portId");
		String role = (String) session.getAttribute("role");
		System.out.println("details =" + portId + " " + role);
		SellerPort seller = new SellerPort();
		seller.setPortId(portId);

		if (portId != null && role != null) {
			// Delete the profile based on role (Consumer/Seller)
			if ("CONSUMER".equals(role)) {
				consumerOps.deleteProfile(portId);
			} else if ("SELLER".equals(role)) {
				sellerOps.deleteProfile(seller);
			}

			// Invalidate session as profile is deleted
			session.invalidate();

			System.out.println("Session invalidated for user with Port ID: " + portId);

			// Check if the session is terminated (should return null)
			if (request.getSession(false) == null) {
				System.out.println("Session successfully terminated.");
			} else {
				System.out.println("Session termination failed.");
			}
			// Redirect to registration page
			response.sendRedirect("register.jsp");
		} else {
			// If something goes wrong, redirect to an error page
	
			response.sendRedirect("consumerDashboard.jsp");
		}
	}

}
