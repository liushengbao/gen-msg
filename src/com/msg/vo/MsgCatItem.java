package com.msg.vo;

import java.util.ArrayList;
import java.util.List;
import com.msg.bean.MsgCat;

public class MsgCatItem {

	private int msg_cat_id;
	private String msg_cat;
	private int msg_cat_type;

	private List<MsgItem> items = new ArrayList<>();

	public List<MsgItem> getItems() {
		return items;
	}

	public void setItems(List<MsgItem> items) {
		this.items = items;
	}

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
	
	public static MsgCatItem valueOf(MsgCat cat) {
		MsgCatItem catItem = new MsgCatItem();
		catItem.setMsg_cat_id(cat.getMsg_cat_id());
		catItem.setMsg_cat(cat.getMsg_cat());
		catItem.setMsg_cat_type(cat.getMsg_cat_type());
		return catItem;
	}

}
