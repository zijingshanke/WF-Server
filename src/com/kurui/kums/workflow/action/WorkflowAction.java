package com.kurui.kums.workflow.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.jbpm.JbpmContext;
import org.jbpm.context.exe.ContextInstance;
import org.jbpm.graph.def.ProcessDefinition;
import org.jbpm.graph.exe.ProcessInstance;
import org.jbpm.taskmgmt.exe.TaskInstance;
import com.kurui.kums.workflow.Workflow;
import com.kurui.kums.workflow.biz.WorkflowBiz;
import com.kurui.kums.base.BaseAction;
import com.kurui.kums.base.Inform;
import com.kurui.kums.base.exception.AppException;
import com.kurui.kums.base.jbpm.JbpmUtil;

public class WorkflowAction extends BaseAction {
	private WorkflowBiz workflowBiz;

	public ActionForward insertPayment(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws AppException {
		String forwardPage = "";
		Inform inf = new Inform();

		Workflow workflow = (Workflow) form;

		JbpmContext jbpmContext = JbpmUtil.getJbpmContext();
		try {
			String issueperson = "user1";
			// 设置当前用户为user1
			jbpmContext.setActorId(issueperson);

			ProcessDefinition pd = jbpmContext.getGraphSession()
					.findLatestProcessDefinition("payment");

			ProcessInstance processInstance = pd.createProcessInstance();
			ContextInstance contextInstance = processInstance
					.getContextInstance();

			//
			contextInstance.setVariable("issueperson", issueperson);

			// 创建开始节点的TaskInstance
			TaskInstance taskInstance = processInstance.getTaskMgmtInstance()
					.createStartTaskInstance();

			// 向任务实例当中写入相关变量
			taskInstance.setVariable("title", workflow.getTitle());
			taskInstance.setVariable("moneyCount", workflow.getMoneyCount());
			taskInstance.setVariable("remark", workflow.getRemark());

			// 结束任务实例，token进入部门经理审批
			taskInstance.end();

			inf.setMessage("报销申请提交成功");
		} catch (Exception e) {
			e.printStackTrace();
			inf.setMessage("异常信息：" + e.getMessage());
		} finally {
			jbpmContext.close();
		}
		return forwardInformPage(inf, mapping, request);
	}

	public ActionForward processPayment(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws AppException {
		String forwardPage = "";
		Inform inf = new Inform();

		Workflow workflow = (Workflow) form;

		JbpmContext jbpmContext = JbpmUtil.getJbpmContext();
		try {
			long taskInstanceId = workflow.getTaskInstanceId();
			TaskInstance taskInstance = jbpmContext
					.getTaskInstance(taskInstanceId);
			// String isSubmit 结束/总经理处理 此处省略
			taskInstance.end();
			inf.setMessage("处理完成");
			inf.setForwardPage("../workflow/workflowList.do?thisAction=listTask");
		} catch (Exception e) {
			e.printStackTrace();
			inf.setMessage("异常信息：" + e.getMessage());
		} finally {
			jbpmContext.close();
		}
		return forwardInformPage(inf, mapping, request);
	}

	public void setWorkflowBiz(WorkflowBiz workflowBiz) {
		this.workflowBiz = workflowBiz;
	}
}