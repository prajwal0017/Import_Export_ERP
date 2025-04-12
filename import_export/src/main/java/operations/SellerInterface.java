package operations;

import model.SellerPojo;

public interface SellerInterface {
	 boolean registerSeller(SellerPojo sellerPojo);

      SellerPojo loginSeller(SellerPojo sellerPojo);
}
