package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ReportedProductsPojo;
import operationsImp.ReportedProductsImp;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Servlet implementation class ReportProductController
 */
public class ReportProductController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        // Retrieve parameters from request
	        int consumerPortId = Integer.parseInt(request.getParameter("consumerPortId"));
	        int productId = Integer.parseInt(request.getParameter("productId"));
	        String issueType = request.getParameter("issue_type");

	        // Validate inputs
	        List<String> validIssueTypes = Arrays.asList("Damage", "Wrong Product", "Delayed", "Still Not Received", "Missing");
	        
	        if (consumerPortId <= 0 || productId <= 0 || issueType == null || !validIssueTypes.contains(issueType)) {
	            throw new IllegalArgumentException("Invalid input values.");
	        }

	        // Create ReportedProductsPojo object
	        ReportedProductsPojo reportedProduct = new ReportedProductsPojo();
	        reportedProduct.setConsumerPortId(consumerPortId);
	        reportedProduct.setProductId(productId);
	        reportedProduct.setIssueType(issueType);

	        // Create DAO instance and call reportProduct method
	       
	        reportedProduct.reportProduct(reportedProduct);

	        // Redirect or forward to a success page
	        response.sendRedirect("consumerDashboard.jsp");
	        
	    } catch (NumberFormatException e) {
	        // Handle case where parsing integer fails
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format.");
	    } catch (IllegalArgumentException e) {
	        // Handle validation failure
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
	    } catch (Exception e) {
	        // Handle other exceptions
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
	    }
	}


}
