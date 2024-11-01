package operations;

import model.ConsumerPort;
import model.Orders;
import model.Products;
import model.ReportProducts;
import java.util.List;
import java.util.Map;

public interface ConsumerOperations {

	void registerConsumer(ConsumerPort consumer);

	boolean loginConsumer(ConsumerPort consumer);

	void editProfile(ConsumerPort consumer);

	void deleteProfile(String portId);

	void placeOrder(Orders order);

	List<Orders> viewOrders(String portId);

	Orders trackOrder(String orderId);

	List<Products> viewProducts();

	Map<String, String> reportProductIssue(ReportProducts report);
}
