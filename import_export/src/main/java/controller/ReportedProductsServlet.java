package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import operationsImp.ReportedProductsImp;
import model.ReportedProductsPojo;
import model.SellerPojo;

@WebServlet("/reportedProducts")
public class ReportedProductsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check for seller session
        HttpSession session = request.getSession();
        SellerPojo seller = (SellerPojo) session.getAttribute("seller");
        
        if (seller == null) {
            // Redirect to login if no seller is found
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Fetch reported products
        ReportedProductsPojo pojo = new ReportedProductsPojo();
        List<ReportedProductsPojo> reportedProductsList = pojo.viewReportedProducts();
        
        // Set the list as a request attribute
        request.setAttribute("reportedProductsList", reportedProductsList);
        
        // Forward to the JSP page
        request.getRequestDispatcher("reportedProducts.jsp").forward(request, response);
    }
}
