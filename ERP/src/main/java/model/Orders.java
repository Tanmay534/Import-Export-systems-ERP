package model;

import java.sql.Timestamp;

public class Orders {
	private String orderId;
	private String productId;
	private String consumerPortId;
	private int quantity;
	private Timestamp orderDate;
	private boolean orderPlaced;
	private boolean shipped;
	private boolean outForDelivery;
	private boolean delivered;

	// Getters and Setters
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getConsumerPortId() {
		return consumerPortId;
	}

	public void setConsumerPortId(String consumerPortId) {
		this.consumerPortId = consumerPortId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Timestamp getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}

	public boolean isOrderPlaced() {
		return orderPlaced;
	}

	public void setOrderPlaced(boolean orderPlaced) {
		this.orderPlaced = orderPlaced;
	}

	public boolean isShipped() {
		return shipped;
	}

	public void setShipped(boolean shipped) {
		this.shipped = shipped;
	}

	public boolean isOutForDelivery() {
		return outForDelivery;
	}

	public void setOutForDelivery(boolean outForDelivery) {
		this.outForDelivery = outForDelivery;
	}

	public boolean isDelivered() {
		return delivered;
	}

	public void setDelivered(boolean delivered) {
		this.delivered = delivered;
	}

	@Override
	public String toString() {
		return "Orders [orderId=" + orderId + ", productId=" + productId + ", consumerPortId=" + consumerPortId
				+ ", quantity=" + quantity + ", orderDate=" + orderDate + ", orderPlaced=" + orderPlaced + ", shipped="
				+ shipped + ", outForDelivery=" + outForDelivery + ", delivered=" + delivered + "]";
	}
}