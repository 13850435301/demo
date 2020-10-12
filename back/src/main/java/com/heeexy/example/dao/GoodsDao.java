package com.heeexy.example.dao;

import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * @author: hxy
 * @description: 商品Dao层
 *
 */
@Component
public interface GoodsDao {


	/**
	 * 商品规格名列表
	 */
	List<JSONObject> s_specs_name_list(Map map);

	/**
	 * 操作商品规格名列表-
	 */
	JSONObject aud_specs_name(Map map);


	/**
	 * 商品规格值列表
	 */
	List<JSONObject> s_specs_value_list(Map map);

	/**
	 * 操作商品规格值列表-
	 */
	JSONObject aud_specs_value(Map map);

	/**
	 * 商品分类列表
	 */
	List<JSONObject> goods_category_list(Map map);

	/**
	 * 操作商品分类列表-
	 */
	JSONObject aud_goods_category(Map map);


	/**
	 * 查询商品spu列表
	 */
	List<JSONObject> s_goods_spu_list(Map map);

	/**
	 * 操作商品spu列表-
	 */
	JSONObject aud_goods_spu(Map map);


	/**
	 * 查询所有规格名，商品添加使用
	 */
	List<JSONObject> s_getSelectSpecsNameList();

}
