package com.kurui.kums.workflow.biz;

import java.util.List;
import com.kurui.kums.workflow.WorkflowListForm;
import com.kurui.kums.base.exception.AppException;

public interface WorkflowBiz {

	public List list(WorkflowListForm workflowListForm) throws AppException;

}
