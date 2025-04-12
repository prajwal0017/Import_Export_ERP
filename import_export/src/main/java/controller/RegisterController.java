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
 * Servlet implementation class RegisterController
 */


	
	public class RegisterController extends HttpServlet {

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String portId = request.getParameter("port_id");
	        String password = request.getParameter("password"); // Ensure the name matches
	        String location = request.getParameter("location");
	        String role = request.getParameter("role");

	        HttpSession session = request.getSession();
	        String message = "";

	        try {
	            if ("Consumer".equalsIgnoreCase(role)) {
	                ConsumerPojo consumer = new ConsumerPojo();
	                consumer.setPortId(Integer.parseInt(portId));
	                consumer.setPassword(password);
	                consumer.setLocation(location);
	                consumer.setRole(role);
	                
	                
	             

	                // Register the consumer
	                boolean isRegistered = consumer.registerConsumer(consumer);
	                if (isRegistered) {
	                    session.setAttribute("succMsg", "Registration Successful!");
	                    response.sendRedirect("login.jsp");
	                    return; // Exit after redirect
	                } else {
	                    session.setAttribute("failedMsg", "Consumer registration failed.");
	                    response.sendRedirect("register.jsp");
	                    return; // Exit after redirect
	                }

	            } else if ("Seller".equalsIgnoreCase(role)) {
	                SellerPojo seller = new SellerPojo();
	                seller.setPortId(Integer.parseInt(portId));
	                seller.setPassword(password);
	                 // Assuming SellerPojo has a location field
	                seller.setRole(role);
	                
	                
	                

	                // Register the seller
	                boolean isRegistered = seller.registerSeller(seller);
	                if (isRegistered) {
	                    session.setAttribute("succMsg", "Seller registered successfully!");
	                    response.sendRedirect("login.jsp");
	                    return; // Exit after redirect
	                } else {
	                    session.setAttribute("failedMsg", "Seller registration failed.");
	                    response.sendRedirect("register.jsp");
	                    return; // Exit after redirect
	                }

	            } else {
	                message = "Invalid role";
	                session.setAttribute("failedMsg", message);
	                response.sendRedirect("register.jsp");
	                return; // Exit after redirect
	            }

	        } catch (Exception e) {
	            message = "An error occurred: " + e.getMessage();
	            session.setAttribute("failedMsg", message);
	            response.sendRedirect("register.jsp"); // Redirect in case of error
	        }
	    }
	}


