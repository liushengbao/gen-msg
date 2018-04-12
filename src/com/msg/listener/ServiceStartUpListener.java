package com.msg.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.msg.mgr.CacheMgr;

public class ServiceStartUpListener implements ServletContextListener  {
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContextListener.super.contextInitialized(sce);
		//缓存中心初始化
		CacheMgr.getInstance().init();
	}
}
