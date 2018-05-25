package com.msg.mgr;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import com.msg.bean.MsgCat;
import com.msg.bean.MsgDef;
import com.msg.bean.MsgField;
import com.msg.util.ConfigHelper;
import com.msg.util.JsonHelper;
import com.msg.util.LogUtil;

public class DBMgr {

	private static final DBMgr instance = new DBMgr();

	public static void loadDriver() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		LogUtil.console.info("数据库加载驱动完毕！");
	}

	public static DBMgr getInstance() {
		return instance;
	}

	public Connection getConnection() {
		Connection conn;
		try {
			String url = ConfigHelper.getCfgVal("url");
			String user = ConfigHelper.getCfgVal("user");
			String passwd = ConfigHelper.getCfgVal("passwd");
			conn = DriverManager.getConnection(url, user, passwd);
			return conn;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		throw new IllegalAccessError("获取连接失败!");
	}

	public List<MsgDef> loadMsgDefs() {
		Connection conn = getConnection();
		QueryRunner run = new QueryRunner();
		ResultSetHandler<List<MsgDef>> handler = new BeanListHandler<>(MsgDef.class);
		try {
			List<MsgDef> list = run.query(conn, "select * from msg_info", handler);
			list.forEach(v -> {
				v.setReqBodys(JsonHelper.jsonToArray(v.getReq_body(), MsgField.class));
				v.setRspBodys(JsonHelper.jsonToArray(v.getRsp_body(), MsgField.class));
			});

			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return Collections.emptyList();
	}

	/** 
	 * 保存消息定义
	 * @param list
	 */
	public void saveMsgDefs(List<MsgDef> list) {
		if (list.isEmpty()) {
			return;
		}

		Connection conn = getConnection();
		QueryRunner run = new QueryRunner();
		try {
			for (MsgDef msgDef : list) {
				if (!CacheMgr.getInstance().getMsgDefs().containsKey(msgDef.getMsg_id())) {
					System.out.println("插入消息 " + msgDef.getMsg_id());//TODO syso
					run.update(conn, "insert into msg_info(msg_id,msg_cat,msg_desc,req_id,req_body,rsp_id,rsp_body,msg_note) values(?,?,?,?,?,?,?,?)", msgDef.getMsg_id(), msgDef.getMsg_cat(), msgDef.getMsg_desc(), msgDef.getReq_id(), JsonHelper.toS(msgDef.getReqBodys()), msgDef.getRsp_id(), JsonHelper.toS(msgDef.getRspBodys()), msgDef.getMsg_note());
				} else {
					System.out.println("更新消息 " + msgDef.getMsg_id());//TODO syso
					run.update(conn, "update msg_info set msg_cat=?,msg_desc=?,req_id=?,req_body=?,rsp_id=?,rsp_body=?,msg_note=? where msg_id=?", msgDef.getMsg_cat(), msgDef.getMsg_desc(), msgDef.getReq_id(), JsonHelper.toS(msgDef.getReqBodys()), msgDef.getRsp_id(), JsonHelper.toS(msgDef.getRspBodys()), msgDef.getMsg_note(), msgDef.getMsg_id());
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}

	}

	public void addMsgCat(MsgCat msgCat) {
		if (msgCat != null) {
			Connection conn = getConnection();
			QueryRunner run = new QueryRunner();
			try {
				run.update(conn, "insert into msg_cat(msg_cat_id,msg_cat,msg_cat_type) values(?,?,?)", msgCat.getMsg_cat_id(), msgCat.getMsg_cat(), msgCat.getMsg_cat_type());
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DbUtils.closeQuietly(conn);
			}
		}
	}

	public List<MsgCat> getAllMsgCats() {
		Connection conn = getConnection();
		QueryRunner run = new QueryRunner();
		try {
			List<MsgCat> list = run.query(conn, "select * from msg_cat", new BeanListHandler<>(MsgCat.class));
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return Collections.emptyList();
	}

	public void delMsg(Integer msgId) {
		Connection conn = getConnection();
		QueryRunner run = new QueryRunner();
		try {
			run.execute(conn, "delete from msg_info where msg_id=?", msgId);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

}
