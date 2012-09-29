package com.kurui.kums.workflow;

public class Workflow extends org.apache.struts.action.ActionForm implements
		Cloneable {
	private static final long serialVersionUID = 1L;

	private String method = "";
	
	public long taskInstanceId;

	public String title = "";
	public String moneyCount = "";
	public String remark = "";
	public String issueperson = "";
	public String approveResult;
	
	

	public long getTaskInstanceId() {
		return taskInstanceId;
	}

	public void setTaskInstanceId(long taskInstanceId) {
		this.taskInstanceId = taskInstanceId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMoneyCount() {
		return moneyCount;
	}

	public void setMoneyCount(String moneyCount) {
		this.moneyCount = moneyCount;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getIssueperson() {
		return issueperson;
	}

	public void setIssueperson(String issueperson) {
		this.issueperson = issueperson;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}
	
	

	// ======================
	private String thisAction = "";

	public String getThisAction() {
		return thisAction;
	}

	public void setThisAction(String thisAction) {
		this.thisAction = thisAction;
	}

	private int index = 0;

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public String getApproveResult() {
		return approveResult;
	}

	public void setApproveResult(String approveResult) {
		this.approveResult = approveResult;
	}

}
