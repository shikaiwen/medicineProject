package com.drp.global;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.drp.domain.User;
import com.drp.util.Constants;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class ValidateInterceptor implements Interceptor{

	public void destroy() {
		
	}

	public void init() {
	}

	public String intercept(ActionInvocation actionInvocation) throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute(Constants.USER);
		
		String actionName = ActionContext.getContext().getActionInvocation().getProxy().getActionName();
		System.out.println(actionName);
		if(!"login".equals(actionName)){
			if(null == user){
				return "loginError";
			}
		}
		
		request.getRequestURL();
		
		String result = actionInvocation.invoke();
		return result;
	}

}
