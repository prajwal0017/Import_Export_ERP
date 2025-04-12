package operations;

import java.util.List;
import model.OrdersPojo;

public interface OrderInterface {

    void placeOrder(OrdersPojo order);

    void updateOrderStatus(int orderId);

    OrdersPojo trackOrder(int orderId);

    List<OrdersPojo> viewOrders();
    
    List<OrdersPojo> getAllOrdersForConsumer(int consumerPortId);
    
    
    public OrdersPojo getOrderById(int orderId) ;
}
