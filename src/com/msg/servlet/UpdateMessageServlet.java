package com.msg.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.msg.bean.MsgDef;
import com.msg.bean.MsgField;
import com.msg.mgr.MsgMgr;
import com.msg.util.HttpHelpler;
import com.msg.util.IdHelper;
import com.msg.util.JsonHelper;

/**
 * 添加修改消息
 * 
 * @author shengbao
 */
@SuppressWarnings("serial")
@WebServlet("/update_msg")
public class UpdateMessageServlet extends HttpServlet {

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateMessageServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reqFieldCount = (int) request.getParameterMap().keySet().stream().filter(k -> k.startsWith("req_f_type")).count();
		int rspFieldCount = (int) request.getParameterMap().keySet().stream().filter(k -> k.startsWith("rsp_f_type")).count();
		String reqId = HttpHelpler.getParameter(request, "req_id");
		if (reqId == "") {
			return;
		}
		
		
		MsgDef msgDef = new MsgDef();
		Integer msgId = Integer.valueOf(HttpHelpler.getParameterOrDefault(request, "msg_id", "0"));
		if (msgId > 0) {
			// 旧的消息id
			msgDef.setMsg_id(msgId);
		} else {
			//消息id
			msgDef.setMsg_id(IdHelper.genMsgId());
		}
		//消息分类
		msgDef.setMsg_cat(Integer.valueOf(HttpHelpler.getParameter(request, "msg_cat")));
		// 请求
		msgDef.setReq_id(Integer.valueOf(reqId));
		msgDef.setMsg_desc(HttpHelpler.getParameter(request, "msg_desc"));
		for (int i = 1; i <= reqFieldCount; i++) {
			MsgField msgField = new MsgField();
			String rft = HttpHelpler.getParameter(request, "req_f_type_" + i);
			String rfn = HttpHelpler.getParameter(request, "req_f_name_" + i);
			String rfd = HttpHelpler.getParameter(request, "req_f_desc_" + i);
			msgField.setId(i);
			msgField.setFt(rft);
			msgField.setFn(rfn);
			msgField.setDesc(rfd);
			msgDef.getReqBodys().add(msgField);
		}
		
		// 返回
		String rspId = HttpHelpler.getParameter(request, "rsp_id");
		msgDef.setRsp_id(Integer.valueOf(rspId));
		for (int i = 1; i <= rspFieldCount; i++) {
			MsgField msgField = new MsgField();
			String rft = HttpHelpler.getParameter(request, "rsp_f_type_" + i);
			String rfn = HttpHelpler.getParameter(request, "rsp_f_name_" + i);
			String rfd = HttpHelpler.getParameter(request, "rsp_f_desc_" + i);
			msgField.setId(i);
			msgField.setFt(rft);
			msgField.setFn(rfn);
			msgField.setDesc(rfd);
			msgDef.getRspBodys().add(msgField);
		}
		// 备注
		msgDef.setMsg_note(HttpHelpler.getParameter(request, "msg_note"));
		System.out.println(JsonHelper.toS(msgDef));// TODO syso
		MsgMgr.getInstance().addModifyMsgDef(msgDef);
		MsgMgr.getInstance().submit();// FIXME 这里为了测试先每次都提交
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
