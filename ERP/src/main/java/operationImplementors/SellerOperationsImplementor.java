package operationImplementors;

import dao.SellerDAO;
import daoimpl.SellerDAOImpl;
import model.Orders;
import model.Products;
import model.ReportProducts;
import model.SellerPort;
import operations.SellerOperations;

import java.util.List;

public class SellerOperationsImplementor implements SellerOperations {

	private SellerDAO sellerDAO = new SellerDAOImpl();

	@Override
	public void registerSeller(SellerPort seller) {
		sellerDAO.registerSeller(seller);
	}

	@Override
	public boolean loginSeller(SellerPort seller) {
		return sellerDAO.loginSeller(seller); // Fix: Passing the POJO object instead of String arguments
	}

	@Override
	public void editProfile(SellerPort seller) {
		sellerDAO.editSellerProfile(seller);
	}

	@Override
	public void deleteProfile(SellerPort seller) {
		sellerDAO.deleteSellerProfile(seller);
	}

	@Override
	public String addProduct(Products product, SellerPort seller) {
		return sellerDAO.addProduct(product, seller);
	}

	@Override
	public List<Products> viewProducts(SellerPort seller) {
		return sellerDAO.viewProducts(seller);
	}

	@Override
	public void alterProduct(Products product) {
		sellerDAO.updateProduct(product);
	}

	@Override
	public String removeProduct(Products product) {

		return sellerDAO.removeProduct(product);
	}

	@Override
	public void manageOrders(Orders order) {
		sellerDAO.manageOrder(order.getOrderId(), order.isShipped(), order.isOutForDelivery(), order.isDelivered());
	}

	@Override
	public List<Orders> viewOrders(SellerPort seller) {
		return sellerDAO.viewOrders(seller);
	}

	@Override
	public List<ReportProducts> viewReportedProducts(SellerPort seller) {
		return sellerDAO.viewReportedProducts(seller);
	}

	@Override
	public void updateOrderStatus(Orders order) {
		sellerDAO.updateOrderStatus(order);

	}
}
