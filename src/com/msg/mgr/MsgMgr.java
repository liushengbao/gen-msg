package com.msg.mgr;

import java.util.List;
import java.util.stream.Collectors;

import com.msg.bean.MsgDef;

public class MsgMgr {

	private static final MsgMgr instance = new MsgMgr();

	public static MsgMgr getInstance() {
		return instance;
	}

	/** 添加修改了的消息定义 **/
	public void addModifyMsgDef(MsgDef msgDef) {
		CacheMgr.getInstance().getModifyMsgDefs().put(msgDef.getReqId(), msgDef);
	}

	/** 提交修改 **/
	public void submit() {
		writeFiles();
		saveMsgDefsToDB();
	}
	
	/** 写入文件 >> 例如Msg1010101.java **/
	public void writeFiles() {
		
	}
	
	/** 保存消息定义到DB **/
	public void saveMsgDefsToDB() {
		List<MsgDef> list = CacheMgr.getInstance().getModifyMsgDefs().values().stream().collect(Collectors.toList());
		DBMgr.getInstance().updateMsgDefs(list);
	}

}
