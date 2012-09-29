package com.kurui.kums.base.jbpm;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import org.jbpm.JbpmConfiguration;
import org.jbpm.JbpmContext;

public class JbpmFilter implements Filter {

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain filterChain) throws IOException, ServletException {
		JbpmContext jbpmContext = JbpmConfiguration.getInstance()
				.createJbpmContext(JbpmContext.DEFAULT_JBPM_CONTEXT_NAME);
		try {
			filterChain.doFilter(arg0, arg1);
		} catch (Exception e) {
			jbpmContext.close();
		}

	}

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
	}

}
