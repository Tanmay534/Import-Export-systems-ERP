package dao;

import model.SellerPort;
import model.Orders;
import model.Products;
import model.ReportProducts;
import java.util.List;

public interface SellerDAO {
	void registerSeller(SellerPort seller);

	boolean loginSeller(SellerPort seller);

	void editSellerProfile(SellerPort seller);

	void deleteSellerProfile(SellerPort seller);

	String addProduct(Products product, SellerPort seller);

	void updateProduct(Products product);

	String removeProduct(Products product);

	void manageOrder(String orderId, boolean shipped, boolean outForDelivery, boolean delivered);

	List<Products> viewProducts(SellerPort seller);

	List<Orders> viewOrders(SellerPort seller);

	List<ReportProducts> viewReportedProducts(SellerPort seller);
	
	void updateOrderStatus(Orders order);

	
}
