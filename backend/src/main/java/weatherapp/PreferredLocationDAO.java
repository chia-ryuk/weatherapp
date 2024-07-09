package weatherapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PreferredLocationDAO {
	private final String url = "jdbc:postgresql://localhost:5432/weatherapi"; // replace 'yourdb' with your database
																				// name
	private final String user = "postgres"; // replace 'youruser' with your username
	private final String password = "root"; // replace 'yourpassword' with your password

	private Connection connect() {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		Connection connection = null;
		try {
			connection = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			System.out.println("Error connecting to the database: " + e.getMessage());
		}
		return connection;
	}

	public void addPreferredLocation(PreferredLocationModel location) {
		String SQL = "INSERT INTO preferred_locations(id, preferred_location) VALUES(?, ?)";

		try (Connection connection = connect(); PreparedStatement pstmt = connection.prepareStatement(SQL)) {
			pstmt.setInt(1, location.getId());
			pstmt.setString(2, location.getPreferredLocation());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("Error adding preferred location: " + e.getMessage());
		}
	}

	public PreferredLocationModel getPreferredLocationById(int id) {
		String SQL = "SELECT id, preferred_location FROM preferred_locations WHERE id = ?";
		PreferredLocationModel location = null;

		try (Connection connection = connect(); PreparedStatement pstmt = connection.prepareStatement(SQL)) {
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				location = new PreferredLocationModel();
				location.setId(rs.getInt("id"));
				location.setPreferredLocation(rs.getString("preferred_location"));
			}
		} catch (SQLException e) {
			System.out.println("Error fetching preferred location: " + e.getMessage());
		}

		return location;
	}

	public List<PreferredLocationModel> getAllPreferredLocations() {
		String SQL = "SELECT id, preferred_location FROM preferred_locations";
		List<PreferredLocationModel> locations = new ArrayList<>();

		try (Connection connection = connect();
				PreparedStatement pstmt = connection.prepareStatement(SQL);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				PreferredLocationModel location = new PreferredLocationModel();
				location.setId(rs.getInt("id"));
				location.setPreferredLocation(rs.getString("preferred_location"));
				locations.add(location);
			}
		} catch (SQLException e) {
			System.out.println("Error fetching all preferred locations: " + e.getMessage());
		}

		return locations;
	}

	public void updatePreferredLocation(PreferredLocationModel location) {
		String SQL = "UPDATE preferred_locations SET preferred_location = ? WHERE id = ?";

		try (Connection connection = connect(); PreparedStatement pstmt = connection.prepareStatement(SQL)) {
			pstmt.setString(1, location.getPreferredLocation());
			pstmt.setInt(2, location.getId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("Error updating preferred location: " + e.getMessage());
		}
	}

	public void deletePreferredLocation(int id) {
		String SQL = "DELETE FROM preferred_locations WHERE id = ?";

		try (Connection connection = connect(); PreparedStatement pstmt = connection.prepareStatement(SQL)) {
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("Error deleting preferred location: " + e.getMessage());
		}
	}
}
