package model;

import operationsImp.SellerImp;

public class SellerPojo {
    private int portId;
    private String password;
    private String role; // Should be "Seller"
    
    private final SellerImp sellerImp = new SellerImp();

    // Getters and Setters
    public int getPortId() {
        return portId;
    }

    public void setPortId(int portId) {
        this.portId = portId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // Wrapper methods with similar parameters as in SellerImp

    public boolean registerSeller(SellerPojo sellerPojo) {
        return sellerImp.registerSeller(sellerPojo);
    }

    public SellerPojo loginSeller(SellerPojo sellerPojo) {
        return sellerImp.loginSeller(sellerPojo);
    }
}