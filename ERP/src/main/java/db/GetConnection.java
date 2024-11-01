package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class GetConnection {

	public static Connection getConnection() {
		ResourceBundle rb = ResourceBundle.getBundle("dbconfig");

		try {
			
			Class.forName(rb.getString("db.driver"));

		} catch (ClassNotFoundException e) {
			System.out.println("class not found");
			e.printStackTrace();
		}

		Connection connection = null;
		try {
			String url = rb.getString("db.url");
			String username = rb.getString("db.username");
			String password = rb.getString("db.password");

			connection = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return connection;
	}
}
