package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import operationsImp.OrderImp;
import model.ConsumerPojo;
import model.OrdersPojo;

@WebServlet("/viewConsumerOrders")
public class ViewConsumerOrdersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        ConsumerPojo consumer = (ConsumerPojo) session.getAttribute("userobj");
        
        if (consumer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer consumerPortId = consumer.getPortId(); 
        OrdersPojo order= new OrdersPojo();
        List<OrdersPojo> orders = order.getAllOrdersForConsumer(consumerPortId);
        
        // Set the orders list and action type as request attributes
        request.setAttribute("orderList", orders);
        
        
        request.getRequestDispatcher("viewConsumerOrders.jsp").forward(request, response);
    }
}

