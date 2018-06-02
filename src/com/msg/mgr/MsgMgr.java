package com.msg.mgr;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.msg.bean.MsgCat;
import com.msg.bean.MsgDef;
import com.msg.bean.MsgField;
import com.msg.util.ConfigHelper;
import com.msg.util.FreemarkHelper;
import com.msg.util.LogUtil;
import com.msg.util.SvnUtil;
import com.msg.vo.MsgCatItem;
import com.msg.vo.MsgItem;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * 消息管理类
 * 
 * @author shengbao.Liu
 *
 */
public class MsgMgr {

	private static final MsgMgr instance = new MsgMgr();

	public static MsgMgr getInstance() {
		return instance;
	}

	/** 添加修改了的消息定义 **/
	public void addModifyMsgDef(MsgDef msgDef) {
		synchronized (CacheMgr.getInstance().getModifyMsgDefs()) {
			CacheMgr.getInstance().getModifyMsgDefs().put(msgDef.getMsg_id(), msgDef);
			if (CacheMgr.getInstance().getMsgDefs().containsKey(msgDef.getMsg_id())) {
				msgDef.setModifyStatu(MsgDef.MODIFY_UPDATE);
			} else {
				msgDef.setModifyStatu(MsgDef.MODIFY_INSERT);
			}
			CacheMgr.getInstance().getMsgDefs().put(msgDef.getMsg_id(), msgDef);
		}
	}
	
	/** 提交修改 **/
	public void submit() {
		//先处理删除
		List<MsgDef> delMsgDefs = CacheMgr.getInstance().getDelMsgDefs().values().stream().collect(Collectors.toList());
		if (ConfigHelper.getCfgVal("svn.open", "true").equals("true")) {
			delMsgFile(delMsgDefs);
		}
		if (ConfigHelper.getCfgVal("svn.open", "true").equals("true")) {
			//再处理添加，修改
			handleFiles();
		}
		saveMsgDefsToDB();
		
		//清空
		CacheMgr.getInstance().getModifyMsgDefs().clear();
	}

	/** 写入文件 >> 例如Msg1010101.java **/
	public void handleFiles() {
		List<MsgDef> list = CacheMgr.getInstance().getModifyMsgDefs().values().stream().collect(Collectors.toList());

		List<File> javaFiles = writeJava(list);
		if (!javaFiles.isEmpty()) {
			SvnUtil.commit(javaFiles);
		}
	}

