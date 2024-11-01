package daoimpl;

import dao.ConsumerDAO;
import db.GetConnection;
import model.ConsumerPort;
import model.Orders;
import model.Products;
import model.ReportProducts;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ConsumerDAOImpl implements ConsumerDAO {

	@Override
	public void registerConsumer(ConsumerPort consumer) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL register_user(?, ?, ?, ?, 'CONSUMER')}")) {
			stmt.setString(1, consumer.getPortId());
			stmt.setString(2, consumer.getPassword());
			stmt.setString(3, consumer.getPassword()); // Example: might be an additional field
			stmt.setString(4, consumer.getLocation());
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean loginConsumer(ConsumerPort consumer) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL login_user(?, ?, 'CONSUMER')}")) {
			stmt.setString(1, consumer.getPortId());
			stmt.setString(2, consumer.getPassword());
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
	public void editConsumerProfile(ConsumerPort consumer) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL edit_user_details(?, ?, ?, 'CONSUMER')}")) {
			stmt.setString(1, consumer.getPortId());
			stmt.setString(2, consumer.getPassword());
			stmt.setString(3, consumer.getLocation());
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteConsumerProfile(String portId) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL delete_user_profile(?, 'CONSUMER')}")) {
			stmt.setString(1, portId);
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void placeOrder(Orders order) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL place_order(?, ?, ?)}")) {
			stmt.setString(1, order.getConsumerPortId());
			stmt.setString(2, order.getProductId());
			stmt.setInt(3, order.getQuantity());
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Orders> viewOrders(String consumerPortId) {
		List<Orders> ordersList = new ArrayList<>();
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL view_orders_consumer(?)}")) {
			stmt.setString(1, consumerPortId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Orders order = new Orders();
				order.setOrderId(rs.getString("order_id"));
				order.setOrderDate(rs.getTimestamp("order_date"));
				order.setProductId(rs.getString("product_name"));
				order.setQuantity(rs.getInt("quantity"));
				ordersList.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ordersList;
	}

	@Override
	public Orders trackOrder(String orderId) {
		Orders orderStatus = new Orders();
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL track_order(?)}")) {
			stmt.setString(1, orderId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				orderStatus.setOrderId(rs.getString("order_id"));
				orderStatus.setProductId(rs.getString("product_name"));
				orderStatus.setQuantity(rs.getInt("quantity"));
				orderStatus.setOrderDate(rs.getTimestamp("order_date"));
				orderStatus.setOrderPlaced(rs.getBoolean("order_placed"));
				orderStatus.setShipped(rs.getBoolean("shipped"));
				orderStatus.setOutForDelivery(rs.getBoolean("out_for_delivery"));
				orderStatus.setDelivered(rs.getBoolean("delivered"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orderStatus;
	}

	@Override
	public List<Products> viewProducts() {
		List<Products> productList = new ArrayList<>();
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL view_products()}");
				ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				Products product = new Products();
				product.setProductId(rs.getString("Product_ID"));
				product.setProductName(rs.getString("Product_Name"));
				product.setPrice(rs.getDouble("Price"));
				product.setQuantity(rs.getInt("Available_Quantity"));
				productList.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return productList;
	}

	@Override
	public Map<String, String> reportProductIssue(ReportProducts report) {
		Map<String, String> resultMap = new HashMap<>();
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL report_product_issue(?, ?, ?)}")) {
			stmt.setString(1, report.getConsumerPortId());
			stmt.setString(2, report.getProductId());
			stmt.setString(3, report.getIssueType());
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				resultMap.put("report_id", rs.getString("report_id"));
				resultMap.put("solution_message", rs.getString("solution_message"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultMap;
	}
}
