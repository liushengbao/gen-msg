package com.msg.mgr;

import java.util.concurrent.ConcurrentHashMap;
import com.msg.bean.MsgCat;
import com.msg.bean.MsgDef;
import com.msg.util.IdHelper;
/**
 * 缓存中心
 * 
 * @author shengbao.Liu
 *
 */
public class CacheMgr {
	
	private static final CacheMgr instance = new CacheMgr();

	public static CacheMgr getInstance() {
		return instance;
	}
	
	/** 缓存修改的消息定义  **/
	private ConcurrentHashMap<Integer, MsgDef> modifyMsgDefs = new ConcurrentHashMap<>();
	/** 消息定义  **/
	private ConcurrentHashMap<Integer, MsgDef> msgDefs = new ConcurrentHashMap<>();
	/** 消息类别  **/
	private ConcurrentHashMap<Integer, MsgCat> msgCats = new ConcurrentHashMap<>();
	/** 消息类别名字  **/
	private ConcurrentHashMap<String, Integer> msgCatNames = new ConcurrentHashMap<>();
	
	/** 初始化  **/
	public void init() {
		loadMsgCat();
		loadMsgDef();
		
		IdHelper.setMsgCatId(this.msgCats.keySet().stream().max((a,b) -> Integer.compare(a, b)).orElse(0));
		IdHelper.setMsgId(this.msgDefs.keySet().stream().max((a,b) -> Integer.compare(a, b)).orElse(0));
	}
	
	/** 载入消息定义 **/
	public void loadMsgDef() {
		this.msgDefs.clear();
		DBMgr.getInstance().loadMsgDefs().forEach(v -> this.msgDefs.put(v.getMsg_id(), v));
	}

	/** 载入类目  **/
	public void loadMsgCat() {
		this.msgCats.clear();
		DBMgr.getInstance().getAllMsgCats().forEach(v -> this.msgCats.put(v.getMsg_cat_id(), v));
		this.msgCats.values().stream().forEach(v -> this.msgCatNames.put(v.getMsg_cat(), v.getMsg_cat_id()));
	}
	
	public ConcurrentHashMap<Integer, MsgDef> getModifyMsgDefs() {
		return modifyMsgDefs;
	}

	public ConcurrentHashMap<Integer, MsgDef> getMsgDefs() {
		return msgDefs;
	}

	public ConcurrentHashMap<Integer, MsgCat> getMsgCats() {
		return msgCats;
	}
	
	public ConcurrentHashMap<String, Integer> getMsgCatNames() {
		return msgCatNames;
	}
	
}
