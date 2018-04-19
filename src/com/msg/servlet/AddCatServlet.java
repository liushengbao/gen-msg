package com.msg.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.msg.bean.MsgCat;
import com.msg.mgr.MsgMgr;
import com.msg.util.HttpHelpler;
import com.msg.util.IdHelper;
import com.msg.util.JsonHelper;

/**
 * 添加分类
 * @author shengbao
 */
@SuppressWarnings("serial")
@WebServlet("/add_cat")
public class AddCatServlet extends HttpServlet {


	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddCatServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String catName = HttpHelpler.getParameter(request, "cat_name");
		String catType = HttpHelpler.getParameter(request, "cat_type");
		MsgCat msgCat = new MsgCat();
		msgCat.setMsg_cat_id(IdHelper.genMsgCatId());
		msgCat.setMsg_cat(catName);
		msgCat.setMsg_cat_type(Integer.valueOf(catType));
		MsgMgr.getInstance().addCat(msgCat);
		System.out.println(JsonHelper.toS(msgCat));//TODO syso
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
