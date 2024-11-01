package model;

public class ConsumerPort {
	private String portId;
	private String password;
	private String location;

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

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	@Override
	public String toString() {
		return "ConsumerPort [portId=" + portId + ", password=" + password + ", location=" + location + "]";
	}
}
