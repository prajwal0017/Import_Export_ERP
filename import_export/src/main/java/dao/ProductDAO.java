package dao;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.GetConnection;
import model.ProductPojo;
import operations.ProductInterface;

public class ProductDAO implements ProductInterface {
	
	@Override
	public boolean addProduct(ProductPojo productPojo) {
	    boolean success = false;
	    String query = "CALL add_product(?, ?, ?, ?)";

	    try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
	        callableStatement.setInt(1, productPojo.getProductId());
	        callableStatement.setString(2, productPojo.getProductName());
	        callableStatement.setInt(3, productPojo.getQuantity());
	        callableStatement.setDouble(4, productPojo.getPrice());

	        int rowsAffected = callableStatement.executeUpdate();

	        if (rowsAffected > 0) {
	            success = true;
	            System.out.println("Product inserted successfully");
	        }

	    } catch (SQLException | IOException e) {
	        e.printStackTrace();
	    }

	    return success;
	}


	@Override
	public void updateProduct(ProductPojo productPojo) {
		// TODO Auto-generated method stub
		String query = "CALL update_product(?,?,?,?)";

		try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
			callableStatement.setInt(1, productPojo.getProductId());
			callableStatement.setString(2, productPojo.getProductName());
			callableStatement.setInt(3, productPojo.getQuantity());
			callableStatement.setDouble(4, productPojo.getPrice());
			callableStatement.execute();
			System.out.println("Product updated successfully");

		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void deleteProduct(int productId) {
	    // Change the query to call the delete procedure
	    String query = "CALL delete_product(?)"; // Ensure this matches your procedure name

	    try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
	        callableStatement.setInt(1, productId); // Set the productId parameter

	        callableStatement.execute();

	        System.out.println("Product deleted successfully");

	    } catch (SQLException | IOException e) {
	        e.printStackTrace();
	    }
	}


	@Override
	public List<ProductPojo> viewProducts() {
		List<ProductPojo> productList = new ArrayList<>();
		String query = "call view_products()"; // Assuming there's a stored procedure to get all products

		try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
			ResultSet resultSet = callableStatement.executeQuery();

			while (resultSet.next()) {
				ProductPojo product = new ProductPojo();
				product.setProductId(resultSet.getInt("product_id"));
				product.setProductName(resultSet.getString("product_name"));
				product.setQuantity(resultSet.getInt("quantity"));
				product.setPrice(resultSet.getFloat("price"));

				productList.add(product);
			}

		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
		return productList;
	}
	
	 @Override
	    public ProductPojo getProductById(int id) {
	        ProductPojo product = null;
	        String query = "CALL get_product_by_id(?)"; // Ensure this matches your procedure name

	        try (CallableStatement callableStatement = GetConnection.getConnection().prepareCall(query)) {
	            callableStatement.setInt(1, id); // Set the productId parameter

	            ResultSet resultSet = callableStatement.executeQuery();
	            if (resultSet.next()) {
	                product = new ProductPojo();
	                product.setProductId(resultSet.getInt("product_id"));
	                product.setProductName(resultSet.getString("product_name"));
	                product.setQuantity(resultSet.getInt("quantity"));
	                product.setPrice(resultSet.getFloat("price"));
	                // Set additional fields if necessary
	            }

	        } catch (SQLException | IOException e) {
	            e.printStackTrace();
	        }

	        return product;
	    }


}
