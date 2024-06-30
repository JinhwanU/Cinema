package kr.ac.kopo.framework;

import java.io.FileInputStream;
import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

public class HandlerMapping {

	private Map<String, Controller> mappings;

	public HandlerMapping(String propLoc) {
		mappings = new HashMap<>();

		Properties prop = new Properties();
		try (InputStream is = new FileInputStream(propLoc);) {
			prop.load(is);

			Set<Object> keys = prop.keySet();
			for (Object key : keys) {
				String className = prop.getProperty(key.toString());

				Class<?> clz = Class.forName(className); // 문자열을 클래스<?>타입으로 반환
				Constructor<?> constructor = clz.getConstructor();
				Controller control = (Controller) constructor.newInstance();

				mappings.put(key.toString(), control);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Controller getController(String uri) {
		return mappings.get(uri);
	}
}
