package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.controller.base.BaseController;
import com.heeexy.example.service.LoginService;
import com.heeexy.example.util.CommonUtil;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * @author: hxy
 * @description: 登录相关Controller
 * @date: 2017/10/24 10:33
 */
@RestController
@RequestMapping("/login")
public class LoginController extends BaseController {

	@Autowired
	private LoginService loginService;

	/**
	 * 登录
	 */
	@PostMapping("/auth")
	public JSONObject authLogin(@RequestBody JSONObject requestJson, HttpServletRequest request) {
	StringBuffer url=	request.getRequestURL();
		CommonUtil.hasAllRequired(requestJson, "username,password");
		String password=new SimpleHash("MD5",requestJson.getString("password"), ByteSource.Util.bytes(salt),2).toString();
		requestJson.put("password",password);
		return loginService.authLogin(requestJson);
	}

	/**
	 * 查询当前登录用户的信息
	 */
	@PostMapping("/getInfo")
	public JSONObject getInfo() {
		return loginService.getInfo();
	}

	/**
	 * 登出
	 */
	@PostMapping("/logout")
	public JSONObject logout() {
		return loginService.logout();
	}
}
