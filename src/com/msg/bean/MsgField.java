package com.msg.bean;

public class MsgField {
	/** 字段排序id **/
	private int id;
	/** 描述 **/
	private String desc;
	/** 字段类型 **/
	private String ft;
	/** 字段类型key **/
	private String fk;
	/** 字段类型value **/
	private String fv;
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

}
