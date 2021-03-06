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
import com.msg.util.LangUtil;
import com.msg.util.LogUtil;

/**
 * 更新结构体
 * 
 * @author shengbao.Liu
 */
@SuppressWarnings("serial")
@WebServlet("/update_struct")
public class UpdateStructServlet extends HttpServlet {

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateStructServlet() {
		super();
	}

	/**
	 * 处理消息
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LogUtil.info("提交结构体--------------------------------------");
		
		int reqFieldCount = (int) request.getParameterMap().keySet().stream().filter(k -> k.startsWith("req_f_name")).count();
		MsgDef msgDef = new MsgDef();
		Integer msgId = Integer.valueOf(HttpHelpler.getParameterOrDefault(request, "msg_id", "0"));
		if (msgId > 0) {
			// 旧的消息id
			msgDef.setMsg_id(msgId);
		} else {
			// 新消息
			msgDef.setMsg_id(IdHelper.genMsgId());
		}
		//消息分类
		msgDef.setMsg_cat(Integer.valueOf(HttpHelpler.getParameter(request, "msg_cat")));
		//结构体名
		msgDef.setMsg_name(HttpHelpler.getParameterOrDefault(request, "struct_name", "0"));
		// 请求
		msgDef.setReq_id(0);
		msgDef.setMsg_desc(HttpHelpler.getParameter(request, "msg_desc"));
		for (int i = 1; i <= reqFieldCount; i++) {
			MsgField msgField = new MsgField();
			String rft = HttpHelpler.getParameter(request, "req_f_type_" + i);
			String rfk = HttpHelpler.getParameter(request, "req_f_key_" + i);
			if (rft.startsWith("base")) {
				rft = "base";
			}
			if (rft.startsWith("array")) {
				rft = "array";
			} else if (rft.startsWith("map")) {
				rfk = LangUtil.getMapKey(rft);
				rft = "map";
			}
			
			String rfv = HttpHelpler.getParameter(request, "req_f_value_" + i);
			String rfn = HttpHelpler.getParameter(request, "req_f_name_" + i);
			String rfd = HttpHelpler.getParameter(request, "req_f_desc_" + i);
			msgField.setId(i);
			msgField.setFt(rft);
			msgField.setFk(rfk);
			msgField.setFv(rfv);
			msgField.setFn(rfn);
			msgField.setDesc(rfd);
			msgDef.getReqBodys().add(msgField);
		}
		
		// 备注
		msgDef.setMsg_note(HttpHelpler.getParameter(request, "msg_note"));
		// 添加修改的消息
		MsgMgr.getInstance().addModifyMsgDef(msgDef);
		// 由页面点击生成
		MsgMgr.getInstance().submit();
		
		LogUtil.info(JsonHelper.toS(msgDef));//TODO syso
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
