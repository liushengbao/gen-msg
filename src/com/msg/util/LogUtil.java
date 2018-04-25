package com.msg.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
  * @author shengbao.Liu
  * @date 2018年4月25日 下午4:46:34
  * 
  */
public class LogUtil {
	
	public static final Logger console = LogManager.getLogger("console");  
	
	public static void info(String string) {
		console.info(string);
	}
	
}
