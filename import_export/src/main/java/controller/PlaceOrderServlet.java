package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ConsumerPojo;
import model.OrdersPojo;
import model.SellerPojo;
import operationsImp.OrderImp;


public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get parameters from the request
            String productId = request.getParameter("productId");
            String consumerPortId = request.getParameter("consumerPortId");
            String quantity = request.getParameter("quantity");

            // Log the received parameters
            System.out.println("Received Product ID: " + productId);
            System.out.println("Received Consumer Port ID: " + consumerPortId);
            System.out.println("Received Quantity: " + quantity);


            // Create OrdersPojo object to store order data
            OrdersPojo order = new OrdersPojo();
            order.setProductId(Integer.parseInt(productId));
            order.setConsumerPortId(Integer.parseInt(consumerPortId));
            order.setQuantity(Integer.parseInt(quantity));

           
            order.placeOrder(order);

            // Redirect or display success message
            response.sendRedirect("viewConsumerOrders");

        } catch (NumberFormatException e) {
            // Handle invalid input error (e.g., if user submits non-integer data)
            e.printStackTrace();
            response.sendRedirect("consumerDashboard.jsp");

        } catch (Exception e) {
            // Handle other exceptions (e.g., database failure)
            e.printStackTrace();
            response.sendRedirect("allProducts.jsp?error=orderFailed");
        }
    }

}
