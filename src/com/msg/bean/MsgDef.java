package com.msg.bean;

import java.util.ArrayList;
import java.util.List;

/** 
 * 消息定义
 * @author shengbao
 *
 */
public class MsgDef {
	
	private int msg_id;
	private int msg_cat;
	private int req_id;
	private int rsp_id;
	private String msg_desc;
	private String req_body;
	private String rsp_body;
	private String msg_note;
	//++++++++++++++++++++++++++++++++++++++++++++++++++++++
	private List<MsgField> reqBodys = new ArrayList<>();
	private List<MsgField> rspBodys = new ArrayList<>();

	public List<MsgField> getReqBodys() {
		return reqBodys;
	}

	public void setReqBodys(List<MsgField> reqBodys) {
		this.reqBodys = reqBodys;
	}

	public List<MsgField> getRspBodys() {
		return rspBodys;
	}
	
	public void setRspBodys(List<MsgField> rspBodys) {
		this.rspBodys = rspBodys;
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

	public String getReq_body() {
		return req_body;
	}

	public void setReq_body(String req_body) {
		this.req_body = req_body;
	}

	public String getRsp_body() {
		return rsp_body;
	}

	public void setRsp_body(String rsp_body) {
		this.rsp_body = rsp_body;
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

	public String getMsg_note() {
		return msg_note;
	}

	public void setMsg_note(String msg_note) {
		this.msg_note = msg_note;
	}
	
}
