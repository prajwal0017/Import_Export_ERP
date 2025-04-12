package dao;

import java.io.IOException;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.GetConnection;
import model.SellerPojo;
import operations.SellerInterface;
public class SellerDAO implements SellerInterface {

	@Override
	public boolean registerSeller(SellerPojo sellerPojo) {
	    String query = "Call register_user(?,?,?,?)";
	    try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
	        callableStatement.setInt(1, sellerPojo.getPortId());
	        callableStatement.setString(2, sellerPojo.getPassword());
	        callableStatement.setString(3, null); // Assuming this is intended
	        callableStatement.setString(4, sellerPojo.getRole());
	        callableStatement.execute();
	        
	        System.out.println("Seller registered successfully");
	        return true; // Return true on successful registration
	    } catch (SQLException | IOException e) {
	        e.printStackTrace();
	        return false; // Return false on exception
	    }
	}


	@Override
	public SellerPojo loginSeller(SellerPojo sellerPojo) {
	    String query = "CALL login_user(?, ?, ?)"; // Ensure you have a stored procedure for login
	    SellerPojo loggedInSeller = null;

	    try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
	        callableStatement.setInt(1, sellerPojo.getPortId());
	        callableStatement.setString(2, sellerPojo.getPassword()); // Consider hashing the password here
	        callableStatement.setString(3, sellerPojo.getRole());

	        // Use executeQuery to retrieve a ResultSet and check if a user exists
	        try (ResultSet resultSet = callableStatement.executeQuery()) {
	            if (resultSet.next()) {
	                loggedInSeller = new SellerPojo();
	                loggedInSeller.setPortId(resultSet.getInt("port_id")); // Adjust according to your database schema
	                loggedInSeller.setPassword(resultSet.getString("password")); // Optionally, don't return password
	                loggedInSeller.setRole(resultSet.getString("role"));
	                // Set other properties if needed
	                System.out.println("Seller logged in successfully");
	            }
	        }

	    } catch (SQLException | IOException e) {
	        e.printStackTrace();
	    }

	    return loggedInSeller; // Returns null if login fails
	}

}
