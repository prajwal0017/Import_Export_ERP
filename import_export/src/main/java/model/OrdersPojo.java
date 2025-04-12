package model;

import java.util.Date;
import java.util.List;
import operationsImp.OrderImp;

public class OrdersPojo {
    private int orderId;
    private int productId;
    private String productName; // Added productName field
    private int consumerPortId;
    private int quantity;
    private Date orderDate;
    private boolean orderPlaced;
    private boolean shipped;
    private boolean outForDelivery;
    private boolean delivered;

    private final OrderImp orderImp = new OrderImp();

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() { // Getter for productName
        return productName;
    }

    public void setProductName(String productName) { // Setter for productName
        this.productName = productName;
    }

    public int getConsumerPortId() {
        return consumerPortId;
    }

    public void setConsumerPortId(int consumerPortId) {
        this.consumerPortId = consumerPortId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public boolean isOrderPlaced() {
        return orderPlaced;
    }

    public void setOrderPlaced(boolean orderPlaced) {
        this.orderPlaced = orderPlaced;
    }

    public boolean isShipped() {
        return shipped;
    }

    public void setShipped(boolean shipped) {
        this.shipped = shipped;
    }

    public boolean isOutForDelivery() {
        return outForDelivery;
    }

    public void setOutForDelivery(boolean outForDelivery) {
        this.outForDelivery = outForDelivery;
    }

    public boolean isDelivered() {
        return delivered;
    }

    public void setDelivered(boolean delivered) {
        this.delivered = delivered;
    }

    // Wrapper methods with similar parameters to those in OrderImp

    public void placeOrder(OrdersPojo order) {
        orderImp.placeOrder(order);
    }

    public void updateOrderStatus(int orderId) {
        orderImp.updateOrderStatus(orderId);
    }

    public OrdersPojo trackOrder(int orderId) {
        return orderImp.trackOrder(orderId);
    }

    public List<OrdersPojo> viewOrders() {
        return orderImp.viewOrders();
    }

    public List<OrdersPojo> getAllOrdersForConsumer(int consumerPortId) {
        return orderImp.getAllOrdersForConsumer(consumerPortId);
    }

    public OrdersPojo getOrderById(int orderId) {
        return orderImp.getOrderById(orderId);
    }
}
