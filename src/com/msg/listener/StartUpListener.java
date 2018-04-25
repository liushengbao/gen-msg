package com.msg.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import com.msg.Context;
import com.msg.mgr.CacheMgr;
import com.msg.mgr.DBMgr;
import com.msg.util.ConfigHelper;
import com.msg.util.FreemarkHelper;

public class StartUpListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContextListener.super.contextInitialized(sce);
		// 上下文
		Context.setServletContext(sce.getServletContext());
		// 加载配置文件
		ConfigHelper.loadConfigs(sce.getServletContext());
		// 加载数据库驱动
		DBMgr.loadDriver();
		// 缓存中心初始化
		CacheMgr.getInstance().init();
		// 模板引擎加载配置
		FreemarkHelper.init(sce.getServletContext());
	}
}
