package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ConsumerPort;
import model.Orders;
import model.ReportProducts;
import model.SellerPort;
import operationImplementors.ConsumerOperationsImplementor;
import operationImplementors.SellerOperationsImplementor;

@WebServlet("/ReportController")
public class ReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ConsumerOperationsImplementor consumerOps = new ConsumerOperationsImplementor();
	private SellerOperationsImplementor sellerOps = new SellerOperationsImplementor();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		System.out.println("Received action: " + action); // Debugging action

		if ("reportProductIssue".equals(action)) {
			handleReportProductIssue(request, response);
		} else if ("viewReportedProducts".equals(action)) {
			handleViewReportedProducts(request, response);
		} else if ("reportProduct".equals(action)) {
			handleReportProduct(request, response);
		}

	}

	private void handleReportProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String portId = (String) session.getAttribute("portId");
		ConsumerPort consumer = new ConsumerPort();
		consumer.setPortId(portId);
		
		List<Orders> ordersList = new ArrayList<>();
		ordersList = consumerOps.viewOrders(portId);
		request.setAttribute("ordersList", ordersList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("reportIssue.jsp");
		dispatcher.forward(request, response);
		
	}

	private void handleReportProductIssue(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get input from the form
		String productId = request.getParameter("productId");
		String issueType = request.getParameter("issueType");

		System.out.println(productId);
		// Get the consumer's port ID from the session
		HttpSession session = request.getSession();
		String consumerPortId = (String) session.getAttribute("portId");

		// Create a ReportProducts object and set the values using setters
		ReportProducts reportedProduct = new ReportProducts();
		reportedProduct.setConsumerPortId(consumerPortId);
		reportedProduct.setProductId(productId);
		reportedProduct.setIssueType(issueType);

		// Call the consumerOps to report the product issue and get the result
		Map<String, String> reportResult = consumerOps.reportProductIssue(reportedProduct);

		// Set the report ID and solution message as request attributes
		request.setAttribute("reportId", reportResult.get("report_id"));
		request.setAttribute("solutionMessage", reportResult.get("solution_message"));

		// Forward to a JSP to display the result
		RequestDispatcher dispatcher = request.getRequestDispatcher("reportIssueResult.jsp");
		dispatcher.forward(request, response);
	}

	private void handleViewReportedProducts(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Call the consumer operations to get the list of reported products
		HttpSession session = request.getSession();
		String portId = (String) session.getAttribute("portId");
		SellerPort seller = new SellerPort();
		seller.setPortId(portId);
		
		List<ReportProducts> reportedProducts = sellerOps.viewReportedProducts(seller);

		// Set the list of reported products in the request attribute
		request.setAttribute("reportedProducts", reportedProducts);

		// Forward to the viewReportedProducts.jsp page to display the data
		RequestDispatcher dispatcher = request.getRequestDispatcher("viewReportedProducts.jsp");
		dispatcher.forward(request, response);
	}
}