	/** 写入.java的逻辑 **/
	private List<File> writeJava(List<MsgDef> list) {
		List<File> files = new ArrayList<>();
		Configuration cfg = FreemarkHelper.getCfg();
		String javaPath = ConfigHelper.getCfgVal("gen.java.path");
		try {
			for (MsgDef msgDef : list) {
				Map<String, Object> root = new HashMap<String, Object>();
				// 请求
				root.put("packageName", "org.message.game");
				root.put("className", "Msg" + msgDef.getReq_id());
				root.put("author", "shengbao");
				root.put("desc", msgDef.getMsg_desc());
				root.put("reqId", msgDef.getReq_id());
				root.put("fields", msgDef.getReqBodys());
				Template temp = cfg.getTemplate("JavaMsgTemplate.ftl");
				File reqMsgFile = new File(javaPath + "\\Msg" + msgDef.getReq_id() + ".java");
				Writer out = null;
				try {
					out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(reqMsgFile), "utf-8"));
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				temp.process(root, out);
				out.close();
				files.add(reqMsgFile);
				// 返回
				root.clear();
				if (msgDef.getRsp_id() > 0) {
					root.put("packageName", "org.message.game");
					root.put("className", "Msg" + msgDef.getRsp_id());
					root.put("author", "shengbao");
					root.put("desc", msgDef.getMsg_desc());
					root.put("reqId", msgDef.getRsp_id());
					root.put("fields", msgDef.getRspBodys());

					temp = cfg.getTemplate("JavaMsgTemplate.ftl");
					try {
						File rspMsgFile = new File(javaPath + "\\Msg" + msgDef.getRsp_id() + ".java");
						out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(rspMsgFile), "utf-8"));
						files.add(rspMsgFile);
					} catch (Exception e1) {
						e1.printStackTrace();
					}
					temp.process(root, out);
					out.close();
				}
			}

		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
		return files;
	}

	/** 保存消息定义到DB **/
	public void saveMsgDefsToDB() {
		synchronized (CacheMgr.getInstance().getModifyMsgDefs()) {
			List<MsgDef> list = CacheMgr.getInstance().getModifyMsgDefs().values().stream().collect(Collectors.toList());
			//保存到数据库
			DBMgr.getInstance().saveMsgDefs(list);
		}
	}

	/** 添加类别 **/
	public void addCat(MsgCat msgCat) {
		if (!CacheMgr.getInstance().getMsgCatNames().containsKey(msgCat.getMsg_cat())) {
			DBMgr.getInstance().addMsgCat(msgCat);
			CacheMgr.getInstance().loadMsgCat();
		}
	}
	
	/** 获取客户端显示的类别 **/
	public List<MsgCatItem> getCatItems() {
		List<MsgCatItem> collect = CacheMgr.getInstance().getMsgCats().values().stream().map(v -> MsgCatItem.valueOf(v)).collect(Collectors.toList());
		List<MsgDef> msgDefs = CacheMgr.getInstance().getMsgDefs().values().stream().sorted((a, b) -> Integer.compare(a.getReq_id(), b.getReq_id())).collect(Collectors.toList());
		for (MsgCatItem item : collect) {
			boolean firstName = false;
			for (MsgDef msgDef : msgDefs) {
				if (msgDef.getMsg_cat() == item.getMsg_cat_id()) {
					item.getItems().add(MsgItem.valueOf(msgDef));
					if (!firstName) {
						item.setFirstMsgName(String.valueOf(msgDef.getReq_id()));
						firstName = true;
					}
				}

			}
		}
		return collect;
	}

	/** 获取客户端消息  **/
	public MsgItem getMsgItem(final int msgId) {
		MsgDef msgDef = CacheMgr.getInstance().getMsgDefs().values().stream().filter(v -> v.getMsg_id() == msgId).findFirst().orElse(null);
		if (msgDef != null) {
			return MsgItem.valueOf(msgDef);
		}
		return null;
	}

	public String getFieldTypeShowStr(MsgField field) {
		if (field.getFt().equals("array")) {
			return field.getFt() + "<" + field.getFv() + ">";
		} else if (field.getFt().equals("map")) {
			return field.getFt() + "<" + field.getFk() + "," + field.getFv() + ">";
		} else {
			return field.getFv();
		}
	}

	public void delMsg(Integer... list) {
		List<MsgDef> delMsgDefs = delServerMsg(Arrays.asList(list));
		if (!delMsgDefs.isEmpty()) {
			delMsgDefs.forEach(v -> CacheMgr.getInstance().getDelMsgDefs().put(v.getMsg_id(), v));
		}
	}

	public List<MsgDef> delServerMsg(List<Integer> list) {
		List<MsgDef> dels = new ArrayList<>();
		for (Integer msgId : list) {
			// 内存删除
			CacheMgr.getInstance().getModifyMsgDefs().remove(msgId);
			MsgDef msgDef = CacheMgr.getInstance().getMsgDefs().remove(msgId);
			if (msgDef != null) {
				dels.add(msgDef);
			}
			// 数据库删除
			DBMgr.getInstance().delMsg(msgId);
		}
		return dels;
	}

	public void delMsgFile(List<MsgDef> list) {
		List<String> batDels = new ArrayList<>();
		for (MsgDef msgDef : list) {
			// svn删除
			if (msgDef != null) {
				// 本地文件库删除
				File delReqFile = new File(ConfigHelper.getCfgVal("gen.java.path")  + "/Msg" + msgDef.getReq_id() + ".java");
				if (delReqFile != null && delReqFile.isFile()) {
					delReqFile.delete();
				}
				
				String delReqMsg = ConfigHelper.getCfgVal("svn.url") + "/Msg" + msgDef.getReq_id() + ".java";
				LogUtil.info("删除的文件svnUrl:" + delReqMsg);
				batDels.add(delReqMsg);
				
				if (msgDef.getRsp_id() > 0) {
					// 本地文件库删除
					File delRspFile = new File(ConfigHelper.getCfgVal("gen.java.path")  + "/Msg" + msgDef.getRsp_id() + ".java");
					if (delRspFile != null && delRspFile.isFile()) {
						delRspFile.delete();
					}
					
					String delRspMsg = ConfigHelper.getCfgVal("svn.url") + "/Msg" + msgDef.getRsp_id() + ".java";
					LogUtil.info("删除的文件svnUrl:" + delRspMsg);
					batDels.add(delRspMsg);
				}
			}
		}
		if (!batDels.isEmpty()) {
			SvnUtil.delete(batDels.toArray(new String[0]));
			LogUtil.info("删除svn 库文件成功!");
		}
	}

}
