package com.msg.bean;
/** 
 * 消息类别 
 * @author shengbao
 *
 */
public class MsgCat {
	
	/** 普通消息号 **/
	public static final int CAT_COMMON = 1;
	/** 结构体  **/
	public static final int CAT_STRUCT = 2;
	/** 广播  **/
	public static final int CAT_BROADCAST = 3;
	
	private int msg_cat_id;
	private String msg_cat;
	private int msg_cat_type;

	public int getMsg_cat_id() {
		return msg_cat_id;
	}

	public void setMsg_cat_id(int msg_cat_id) {
		this.msg_cat_id = msg_cat_id;
	}

	public String getMsg_cat() {
		return msg_cat;
	}

	public void setMsg_cat(String msg_cat) {
		this.msg_cat = msg_cat;
	}

	public int getMsg_cat_type() {
		return msg_cat_type;
	}

	public void setMsg_cat_type(int msg_cat_type) {
		this.msg_cat_type = msg_cat_type;
	}

}
