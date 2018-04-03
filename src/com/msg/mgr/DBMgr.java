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
import com.msg.bean.MsgDef;
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
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return Collections.emptyList();
	}

	public void updateMsgDefs(List<MsgDef> list) {
		if (!list.isEmpty()) {
			Connection conn = getConnection();
			QueryRunner run = new QueryRunner();
			try {
				for (MsgDef msgDef : list) {
					run.update(conn, "replace into msg_info(req_id,msg_type,msg_desc,req_body,rsp_id,rsp_body) values(?,?,?,?,?,?)", msgDef.getReqId(), 1, msgDef.getMsgDesc(), JsonHelper.toS(msgDef.getReqBodys()), msgDef.getRspId(), JsonHelper.toS(msgDef.getRspBodys()));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DbUtils.closeQuietly(conn);
			}
		}
	}

}
