package com.msg.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.msg.mgr.CacheMgr;
import com.msg.mgr.MsgMgr;
import com.msg.util.HttpHelpler;
import com.msg.util.LogUtil;

/**
 * 删除消息
 * 
 * @author shengbao.Liu
 */
@SuppressWarnings("serial")
@WebServlet("/del_msg")
public class DelMessageServlet extends HttpServlet {

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DelMessageServlet() {
		super();
	}

	/**
	 * 处理消息
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer msgId = Integer.valueOf(HttpHelpler.getParameterOrDefault(request, "msg_id", "0"));
		if (msgId > 0) {
			MsgMgr.getInstance().delMsg(msgId);
			LogUtil.info("del msgId:" +msgId);//TODO syso
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
