package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.heeexy.example.service.ArticleService;
import com.heeexy.example.service.GoodsService;
import com.heeexy.example.util.CommonUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * @author: hxy
 * @description: 商品相关Controller
 *
 */
@RestController
@RequestMapping("/goods")
public class GoodsController {

	@Autowired
	private GoodsService goodsService;

	/**
	 * 查询规格名列表
	 */
	@RequiresPermissions("specsname:list")
	@PostMapping("/listSpecsName")
	public JSONObject listSpecsName(@RequestBody JSONObject requestJson) {
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		return goodsService.s_specs_name_list(params);
	}


	/**
	 * 添加规格名
	 */
	@RequiresPermissions("specsname:add")
	@PostMapping("/addSpecsname")
	public JSONObject addSpecsname(@RequestBody JSONObject requestJson) {
		CommonUtil.hasAllRequired(requestJson, "specsname");
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		params.put("type","add");
		return goodsService.aud_specs_name(params);
	}

	/**
	 * 修改规格名
	 */
	@RequiresPermissions("specsname:update")
	@PostMapping("/updateSpecsname")
	public JSONObject updateSpecsname(@RequestBody JSONObject requestJson) {
		CommonUtil.hasAllRequired(requestJson, "specsNameId");
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		params.put("type","update");
		return goodsService.aud_specs_name(params);
	}


	/**
	 * 查询规格值列表
	 */
	@RequiresPermissions("specsvalue:list")
	@PostMapping("/listSpecsValue")
	public JSONObject listSpecsValue(@RequestBody JSONObject requestJson) {
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		return goodsService.s_specs_value_list(params);
	}


	/**
	 * 添加规格值
	 */
	@RequiresPermissions("specsvalue:add")
	@PostMapping("/addSpecsvalue")
	public JSONObject addSpecsvalue(@RequestBody JSONObject requestJson) {
		CommonUtil.hasAllRequired(requestJson, "specsvalue");
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		params.put("type","add");
		return goodsService.aud_specs_value(params);
	}

	/**
	 * 修改规格值
	 */
	@RequiresPermissions("specsvalue:update")
	@PostMapping("/updateSpecsvalue")
	public JSONObject updateSpecsvalue(@RequestBody JSONObject requestJson) {
		CommonUtil.hasAllRequired(requestJson, "specsvalueid,specsnameid");
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		params.put("type","update");
		return goodsService.aud_specs_value(params);
	}

	/**
	 * 删除规格值
	 */
	@RequiresPermissions("specsvalue:delete")
	@PostMapping("/deleteSpecsvalue")
	public JSONObject deleteSpecsvalue(@RequestBody JSONObject requestJson) {
		CommonUtil.hasAllRequired(requestJson, "specsvalueid");
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		params.put("type","delete");
		return goodsService.aud_specs_value(params);
	}


	/**
	 * 查询商品分类列表
	 */
	@RequiresPermissions("category:list")
	@PostMapping("/listCategory")
	public JSONObject listCategory(@RequestBody JSONObject requestJson) {
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		return goodsService.goods_category_list(params);
	}


	/**
	 * 添加商品分类
	 */
	@RequiresPermissions("category:add")
	@PostMapping("/addCategory")
	public JSONObject addCategory(@RequestBody JSONObject requestJson) {
		CommonUtil.hasAllRequired(requestJson, "categoryname");
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		params.put("type","add");
		return goodsService.aud_goods_category(params);
	}

	/**
	 * 修改商品分类
	 */
	@RequiresPermissions("category:update")
	@PostMapping("/updateCategory")
	public JSONObject updateCategory(@RequestBody JSONObject requestJson) {
		CommonUtil.hasAllRequired(requestJson, "categoryname,categoryid");
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		params.put("type","update");
		return goodsService.aud_goods_category(params);
	}

	/**
	 * 删除商品分类
	 */
	@RequiresPermissions("category:delete")
	@PostMapping("/deleteCategory")
	public JSONObject deleteCategory(@RequestBody JSONObject requestJson) {
		CommonUtil.hasAllRequired(requestJson, "categoryid");
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		params.put("type","delete");
		return goodsService.aud_goods_category(params);
	}


	/**
	 * 查询商品spu列表
	 */
	@RequiresPermissions("spu:list")
	@PostMapping("/listSpu")
	public JSONObject listSpu(@RequestBody JSONObject requestJson) {
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		return goodsService.s_goods_spu_list(params);
	}


	/**
	 * 添加商品spu
	 */
	@RequiresPermissions("spu:add")
	@PostMapping("/addSpu")
	public JSONObject addSpu(@RequestBody JSONObject requestJson) {
		CommonUtil.hasAllRequired(requestJson, "categoryid,forthemeimg,spuimg,spuprice,rootcategoryid,spusubtitle,sputitle,bannerimgs,spudetails,specsjson");
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		params.put("type","add");
		return goodsService.aud_goods_spu(params);
	}

	/**
	 * 修改商品spu
	 */
	@RequiresPermissions("spu:update")
	@PostMapping("/updateSpu")
	public JSONObject updateSpu(@RequestBody JSONObject requestJson) {
		CommonUtil.hasAllRequired(requestJson, "spuid,categoryid,forthemeimg,spuimg,spuprice,rootcategoryid,spusubtitle,sputitle,bannerimgs,spudetails,specsjson");
		Map<String, Object> params = JSONObject.parseObject(requestJson.toJSONString(), new TypeReference<Map<String, Object>>(){});
		params.put("type","update");
		return goodsService.aud_goods_spu(params);
	}


	/**
	 * 查询商品分类添加商品选择用
	 */
	@GetMapping("/selectListCategory")
	public JSONObject selectListCategory() {
		Map<String, Object> params =new HashMap<>();
		return goodsService.selectListCategory(params);
	}


	/**
	 * 查询所有规格名，商品添加使用
	 */
	@GetMapping("/selectListSpecsName")
	public JSONObject selectListSpecsName() {
		Map<String, Object> params =new HashMap<>();
		return goodsService.s_getSelectSpecsNameList();
	}


}
