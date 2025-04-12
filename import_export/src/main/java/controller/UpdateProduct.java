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


public class UpdateProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            String action = request.getParameter("action"); // Get the action parameter

            ProductPojo productPojo = new ProductPojo();

            if ("update".equals(action)) {
                // Get product details from request parameters
                int productId = Integer.parseInt(request.getParameter("productId"));
                String productName = request.getParameter("productName");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                double price = Double.parseDouble(request.getParameter("price"));

                productPojo.setProductId(productId);
                productPojo.setProductName(productName);
                productPojo.setQuantity(quantity);
                productPojo.setPrice(price);

                // Call method to update the product
               
                productPojo.updateProduct(productPojo);

                // Set success message in session and redirect
                session.setAttribute("succMsg", "Product updated successfully!");
                response.sendRedirect("allProducts"); // Redirect to the product dashboard

            } else if ("delete".equals(action)) {
                // Get productId from request parameter and call delete method
                int productId = Integer.parseInt(request.getParameter("productId"));
                
                
                
                productPojo.deleteProduct(productId);

                // Set success message in session and redirect
                session.setAttribute("succMsg", "Product deleted successfully!");
                response.sendRedirect("allProducts"); // Redirect to the product dashboard
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Error updating or deleting product: " + e.getMessage());
            response.sendRedirect("updateProduct.jsp"); // Redirect back to the update page
        }
    }

}
