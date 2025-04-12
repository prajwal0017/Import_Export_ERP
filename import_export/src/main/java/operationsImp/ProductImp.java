package operationsImp;


import java.util.List;

import dao.ProductDAO;
import model.ProductPojo;
import operations.ProductInterface;


public class ProductImp implements ProductInterface  {

	public boolean addProduct(ProductPojo productPojo) {
		return new ProductDAO().addProduct(productPojo);
	    
	}


	public void updateProduct(ProductPojo productPojo) {
		new ProductDAO().updateProduct(productPojo);
		

	}

	public void deleteProduct(int productId) {
		new ProductDAO().deleteProduct(productId);
	    
	}


	public List<ProductPojo> viewProducts() {
		return new ProductDAO().viewProducts();
		
	}
	
	
	    public ProductPojo getProductById(int id) {
		 return new ProductDAO().getProductById(id);
	       
	 }
	    
	    
}
