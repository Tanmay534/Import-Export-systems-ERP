package dao;

import model.ConsumerPort;
import model.Orders;
import model.Products;
import model.ReportProducts;
import java.util.List;
import java.util.Map;

public interface ConsumerDAO {
	void registerConsumer(ConsumerPort consumer);

	boolean loginConsumer(ConsumerPort consumer);

	void editConsumerProfile(ConsumerPort consumer);

	void deleteConsumerProfile(String portId);

	void placeOrder(Orders order);

	List<Orders> viewOrders(String consumerPortId);

	List<Products> viewProducts();

	Map<String, String> reportProductIssue(ReportProducts report);

	Orders trackOrder(String orderId);
}
