package com.msg.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.msg.mgr.MsgMgr;
import com.msg.util.HttpHelpler;

/**
 * 删除分类
 * @author shengbao
 */
@SuppressWarnings("serial")
@WebServlet("/del_cat")
public class DelCatServlet extends HttpServlet {


	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DelCatServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer msgId = Integer.valueOf(HttpHelpler.getParameterOrDefault(request, "cat_id", "0"));
		if (msgId > 0) {
			MsgMgr.getInstance().delCat(msgId);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
