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
		<title>审批报销单</title>
		<link href="../_css/reset.css" rel="stylesheet" type="text/css" />
		<link href="../_css/global.css" rel="stylesheet" type="text/css" />
		<script>
    function processPayment() {  	
       	document.forms[0].submit();
    }
    </script>
	</head>
	<body>
		<div id="mainContainer">
			<div id="container">
				<html:form action="/workflow/workflow.do" method="post">
					<html:hidden property="thisAction" name="workflow" />

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
										<td class="lef">
											报销人
										</td>
										<td style="text-align: left">
											<c:out value="${issueperson}"></c:out>
										</td>
									</tr>
									<tr>
										<td class="lef">
											报销主题
										</td>
										<td style="text-align: left">
											<c:out value="${title}"></c:out>
										</td>
									</tr>
									<tr>
										<td class="lef">
											报销金额
										</td>
										<td style="text-align: left">
											<c:out value="${moneyCount}"></c:out>
										</td>
									</tr>
									<tr>
										<td class="lef">
											报销说明
										</td>
										<td style="text-align: left">
											<c:out value="${remark}"></c:out>
										</td>
									</tr>
									<tr>
										<td class="lef">
											审批意见
										</td>
										<td style="text-align: left">
											<input type="radio" name="approveResult" value="1"
												checked="checked" />
											同意
											<input type="radio" name="approveResult" value="0" />
											不同意
										</td>
									</tr>
									<tr>
										<td colspan="2" style="text-align: center">
											<html:hidden property="taskInstanceId"
												value="${taskInstance.id}"></html:hidden>
											<input name="label" type="button" class="button1" value="提交"
												onclick="addPayment();">
										</td>
									</tr>
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

				</html:form>
			</div>
		</div>
	</body>
</html>