package com.msg.vo;

import com.msg.bean.MsgDef;

public class MsgItem {
	
	private int msg_id;
	private int msg_cat;
	private int req_id;
	private int rsp_id;
	private String msg_desc;
	private String msg_note;
	
	public static MsgItem valueOf(MsgDef msgDef) {
		return null;
	}

	public int getMsg_id() {
		return msg_id;
	}

	public void setMsg_id(int msg_id) {
		this.msg_id = msg_id;
	}

	public int getMsg_cat() {
		return msg_cat;
	}

	public void setMsg_cat(int msg_cat) {
		this.msg_cat = msg_cat;
	}

	public int getReq_id() {
		return req_id;
	}

	public void setReq_id(int req_id) {
		this.req_id = req_id;
	}

	public int getRsp_id() {
		return rsp_id;
	}

	public void setRsp_id(int rsp_id) {
		this.rsp_id = rsp_id;
	}

	public String getMsg_desc() {
		return msg_desc;
	}

	public void setMsg_desc(String msg_desc) {
		this.msg_desc = msg_desc;
	}

	public String getMsg_note() {
		return msg_note;
	}

	public void setMsg_note(String msg_note) {
		this.msg_note = msg_note;
	}

}
