package com.kurui.kums.base.jbpm;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.dom4j.Element;
import org.dom4j.XPath;
import org.dom4j.xpath.DefaultXPath;
import org.jbpm.JbpmContext;
import org.jbpm.graph.def.ProcessDefinition;
import org.jbpm.graph.exe.Token;
import com.kurui.kums.base.Constant;
import com.kurui.kums.base.exception.AppException;
import com.kurui.kums.base.file.XmlUtil_dom4j;
import com.kurui.kums.base.http.ServletUtil;

public class JbpmImageServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String result = "";
		try {
			String thisAction = Constant.toString(request
					.getParameter("thisAction"));
			if ("".equals(thisAction)) {
				result = "thisAction can not be null";
			} else {
				if ("showProcessDefinition".equals(thisAction)) {
					showProcessDefinition(request, response);
				} else if ("showProcessToken".equals(thisAction)) {
					showProcessToken(request, response);
				} else {
					result = "thisAction can not be definition";
				}
			}

			if (result.equals("") == false) {
				ServletUtil.printResult(result, response);
			}

		} catch (AppException e) {
			e.printStackTrace();
		}

	}

	protected void showProcessToken(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 流程模版ID
		long tokenId = Constant.toLong(request.getParameter("tokenId"));
		if (tokenId < 1) {
			try {
				ServletUtil.printResult("tokenId can not be null", response);
			} catch (AppException e) {
				e.printStackTrace();
			}
			return;
		}

		JbpmContext jbpmContext = JbpmUtil.getJbpmContext();
		try {
			Token currentToken = jbpmContext.getToken(tokenId);
			if (currentToken != null) {
				String currentNodeName = currentToken.getNode().getName();
				ProcessDefinition pd = currentToken.getProcessInstance()
						.getProcessDefinition();

				byte[] gpdBytes = pd.getFileDefinition().getBytes("gpd.xml");
				// 将jpd.xml的二进制数据解析为xml结构
				Element gpdRootElement = XmlUtil_dom4j.getElementAsBytes(gpdBytes);

				// 取出图片的宽和高
				int[] imageDimension = new int[2];
				imageDimension[0] = Integer.parseInt(gpdRootElement
						.attributeValue("width"));
				imageDimension[1] = Integer.parseInt(gpdRootElement
						.attributeValue("height"));

				// 定义生成流程图片的URL
				String imageUrl = request.getContextPath();
				imageUrl += "/jbpmImageServlet?thisAction=showProcessDefinition";
				imageUrl += "&processDefinitionId=" + pd.getId();

				// 输出背景图为流程图的DIV
				String processDivHtml = "<div style=\"position:relative;";
				processDivHtml += "background-image:url(" + imageUrl + ");";
				processDivHtml += "width:" + imageDimension[0] + "px;";
				processDivHtml += "height:" + imageDimension[1] + "px;\">";
				ServletUtil.printResult(processDivHtml, response);

				List allTokenList = new ArrayList();
				Token rootToken = findRootToken(currentToken);
				allTokenList = findAllTokens(rootToken, allTokenList);
				for (int i = 0; i < allTokenList.size(); i++) {
					Token token = (Token) allTokenList.get(i);
					currentNodeName = token.getNode().getName();
					String currentNodeColor = "green";
					if (token.equals(currentToken)) {
						currentNodeColor = "red";
					}

					String tokenDivHtml = printSelectNode(gpdRootElement,
							currentNodeName, currentNodeColor);

					ServletUtil.printResult(tokenDivHtml, response);
				}
				ServletUtil.printResult("</div>", response);
			} else {
				ServletUtil.printResult("token " + tokenId + "不存在", response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jbpmContext.close();
		}
	}

	// 输出当前Token所在节点位置
	private String printSelectNode(Element gpdRootElement,
			String currentNodeName, String currentNodeColor) {
		// 取出当前节点座标和尺寸
		int[] currentNodeDimension = new int[4];
		String xpathStr = "//node[@name='" + currentNodeName + "']";// xpath查找gpd.xml里的节点
		XPath xpath = new DefaultXPath(xpathStr);
		Element currentXmlNode = (Element) xpath
				.selectSingleNode(gpdRootElement);
		currentNodeDimension[0] = Integer.parseInt(currentXmlNode
				.attributeValue("width"));
		currentNodeDimension[1] = Integer.parseInt(currentXmlNode
				.attributeValue("height"));
		currentNodeDimension[2] = Integer.parseInt(currentXmlNode
				.attributeValue("x"));
		currentNodeDimension[3] = Integer.parseInt(currentXmlNode
				.attributeValue("y"));

		// 输出当前Token所在节点位置
		String tokenDivHtml = "<div style=\"position:absolute;";
		tokenDivHtml += "left:" + currentNodeDimension[2] + "px;";
		tokenDivHtml += "top:" + currentNodeDimension[3] + "px;";
		tokenDivHtml += "width:" + (currentNodeDimension[0] - 6) + "px;";
		tokenDivHtml += "height:" + (currentNodeDimension[1] - 6) + "px;";
		tokenDivHtml += "border:5px solid " + currentNodeColor + "\"></div>";
		return tokenDivHtml;
	}

	protected void showProcessDefinition(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 流程模版ID
		long processDefinitionId = Constant.toLong(request
				.getParameter("processDefinitionId"));
		if (processDefinitionId < 1) {
			try {
				ServletUtil.printResult("processDefinitionId can not be null",
						response);
			} catch (AppException e) {
				e.printStackTrace();
			}
			return;
		}

		JbpmContext jbpmContext = JbpmUtil.getJbpmContext();
		try {
			ProcessDefinition pd = jbpmContext.getGraphSession()
					.loadProcessDefinition(processDefinitionId);
			// 取出image对应的二进制信息
			byte[] bytes = pd.getFileDefinition().getBytes("processimage.jpg");

			// 输出页面显示
			OutputStream out = response.getOutputStream();
			out.write(bytes);
			out.flush();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jbpmContext.close();
		}
	}

	private List findAllTokens(Token parent, List allTokens) {
		Map children = parent.getChildren();
		if (children != null && children.size() > 0) {
			Collection childTokens = children.values();
			for (Iterator iterator = childTokens.iterator(); iterator.hasNext();) {
				Token token = (Token) iterator.next();
				findAllTokens(parent, allTokens);
			}
		}
		allTokens.add(parent);
		return allTokens;
	}

	private Token findRootToken(Token token) {
		if (token.getParent() != null) {
			token = token.getParent();
			findRootToken(token);
		}
		return token;
	}

}
