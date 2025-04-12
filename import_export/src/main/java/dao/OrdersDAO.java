package dao;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.GetConnection;
import model.OrdersPojo;
import operations.OrderInterface;

public class OrdersDAO implements OrderInterface {
    
    @Override
    public void placeOrder(OrdersPojo order) {
        String query = "call place_order(?, ?, ?)";

        try (Connection conn = GetConnection.getConnection();
             CallableStatement callableStatement = conn.prepareCall(query)) {
            
            // Set parameters for the stored procedure
            callableStatement.setInt(1, order.getProductId());      // Set product ID
            callableStatement.setInt(2, order.getConsumerPortId()); // Set consumer port ID
            callableStatement.setInt(3, order.getQuantity());       // Set quantity

            // Execute the stored procedure
            boolean hasResultSet = callableStatement.execute(); // Better suited for stored procedures
            
            if (!hasResultSet) {
                System.out.println("Order placed successfully.");
            } else {
                System.out.println("Failed to place the order.");
            }

        } catch (SQLException e) {
            // Handle specific SQL exceptions with more context
            System.err.println("SQL Exception occurred while placing the order: " + e.getMessage());
            e.printStackTrace();
            
            if (e.getSQLState().equals("45000")) {
                System.err.println("Order failed due to insufficient product quantity.");
            }
        } catch (IOException e) {
            // Handle IO exceptions if any
            System.err.println("IO Exception occurred while placing the order: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void updateOrderStatus(int orderId) {
        String query = "call update_order_status(?)"; // Assuming there's a stored procedure `update_order_status`

        try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {

            callableStatement.setInt(1, orderId); // Set the order ID
            
            // Execute the stored procedure
            callableStatement.executeUpdate();
            System.out.println("Order status updated successfully.");

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrdersPojo trackOrder(int orderId) {
        String query = "{call track_order(?)}";  // Assuming the stored procedure is correct

        OrdersPojo order = null;

        try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {

            // Set the input parameter for orderId
            callableStatement.setInt(1, orderId);

            // Execute the stored procedure and get the result set
            ResultSet resultSet = callableStatement.executeQuery();

            while (resultSet.next()) {
                // Initialize the OrdersPojo object
                order = new OrdersPojo();
                order.setOrderId(resultSet.getInt("order_id"));
                order.setProductId(resultSet.getInt("product_id"));
                order.setConsumerPortId(resultSet.getInt("consumer_port_id"));
                order.setQuantity(resultSet.getInt("quantity"));
                order.setOrderDate(resultSet.getTimestamp("order_date"));
                
                // Optionally set other status flags here as needed
            }
            
            System.out.println("Order tracking completed.");

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }

        return order;
    }

    @Override
    public List<OrdersPojo> viewOrders() {
        String query = "{call view_all_orders()}";  // Assuming a stored procedure to view all orders

        List<OrdersPojo> ordersList = new ArrayList<>();  // Initialize an empty list to store the orders

        try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {

            // Execute the stored procedure and get the result set
            ResultSet resultSet = callableStatement.executeQuery();

            // Iterate over the result set to populate the ordersList
            while (resultSet.next()) {
                // Initialize an OrdersPojo object for each record
                OrdersPojo order = new OrdersPojo();
                order.setOrderId(resultSet.getInt("order_id"));
                order.setProductId(resultSet.getInt("product_id"));
                order.setProductName(resultSet.getString("product_name"));
                order.setConsumerPortId(resultSet.getInt("consumer_port_id"));
                order.setQuantity(resultSet.getInt("quantity"));
                order.setOrderDate(resultSet.getTimestamp("order_date"));
                order.setOrderPlaced(resultSet.getBoolean("order_placed"));
                order.setShipped(resultSet.getBoolean("shipped"));
                order.setOutForDelivery(resultSet.getBoolean("out_for_delivery"));
                order.setDelivered(resultSet.getBoolean("delivered"));

                // Add the OrdersPojo object to the list
                ordersList.add(order);
            }

            System.out.println("Orders retrieved successfully.");

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }

        return ordersList;  // Return the list of orders
    }
    
    @Override
    public List<OrdersPojo> getAllOrdersForConsumer(int consumerPortId) {
        List<OrdersPojo> ordersList = new ArrayList<>();
        String query = "{call get_all_orders(?)}";

        try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
            // Set the consumer port ID
            callableStatement.setInt(1, consumerPortId);

            // Execute the stored procedure and get the result set
            ResultSet resultSet = callableStatement.executeQuery();

            while (resultSet.next()) {
                // Initialize the OrdersPojo object
                OrdersPojo order = new OrdersPojo();
                order.setOrderId(resultSet.getInt("order_id"));
                order.setProductId(resultSet.getInt("product_id"));
                order.setProductName(resultSet.getString("product_name")); // Set the product name
                order.setConsumerPortId(resultSet.getInt("consumer_port_id"));
                order.setQuantity(resultSet.getInt("quantity"));
                order.setOrderDate(resultSet.getTimestamp("order_date"));
                order.setOrderPlaced(resultSet.getBoolean("order_placed"));
                order.setShipped(resultSet.getBoolean("shipped"));
                order.setOutForDelivery(resultSet.getBoolean("out_for_delivery"));
                order.setDelivered(resultSet.getBoolean("delivered"));

                ordersList.add(order);
            }

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }

        return ordersList;
    }
    
    public OrdersPojo getOrderById(int orderId) {
	    OrdersPojo order = null;
	    String sql = "SELECT o.order_id, o.product_id, p.product_name, o.quantity, o.order_date, o.order_placed, o.shipped, o.out_for_delivery, o.delivered "
	               + "FROM orders o JOIN products p ON o.product_id = p.product_id WHERE o.order_id = ?";

	    try (Connection conn = GetConnection.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        
	        stmt.setInt(1, orderId);
	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {
	            order = new OrdersPojo();
	            order.setOrderId(rs.getInt("order_id"));
	            order.setProductId(rs.getInt("product_id"));
	            order.setProductName(rs.getString("product_name")); // Set product name
	            order.setQuantity(rs.getInt("quantity"));
	            order.setOrderDate(rs.getDate("order_date"));
	            order.setOrderPlaced(rs.getBoolean("order_placed"));
	            order.setShipped(rs.getBoolean("shipped"));
	            order.setOutForDelivery(rs.getBoolean("out_for_delivery"));
	            order.setDelivered(rs.getBoolean("delivered"));
	        } else {
	            System.out.println("No order found with ID: " + orderId);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace(); // Handle exceptions properly in production code
	    } catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	    return order;
	}

}
