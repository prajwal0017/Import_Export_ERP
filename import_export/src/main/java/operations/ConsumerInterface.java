package operations;

import model.ConsumerPojo;



public interface ConsumerInterface {

    boolean registerConsumer(ConsumerPojo consumerPojo);

   

    ConsumerPojo loginConsumer(ConsumerPojo consumerPojo);

    // Method for consumers to update their profiles
    void updateConsumerProfile(ConsumerPojo consumerPojo);
    
    void deleteConsumer(int port_id);
    
    ConsumerPojo viewProfile(ConsumerPojo consumerPojo);
    
    
    ConsumerPojo getConsumerById(int portId);
    
}
