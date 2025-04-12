package operations;

import java.util.List;

import model.ProductPojo;

public interface ProductInterface {
	
    boolean addProduct(ProductPojo product);
    
    void updateProduct(ProductPojo product);
    
    void deleteProduct(int productId);
    
    List<ProductPojo> viewProducts();

	ProductPojo getProductById(int id);

}
