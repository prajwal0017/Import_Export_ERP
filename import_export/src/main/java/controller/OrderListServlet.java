package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.OrdersPojo;
import operationsImp.OrderImp;
import model.SellerPojo;

@WebServlet("/orderedProducts")
public class OrderListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        SellerPojo seller = (SellerPojo) session.getAttribute("seller");
        
        if (seller == null) {
            // If no seller is logged in, redirect to the login page
            response.sendRedirect("login.jsp");
            return;
        }

        OrdersPojo orderService = new OrdersPojo();
        List<OrdersPojo> orderList = orderService.viewOrders();
        
        // Set the order list as a request attribute
        request.setAttribute("orderList", orderList);
        
        // Forward to the JSP page
        request.getRequestDispatcher("orderedProducts.jsp").forward(request, response);
    }
}
