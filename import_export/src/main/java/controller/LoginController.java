package controller;

import jakarta.servlet.ServletException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ConsumerPojo;
import model.SellerPojo;
import operationsImp.ConsumerImp;
import operationsImp.SellerImp;

import java.io.IOException;

/**
 * Servlet implementation class LoginController
 */

public class LoginController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String portId = request.getParameter("port_id");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Log the incoming parameters for debugging
        System.out.println("Received Port ID: " + portId);
        System.out.println("Received Password: " + password);
        System.out.println("Received Role: " + role);

        HttpSession session = request.getSession();
        
        try {
        	if ("Consumer".equalsIgnoreCase(role)) {
        	    ConsumerPojo consumer = new ConsumerPojo();
        	    consumer.setPortId(Integer.parseInt(portId)); // Set the portId from the request
        	    consumer.setPassword(password);
        	    consumer.setRole(role);

        	    System.out.println("Consumer details - Port ID: " + consumer.getPortId() + ", Role: " + consumer.getRole());

        	    
        	    
        	    // Perform the login operation
        	    ConsumerPojo loggedInConsumer = consumer.loginConsumer(consumer); // Make sure the login method returns a ConsumerPojo object

        	    if (loggedInConsumer != null) {
        	        // Now set the consumer port ID in the session
        	        session.setAttribute("userobj", loggedInConsumer);
        	        session.setAttribute("consumerPortId", loggedInConsumer.getPortId()); // Use getPortId() to retrieve it
        	        System.out.println("Redirecting to consumerDashboard.jsp");
        	        response.sendRedirect("consumerDashboard.jsp");
        	    } else {
        	        session.setAttribute("failedMsg", "Port ID & Password Invalid");
        	        System.out.println("Consumer login failed, redirecting to login.jsp");
        	        response.sendRedirect(request.getContextPath() + "/login.jsp");
        	    }
        	}
 else if ("Seller".equalsIgnoreCase(role)) {
                SellerPojo seller = new SellerPojo();
                seller.setPortId(Integer.parseInt(portId));
                seller.setPassword(password);
                seller.setRole(role);
                
                System.out.println("Seller details - Port ID: " + seller.getPortId() + ", Role: " + seller.getRole());
                
                
                
                SellerPojo loggedInSeller = seller.loginSeller(seller);
                if (loggedInSeller != null) {
                    session.setAttribute("seller", loggedInSeller);
                    System.out.println("Redirecting to sellerDashboard.jsp");
                    response.sendRedirect("sellerDashboard.jsp"); // Ensure correct path
                } else {
                    session.setAttribute("failedMsg", "Port ID & Password Invalid");
                    System.out.println("Seller login failed, redirecting to login.jsp");
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                }
            } else {
                session.setAttribute("failedMsg", "Invalid role");
                System.out.println("Invalid role, redirecting to login.jsp");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        } catch (Exception e) {
            session.setAttribute("failedMsg", "An error occurred: " + e.getMessage());
            System.out.println("Error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}
