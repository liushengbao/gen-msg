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
import com.msg.util.JsonHelper;

/**
 * 添加修改消息
 */
@WebServlet("/update_msg")
public class UpdateMessageServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

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
		System.out.println("请求字段数量:" + reqFieldCount);
		System.out.println("返回字段数量:" + rspFieldCount);
		
		String reqId = HttpHelpler.getParameterValue(request, "req_id");
		if (reqId == "") {
			return;
		}
		MsgDef msgDef = new MsgDef();
		//请求
		msgDef.setReqId(Integer.valueOf(reqId));
		msgDef.setMsgDesc(HttpHelpler.getParameterValue(request, "msg_desc"));
		for (int i = 1; i <= reqFieldCount; i++) {
			MsgField msgField = new MsgField();
			String rft = HttpHelpler.getParameterValue(request, "req_f_type_" + i);
			String rfn = HttpHelpler.getParameterValue(request, "req_f_name_" + i);
			String rfd = HttpHelpler.getParameterValue(request, "req_f_desc_" + i);
			msgField.setId(i);
			msgField.setFt(rft);
			msgField.setFn(rfn);
			msgField.setDesc(rfd);
			msgDef.getReqBodys().add(msgField);
		}
		
		// 返回
		String rspId = HttpHelpler.getParameterValue(request, "rsp_id");
		msgDef.setRspId(Integer.valueOf(rspId));
		for (int i = 1; i <= rspFieldCount; i++) {
			MsgField msgField = new MsgField();
			String rft = HttpHelpler.getParameterValue(request, "rsp_f_type_" + i);
			String rfn = HttpHelpler.getParameterValue(request, "rsp_f_name_" + i);
			String rfd = HttpHelpler.getParameterValue(request, "rsp_f_desc_" + i);
			msgField.setId(i);
			msgField.setFt(rft);
			msgField.setFn(rfn);
			msgField.setDesc(rfd);
			msgDef.getRspBodys().add(msgField);
		}
		
		System.out.println(JsonHelper.toS(msgDef));//TODO syso
		
		MsgMgr.getInstance().addModifyMsgDef(msgDef);
		MsgMgr.getInstance().submit();//FIXME 这里为了测试先每次都提交
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
