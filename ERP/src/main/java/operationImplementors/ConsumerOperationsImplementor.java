package operationImplementors;

import dao.ConsumerDAO;
import daoimpl.ConsumerDAOImpl;
import model.ConsumerPort;
import model.Orders;
import model.Products;
import model.ReportProducts;
import operations.ConsumerOperations;

import java.util.List;
import java.util.Map;

public class ConsumerOperationsImplementor implements ConsumerOperations {

	private ConsumerDAO consumerDAO = new ConsumerDAOImpl();

	@Override
	public void registerConsumer(ConsumerPort consumer) {
		consumerDAO.registerConsumer(consumer);
	}

	@Override
	public boolean loginConsumer(ConsumerPort consumer) {
		return consumerDAO.loginConsumer(consumer); // Fix: Passing ConsumerPort object instead of String arguments
	}

	@Override
	public void editProfile(ConsumerPort consumer) {
		consumerDAO.editConsumerProfile(consumer);
	}

	@Override
	public void deleteProfile(String portId) {
		consumerDAO.deleteConsumerProfile(portId);
	}

	@Override
	public void placeOrder(Orders order) {
		consumerDAO.placeOrder(order);
	}

	@Override
	public List<Orders> viewOrders(String portId) {
		return consumerDAO.viewOrders(portId);
	}

	@Override
	public Orders trackOrder(String orderId) {
		return consumerDAO.trackOrder(orderId);
	}

	@Override
	public List<Products> viewProducts() {
		return consumerDAO.viewProducts();
	}

	@Override
	public Map<String, String> reportProductIssue(ReportProducts report) {
		return consumerDAO.reportProductIssue(report);
	}
}
