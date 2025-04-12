package operationsImp;


import java.util.List;

import dao.ReportedProductsDAO;

import model.ReportedProductsPojo;
import operations.ReportedProductsInterface;

public class ReportedProductsImp implements ReportedProductsInterface {

	@Override
	public void reportProduct(ReportedProductsPojo reportedProduct) {
		new ReportedProductsDAO().reportProduct(reportedProduct);
	}

	@Override
	public void updateReportSolution(int reportId) {
		new ReportedProductsDAO().updateReportSolution(reportId);
	}

	@Override
	public List<ReportedProductsPojo> viewReportedProducts() {
		return new ReportedProductsDAO().viewReportedProducts();

}
}