package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.GoodsDao;
import com.heeexy.example.service.GoodsService;
import com.heeexy.example.util.CommonUtil;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author: hxy
 * @date: 2017/10/24 16:07
 */
@Service
public class GoodsServiceImpl implements GoodsService {

	@Autowired
	private GoodsDao goodsDao;



	/**
	 * 文章列表
	 */
	@Override
	public JSONObject s_specs_name_list(Map map) {
		List<JSONObject> list = goodsDao.s_specs_name_list(map);
		return CommonUtil.successPage( list);
	}

	@Override
	public JSONObject aud_specs_name(Map map) {
		JSONObject jb = goodsDao.aud_specs_name(map);
		return CommonUtil.successJson(jb);
	}

	@Override
	public JSONObject s_specs_value_list(Map map) {
		List<JSONObject> list = goodsDao.s_specs_value_list(map);
		return CommonUtil.successPage( list);
	}

	@Override
	public JSONObject aud_specs_value(Map map) {
		JSONObject jb = goodsDao.aud_specs_value(map);
		return CommonUtil.successJson(jb);
	}

	@Override
	public JSONObject goods_category_list(Map map) {
		List<JSONObject> list = goodsDao.goods_category_list(map);
		return CommonUtil.successPage( list);
	}

	@Override
	public JSONObject aud_goods_category(Map map) {
		JSONObject jb = goodsDao.aud_goods_category(map);
		return CommonUtil.successJson(jb);
	}

	@Override
	public JSONObject s_goods_spu_list(Map map) {
		List<JSONObject> list = goodsDao.s_goods_spu_list(map);
		return CommonUtil.successPage( list);
	}

	@Override
	public JSONObject aud_goods_spu(Map map) {
		JSONObject jb = goodsDao.aud_goods_spu(map);
		return CommonUtil.successJson(jb);
	}

	@Override
	public JSONObject selectListCategory(Map map) {
		map.put("isusables",1);
		map.put("isLimit",0);
		List<JSONObject> list = goodsDao.goods_category_list(map);
		if (CollectionUtils.isNotEmpty(list)){
			List<JSONObject> categoryList=new ArrayList<>();
			for (JSONObject jsonObject : list) {
				String isparent=jsonObject.getString("isparent");
				if ("1".equals(isparent)){
					JSONObject categoryJSONObject=new JSONObject();
					categoryJSONObject.put("value",jsonObject.getInteger("category_id"));
					categoryJSONObject.put("label",jsonObject.getString("category_name"));
					categoryList.add(categoryJSONObject);
				}
			}
			if (CollectionUtils.isNotEmpty(categoryList)){
				for (JSONObject jsonObject : categoryList) {
					int category_id=jsonObject.getInteger("value");
					List<JSONObject> sonCategoryList=new ArrayList<>();
					for (JSONObject fCategory : list) {
						String isparent=fCategory.getString("isparent");
						if ("0".equals(isparent)){
							int parent_id=fCategory.getInteger("parent_id");
							if (category_id==parent_id){
								JSONObject categoryJSONObject=new JSONObject();
								categoryJSONObject.put("value",fCategory.getInteger("category_id"));
								categoryJSONObject.put("label",fCategory.getString("category_name"));
								sonCategoryList.add(categoryJSONObject);
							}
						}
					}
					jsonObject.put("children",sonCategoryList);
				}
			}
			return CommonUtil.successPage( categoryList);
		}
		return CommonUtil.successPage( list);
	}

	@Override
	public JSONObject s_getSelectSpecsNameList() {
		List<JSONObject> list = goodsDao.s_getSelectSpecsNameList();
		return CommonUtil.successPage( list);
	}


}
