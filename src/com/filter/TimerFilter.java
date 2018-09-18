package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class TimerFilter implements Filter{

	private FilterConfig config;
	
	
	
	@Override
	public void destroy() {//끝날때
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {//몸통
	
		long before = System.currentTimeMillis();//시작시간

		chain.doFilter(req, resp); //목적지로 데이터전송
		
		long after= System.currentTimeMillis();//종료시간
	
		String uri;
		
		if(req instanceof HttpServletRequest){ //req가 httpservlet request인지 확인
			HttpServletRequest request = (HttpServletRequest)req;
			
			uri = request.getRequestURI();
			/*config.getServletContext().log(uri + ":" +
					(after-before) + "ms"); */
			
			System.out.println(uri + ":" +
					(after-before) + "ms"); 
			
			
			
		}
		
		
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config = config;
	}

}
