package operationsImp;



import dao.ConsumerDAO;

import model.ConsumerPojo;
import operations.ConsumerInterface;

public class ConsumerImp implements ConsumerInterface {

	public boolean registerConsumer(ConsumerPojo consumerPojo) {
		return new ConsumerDAO().registerConsumer(consumerPojo);
	}

	public void updateConsumerProfile(ConsumerPojo consumerPojo) {
		new ConsumerDAO().updateConsumerProfile(consumerPojo);
	}

	public ConsumerPojo loginConsumer(ConsumerPojo consumerPojo) {
	    return new ConsumerDAO().loginConsumer(consumerPojo);
	}

	public void deleteConsumer(int port_id) {
		 new ConsumerDAO().deleteConsumer(port_id);
}
	
	
	public ConsumerPojo getConsumerById(int portId) {
		return new ConsumerDAO().getConsumerById(portId);
		
	}

	@Override
	public ConsumerPojo viewProfile(ConsumerPojo consumerPojo) {
		// TODO Auto-generated method stub
		return new ConsumerDAO().viewProfile(consumerPojo);
	}
}
