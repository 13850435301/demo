package com.heeexy.example.util;

import org.apache.shiro.crypto.hash.SimpleHash;

/**
 * @author: hxy
 * @date: 2017/10/24 10:16
 */
public class StringTools {

	public static boolean isNullOrEmpty(String str) {
		return null == str || "".equals(str) || "null".equals(str);
	}

	public static boolean isNullOrEmpty(Object obj) {
		return null == obj || "".equals(obj);
	}

	public static void main(String[] args) {
		String simpleHash=new SimpleHash("MD5","123456","b27f2cfff42a86c67c7dae00d5446c99",1).toString();
		System.out.println(simpleHash);
//		841973b43b027a6dcc64ce9f80555cd9 2
//		811c967a92855bf755903bde87c837fd    1


	}
}
