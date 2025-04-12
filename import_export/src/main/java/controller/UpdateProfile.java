package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ConsumerPojo;
import operationsImp.ConsumerImp;

import java.io.IOException;

/**
 * Servlet implementation class UpdateProfile
 */
public class UpdateProfile extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            // Get consumerPortId from the session
            Integer portId = (Integer) session.getAttribute("consumerPortId");

            if (portId == null) {
                throw new Exception("User is not logged in or port ID is not found in the session.");
            }

            String action = request.getParameter("action");
            ConsumerPojo consumerPojo = new ConsumerPojo();
            consumerPojo.setPortId(portId);

          

            if ("update".equals(action)) {
                // Get new values from request parameters
                String newPassword = request.getParameter("new_password");
                String newLocation = request.getParameter("new_location");

                // Set new values to the consumerPojo
                consumerPojo.setPassword(newPassword);
                consumerPojo.setLocation(newLocation);

                // Call the method that updates the consumer profile
                consumerPojo.updateConsumerProfile(consumerPojo);

                // Retrieve the updated consumer data from the database
                ConsumerPojo updatedConsumer = consumerPojo.getConsumerById(portId); // Make sure this method is implemented

                // Update the session with the new consumer object
                session.setAttribute("userobj", updatedConsumer);

                // Set success message in session and redirect
                session.setAttribute("message", "Consumer details updated successfully!");
                response.sendRedirect("viewProfile.jsp"); // Redirect to the profile page

            } else if ("delete".equals(action)) {
                // Call the method to delete the consumer profile
                consumerPojo.deleteConsumer(portId);
                session.invalidate(); // Invalidate the session after deletion
                response.sendRedirect("login.jsp"); // Redirect to login page after deletion
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Error updating or deleting consumer details: " + e.getMessage());
            response.sendRedirect("updateConsumer.jsp"); // Redirect back to the update page on error
        }
    }
}
