package com.drp.global;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.drp.domain.User;
import com.drp.util.Constants;

public class ValidateFilter implements Filter {

	public void destroy() {
		
	}

	public void doFilter(ServletRequest request, ServletResponse reponse,
			FilterChain filterChain) throws IOException, ServletException {
	try{
		HttpServletRequest req = (HttpServletRequest)request;
		HttpSession session = req.getSession();
		System.out.println(session.getId());
		User user = (User)session.getAttribute(Constants.USER);
		if(null == user){
			System.out.println("null");
			RequestDispatcher dispatcher = req.getRequestDispatcher("/login.jsp");
			dispatcher.forward(request, reponse);
			return;
		}
		
		filterChain.doFilter(request, reponse);
	}catch(Exception e){
		e.printStackTrace();
	}

	}

	
	public void init(FilterConfig arg0) throws ServletException {
		System.out.println("ValidateFilter initilied");
		
	}

}
