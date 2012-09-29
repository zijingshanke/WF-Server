package com.kurui.kums.workflow.jbpm.action;

import org.jbpm.graph.exe.ExecutionContext;
import org.jbpm.taskmgmt.def.AssignmentHandler;
import org.jbpm.taskmgmt.exe.Assignable;

import com.kurui.kums.workflow.jbpm.Constants;

/**
 * 报销流程处理类
 */
public class ManagerAssignment implements AssignmentHandler, Constants {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void assign(Assignable assignable, ExecutionContext executionContext)
			throws Exception {
		// 从当前流程实例上下文取出当前报销人
//		String issueperson = executionContext.getContextInstance().getVariable(
//				this.ISSUE_PERSON).toString();
		String issueperson="user1";
		// 报销人为1时，部门经理为manager1
		if (issueperson.equals("user1")) {
			assignable.setActorId("manager1");
		} else {
			assignable.setActorId("manager2");
		}
	}

}
