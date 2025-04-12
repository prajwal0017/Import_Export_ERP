package model;

import java.util.Date;
import java.util.List;
import operationsImp.ReportedProductsImp;

public class ReportedProductsPojo {
    private int reportId;
    private int consumerPortId;
    private int productId;
    private String issueType;
    private String solution;
    private Date reportDate;

    private final ReportedProductsImp reportedProductsImp = new ReportedProductsImp();

    // Getters and Setters
    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getConsumerPortId() {
        return consumerPortId;
    }

    public void setConsumerPortId(int consumerPortId) {
        this.consumerPortId = consumerPortId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getIssueType() {
        return issueType;
    }

    public void setIssueType(String issueType) {
        this.issueType = issueType;
    }

    public String getSolution() {
        return solution;
    }

    public void setSolution(String solution) {
        this.solution = solution;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    // Wrapper methods with similar parameters to those in ReportedProductsImp

    public void reportProduct(ReportedProductsPojo reportedProduct) {
        reportedProductsImp.reportProduct(reportedProduct);
    }

    public void updateReportSolution(int reportId) {
        reportedProductsImp.updateReportSolution(reportId);
    }

    public List<ReportedProductsPojo> viewReportedProducts() {
        return reportedProductsImp.viewReportedProducts();
    }
}
