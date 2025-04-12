package operations;

import java.util.List;

import model.ReportedProductsPojo;

public interface ReportedProductsInterface {
   void reportProduct(ReportedProductsPojo reportedProduct);
    
    void updateReportSolution(int reportId);
    
    // View reported products method
    List<ReportedProductsPojo> viewReportedProducts();
    
    

}
