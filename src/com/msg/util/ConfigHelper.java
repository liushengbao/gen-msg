package com.msg.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import javax.servlet.ServletContext;

/**
 * 配置文件帮主类 
 * 
 * @author shengbao.Liu
 * @date 2018年4月25日 上午11:00:47
 * 
 */
public class ConfigHelper {
	
	/** 配置文件 **/
	private static final Properties properties = new Properties();

	public static void loadConfigs(ServletContext servletContext) {
		String filePath = servletContext.getRealPath("/config/config.properties");
		FileInputStream fis;
		try {
			fis = new FileInputStream(filePath);
			properties.load(fis);
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static String getCfgVal(String key, String defaultValue) {
		return properties.getProperty(key, defaultValue);
	}
	
	public static String getCfgVal(String key) {
		return properties.getProperty(key);
	}
	
}
