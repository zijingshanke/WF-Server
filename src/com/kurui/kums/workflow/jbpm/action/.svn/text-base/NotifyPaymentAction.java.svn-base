package com.kurui.kums.workflow.jbpm.action;

import org.jbpm.context.exe.ContextInstance;
import org.jbpm.graph.def.ActionHandler;
import org.jbpm.graph.exe.ExecutionContext;

import com.kurui.kums.workflow.jbpm.Constants;

public class NotifyPaymentAction implements ActionHandler, Constants {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void execute(ExecutionContext executionContext) throws Exception {
		ContextInstance ct = executionContext.getContextInstance();

		// 获取当前报销人
		String issueperson = ct.getVariable(this.ISSUE_PERSON).toString();

		String managerApproveResult = ct.getVariable(
				this.MANAGER_APPROVE_RESULT).toString();

		boolean result = false;

		// 判断部门经理是否同意

		if (managerApproveResult.equals(this.APPROVE_RESULT_OK)) {
			String moneyCount = ct.getVariable(this.MONEY_COUNT).toString();
			if (Integer.parseInt(moneyCount) > 1000) {
				String superManagerApproveResult = ct.getVariable(
						this.SUPER_MANAGER_APPROVE_RESULT).toString();
				if (superManagerApproveResult.equals(this.APPROVE_RESULT_OK)) {
					result = true;
				}
			}
		} else {
			result = true;
		}

		if (result) {
			System.out.println(issueperson+" 你的报销审批已通过");
		} else {
			System.out.println(issueperson+" 你的报销审批被否决");
		}

	}
}
