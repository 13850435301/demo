package com.heeexy.example.service;

import com.alibaba.fastjson.JSONObject;

import java.util.List;
import java.util.Map;

/**
 * @author: hxy
 * @date: 2017/10/24 16:06
 */
public interface GoodsService {


	/**
	 * 商品规格名列表
	 */
	JSONObject s_specs_name_list(Map map);


	/**
	 * 操作商品规格名列表-
	 */
	JSONObject aud_specs_name(Map map);


	/**
	 * 商品规格值列表
	 */
	JSONObject s_specs_value_list(Map map);


	/**
	 * 操作商品规格值列表-
	 */
	JSONObject aud_specs_value(Map map);


	/**
	 * 商品分类列表
	 */
	JSONObject goods_category_list(Map map);


	/**
	 * 操作商品分类列表-
	 */
	JSONObject aud_goods_category(Map map);


	/**
	 * 查询商品spu列表
	 */
	JSONObject s_goods_spu_list(Map map);

	/**
	 * 操作商品spu列表-
	 */
	JSONObject aud_goods_spu(Map map);

	/**
	 * 查询商品分类添加商品选择用
	 */
	JSONObject selectListCategory(Map map);

	/**
	 * 查询所有规格名，商品添加使用
	 *
	 *
	 */
	JSONObject s_getSelectSpecsNameList();



}
