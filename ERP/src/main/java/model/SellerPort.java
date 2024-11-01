package model;

public class SellerPort {
	private String portId;
	private String password;

	// Getters and Setters
	public String getPortId() {
		return portId;
	}

	public void setPortId(String portId) {
		this.portId = portId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "SellerPort [portId=" + portId + ", password=" + password + "]";
	}
}
