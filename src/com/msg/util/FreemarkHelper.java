package com.msg.util;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;

import freemarker.template.Configuration;
import freemarker.template.TemplateExceptionHandler;

/**
 * @author shengbao.Liu
 * @date 2018年4月25日 上午11:45:02
 * 
 */
public class FreemarkHelper {

	private static final Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);

	public static void init(ServletContext servletContext) {
		try {
			String filePath = servletContext.getRealPath("/ftl/");
			cfg.setDirectoryForTemplateLoading(new File(filePath));
			cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
			cfg.setDefaultEncoding("UTF-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static Configuration getCfg() {
		return cfg;
	}

}
