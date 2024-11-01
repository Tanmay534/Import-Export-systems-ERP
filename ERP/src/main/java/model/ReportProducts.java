package model;

import java.sql.Timestamp;

public class ReportProducts {
	private String reportId;
	private String consumerPortId;
	private String productId;
	private String issueType;
	private String solution;
	private Timestamp reportDate;

	// Getters and Setters
	public String getReportId() {
		return reportId;
	}

	public void setReportId(String reportId) {
		this.reportId = reportId;
	}

	public String getConsumerPortId() {
		return consumerPortId;
	}

	public void setConsumerPortId(String consumerPortId) {
		this.consumerPortId = consumerPortId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
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

	public Timestamp getReportDate() {
		return reportDate;
	}

	public void setReportDate(Timestamp reportDate) {
		this.reportDate = reportDate;
	}

	@Override
	public String toString() {
		return "ReportProducts [reportId=" + reportId + ", consumerPortId=" + consumerPortId + ", productId="
				+ productId + ", issueType=" + issueType + ", solution=" + solution + ", reportDate=" + reportDate
				+ "]";
	}
}
