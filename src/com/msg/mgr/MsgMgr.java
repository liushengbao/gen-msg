package com.msg.mgr;

import java.io.File;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.msg.bean.MsgCat;
import com.msg.bean.MsgDef;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;

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
		List<MsgDef> list = CacheMgr.getInstance().getModifyMsgDefs().values().stream().collect(Collectors.toList());

		Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
		try {
			cfg.setDirectoryForTemplateLoading(new File("E:\\workspace-oxygen\\gen-msg\\ftl"));
			cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

			for (MsgDef msgDef : list) {
				Map<String, Object> root = new HashMap<String, Object>();

				root.put("packageName", "com.shengbao.message");
				root.put("className", "Msg" + msgDef.getReqId());
				root.put("author", "shengbao");
				root.put("reqId", msgDef.getReqId());
				root.put("fields", msgDef.getReqBodys());
				
				Template temp = cfg.getTemplate("JavaMsgTemplate.ftl");
				Writer out = new OutputStreamWriter(System.out);
				temp.process(root, out);
			}

		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}

	}

	/** 保存消息定义到DB **/
	public void saveMsgDefsToDB() {
		List<MsgDef> list = CacheMgr.getInstance().getModifyMsgDefs().values().stream().collect(Collectors.toList());
		DBMgr.getInstance().updateMsgDefs(list);
	}
	
	public void addCat(MsgCat msgCat) {
		if (!CacheMgr.getInstance().getMsgCatNames().containsKey(msgCat.getMsg_cat())) {
			DBMgr.getInstance().addMsgCat(msgCat);
			CacheMgr.getInstance().loadMsgCat();
		}
	}

	public static void main(String[] args) {
		Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
		try {
			cfg.setDirectoryForTemplateLoading(new File("E:\\workspace-oxygen\\gen-msg\\ftl"));
			cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

			Map<String, Object> root = new HashMap<String, Object>();

			root.put("packageName", "co");
			root.put("className", "Msg1010101");
			root.put("author", "autoMake");
			Template temp = cfg.getTemplate("JavaMsgTemplate.ftl");
			Writer out = new OutputStreamWriter(System.out);
			temp.process(root, out);
		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
	}

}
