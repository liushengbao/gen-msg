package com.msg.util;

import javax.servlet.http.HttpServletRequest;

public class HttpHelpler {
	
	/** 获取参数的值  **/
	public static String getParameter(HttpServletRequest request, String key) {
		return getParameterOrDefault(request, key, "");
	}

	/** 获取带默认值参数的值 **/
	public static String getParameterOrDefault(HttpServletRequest request, String key, String def) {
		String[] values = request.getParameterMap().get(key);
		if (values != null && values.length > 0) {
			return values[0];
		}
		return def;
	}

}
