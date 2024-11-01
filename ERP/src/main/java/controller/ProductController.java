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

import model.Products;
import model.SellerPort;
import operationImplementors.SellerOperationsImplementor;

@WebServlet("/ProductController")
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private SellerOperationsImplementor sellerOps = new SellerOperationsImplementor();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		System.out.println("Received action: " + action);

		if ("manageProducts".equals(action)) {
			handleManageProducts(request, response);
		}
//		 else if ("addProduct".equals(action)) {
//			handleAddProduct(request, response); // Add a product
//		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		System.out.println("Received action: " + action); // Debugging action

		if ("addProduct".equals(action)) {
			handleAddProduct(request, response); // Add a product
		} else if ("updateProduct".equals(action)) {
			handleEditProduct(request, response); // Edit a product
		} else if ("removeProduct".equals(action)) {
			handleRemoveProduct(request, response); // Remove a product
		} else if ("manageProducts".equals(action)) {
			handleManageProducts(request, response);
		}
	}

	private void handleAddProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String portId = (String) session.getAttribute("portId");
		String role = (String) session.getAttribute("role");

		// Gather input from the form
		String productId = request.getParameter("productId");
		String productName = request.getParameter("productName");
		double price = Double.parseDouble(request.getParameter("price"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));

		Products product = new Products();
		product.setProductId(productId);
		product.setProductName(productName);
		product.setPrice(price);
		product.setQuantity(quantity);

		SellerPort seller = new SellerPort(); // Assuming you have a Seller POJO
		seller.setPortId(portId);

		List<Products> productList = sellerOps.viewProducts(seller);

		// Set the product list as an attribute and forward to viewProducts.jsp
		request.setAttribute("productList", productList);
		// Call the SellerOperationsImplementor to add the product, passing both
		// Products and Seller objects
		String resultMessage = sellerOps.addProduct(product, seller);
		request.setAttribute("resultMessage", resultMessage);

		// Set an attribute to indicate success
		request.setAttribute("successMessage", "Product added successfully!");

		// Forward the request to manage products to show the success message
		request.getRequestDispatcher("manageProducts.jsp").forward(request, response);
	}

	private void handleEditProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Collect data from the form
		HttpSession session = request.getSession();
		String portId = (String) session.getAttribute("portId");

		String productId = request.getParameter("productId");
		String productName = request.getParameter("productName"); // Optional
		String priceStr = request.getParameter("price"); // Optional
		String quantityStr = request.getParameter("quantity"); // Optional

		// Default to -1 if blank, otherwise parse the value
		Double price = (priceStr == null || priceStr.isEmpty()) ? -1 : Double.parseDouble(priceStr);
		Integer quantity = (quantityStr == null || quantityStr.isEmpty()) ? -1 : Integer.parseInt(quantityStr);

		// Create a Products object with the optional fields (use null for unchanged
		// values in DAO)
		Products product = new Products();
		product.setProductId(productId);
		product.setProductName(productName);
		product.setPrice(price);
		product.setQuantity(quantity);

		SellerPort seller = new SellerPort(); // Assuming you have a Seller POJO
		seller.setPortId(portId);
		// Call the DAO method to edit the product
		sellerOps.alterProduct(product);
		List<Products> productList = sellerOps.viewProducts(seller);

		// Set the product list as an attribute and forward to viewProducts.jsp
		request.setAttribute("productList", productList);

		request.setAttribute("successMessage", "Product updated successfully!");
		// Redirect or display a success message
		request.getRequestDispatcher("manageProducts.jsp").forward(request, response);
	}

	private void handleRemoveProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get the Product ID from the request
		HttpSession session = request.getSession();
		String portId = (String) session.getAttribute("portId");
		String productId = request.getParameter("productId");
		System.out.println(productId);

		SellerPort seller = new SellerPort();
		seller.setPortId(portId);
		// Call the SellerOperationsImplementor to remove the product
		Products products = new Products();
		products.setProductId(productId);
		String resultMessage = sellerOps.removeProduct(products);
		String alertType;

		System.out.println(resultMessage);
		if ("Product removed successfully.".equals(resultMessage)) {
			alertType = "success"; // Set alert type to success for a successful operation
		} else {
			alertType = "error"; // Set alert type to error for a failed operation
		}
		
		seller.setPortId(portId);
		List<Products> productList = sellerOps.viewProducts(seller);

		// Set the product list as an attribute and forward to viewProducts.jsp
		request.setAttribute("productList", productList);

		// Set attributes to be forwarded to the frontend
		request.setAttribute("resultMessage", resultMessage);
		request.setAttribute("successMessage", "Product deleted successfully!");

		// Redirect back to the manage products page or show a success message

		request.getRequestDispatcher("manageProducts.jsp").forward(request, response);
	}

	private void handleManageProducts(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get the list of products from the SellerOperationsImplementor
		HttpSession session = request.getSession();
		String portId = (String) session.getAttribute("portId");
		SellerPort seller = new SellerPort(); // Assuming you have a Seller POJO
		seller.setPortId(portId);
		List<Products> productList = sellerOps.viewProducts(seller);

		// Set the product list as an attribute and forward to viewProducts.jsp
		request.setAttribute("productList", productList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("manageProducts.jsp");
		dispatcher.forward(request, response);
	}

}
