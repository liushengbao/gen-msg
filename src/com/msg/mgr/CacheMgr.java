package com.msg.mgr;

import java.util.concurrent.ConcurrentHashMap;

import com.msg.bean.MsgDef;

public class CacheMgr {
	
	private static final CacheMgr instance = new CacheMgr();

	public static CacheMgr getInstance() {
		return instance;
	}
	
	/** 缓存修改的消息定义  **/
	private ConcurrentHashMap<Integer, MsgDef> modifyMsgDefs = new ConcurrentHashMap<>();
	
	public ConcurrentHashMap<Integer, MsgDef> getModifyMsgDefs() {
		return modifyMsgDefs;
	}

}
