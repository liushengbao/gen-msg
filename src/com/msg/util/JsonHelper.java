package com.msg.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.alibaba.fastjson.serializer.SerializerFeature;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Json工具类
 * 
 */
public final class JsonHelper {

	public static String toS(Object o) {
		return JSON.toJSONString(o, SerializerFeature.DisableCircularReferenceDetect, SerializerFeature.WriteNonStringKeyAsString);
	}

	public static <T> List<T> jsonToArray(String jsonStr, Class<T> clazz) {
		if (jsonStr == null || jsonStr.equals("") || "null".equals(jsonStr)) {
			return new ArrayList<T>();
		}
		return JSON.parseArray(jsonStr, clazz);
	}

	public static <T> T jsonToObject(String jsonStr, Class<T> clazz) {
		try {
			if (jsonStr == null || jsonStr.equals("")) {
				return clazz.newInstance();
			}
			return JSON.parseObject(jsonStr, clazz);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static <T> T jsonToMap(String jsonStr, TypeReference<T> tr) {
		try {
			if (jsonStr == null || jsonStr.equals("")) {
				return null;
			}
			return JSON.parseObject(jsonStr, tr);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static <K, V> Map<K, V> jsonToMap(String jsonStr, Class<K> keyType, Class<V> valueType) {
		return jsonToMap(jsonStr, new TypeReference<Map<K, V>>(keyType, valueType) {
		});
	}


}
