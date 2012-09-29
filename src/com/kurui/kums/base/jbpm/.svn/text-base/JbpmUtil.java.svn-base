package com.kurui.kums.base.jbpm;

import java.io.FileInputStream;
import java.util.List;
import java.util.zip.ZipInputStream;
import org.jbpm.JbpmConfiguration;
import org.jbpm.JbpmContext;
import org.jbpm.graph.def.ProcessDefinition;
import org.jbpm.graph.exe.ProcessInstance;
import org.jbpm.graph.exe.Token;

public class JbpmUtil {
	public static void main(String[] args) {
		// createSchema();// 构建数据库

		// String archiveFile = "dist\\payment.zip";
		// archiveFile = "dist\\purchase.zip";
		// deployProcess(archiveFile);

		// getProcessFromDB("ticket");
		 getProcessFromDB("purchase");
		

//		getTaskList();
	}

	public static void getTaskList() {
		JbpmContext jbpmContext = getJbpmContext();
		String currentperson = "user1";
		List taskList = jbpmContext.getTaskList(currentperson);
		System.out.println("taskList:" + taskList.size());

		jbpmContext.close();
	}

	// 获取数据库工作流实例
	public static void getProcessFromDB(String processName) {
		JbpmContext jbpmContext = getJbpmContext();
		try {
			ProcessDefinition pd = jbpmContext.getGraphSession()
					.findLatestProcessDefinition(processName);

			ProcessInstance instance = new ProcessInstance(pd);
			Token token = instance.getRootToken();

			System.out.println("1 当前的节点：" + token.getNode().getName());

			token.signal();

			System.out.println("2 当前的节点：" + token.getNode().getName());

			System.out.println("当前的流程状态："
					+ token.getProcessInstance().hasEnded());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jbpmContext.close();
		}
	}

	// 发布流程
	public static void deployProcess(String archiveFile) {
		JbpmContext jbpmContext = getJbpmContext();
		try {
			FileInputStream fis = new FileInputStream(archiveFile);
			ZipInputStream zis = new ZipInputStream(fis);

			ProcessDefinition pd = ProcessDefinition
					.parseParZipInputStream(zis);

			jbpmContext.deployProcessDefinition(pd);

			zis.close();
			fis.close();

			System.out.println("发布成功");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jbpmContext.close();
		}
	}

	public static void createSchema() {
		JbpmConfiguration jbpmConfig = JbpmConfiguration.getInstance();
		jbpmConfig.createSchema();// 构建数据库
	}

	public static JbpmContext getJbpmContext() {
		JbpmConfiguration jbpmConfig = JbpmConfiguration.getInstance();

		JbpmContext jbpmContext = jbpmConfig.getCurrentJbpmContext();
		if (jbpmContext == null) {
			System.out.println("current jbpmContext is null create new ..");
			jbpmContext = jbpmConfig.createJbpmContext();
		}
		return jbpmContext;
	}
}