package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ProductPojo;
import model.SellerPojo;
import model.ConsumerPojo;

import java.io.IOException;
import java.util.List;

@WebServlet("/allProducts") // This maps the servlet to the "/allProducts" URL
public class AllProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        SellerPojo seller = (SellerPojo) session.getAttribute("seller");
        ConsumerPojo consumer = (ConsumerPojo) session.getAttribute("userobj");

        // Log session information for debugging
        System.out.println("Seller: " + seller);
        System.out.println("Consumer: " + consumer);

        ProductPojo productPojo = new ProductPojo();
        List<ProductPojo> productList = productPojo.viewProducts(); // Use ProductPojo to retrieve product list

        if (seller != null) { // Seller logged in
            request.setAttribute("productList", productList);
            request.getRequestDispatcher("allProducts.jsp").forward(request, response);

        } else if (consumer != null) { // Consumer logged in
            request.setAttribute("productList", productList);
            request.getRequestDispatcher("viewConsumerProducts.jsp").forward(request, response);

        } else { // Neither seller nor consumer logged in
            response.sendRedirect("login.jsp");
        }
    }
}
