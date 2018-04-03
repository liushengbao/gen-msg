package com.msg.util;

import javax.servlet.http.HttpServletRequest;

public class HttpHelpler {

	public static String getParameterValue(HttpServletRequest request, String key) {
		String[] values = request.getParameterMap().get(key);
		if (values != null && values.length > 0) {
			return values[0];
		}
		return "";
	}

}
