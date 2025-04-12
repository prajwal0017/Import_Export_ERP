package model;

import operationsImp.ConsumerImp;

public class ConsumerPojo {
    private int portId;
    private String password;
    private String location;
    private String role; // Should be "Consumer"
    
    private final ConsumerImp consumerImp = new ConsumerImp();

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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // Methods with similar parameters to those in ConsumerImp

    public boolean registerConsumer(ConsumerPojo consumerPojo) {
        return consumerImp.registerConsumer(consumerPojo);
    }

    public void updateConsumerProfile(ConsumerPojo consumerPojo) {
        consumerImp.updateConsumerProfile(consumerPojo);
    }

    public ConsumerPojo loginConsumer(ConsumerPojo consumerPojo) {
        return consumerImp.loginConsumer(consumerPojo);
    }

    public void deleteConsumer(int portId) {
        consumerImp.deleteConsumer(portId);
    }

    public ConsumerPojo getConsumerById(int portId) {
        return consumerImp.getConsumerById(portId);
    }

    public ConsumerPojo viewProfile(ConsumerPojo consumerPojo) {
        return consumerImp.viewProfile(consumerPojo);
    }
}
