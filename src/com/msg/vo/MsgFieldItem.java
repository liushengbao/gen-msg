package com.msg.vo;

import com.msg.bean.MsgField;

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

	public static MsgFieldItem valueOf(MsgField v) {
		MsgFieldItem item  = new MsgFieldItem();
		item.setId(v.getId());
		item.setFt(v.getFt());
		item.setFn(v.getFn());
		item.setDesc(v.getDesc());
		return item;
	}
	
}
