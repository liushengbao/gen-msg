package com.msg.util;

import java.io.File;
import java.util.List;

import org.tmatesoft.svn.core.SVNCommitInfo;
import org.tmatesoft.svn.core.SVNDepth;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNProperties;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.io.svn.SVNRepositoryFactoryImpl;
import org.tmatesoft.svn.core.wc.ISVNOptions;
import org.tmatesoft.svn.core.wc.SVNClientManager;
import org.tmatesoft.svn.core.wc.SVNRevision;
import org.tmatesoft.svn.core.wc.SVNStatus;
import org.tmatesoft.svn.core.wc.SVNStatusType;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

/**
 * svn工具
 * 
 * @author shengbao.Liu
 * @date 2018年4月26日 下午4:42:36
 * 
 */
public class SvnUtil {

	private static SVNClientManager svnClientManager;

	public static void init() {
		LogUtil.console.info("---------------------初始化svn配置----------------");

		// 1.根据访问协议初始化工厂
		SVNRepositoryFactoryImpl.setup();
		// 2.使用默认选项
		ISVNOptions isvnOptions = SVNWCUtil.createDefaultOptions(true);
		// 3.初始化权限
		ISVNAuthenticationManager isvnAuthenticationManager = SVNWCUtil.createDefaultAuthenticationManager(ConfigHelper.getCfgVal("svn.user"), ConfigHelper.getCfgVal("svn.pwd").toCharArray());
		// 4.创建SVNClientManager的实例
		svnClientManager = SVNClientManager.newInstance(isvnOptions, isvnAuthenticationManager);
		
		if (!isChecked(ConfigHelper.getCfgVal("gen.java.path"))) {
			LogUtil.info(ConfigHelper.getCfgVal("gen.java.path") + " 尚未检出!");
			checkOut(ConfigHelper.getCfgVal("svn.url"), ConfigHelper.getCfgVal("gen.java.path"));
		} else {
			LogUtil.info(ConfigHelper.getCfgVal("gen.java.path") + " 已经检出!");
		}
	}

	/** 判断当前路径svn 是否已经检出 **/
	public static boolean isChecked(String path) {
		File file = new File(path);
		if (file != null && file.isDirectory()) {
			for (File f : file.listFiles()) {
				if (f.isDirectory() && f.getName().equals(".svn")) {
					return true;
				}
			}
		}
		return false;
	}

	public static void main(String[] args) throws SVNException {

	}

	/** svn检出 **/
	public static void checkOut(String svnUrl, String localPath) {
		LogUtil.console.info("svn checkout ing..... svrUrl:" + svnUrl + " localPath:" + localPath);
		try {
			long nowRevision = svnClientManager.getUpdateClient().doCheckout(SVNURL.parseURIEncoded(svnUrl), new File(localPath), SVNRevision.HEAD, SVNRevision.HEAD, SVNDepth.INFINITY, true);
			LogUtil.info("svn 检出版本:" + nowRevision);

			File file = new File(localPath);
			if (file != null && file.isDirectory()) {
				LogUtil.info("path:" + localPath + "svn 检出版本:" + nowRevision + " 文件数:" + file.list().length);
			}
		} catch (SVNException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 提交-commit commit更改一个文件时，如果文件本身存在，则需要提交其父目录
	 * 
	 * @throws SVNException
	 */
	public static void commit(List<File> files) {
		try {
			// 没有版本号的先执行add操作
			for (File file : files) {
				SVNStatus status = svnClientManager.getStatusClient().doStatus(file, true);
				if (status == null || status.getContentsStatus() == SVNStatusType.STATUS_UNVERSIONED) {
					svnClientManager.getWCClient().doAdd(file, false, false, false, SVNDepth.INFINITY, false, false);
					LogUtil.console.info("svn add -->" + file.getName());
				}
			}
			// 执行commit操作
			svnClientManager.getCommitClient().setIgnoreExternals(false);
			SVNProperties svnProperties = new SVNProperties();
			String[] changeLists = new String[] {};
			SVNCommitInfo svnCommitInfo = svnClientManager.getCommitClient().doCommit(files.toArray(new File[0]), false, "message up by shengbao util", svnProperties, changeLists, false, false, SVNDepth.fromRecurse(true));
			LogUtil.info("svn commit操作成功，操作结果：" + JsonHelper.toS(svnCommitInfo));
		} catch (Exception e) {
			LogUtil.console.error("svn commit err!", e);
		}

	}

	/**
	 * 更新-update
	 * 
	 * @throws SVNException
	 */
	public static void update(File file) throws SVNException {
		svnClientManager.getUpdateClient().doUpdate(file, SVNRevision.HEAD, SVNDepth.INFINITY, true, false);
		LogUtil.info("snv update >> " + file.getName());
	}

	/**
	 * 删除-delete
	 * 
	 * @throws SVNException
	 */
	public static void delete(String[] path) {
		if (path == null || path.length <= 0) {
			return;
		}
		
		try {
			SVNURL[] array = new SVNURL[path.length];
			for (int i = 0; i < path.length; i++) {
				array[i] =  SVNURL.parseURIEncoded(path[i]);
			}
			SVNCommitInfo svnCommitInfo = svnClientManager.getCommitClient().doDelete(array, "message up");
			LogUtil.info("删除  >>" + JsonHelper.toS(svnCommitInfo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	
	}

}
