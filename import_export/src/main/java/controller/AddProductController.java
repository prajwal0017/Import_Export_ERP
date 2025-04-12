package controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ProductPojo;
import operationsImp.ProductImp;

import java.io.IOException;

import dao.ProductDAO;

/**
 * Servlet implementation class AddProductController
 */

public class AddProductController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve parameters from the request
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String productName = request.getParameter("product_name");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));
            
            // Create and populate the ProductPojo object
            ProductPojo productPojo = new ProductPojo();
            productPojo.setProductId(productId);      // Assuming you have a setProductId method
            productPojo.setProductName(productName);  // Assuming you have a setProductName method
            productPojo.setQuantity(quantity);        // Assuming you have a setQuantity method
            productPojo.setPrice(price);              // Assuming you have a setPrice method

        
            productPojo.addProduct(productPojo);
            
            // Manage session for success message
            HttpSession session = request.getSession();
            session.setAttribute("succMsg", "Product added successfully!");
            response.sendRedirect("allProducts"); // Redirect to success page

        } catch (Exception e) {
            e.printStackTrace();
            // Handle the error
            HttpSession session = request.getSession();
            session.setAttribute("failedMsg", "Something went wrong on the server.");
            response.sendRedirect("admin/add_product.jsp"); // Redirect to error page
        }
    }
}
