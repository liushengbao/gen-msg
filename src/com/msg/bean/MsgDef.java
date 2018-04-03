package com.msg.bean;

import java.util.ArrayList;
import java.util.List;

public class MsgDef {
	
	private int reqId;
	private int rspId;
	private String msgDesc;

	private List<MsgField> reqBodys = new ArrayList<>();
	private List<MsgField> rspBodys = new ArrayList<>();

	public int getReqId() {
		return reqId;
	}

	public void setReqId(int reqId) {
		this.reqId = reqId;
	}

	public int getRspId() {
		return rspId;
	}

	public void setRspId(int rspId) {
		this.rspId = rspId;
	}

	public List<MsgField> getReqBodys() {
		return reqBodys;
	}

	public void setReqBodys(List<MsgField> reqBodys) {
		this.reqBodys = reqBodys;
	}

	public String getMsgDesc() {
		return msgDesc;
	}

	public void setMsgDesc(String msgDesc) {
		this.msgDesc = msgDesc;
	}

	public List<MsgField> getRspBodys() {
		return rspBodys;
	}

	public void setRspBodys(List<MsgField> rspBodys) {
		this.rspBodys = rspBodys;
	}
	
}
