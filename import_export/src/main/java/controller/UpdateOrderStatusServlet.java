package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.OrdersPojo;
import operationsImp.OrderImp;

import java.io.IOException;

/**
 * Servlet implementation class UpdateOrderStatusServlet
 */
public class UpdateOrderStatusServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId")); // Get the order ID from the request

        // Create an instance of the class containing updateOrderStatus
         // Call method to update order status
        OrdersPojo order=new OrdersPojo();
        order.updateOrderStatus(orderId);
        
        response.sendRedirect("orderedProducts"); // Redirect back to the orders page after updating
    }

}
