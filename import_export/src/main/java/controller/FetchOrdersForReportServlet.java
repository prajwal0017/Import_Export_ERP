package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import model.ConsumerPojo;
import model.OrdersPojo;

@WebServlet("/reportProduct")
public class FetchOrdersForReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        ConsumerPojo consumer = (ConsumerPojo) session.getAttribute("userobj");
        
        if (consumer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer consumerPortId = consumer.getPortId(); 
        OrdersPojo ordersPojo = new OrdersPojo();
        List<OrdersPojo> orders = ordersPojo.getAllOrdersForConsumer(consumerPortId);
        
        // Set the orders list as a request attribute
        request.setAttribute("orderList", orders);
        
        // Forward the request to the report product page
        request.getRequestDispatcher("reportProduct.jsp").forward(request, response);
    }
}
