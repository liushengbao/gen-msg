package com.msg.vo;

import java.util.ArrayList;
import java.util.List;

import com.msg.bean.MsgCat;
import com.msg.bean.MsgDef;
import com.msg.mgr.CacheMgr;

public class MsgItem {

	private int msg_id;
	private int msg_cat;
	private int req_id;
	private int rsp_id;
	private int msg_cat_type;
	private String msg_name;
	private String msg_desc;
	private String msg_note;
	private String msg_cat_name;
	private List<MsgFieldItem> reqFields = new ArrayList<>();
	private List<MsgFieldItem> rspFields = new ArrayList<>();

	public static MsgItem valueOf(MsgDef msgDef) {
		MsgItem item = new MsgItem();
		item.setMsg_name(msgDef.getMsg_name());
		item.setMsg_cat(msgDef.getMsg_cat());
		item.setMsg_desc(msgDef.getMsg_desc());
		item.setMsg_id(msgDef.getMsg_id());
		item.setReq_id(msgDef.getReq_id());
		item.setRsp_id(msgDef.getRsp_id());
		item.setMsg_note(msgDef.getMsg_note());
		MsgCat msgCat = CacheMgr.getInstance().getMsgCats().get(item.getMsg_cat());
		if (msgCat != null) {
			item.setMsg_cat_name(msgCat.getMsg_cat());
			item.setMsg_cat_type(msgCat.getMsg_cat_type());
		}
		msgDef.getReqBodys().forEach(v -> {
			item.getReqFields().add(MsgFieldItem.valueOf(v));
		});
		msgDef.getRspBodys().forEach(v -> {
			item.getRspFields().add(MsgFieldItem.valueOf(v));
		});
		return item;
	}

	public List<MsgFieldItem> getReqFields() {
		return reqFields;
	}

	public void setReqFields(List<MsgFieldItem> reqFields) {
		this.reqFields = reqFields;
	}

	public List<MsgFieldItem> getRspFields() {
		return rspFields;
	}

	public void setRspFields(List<MsgFieldItem> rspFields) {
		this.rspFields = rspFields;
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

	public String getMsg_cat_name() {
		return msg_cat_name;
	}

	public void setMsg_cat_name(String msg_cat_name) {
		this.msg_cat_name = msg_cat_name;
	}

	public int getMsg_cat_type() {
		return msg_cat_type;
	}

	public void setMsg_cat_type(int msg_cat_type) {
		this.msg_cat_type = msg_cat_type;
	}

	public boolean isStruct() {
		return msg_cat_type == MsgCat.CAT_STRUCT;
	}

	public String getMsg_name() {
		return msg_name;
	}

	public void setMsg_name(String msg_name) {
		this.msg_name = msg_name;
	}

}
