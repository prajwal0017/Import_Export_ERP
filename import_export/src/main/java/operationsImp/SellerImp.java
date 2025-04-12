package operationsImp;



import dao.SellerDAO;

import model.SellerPojo;
import operations.SellerInterface;

public class SellerImp implements SellerInterface {

	@Override
	public boolean registerSeller(SellerPojo sellerPojo) {
	    return new SellerDAO().registerSeller(sellerPojo);
	}


	@Override
	public SellerPojo loginSeller(SellerPojo sellerPojo) {
	    return new SellerDAO().loginSeller(sellerPojo);

}
	
}


