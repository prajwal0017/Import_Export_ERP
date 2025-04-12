package dao;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.GetConnection;
import model.ConsumerPojo;
import operations.ConsumerInterface;

public class ConsumerDAO implements ConsumerInterface {

	@Override
	public boolean registerConsumer(ConsumerPojo consumerPojo) {
		boolean f=false;
	    String query = "Call register_user(?,?,?,?)";
	    try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
	        callableStatement.setInt(1, consumerPojo.getPortId());
	        callableStatement.setString(2, consumerPojo.getPassword());
	        callableStatement.setString(3, consumerPojo.getLocation());
	        callableStatement.setString(4, consumerPojo.getRole());
	        int i=callableStatement.executeUpdate();
	        
	        if (i == 1) {
				f = true;
			}
	        
	        System.out.println("Consumer Registered Successfully");
	        return true; // Return true on successful registration
	    } catch (SQLException | IOException e) {
	        e.printStackTrace();
	        // Return false on exception
	    }
	    return f;
	}


	

	@Override
	public void updateConsumerProfile(ConsumerPojo consumerPojo) {
	    String query = "CALL update_consumer_details(?, ?, ?)";

	    try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
	        callableStatement.setInt(1, consumerPojo.getPortId());
	        callableStatement.setString(2, consumerPojo.getLocation());
	        callableStatement.setString(3, consumerPojo.getPassword());

	        callableStatement.execute();
	        System.out.println("Consumer Details Updated Successfully");
	    } catch (SQLException e) {
	        // Handle SQL exception and provide feedback
	        if (e.getMessage().contains("Consumer does not exist")) {
	            System.err.println("Error: " + e.getMessage());
	            // You might want to throw a custom exception or handle this differently
	            throw new RuntimeException("Error: Consumer does not exist", e);
	        } else {
	            System.err.println("SQL Error: " + e.getMessage());
	            throw new RuntimeException("SQL Error: " + e.getMessage(), e);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}





	@Override
	public ConsumerPojo loginConsumer(ConsumerPojo consumerPojo) {
	    ConsumerPojo loggedInConsumer = null;
	    String query = "CALL login_user(?, ?, ?)"; // Stored procedure to validate login

	    try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
	        callableStatement.setInt(1, consumerPojo.getPortId());
	        callableStatement.setString(2, consumerPojo.getPassword()); // Hash if necessary
	        callableStatement.setString(3, consumerPojo.getRole());

	        System.out.println("Executing stored procedure with Port ID: " + consumerPojo.getPortId());
	        System.out.println("Role: " + consumerPojo.getRole());

	        // Execute the stored procedure
	        ResultSet resultSet = callableStatement.executeQuery();
	        
	        // Process the result set
	        if (resultSet.next()) {
	            loggedInConsumer = new ConsumerPojo();
	            loggedInConsumer.setPortId(resultSet.getInt("port_id"));
	            loggedInConsumer.setPassword(resultSet.getString("password")); // This might not be necessary
	            loggedInConsumer.setLocation(resultSet.getString("location"));
	            loggedInConsumer.setRole(resultSet.getString("role"));
	            System.out.println("Consumer logged in successfully");
	        } else {
	            System.out.println("No consumer found with the provided credentials.");
	        }
	    } catch (SQLException | IOException e) {
	        e.printStackTrace();
	    }

	    return loggedInConsumer; // Returns null if login fails
	}






	@Override
	public void deleteConsumer(int port_id) {
		String query="call delete_consumer_account(?)";
		
		try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
	        callableStatement.setInt(1, port_id);
	        callableStatement.execute();
	        
	        System.out.println("Consumer deleted successfully");

	        // Use executeQuery to retrieve a ResultSet and check if a user exists
	       

	    } catch (SQLException | IOException e) {
	        e.printStackTrace();
	    }
		
		
	}





    @Override
    public ConsumerPojo viewProfile(ConsumerPojo consumerPojo) {
        String query = "CALL viewProfile(?)"; // Adjust the procedure name as needed
        ConsumerPojo profile = null;

        try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
            callableStatement.setInt(1, consumerPojo.getPortId());

            // Execute the stored procedure
            ResultSet resultSet = callableStatement.executeQuery();

            // Check if the result set has data
            if (resultSet.next()) {
                profile = new ConsumerPojo();
                profile.setPortId(resultSet.getInt("port_id"));
                profile.setLocation(resultSet.getString("location"));
                profile.setRole(resultSet.getString("role"));
            } else {
                System.out.println("No profile found for the provided port ID.");
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }

        return profile; // Returns null if no profile is found
    }
    
    public ConsumerPojo getConsumerById(int portId) {
        ConsumerPojo consumer = null;
        String query = "CALL get_consumer_by_id(?)"; // Adjust stored procedure name

        try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
            callableStatement.setInt(1, portId);

            ResultSet resultSet = callableStatement.executeQuery();

            if (resultSet.next()) {
                consumer = new ConsumerPojo();
                consumer.setPortId(resultSet.getInt("port_id"));
                consumer.setLocation(resultSet.getString("location"));
                consumer.setRole(resultSet.getString("role"));
                consumer.setPassword(resultSet.getString("password"));
            } else {
                System.out.println("No consumer found with the provided port ID.");
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }

        return consumer;
    }



	
	

}
