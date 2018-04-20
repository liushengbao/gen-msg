package com.msg.bean;

public class WriteField {
	/** 字段排序id **/
	private int id;
	/** 描述 **/
	private String desc;
	/** 字段类型 **/
	private String ft;
	private String ft_java;
	/** 字段类型key **/
	private String fk;
	private String fk_jav;
	/** 字段类型value **/
	private String fv;
	private String fv_java;
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
	
	public String getFt_java() {
		return ft_java;
	}

	public void setFt_java(String ft_java) {
		this.ft_java = ft_java;
	}

	public String getFk_jav() {
		return fk_jav;
	}

	public void setFk_jav(String fk_jav) {
		this.fk_jav = fk_jav;
	}

	public String getFv_java() {
		return fv_java;
	}

	public void setFv_java(String fv_java) {
		this.fv_java = fv_java;
	}

	public static WriteField valueOf(MsgField field) {
		WriteField f = new WriteField();
		f.setDesc(field.getDesc());
		f.setFn(field.getFn());
		f.setFt(field.getFt());
		f.setFk(field.getFk());
		f.setFv(field.getFv());
		return f;
	}
}
