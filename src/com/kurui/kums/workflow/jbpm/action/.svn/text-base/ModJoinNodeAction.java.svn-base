package com.kurui.kums.workflow.jbpm.action;

import java.util.Collection;
import java.util.Iterator;

import org.jbpm.graph.def.ActionHandler;
import org.jbpm.graph.exe.ExecutionContext;
import org.jbpm.graph.exe.Token;
import org.jbpm.taskmgmt.exe.TaskInstance;
import org.jbpm.taskmgmt.exe.TaskMgmtInstance;

public class ModJoinNodeAction implements ActionHandler {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void execute(ExecutionContext executionContext) throws Exception {
		TaskMgmtInstance tmi = executionContext.getTaskMgmtInstance();

		// 取得当前流程实例所有的子Token上的任务实例

		Token rootToken = executionContext.getProcessInstance().getRootToken();
		Collection childTokeList = rootToken.getChildren().values();

		for (Iterator iterator = childTokeList.iterator(); iterator.hasNext();) {
			Token childToken = (Token) iterator.next();
			Collection c = tmi.getUnfinishedTasks(childToken);
			for (Iterator iterator2 = c.iterator(); iterator2.hasNext();) {
				TaskInstance ti = (TaskInstance) iterator2.next();
				ti.cancel();
			}
		}
	}

}
