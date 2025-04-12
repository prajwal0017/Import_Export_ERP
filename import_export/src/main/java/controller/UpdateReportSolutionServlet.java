package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ReportedProductsPojo;
import operationsImp.ReportedProductsImp;

import java.io.IOException;


public class UpdateReportSolutionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportIdParam = request.getParameter("reportId");
        int reportId = Integer.parseInt(reportIdParam);

        // Assuming you have a ReportService class with the method to update the solution
        ReportedProductsPojo reportedProductsPojo=new ReportedProductsPojo();
        reportedProductsPojo.updateReportSolution(reportId);

        // Redirect to the same page or another page to show success message
        response.sendRedirect("reportedProducts.jsp"); // Redirect to the reported products page
    }
}
