<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/WEB-INF/struts-html-el.tld" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic"
	prefix="logic"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>

<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>流程实例列表</title>
		<link href="../_css/reset.css" rel="stylesheet" type="text/css" />
		<link href="../_css/global.css" rel="stylesheet" type="text/css" />
		<script>
    function executeBaseCase(method) { 
    	document.forms[0].method.value=method;
       	document.forms[0].thisAction.value="executeBaseCase";    	
       	document.forms[0].submit();
    }
    </script>
	</head>
	<body>
		<div id="mainContainer">
			<div id="container">
				<html:form action="/workflow/workflow.do" method="post">
					<html:hidden property="thisAction" />
					<html:hidden property="method" />

					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="10" height="10" class="tblt"></td>
							<td height="10" class="tbtt"></td>
							<td width="10" height="10" class="tbrt"></td>
						</tr>
						<tr>
							<td width="10" class="tbll"></td>
							<td valign="top" class="body">
								<c:import url="../page/mainTitle.jsp" charEncoding="UTF-8">
									<c:param name="title1" value="工作流服务管理" />
									<c:param name="title2" value="流程监控" />
									<c:param name="title3" value="任务列表" />
								</c:import>

								<div class="searchBar">
									<table cellpadding="0" cellspacing="0" border="0"
										class="searchPanel">
										<tr>
											<td></td>
										</tr>
									</table>
								</div>
								<table width="100%" cellpadding="0" cellspacing="0" border="0"
									class="dataList">
									<tr>
										<th>
											<div>
												版本号
											</div>
										</th>
										<th>
											<div>
												开始时间
											</div>
										</th>
										<th>
											<div>
												查看当前流程实例所在节点
											</div>
										</th>
									</tr>
									<c:forEach var="processInstance"
										items="${workflowListForm.list}" varStatus="status">
										<tr>
											<td>
												<c:out value="${taskInstance.name}"></c:out>
											</td>
											<td>
												<c:out value="${taskInstance.create}"></c:out>
											</td>
											<td>
												<a
													href="../jbpmProcessImageServlet?tokenId=<c:out value="${taskInstance.token.id}"></c:out>">
													查看流程进度图</a>
											</td>
											<td>
												<c:if
													test="${taskInstance.description}=='payment.manager.approve'||${taskInstance.description}=='payment.super.manager.approve'">
													<a
														href="../workflow/workflowList.do?thisAction=managePayment&taskInstanceId=<c:out value="${taskInstance.id}"></c:out>">
														审批</a>
												</c:if>
											</td>
										</tr>

									</c:forEach>
								</table>
								<div class="clear"></div>

							</td>
							<td width="10" class="tbrr"></td>
						</tr>
						<tr>
							<td width="10" class="tblb"></td>
							<td class="tbbb"></td>
							<td width="10" class="tbrb"></td>
						</tr>
					</table>
			</div>
			</html:form>
		</div>
	</body>
</html>