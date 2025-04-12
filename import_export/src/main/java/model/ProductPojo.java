package model;

import java.util.List;
import operationsImp.ProductImp;

public class ProductPojo {
    private int productId;
    private String productName;
    private int quantity;
    private double price;

    private final ProductImp productImp = new ProductImp();

    // Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    // Wrapper methods with similar parameters to those in ProductImp

    public boolean addProduct(ProductPojo productPojo) {
        return productImp.addProduct(productPojo);
    }

    public void updateProduct(ProductPojo productPojo) {
        productImp.updateProduct(productPojo);
    }

    public void deleteProduct(int productId) {
        productImp.deleteProduct(productId);
    }

    public List<ProductPojo> viewProducts() {
        return productImp.viewProducts();
    }

    public ProductPojo getProductById(int id) {
        return productImp.getProductById(id);
    }
}
