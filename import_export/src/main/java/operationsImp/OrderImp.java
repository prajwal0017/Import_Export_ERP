package operationsImp;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.OrdersDAO;
import database.GetConnection;
import model.OrdersPojo;
import operations.OrderInterface;

public class OrderImp implements OrderInterface {

	@Override
	public void placeOrder(OrdersPojo order) {
	    new OrdersDAO().placeOrder(order);
	}



	@Override
	public void updateOrderStatus(int orderId) {
		new OrdersDAO().updateOrderStatus(orderId);
		

	}

	@Override
	public OrdersPojo trackOrder(int orderId) {
		return new OrdersDAO().trackOrder(orderId);
	    
	}


	@Override
	public List<OrdersPojo> viewOrders() {
		return new OrdersDAO().viewOrders();
	    
	}
	
	public List<OrdersPojo> getAllOrdersForConsumer(int consumerPortId) {
		return new OrdersDAO().getAllOrdersForConsumer(consumerPortId);
	   
	}
	
	@Override
	public OrdersPojo getOrderById(int orderId) {
		// TODO Auto-generated method stub
		return new OrdersDAO().getOrderById(orderId);
	}
	
	




}
