package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


 // This maps the Servlet to /LogoutServlet
public class LogoutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    try {
	        HttpSession session = req.getSession(false);
	        
	        if (session != null) {
	            System.out.println("Invalidating session: " + session.getId());
	            session.invalidate();
	            req.setAttribute("succMsg", "Logout Successfully");
	        } else {
	            System.out.println("No session found to invalidate.");
	        }

	        // Prevent caching for the redirected login page
	        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	        resp.setHeader("Pragma", "no-cache");
	        resp.setDateHeader("Expires", 0);
	        
	        resp.sendRedirect("login.jsp");

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}


}

