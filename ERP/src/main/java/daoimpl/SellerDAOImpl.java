package daoimpl;

import dao.SellerDAO;
import db.GetConnection;
import model.Products;
import model.ReportProducts;
import model.SellerPort;
import model.Orders;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SellerDAOImpl implements SellerDAO {

	@Override
	public void registerSeller(SellerPort seller) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL register_user(?, ?, ?, NULL, 'SELLER')}")) {
			stmt.setString(1, seller.getPortId());
			stmt.setString(2, seller.getPassword());
			stmt.setString(3, seller.getPassword());
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean loginSeller(SellerPort seller) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL login_user(?, ?, 'SELLER')}")) {
			stmt.setString(1, seller.getPortId());
			stmt.setString(2, seller.getPassword());
			ResultSet rs = stmt.executeQuery();
			if (rs.next() && rs.getBoolean("success")) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public void editSellerProfile(SellerPort seller) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL edit_user_details(?, ?, NULL, 'SELLER')}")) {
			stmt.setString(1, seller.getPortId());
			stmt.setString(2, seller.getPassword());
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteSellerProfile(SellerPort seller) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL delete_user_profile(?, 'SELLER')}")) {
			stmt.setString(1, seller.getPortId());
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public String addProduct(Products product, SellerPort seller) {
		String sellerPortId = seller.getPortId();
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL add_product(?, ?, ?, ?, ?)}")) {

			stmt.setString(1, product.getProductId());
			stmt.setString(2, product.getProductName());
			stmt.setDouble(3, product.getPrice());
			stmt.setInt(4, product.getQuantity());
			stmt.setString(5, sellerPortId); // Pass seller port ID here

			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sellerPortId;
	}

	@Override
	public void updateProduct(Products product) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL alter_product(?, ?, ?, ?)}")) {
			stmt.setString(1, product.getProductId());
			stmt.setString(2, product.getProductName());
			stmt.setDouble(3, product.getPrice());
			stmt.setInt(4, product.getQuantity());
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public String removeProduct(Products product) {
		String resultMessage = "Product removed successfully."; // Default success message

		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL remove_product(?)}")) {

			// Set product ID
			stmt.setString(1, product.getProductId());

			// Execute the stored procedure
			stmt.execute();

		} catch (SQLException e) {
			// Check if the exception has a custom SQLSTATE that corresponds to the SIGNAL
			if (e.getSQLState().equals("45000")) {
				// Retrieve the custom error message from the exception
				resultMessage = e.getMessage(); // This message comes from the SIGNAL SQLSTATE in the procedure
			} else {
				e.printStackTrace(); // Log other SQLExceptions
				resultMessage = "An error occurred while trying to remove the product.";
			}
		}

		return resultMessage; // Return the result (either success or custom error message)
	}

	@Override
	public void manageOrder(String orderId, boolean shipped, boolean outForDelivery, boolean delivered) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL manage_order(?, ?, ?, ?)}")) {
			stmt.setString(1, orderId);
			stmt.setBoolean(2, shipped);
			stmt.setBoolean(3, outForDelivery);
			stmt.setBoolean(4, delivered);
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Products> viewProducts(SellerPort seller) {
		List<Products> productList = new ArrayList<>();
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL view_products_by_seller(?)}")) {

			// Set the seller port ID from the SellerPort object
			stmt.setString(1, seller.getPortId());

			// Execute the query and process the result set
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					Products product = new Products();
					product.setProductId(rs.getString("Product_ID"));
					product.setProductName(rs.getString("Product_Name"));
					product.setPrice(rs.getDouble("Price"));
					product.setQuantity(rs.getInt("Available_Quantity"));
					productList.add(product);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return productList;
	}

	@Override
	public List<Orders> viewOrders(SellerPort seller) {
		System.out.println("Calling procedure to view orders for seller: " + seller.getPortId());
		List<Orders> ordersList = new ArrayList<>();

		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL view_orders_seller(?)}")) {

			// Set the seller port ID from the SellerPort object
			stmt.setString(1, seller.getPortId());

			// Execute the query and process the result set
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					Orders order = new Orders();
					order.setOrderId(rs.getString("Order_ID"));
					order.setOrderDate(rs.getTimestamp("Order_Date"));
					order.setProductId(rs.getString("Product_ID"));
					order.setQuantity(rs.getInt("Quantity"));
					order.setOrderPlaced(rs.getBoolean("Order_Placed"));
					order.setShipped(rs.getBoolean("Shipped"));
					order.setOutForDelivery(rs.getBoolean("Out_For_Delivery"));
					order.setDelivered(rs.getBoolean("Delivered"));

					System.out.println("Order Retrieved: " + order.toString());
					ordersList.add(order);
				}
			}
			System.out.println("Total Orders Retrieved: " + ordersList.size());

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return ordersList;
	}

	@Override
	public List<ReportProducts> viewReportedProducts(SellerPort seller) {
		List<ReportProducts> reportedProductsList = new ArrayList<>();
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL view_reported_products(?)}")) {
			stmt.setString(1, seller.getPortId());
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				ReportProducts report = new ReportProducts();
				report.setReportId(rs.getString("Report_ID"));
				report.setConsumerPortId(rs.getString("Consumer_ID"));
				report.setProductId(rs.getString("Product_ID"));
				report.setIssueType(rs.getString("Issue_Type"));
				report.setSolution(rs.getString("Solution"));
				report.setReportDate(rs.getTimestamp("Report_Date"));
				reportedProductsList.add(report);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reportedProductsList;
	}

	@Override
	public void updateOrderStatus(Orders order) {

		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL update_Order_Status(?, ?, ?, ?)}")) {

			// Set the seller port ID from the SellerPort object
			stmt.setString(1, order.getOrderId()); // Set order ID
			stmt.setBoolean(2, order.isShipped()); // Set shipped status
			stmt.setBoolean(3, order.isOutForDelivery()); // Set out for delivery status
			stmt.setBoolean(4, order.isDelivered()); // Set delivered status

			stmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
