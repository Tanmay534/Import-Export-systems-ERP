package operations;

import model.SellerPort;
import model.Products;
import model.ReportProducts;
import model.Orders;
import java.util.List;

public interface SellerOperations {

	void registerSeller(SellerPort seller);

	boolean loginSeller(SellerPort seller);

	void editProfile(SellerPort seller);

	void deleteProfile(SellerPort seller);

	String addProduct(Products product, SellerPort seller);

	List<Products> viewProducts(SellerPort seller);

	void alterProduct(Products product);

	String removeProduct(Products product);

	void manageOrders(Orders order);

	List<ReportProducts> viewReportedProducts(SellerPort seller);

	List<Orders> viewOrders(SellerPort seller);

	void updateOrderStatus(Orders order);
}
