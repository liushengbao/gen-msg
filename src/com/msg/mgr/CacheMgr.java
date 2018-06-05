package com.msg.mgr;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import com.msg.bean.MsgCat;
import com.msg.bean.MsgDef;
import com.msg.util.IdHelper;
import com.msg.util.LogUtil;
/**
 * 缓存中心
 * 
 * @author shengbao.Liu
 *
 */
public class CacheMgr {
	
	/** 基础类型 **/
	private static List<String> basicTypes = new ArrayList<>(); 
	static {
		basicTypes.add("int8");
		basicTypes.add("int16");
		basicTypes.add("int32");
		basicTypes.add("int64");
		basicTypes.add("string");
	}
	
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
	/** 删除的消息定义 **/
	private ConcurrentHashMap<Integer, MsgDef> delMsgDefs = new ConcurrentHashMap<>();
	
	/** 初始化  **/
	public void init() {
		loadMsgCat();
		loadMsgDef();
		
		IdHelper.setMsgCatId(this.msgCats.keySet().stream().max((a,b) -> Integer.compare(a, b)).orElse(0));
		IdHelper.setMsgId(this.msgDefs.keySet().stream().max((a,b) -> Integer.compare(a, b)).orElse(0));
		LogUtil.console.info("数据库 消息定义加载完成,size:" + this.msgCats.size());
		LogUtil.console.info("数据库 消息类别加载完成,size:" + this.msgDefs.size());
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
	
	public Collection<MsgCat> getMsgCats(final int type) {
		return msgCats.values().stream().filter(v -> v.getMsg_cat_type() == type).collect(Collectors.toList());
	}
	
	public ConcurrentHashMap<String, Integer> getMsgCatNames() {
		return msgCatNames;
	}
	
	public ConcurrentHashMap<Integer, MsgDef> getDelMsgDefs() {
		return delMsgDefs;
	}
	
	public Collection<String> getStructs() {
		List<String> list = new ArrayList<>();
		list.addAll(basicTypes);
		List<MsgDef> collect = msgDefs.values().stream().filter(v -> MsgMgr.getInstance().getMsgCatType(v) == MsgCat.CAT_STRUCT).collect(Collectors.toList());
		collect.forEach(v -> list.add(v.getMsg_name()));
		return list;
	}
}
