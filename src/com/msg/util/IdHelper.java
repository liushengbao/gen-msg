package com.msg.util;

import java.util.concurrent.atomic.AtomicInteger;

public class IdHelper {
	
	private static AtomicInteger catId = new AtomicInteger(0);
	private static AtomicInteger msgId = new AtomicInteger(0);
	
	public static void setMsgCatId(int id) {
		if (id > catId.get()) {
			catId.set(id);
		}
	}
	
	public static void setMsgId(int id) {
		if (id > msgId.get()) {
			msgId.set(id);
		}
	}
	
	public static int genMsgCatId() {
		return catId.incrementAndGet();
	}
	
	public static int genMsgId() {
		return msgId.incrementAndGet();
	}
	
}
