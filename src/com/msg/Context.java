package com.msg;

import javax.servlet.ServletContext;


/**
  * 上下文
  * @author shengbao.Liu
  * @date 2018年4月25日 上午11:39:51
  * 
  */
public class Context {
	
	public static ServletContext servletContext;

	public static void setServletContext(ServletContext servletContext) {
		Context.servletContext = servletContext;
	}
	
}
