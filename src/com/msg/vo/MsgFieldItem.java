package com.msg.vo;

import com.msg.bean.MsgField;
import com.msg.mgr.MsgMgr;

/**
 * @author shengbao.Liu
 * @date 2018年4月18日 下午9:02:40
 * 
 */
public class MsgFieldItem {
	/** 字段排序id **/
	private int id;
	/** 描述 **/
	private String desc;
	/** 字段类型 **/
	private String ft;
	private String fk;
	private String fv;
	/** **/
	private String show_msg_ft;
	/** 字段名称 **/
	private String fn;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getFt() {
		return ft;
	}

	public void setFt(String ft) {
		this.ft = ft;
	}

	public String getFn() {
		return fn;
	}

	public void setFn(String fn) {
		this.fn = fn;
	}

	public String getFk() {
		return fk;
	}

	public void setFk(String fk) {
		this.fk = fk;
	}

	public String getFv() {
		return fv;
	}

	public void setFv(String fv) {
		this.fv = fv;
	}

	public String getShow_msg_ft() {
		return show_msg_ft;
	}

	public void setShow_msg_ft(String show_msg_ft) {
		this.show_msg_ft = show_msg_ft;
	}

	public static MsgFieldItem valueOf(MsgField v) {
		MsgFieldItem item = new MsgFieldItem();
		item.setId(v.getId());
		item.setFt(item.toFt(v.getFt(), v.getFk(), v.getFv()));
		item.setFk(v.getFk());
		item.setFv(v.getFv());
		item.setFn(v.getFn());
		item.setDesc(v.getDesc());
		item.setShow_msg_ft(item.toShowMsgFt(v.getFt(), v.getFk(), v.getFv()));
		return item;
	}

	public String toFt(String ft, String fk, String fv) {
		if (ft.equals("array")) {
			return "array&ltv&gt";
		} else if (ft.equals("map")) {
			return "map&lt" + fv + ",v&gt";
		}
		return "base";
	}

	public String toShowMsgFt(String ft, String fk, String fv) {
		//map&lt;int64,v&gt;
		if (ft.equals("array")) {
			return "array&lt" + fv + "&gt";
		} else if (ft.equals("map")) {
			return "map&lt;" + fk + "," + fv + "&gt";
		}
		return fv;
	}

}
