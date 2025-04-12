package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.ProductPojo;
import model.SellerPojo;
import operationsImp.ProductImp;

@WebServlet("/editProduct")
public class ProductDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        SellerPojo seller = (SellerPojo) session.getAttribute("seller");
        
        if (seller == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductPojo pojo = new ProductPojo();
        ProductPojo product = pojo.getProductById(productId);
        
        if (product != null) {
            request.setAttribute("product", product);
            request.getRequestDispatcher("editProduct.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
