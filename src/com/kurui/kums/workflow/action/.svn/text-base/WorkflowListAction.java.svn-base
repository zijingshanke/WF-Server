package com.kurui.kums.workflow.action;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.jbpm.JbpmContext;
import org.jbpm.taskmgmt.exe.TaskInstance;

import com.kurui.kums.workflow.Workflow;
import com.kurui.kums.workflow.WorkflowListForm;
import com.kurui.kums.workflow.biz.WorkflowBiz;
import com.kurui.kums.base.BaseAction;
import com.kurui.kums.base.exception.AppException;
import com.kurui.kums.base.jbpm.JbpmUtil;

public class WorkflowListAction extends BaseAction {
	private WorkflowBiz workflowBiz;

	public ActionForward listTask(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws AppException {
		WorkflowListForm workflowListForm = (WorkflowListForm) form;
		if (workflowListForm == null) {
			workflowListForm = new WorkflowListForm();
		}

		JbpmContext jbpmContext = JbpmUtil.getJbpmContext();
		try {

			String currentperson = "user1";
			List taskList = jbpmContext.getTaskList(currentperson);
			System.out.println("1-taskList:" + taskList.size());
			List taskList2 = jbpmContext.getTaskList();
			System.out.println("2-taskList:" + taskList2.size());

			workflowListForm.setList(taskList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jbpmContext.close();
		}
		request.setAttribute("workflowListForm", workflowListForm);
		return mapping.findForward("listTask");
	}

	public ActionForward addPayment(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws AppException {
		WorkflowListForm workflowListForm = (WorkflowListForm) form;
		if (workflowListForm == null) {
			workflowListForm = new WorkflowListForm();
		}
		try {
			Workflow workflow = new Workflow();
			workflow.setThisAction("insertPayment");
			request.setAttribute("workflow", workflow);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("workflowListForm", workflowListForm);
		return mapping.findForward("writeOrder");
	}

	public ActionForward managePayment(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws AppException {
		WorkflowListForm workflowListForm = (WorkflowListForm) form;
		if (workflowListForm == null) {
			workflowListForm = new WorkflowListForm();
		}
		JbpmContext jbpmContext = JbpmUtil.getJbpmContext();
		try {
			long taskInstanceId = workflowListForm.getTaskInstanceId();

			TaskInstance taskInstance = jbpmContext
					.getTaskInstance(taskInstanceId);

			String title = taskInstance.getVariable("title").toString();
			String monenCount = taskInstance.getVariable("monenCount")
					.toString();
			String remark = taskInstance.getVariable("remark").toString();
			String issueperson = taskInstance.getVariable("issueperson")
					.toString();
			request.setAttribute("title", title);
			request.setAttribute("monenCount", monenCount);
			request.setAttribute("remark", remark);
			request.setAttribute("issueperson", issueperson);

			request.setAttribute("taskInstance", taskInstance);

			Workflow workflow = new Workflow();
			workflow.setThisAction("processPayment");
			request.setAttribute("workflow", workflow);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jbpmContext.close();
		}
		request.setAttribute("workflowListForm", workflowListForm);
		return mapping.findForward("writeOrder");
	}

	/**
	 * 取得给定流程模版的所有流程实例
	 */
	public ActionForward listProcessInstance(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws AppException {
		WorkflowListForm workflowListForm = (WorkflowListForm) form;
		if (workflowListForm == null) {
			workflowListForm = new WorkflowListForm();
		}

		JbpmContext jbpmContext = JbpmUtil.getJbpmContext();
		try {
			long processInstanceId = workflowListForm.getProcessInstanceId();
			// 取得给定流程模版的所有流程实例
			List list = jbpmContext.getGraphSession().findProcessInstances(
					processInstanceId);

			workflowListForm.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jbpmContext.close();
		}
		request.setAttribute("workflowListForm", workflowListForm);
		return mapping.findForward("listProcessInstance");
	}

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws AppException {
		WorkflowListForm workflowListForm = (WorkflowListForm) form;
		if (workflowListForm == null) {
			workflowListForm = new WorkflowListForm();
		}
		try {
			workflowListForm.setList(new ArrayList());
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("workflowListForm", workflowListForm);
		return mapping.findForward("listWorkflow");
	}

	public void setWorkflowBiz(WorkflowBiz workflowBiz) {
		this.workflowBiz = workflowBiz;
	}

}