package com.kurui.kums.workflow.jbpm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jbpm.JbpmConfiguration;
import org.jbpm.JbpmContext;

public class JbpmDAOImp implements JbpmDAO {

	public List query(String sql, Object[] values) throws Exception {
		List result = new ArrayList();
		JbpmContext jbpmContext = this.createJbpmContext();
		Connection conn = jbpmContext.getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			if (values != null) {
				for (int i = 0; i < values.length; i++) {
					stmt.setObject(i + 1, values[i]);
				}
			}
			ResultSetMetaData rmd = stmt.getMetaData();
			int columnCount = rmd.getColumnCount();
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < columnCount; i++) {
					String columnName = rmd.getColumnClassName(i + 1);
					map.put(columnName, rs.getObject(columnName));
				}
				result.add(map);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
			jbpmContext.close();
		}
		return result;
	}

	public void saveOrUpdateOrDelete(String sql, Object[] values)
			throws Exception {
		JbpmContext jbpmContext = this.createJbpmContext();
		Connection conn = jbpmContext.getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			if (values != null) {
				for (int i = 0; i < values.length; i++) {
					stmt.setObject(i + 1, values[i]);
				}
			}
			stmt.execute();
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
			jbpmContext.close();
		}
	}

	public JbpmContext createJbpmContext() {
		return JbpmConfiguration.getInstance().createJbpmContext();
	}

}
