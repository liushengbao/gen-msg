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
import com.msg.util.JsonHelper;

public class DBMgr {

	private static final DBMgr instance = new DBMgr();

	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static DBMgr getInstance() {
		return instance;
	}

	public Connection getConnection() {
		Connection conn;
		try {
			// FIXME 这个应该配置到一个单独的文件里面
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/gen_msg?useUnicode=true&characterEncoding=utf8", "root", "123456");
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

	public void updateMsgDefs(List<MsgDef> list) {
		if (list.isEmpty()) {
			return;
		}
		
		Connection conn = getConnection();
		QueryRunner run = new QueryRunner();
		try {
			for (MsgDef msgDef : list) {
				System.out.println("更新的消息定义id:" + msgDef.getMsg_id() + " 是否更新旧的消息:" + CacheMgr.getInstance().getMsgDefs().containsKey(msgDef.getMsg_id()));//TODO syso
				if (!CacheMgr.getInstance().getMsgDefs().containsKey(msgDef.getMsg_id())) {
					run.update(conn, "insert into msg_info(msg_id,msg_cat,msg_desc,req_id,req_body,rsp_id,rsp_body,msg_note) values(?,?,?,?,?,?,?,?)", msgDef.getMsg_id(), msgDef.getMsg_cat(), msgDef.getMsg_desc(), msgDef.getReq_id(), JsonHelper.toS(msgDef.getReqBodys()), msgDef.getRsp_id(), JsonHelper.toS(msgDef.getRspBodys()), msgDef.getMsg_note());
				} else {
					run.update(conn, "update msg_info set msg_cat=?,msg_desc=?,req_id=?,req_body=?,rsp_id=?,rsp_body=?,msg_note=? where msg_id=?",  msgDef.getMsg_cat(), msgDef.getMsg_desc(), msgDef.getReq_id(), JsonHelper.toS(msgDef.getReqBodys()), msgDef.getRsp_id(), JsonHelper.toS(msgDef.getRspBodys()), msgDef.getMsg_note(), msgDef.getMsg_id());
				}
				CacheMgr.getInstance().getMsgDefs().put(msgDef.getMsg_id(), msgDef);
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

}
