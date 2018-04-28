package com.msg.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import com.msg.Context;
import com.msg.mgr.CacheMgr;
import com.msg.mgr.DBMgr;
import com.msg.util.ConfigHelper;
import com.msg.util.FreemarkHelper;
import com.msg.util.LogUtil;
import com.msg.util.SvnUtil;
/**
 * 启动监听器
 * @author shengbao.Liu
 *
 */
public class StartUpListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		new Thread(() -> {
			LogUtil.console.info("服务器启动处理中。。。。");
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
			// svn初始化
			SvnUtil.init();
			
			LogUtil.console.info(">>>>>>>>>启动完毕>>>>>>>>>");
		}).start();;
	}
	
	
}
