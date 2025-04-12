package dao;

import java.io.IOException;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.GetConnection;
import model.ReportedProductsPojo;
import operations.ReportedProductsInterface;

public class ReportedProductsDAO implements ReportedProductsInterface {
	
	@Override
	public void reportProduct(ReportedProductsPojo reportedProduct) {
		// TODO Auto-generated method stub
		String query = "call report_product(?, ?, ?)"; // Assuming there's a stored procedure `place_order`

		try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {

			callableStatement.setInt(1, reportedProduct.getConsumerPortId()); // Assuming order ID is provided, or could be
																// auto-generated
			callableStatement.setInt(2, reportedProduct.getProductId());

			callableStatement.setString(3, reportedProduct.getIssueType());

			// Execute the stored procedure
			callableStatement.executeUpdate();
			System.out.println("Order reported successfully.");

		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateReportSolution(int reportId) {
		// TODO Auto-generated method stub
		String query = "call update_report_solution(?)"; // Assuming there's a stored procedure `place_order`

		try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {

			callableStatement.setInt(1, reportId); // Assuming order ID is provided, or could be

			// Execute the stored procedure
			callableStatement.executeUpdate();
			System.out.println("Order report updated successfully.");

		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<ReportedProductsPojo> viewReportedProducts() {
		// TODO Auto-generated method stub
		String query = "{call view_reported_products()}";  // Assuming a stored procedure to view all reported products

	    List<ReportedProductsPojo> reportedProductsList = new ArrayList<>();  // Initialize an empty list to store the reported products

	    try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {

	        // Execute the stored procedure and get the result set
	        ResultSet resultSet = callableStatement.executeQuery();

	        // Iterate over the result set to populate the reportedProductsList
	        while (resultSet.next()) {
	            // Initialize a ReportedProductsPojo object for each record
	            ReportedProductsPojo reportedProduct = new ReportedProductsPojo();
	            reportedProduct.setReportId(resultSet.getInt("report_id"));
	            reportedProduct.setConsumerPortId(resultSet.getInt("consumer_port_id"));
	            reportedProduct.setProductId(resultSet.getInt("product_id"));
	            reportedProduct.setIssueType(resultSet.getString("issue_type"));
	            reportedProduct.setSolution(resultSet.getString("solution"));

	            // Add the ReportedProductsPojo object to the list
	            reportedProductsList.add(reportedProduct);
	        }

	        System.out.println("Reported products retrieved successfully.");

	    } catch (SQLException | IOException e) {
	        e.printStackTrace();
	    }

	    return reportedProductsList;
	}


}
