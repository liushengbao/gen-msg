package com.msg.util;

import java.util.HashMap;
import java.util.Map;

/**
 * 编程语言相关
 * 
 * @author shengbao.Liu
 * @date 2018年4月20日 下午8:50:28
 * 
 */
public class LangUtil {

	private static final Map<String, String> javaBasicAlias = new HashMap<>();
	private static final Map<String, String> javaPackAlias = new HashMap<>();
	static {
		javaBasicAlias.put("int8", "byte");
		javaBasicAlias.put("int16", "short");
		javaBasicAlias.put("int32", "int");
		javaBasicAlias.put("int64", "long");
		javaBasicAlias.put("string", "String");

		javaPackAlias.put("int8", "Byte");
		javaPackAlias.put("int16", "Short");
		javaPackAlias.put("int32", "Integer");
		javaPackAlias.put("int64", "Long");
		javaPackAlias.put("string", "String");
	}

	public static String toJavaBasic(String ft) {
		return javaBasicAlias.getOrDefault(ft, ft);
	}

	public static String toJavaPack(String ft) {
		return javaPackAlias.getOrDefault(ft, ft);
	}

	public static String getMapKey(String xx) {
		xx = xx.replace("&lt", "<");
		xx = xx.replace("&gt", ">");
		return xx.substring(xx.indexOf("<") + 1, xx.indexOf(","));
	}

}
