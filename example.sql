/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80018
Source Host           : localhost:3306
Source Database       : example

Target Server Type    : MYSQL
Target Server Version : 80018
File Encoding         : 65001

Date: 2020-08-31 08:34:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT '' COMMENT '文章内容',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效  1.有效  2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='发布号作者表';

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('5', '莎士比亚', '2017-10-25 09:08:45', '2017-10-30 17:59:41', '1');
INSERT INTO `article` VALUES ('6', '亚里士多德', '2017-10-26 10:49:28', '2017-11-18 09:54:15', '1');
INSERT INTO `article` VALUES ('10', '亚历山大', '2017-10-26 14:57:45', '2017-11-08 13:28:52', '1');
INSERT INTO `article` VALUES ('11', '李白', '2017-10-26 15:23:42', '2017-10-26 15:23:42', '1');
INSERT INTO `article` VALUES ('19', '文章test2', '2017-11-18 13:37:07', '2017-11-18 13:37:11', '1');

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类名称',
  `category_img` varchar(255) DEFAULT NULL COMMENT '分类图片',
  `category_describe` varchar(255) DEFAULT NULL COMMENT '分类描述',
  `isusable` bit(1) DEFAULT b'1' COMMENT '是否可用（1可用0不可用）',
  `isparent` bit(1) DEFAULT b'0' COMMENT '是否是父级分类（1是0不是）',
  `parent_id` int(11) DEFAULT NULL COMMENT '父级分类id',
  `add_time` datetime DEFAULT NULL COMMENT '创建时间',
  `add_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods_category
-- ----------------------------
INSERT INTO `goods_category` VALUES ('4', '服装01', 'http://192.168.254.131:80/group1/M00/00/00/wKj-g19DHCGAK91fAAACErsrbNc170.png', '服装', '', '', null, '2020-08-21 16:16:46', 'admin', '2020-08-24 09:47:16', 'admin');
INSERT INTO `goods_category` VALUES ('5', '鞋', 'http://192.168.254.131:80/group1/M00/00/00/wKj-g18_kMGAf5FXAAACGyD7hd0253.png', '鞋', '', '', null, '2020-08-21 16:47:39', 'admin', '2020-08-24 13:58:16', 'admin');
INSERT INTO `goods_category` VALUES ('6', '凉鞋', 'http://192.168.254.131:80/group1/M00/00/00/wKj-g18_kMGAf5FXAAACGyD7hd0253.png', '凉鞋', '', '\0', '5', '2020-08-24 11:14:25', 'admin', '2020-08-24 14:15:57', 'admin');
INSERT INTO `goods_category` VALUES ('8', '运动鞋', 'http://192.168.254.131:80/group1/M00/00/00/wKj-g19DXrSAaj06AAAFPCjBCZ4580.png', '运动鞋', '', '\0', '5', '2020-08-24 14:31:33', 'admin', null, null);

-- ----------------------------
-- Table structure for goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `goods_sku`;
CREATE TABLE `goods_sku` (
  `sku_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'sku id',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `price` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `discount_price` decimal(18,2) DEFAULT '0.00' COMMENT '折扣价格',
  `img` varchar(255) DEFAULT NULL COMMENT '图片',
  `online` bit(1) DEFAULT b'1' COMMENT '是否上架（1上架 0下架）',
  `spu_id` int(11) NOT NULL COMMENT 'spu id',
  `stock` int(255) DEFAULT '0' COMMENT '库存',
  `stock_warn` int(255) DEFAULT '0' COMMENT '库存警告',
  `code` varchar(255) DEFAULT NULL COMMENT '编码',
  `specs` text COMMENT '规格',
  `add_time` datetime DEFAULT NULL COMMENT '创建时间',
  `add_user` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods_sku
-- ----------------------------

-- ----------------------------
-- Table structure for goods_spu
-- ----------------------------
DROP TABLE IF EXISTS `goods_spu`;
CREATE TABLE `goods_spu` (
  `spu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'spu id',
  `category_id` int(11) DEFAULT NULL COMMENT '分类id',
  `discount_price` decimal(18,2) DEFAULT NULL COMMENT '折扣价格',
  `for_theme_img` varchar(255) DEFAULT NULL COMMENT '主题图（首页轮播展示用）',
  `img` varchar(255) DEFAULT NULL COMMENT '图片（列表展示用）',
  `online` bit(1) DEFAULT b'1' COMMENT '是否上架（1上架，0下架）',
  `price` decimal(18,2) DEFAULT NULL COMMENT '价格',
  `root_category_id` int(11) DEFAULT NULL COMMENT '子分类id',
  `sketch_spec_id` int(11) DEFAULT NULL COMMENT '可是规格id',
  `sketch_spec_name` varchar(50) DEFAULT NULL COMMENT '可是规格名称',
  `subtitle` varchar(255) DEFAULT NULL COMMENT '副标题',
  `tags` varchar(255) DEFAULT NULL COMMENT '标签',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `banner_imgs` varchar(1000) DEFAULT NULL COMMENT '轮播图',
  `details` text COMMENT '详情',
  `add_time` datetime DEFAULT NULL COMMENT '创建时间',
  `add_user` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人',
  `specs_json` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '规格数组',
  PRIMARY KEY (`spu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods_spu
-- ----------------------------

-- ----------------------------
-- Table structure for specs_name
-- ----------------------------
DROP TABLE IF EXISTS `specs_name`;
CREATE TABLE `specs_name` (
  `specs_name_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '规格名id',
  `specs_name` varchar(100) NOT NULL COMMENT '规格名称',
  `specs_description` varchar(255) DEFAULT NULL COMMENT '规格描述',
  `specs_standard` bit(1) DEFAULT b'0' COMMENT '是否标准（1是0不是）',
  `specs_unit` varchar(50) DEFAULT NULL COMMENT '单位',
  `add_time` datetime DEFAULT NULL COMMENT '创建时间',
  `add_user` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`specs_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of specs_name
-- ----------------------------
INSERT INTO `specs_name` VALUES ('3', '颜色01', '颜色01', '', null, '2020-08-16 15:00:07', 'admin', '2020-08-17 16:05:55', 'admin');
INSERT INTO `specs_name` VALUES ('4', '尺码', '尺码', '', '米', '2020-08-16 15:20:33', 'admin', null, null);
INSERT INTO `specs_name` VALUES ('5', '尺寸01', '尺寸01', '', '毫米', '2020-08-16 15:59:43', 'admin', '2020-08-16 21:02:12', 'admin');
INSERT INTO `specs_name` VALUES ('6', '内存', '内存', '', 'g', '2020-08-16 16:10:47', 'admin', null, null);
INSERT INTO `specs_name` VALUES ('7', '长度02', '长度02', '', '毫米', '2020-08-17 09:02:23', 'admin', '2020-08-17 16:05:40', 'admin');

-- ----------------------------
-- Table structure for specs_value
-- ----------------------------
DROP TABLE IF EXISTS `specs_value`;
CREATE TABLE `specs_value` (
  `specs_value_id` int(255) NOT NULL AUTO_INCREMENT COMMENT '规格值id',
  `specs_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '规格值',
  `specs_name_id` int(11) DEFAULT NULL,
  `specs_extend` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '扩展',
  `add_time` datetime DEFAULT NULL COMMENT '创建时间',
  `add_user` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`specs_value_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of specs_value
-- ----------------------------
INSERT INTO `specs_value` VALUES ('2', '黄色01', '3', '黄色01', '2020-08-17 15:55:45', 'admin', '2020-08-17 16:13:32', 'admin');
INSERT INTO `specs_value` VALUES ('4', '100x20', '7', '100x20', '2020-08-17 16:15:52', 'admin', null, null);
INSERT INTO `specs_value` VALUES ('5', '白色f', '3', '白色f', '2020-08-17 16:59:00', 'admin', '2020-08-17 16:59:38', 'admin');
INSERT INTO `specs_value` VALUES ('6', '绿色', '3', '绿色', '2020-08-17 16:59:25', 'admin', null, null);

-- ----------------------------
-- Table structure for sys_array
-- ----------------------------
DROP TABLE IF EXISTS `sys_array`;
CREATE TABLE `sys_array` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `array` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_array
-- ----------------------------
INSERT INTO `sys_array` VALUES ('2', '4,5,6');

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '自定id,主要供前端展示权限列表分类排序使用.',
  `menu_code` varchar(255) DEFAULT '' COMMENT '归属菜单,前端判断并展示菜单使用,',
  `menu_name` varchar(255) DEFAULT '' COMMENT '菜单的中文释义',
  `permission_code` varchar(255) DEFAULT '' COMMENT '权限的代码/通配符,对应代码中@RequiresPermissions 的value',
  `permission_name` varchar(255) DEFAULT '' COMMENT '本权限的中文释义',
  `required_permission` tinyint(1) DEFAULT '2' COMMENT '是否本菜单必选权限, 1.必选 2非必选 通常是"列表"权限是必选',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('101', 'article', '文章管理', 'article:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('102', 'article', '文章管理', 'article:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('103', 'article', '文章管理', 'article:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('201', 'specsname', '规格名管理', 'specsname:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('202', 'specsname', '规格名管理', 'specsname:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('203', 'specsname', '规格名管理', 'specsname:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('204', 'specsvalue', '规格值管理', 'specsvalue:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('205', 'specsvalue', '规格值管理', 'specsvalue:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('206', 'specsvalue', '规格值管理', 'specsvalue:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('207', 'specsvalue', '规格值管理', 'specsvalue:delete', '删除', '2');
INSERT INTO `sys_permission` VALUES ('208', 'category', '分类管理', 'category:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('209', 'category', '分类管理', 'category:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('210', 'category', '分类管理', 'category:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('211', 'category', '分类管理', 'category:delete', '删除', '2');
INSERT INTO `sys_permission` VALUES ('212', 'spu', 'spu管理', 'spu:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('213', 'spu', 'spu管理', 'spu:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('214', 'spu', 'spu管理', 'spu:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('601', 'user', '用户', 'user:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('602', 'user', '用户', 'user:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('603', 'user', '用户', 'user:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('701', 'role', '角色权限', 'role:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('702', 'role', '角色权限', 'role:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('703', 'role', '角色权限', 'role:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('704', 'role', '角色权限', 'role:delete', '删除', '2');
INSERT INTO `sys_permission` VALUES ('801', 'file', '文件上传', 'file:upload', '上传', '1');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) DEFAULT NULL COMMENT '角色名',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效  1有效  2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '管理员', '2017-11-22 16:24:34', '2017-11-22 16:24:52', '1');
INSERT INTO `sys_role` VALUES ('2', '作家', '2017-11-22 16:24:34', '2017-11-22 16:24:52', '1');
INSERT INTO `sys_role` VALUES ('3', '程序员', '2017-11-22 16:28:47', '2017-11-22 16:28:47', '1');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '角色id',
  `permission_id` int(11) DEFAULT NULL COMMENT '权限id',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效 1有效     2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='角色-权限关联表';

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('1', '2', '101', '2017-11-22 16:26:21', '2017-11-22 16:26:32', '1');
INSERT INTO `sys_role_permission` VALUES ('2', '2', '102', '2017-11-22 16:26:21', '2017-11-22 16:26:32', '1');
INSERT INTO `sys_role_permission` VALUES ('5', '2', '602', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `sys_role_permission` VALUES ('6', '2', '601', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `sys_role_permission` VALUES ('7', '2', '603', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `sys_role_permission` VALUES ('8', '2', '703', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `sys_role_permission` VALUES ('9', '2', '701', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `sys_role_permission` VALUES ('10', '2', '702', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `sys_role_permission` VALUES ('11', '2', '704', '2017-11-22 16:28:31', '2017-11-22 16:28:31', '1');
INSERT INTO `sys_role_permission` VALUES ('12', '2', '103', '2017-11-22 16:28:31', '2017-11-22 16:28:31', '1');
INSERT INTO `sys_role_permission` VALUES ('13', '3', '601', '2017-11-22 16:28:47', '2017-11-22 16:28:47', '1');
INSERT INTO `sys_role_permission` VALUES ('14', '3', '701', '2017-11-22 16:28:47', '2017-11-22 16:28:47', '1');
INSERT INTO `sys_role_permission` VALUES ('15', '3', '702', '2017-11-22 16:35:01', '2017-11-22 16:35:01', '1');
INSERT INTO `sys_role_permission` VALUES ('16', '3', '704', '2017-11-22 16:35:01', '2017-11-22 16:35:01', '1');
INSERT INTO `sys_role_permission` VALUES ('17', '3', '102', '2017-11-22 16:35:01', '2020-08-18 13:38:50', '2');
INSERT INTO `sys_role_permission` VALUES ('18', '3', '101', '2017-11-22 16:35:01', '2020-08-18 13:38:50', '2');
INSERT INTO `sys_role_permission` VALUES ('19', '3', '603', '2017-11-22 16:35:01', '2017-11-22 16:35:01', '1');
INSERT INTO `sys_role_permission` VALUES ('20', '3', '201', '2020-08-18 13:36:14', '2020-08-18 13:36:14', '1');
INSERT INTO `sys_role_permission` VALUES ('21', '3', '204', '2020-08-18 13:36:14', '2020-08-18 13:36:14', '1');
INSERT INTO `sys_role_permission` VALUES ('22', '3', '202', '2020-08-18 14:49:24', '2020-08-18 14:49:24', '1');
INSERT INTO `sys_role_permission` VALUES ('23', '3', '203', '2020-08-18 14:50:09', '2020-08-18 14:50:09', '1');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `role_id` int(11) DEFAULT '0' COMMENT '角色ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效  1有效  2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10008 DEFAULT CHARSET=utf8 COMMENT='运营后台用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('10003', 'admin', '0dd80a766592f28edddc716cf23ac35f', '超级用户23', '1', '2017-10-30 11:52:38', '2020-08-16 11:04:15', '1');
INSERT INTO `sys_user` VALUES ('10004', 'user', '0dd80a766592f28edddc716cf23ac35f', '莎士比亚', '2', '2017-10-30 16:13:02', '2020-08-16 11:04:17', '1');
INSERT INTO `sys_user` VALUES ('10005', 'aaa', '0dd80a766592f28edddc716cf23ac35f', 'abba', '1', '2017-11-15 14:02:56', '2020-08-16 11:04:19', '1');
INSERT INTO `sys_user` VALUES ('10007', 'test', '0dd80a766592f28edddc716cf23ac35f', '就看看列表', '3', '2017-11-22 16:29:41', '2020-08-16 11:04:21', '1');

-- ----------------------------
-- Procedure structure for aud_goods_category
-- ----------------------------
DROP PROCEDURE IF EXISTS `aud_goods_category`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aud_goods_category`(IN `categoryid` int,IN `categoryname` varchar(100),IN `categoryimg` varchar(500),IN `categorydescribe` varchar(200),IN `isusables` bit,IN `isparents` bit,IN `parentid` int,IN `type` enum('add','update','delete'))
label:BEGIN
	#商品分类添加、修改、删除
	DECLARE t_error INTEGER DEFAULT 1;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @v_sqlstate=RETURNED_SQLSTATE,@v_message= MESSAGE_TEXT; 
		SET t_error = 0;
	END;

	#添加
	IF (type = 'add') THEN
	if ( exists(SELECT 1 FROM goods_category WHERE ifnull(`category_name`,"")=categoryname )) then 
		SELECT 0 as state,'该分类名称已经存在!' as message;
		LEAVE label;
	end if;
	START TRANSACTION;
	INSERT INTO `goods_category` (
	`category_name`,
	`category_img`,
	`category_describe`,
	`isusable`,
	`isparent`,
	`parent_id`,
	`add_time`,
	`add_user`
	)
	VALUES
	(
	`categoryname`,
	`categoryimg`,
	`categorydescribe`,
	ifnull(isusables,1),
	`isparents`,
	`parentid`,
		NOW(),
	'admin'
	);
	IF t_error = 0 THEN
		ROLLBACK;
		SELECT t_error AS state ,@v_message AS message;
  ELSE
		COMMIT;
		SELECT t_error AS state ,'添加成功!' AS message;
		END IF;
  END IF;

#修改
	IF (type = 'update') THEN
	if ( exists(SELECT 1 FROM goods_category WHERE ifnull(`category_name`,"")=`categoryname` and `category_id`<>categoryid )) then 
		SELECT 0 as state,'该分类名称已经存在!' as message;
		LEAVE label;
	end if;
	START TRANSACTION;
	
	UPDATE `goods_category`
	SET 
 `category_name` = ifnull(categoryname,`category_name`),
 `category_img` = ifnull(categoryimg,`category_img`),
 `category_describe` = ifnull(categorydescribe,`category_describe`),
 `isusable` = ifnull(isusables,`isusable`),
 `parent_id` =ifnull(parentid,`parent_id`),
 `update_time` = NOW(),
 `update_user` = 'admin'
	WHERE
	(`category_id` = `categoryid`);

	IF t_error = 0 THEN
		ROLLBACK;
		SELECT t_error AS state ,@v_message AS message;
  ELSE
		COMMIT;
		SELECT t_error AS state ,'修改成功!' AS message;
		END IF;
  END IF;


#删除
	IF (type = 'delete') THEN
	START TRANSACTION;
	DELETE FROM `goods_category`
	WHERE
	(`category_id` = `categoryid`);

	IF t_error = 0 THEN
		ROLLBACK;
		SELECT t_error AS state ,@v_message AS message;
  ELSE
		COMMIT;
		SELECT t_error AS state ,'删除成功!' AS message;
		END IF;
  END IF;



END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for aud_goods_spu
-- ----------------------------
DROP PROCEDURE IF EXISTS `aud_goods_spu`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aud_goods_spu`(`spuid` int, IN `categoryid` INT, IN `discountprice` DECIMAL (18, 2), IN `forthemeimg` VARCHAR (255), IN `spuimg` VARCHAR (255), IN `spuonline` bit, IN `spuprice` DECIMAL (18, 2), IN `rootcategoryid` INT, IN `sketchspecid` INT, IN `sketchspecname` VARCHAR (50), IN `spusubtitle` VARCHAR (255), IN `sputags` VARCHAR (255), IN `sputitle` VARCHAR (255), IN `bannerimgs` VARCHAR (1000), IN `spudetails` text, IN `specsjson` text, IN `type` enum ('add', 'update'))
label:BEGIN
	#spu添加、修改
	DECLARE t_error INTEGER DEFAULT 1;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @v_sqlstate=RETURNED_SQLSTATE,@v_message= MESSAGE_TEXT; 
		SET t_error = 0;
	END;

  if (ifnull(spuprice,0)<=0) THEN
		SELECT 0 as state,'价格不能小于等于0!' as message;
		LEAVE label;
  end if;

	#添加
	IF (type = 'add') THEN
	if ( exists(SELECT 1 FROM goods_spu WHERE ifnull(`title`,"")=sputitle)) then 
		SELECT 0 as state,'该标题已经存在!' as message;
		LEAVE label;
	end if;
	START TRANSACTION;
	INSERT INTO `goods_spu` (
	`category_id`,
	`discount_price`,
	`for_theme_img`,
	`img`,
	`online`,
	`price`,
	`root_category_id`,
	`sketch_spec_id`,
	`sketch_spec_name`,
	`subtitle`,
	`tags`,
	`title`,
	`banner_imgs`,
	`details`,
	`add_time`,
	`add_user`,
	`specs_json`
	)
	VALUES
	(
	`categoryid`,
	`discountprice`,
	`forthemeimg`,
	`spuimg`,
	`spuonline`,
	`spuprice`,
	`rootcategoryid`,
	`sketchspecid`,
	`sketchspecname`,
	`spusubtitle`,
	`sputags`,
	`sputitle`,
	`bannerimgs`,
	`spudetails`,
	NOW(),
	'admin',
	`specsjson`
	);
	IF t_error = 0 THEN
		ROLLBACK;
		SELECT t_error AS state ,@v_message AS message;
  ELSE
		COMMIT;
		SELECT t_error AS state ,'添加成功!' AS message;
		END IF;
  END IF;

#修改
	IF (type = 'update') THEN
	if ( exists(SELECT 1 FROM goods_spu WHERE ifnull(`title`,"")=sputitle and `spu_id`<> `spuid`)) then 
		SELECT 0 as state,'该标题已经存在!' as message;
		LEAVE label;
	end if;
	START TRANSACTION;
	UPDATE `goods_spu`
	SET 
	`category_id` = ifnull(categoryid,`category_id`),
	`discount_price` = ifnull(discountprice,`discount_price`),
	`for_theme_img` = ifnull(forthemeimg,`for_theme_img`),
	`img` = ifnull(spuimg,`img`),
	`online` = ifnull(spuonline,`online`),
	`price` = ifnull(spuprice,`price`),
	`root_category_id` = ifnull(rootcategoryid,`root_category_id`),
	`sketch_spec_id` = ifnull(sketchspecid,`sketch_spec_id`),
	`sketch_spec_name` = ifnull(sketchspecname,`sketch_spec_name`),
	`subtitle` = ifnull(spusubtitle,`subtitle`),
	`tags` = ifnull(sputags,`tags`),
	`title` = ifnull(sputitle,`title`),
	`banner_imgs` = ifnull(bannerimgs,`banner_imgs`),
	`details` = ifnull(spudetails,`details`),
	`update_time` = NOW(),
	`update_user` = 'admin',
	`specs_array` = ifnull(specsarray,`specs_array`)
	WHERE
	(`spu_id` = spuid);

	IF t_error = 0 THEN
		ROLLBACK;
		SELECT t_error AS state ,@v_message AS message;
  ELSE
		COMMIT;
		SELECT t_error AS state ,'修改成功!' AS message;
		END IF;
  END IF;



END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for aud_specs_name
-- ----------------------------
DROP PROCEDURE IF EXISTS `aud_specs_name`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aud_specs_name`(IN `specsNameId` INT, IN `specsname` VARCHAR (100), IN `specsdescription` VARCHAR (255), IN `specsstandard` bit, IN `specsunit` VARCHAR (50), IN `type` enum ('add', 'update'))
label:BEGIN
	#规格名添加、修改
	DECLARE t_error INTEGER DEFAULT 1;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @v_sqlstate=RETURNED_SQLSTATE,@v_message= MESSAGE_TEXT; 
		SET t_error = 0;
	END;

	#添加
	IF (type = 'add') THEN
	if ( exists(SELECT 1 FROM specs_name WHERE ifnull(`specs_name`,"")=specsname)) then 
	SELECT 0 as state,'该规格名称已经存在!' as message;
	LEAVE label;
	end if;
		START TRANSACTION;
		INSERT INTO `specs_name` (
		`specs_name`,
		`specs_description`,
		`specs_standard`,
		`specs_unit`,
		`add_time`,
		`add_user`
		)
		VALUES
		(
		`specsname`,
		`specsdescription`,
		`specsstandard`,
		`specsunit`,
		NOW(),
		'admin' 
		);

	IF t_error = 0 THEN
		ROLLBACK;
		SELECT t_error AS state ,@v_message AS message;
  ELSE
		COMMIT;
		SELECT t_error AS state ,'添加成功!' AS message;
		END IF;
  END IF;

#修改
	IF (type = 'update') THEN
		if ( exists(SELECT 1 FROM specs_name WHERE ifnull(`specs_name`,"")=`specsname` and `specs_name_id`<> `specsNameId`)) then 
		SELECT 0 as state,'该规格名称已经存在!' as message;
		LEAVE label;
	end if;
	START TRANSACTION;
	UPDATE `specs_name`
	SET 
	`specs_name` = ifnull(specsname,`specs_name`),
	`specs_description` = ifnull(specsdescription,`specs_description`),
	`specs_standard` = ifnull(specsstandard,`specs_standard`),
	`specs_unit` = ifnull(specsunit,`specs_unit`),
	`update_time` = NOW(),
	`update_user` = 'admin' 
	WHERE
	(`specs_name_id` =`specsNameId`);

	IF t_error = 0 THEN
		ROLLBACK;
		SELECT t_error AS state ,@v_message AS message;
  ELSE
		COMMIT;
		SELECT t_error AS state ,'修改成功!' AS message;
		END IF;
  END IF;



END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for aud_specs_value
-- ----------------------------
DROP PROCEDURE IF EXISTS `aud_specs_value`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aud_specs_value`(IN `specsvalueid` INT, IN `specsvalue` VARCHAR (100), IN `specsextend` VARCHAR (255), IN `specsnameid` INT,IN `type` enum ('add', 'update','delete'))
label:BEGIN
	#规格值添加、修改
	DECLARE t_error INTEGER DEFAULT 1;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @v_sqlstate=RETURNED_SQLSTATE,@v_message= MESSAGE_TEXT; 
		SET t_error = 0;
	END;

	#添加
	IF (type = 'add') THEN
	if ( exists(SELECT 1 FROM specs_value WHERE ifnull(`specs_value`,"")=specsvalue and `specs_name_id`=`specsnameid`)) then 
		SELECT 0 as state,'该规格值已经存在!' as message;
		LEAVE label;
	end if;
	START TRANSACTION;
	INSERT INTO `specs_value` (
	`specs_value`,
	`specs_name_id`,
	`specs_extend`,
	`add_time`,
	`add_user`
	)
	VALUES
	(
	`specsvalue`,
	`specsnameid`,
	`specsextend`,
	NOW(),
	'admin'
	);
	IF t_error = 0 THEN
		ROLLBACK;
		SELECT t_error AS state ,@v_message AS message;
  ELSE
		COMMIT;
		SELECT t_error AS state ,'添加成功!' AS message;
		END IF;
  END IF;

#修改
	IF (type = 'update') THEN
	if ( exists(SELECT 1 FROM specs_value WHERE ifnull(`specs_value`,"")=`specsvalue` and `specs_value_id`<> `specsvalueid` and `specs_name_id`=`specsnameid`)) then 
		SELECT 0 as state,'该规格值已经存在!' as message;
		LEAVE label;
	end if;
	START TRANSACTION;
	UPDATE `specs_value`
	SET 
 `specs_value` = ifnull(specsvalue,`specs_value`),
 `specs_extend` = ifnull(specsextend,`specs_extend`),
 `update_time` = NOW(),
 `update_user` = 'admin'
	WHERE
	(`specs_value_id` = `specsvalueid`);

	IF t_error = 0 THEN
		ROLLBACK;
		SELECT t_error AS state ,@v_message AS message;
  ELSE
		COMMIT;
		SELECT t_error AS state ,'修改成功!' AS message;
		END IF;
  END IF;


#删除
	IF (type = 'delete') THEN
	START TRANSACTION;
	DELETE FROM `specs_value`
	WHERE
	(`specs_value_id` = `specsvalueid`);

	IF t_error = 0 THEN
		ROLLBACK;
		SELECT t_error AS state ,@v_message AS message;
  ELSE
		COMMIT;
		SELECT t_error AS state ,'修改成功!' AS message;
		END IF;
  END IF;



END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for goods_category_list
-- ----------------------------
DROP PROCEDURE IF EXISTS `goods_category_list`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `goods_category_list`(IN `pageNum` int,IN `pageRow` int,IN `categoryid` int,IN `keyword` varchar(100),IN `isusables` bit,IN `isparents` bit,IN `parentid` int,`isLimit` bit)
BEGIN
	#查询商品分类列表

	#查询条件拼装
	set @wheresql=concat(' where 1=1 ');
	if (ifnull(keyword,null) is not null)THEN
		set @wheresql=concat(@wheresql,' and (category_name like  ',"'%",keyword,"%' ", 'or category_img like ',"'%",keyword,"%'",'or category_describe like ',"'%",keyword,"%'",') ');
	end if;

	if (ifnull(`categoryid`,0)>0)THEN
		set @wheresql=concat(@wheresql,'  and `category_id` =',categoryid);
	end if;

	if ifnull(`isusables`,-1)in(0,1) THEN
		set @wheresql=concat(@wheresql,' and  ifnull(`isusable`,1) =',ifnull(`isusables`,-1));
	end if;
 
if ifnull(`isparents`,-1) in(0,1) THEN
		set @wheresql=concat(@wheresql,' and ifnull(`isparent`,0) =',ifnull(`isparents`,-1));
	end if;

	if (ifnull(`parentid`,0)>0)THEN
		set @wheresql=concat(@wheresql,' and `parent_id` =',parentid);
	end if;

  
  #查询总条数
	set @sumsql=concat('select count(`category_id`) INTO @count from `goods_category` ',@wheresql); 
	prepare sumsql from @sumsql;            
	execute sumsql;			           
	deallocate prepare sumsql; 
	
	if (ifnull(`isLimit`,1)=1)then
  #执行分页查询
	set @executesql=concat('select `category_id`,fu_getFatherCategoryName(`isparent`,`parent_id`,`category_id`,1) as fatherCategoryName, `category_name`, `category_img`, `category_describe`,  ifnull(isusable,1) as isusable, ifnull(isparent,0) as isparent, `parent_id`, DATE_FORMAT(`add_time`,"%Y-%m-%d %H:%i:%s") AS add_time, `add_user`,DATE_FORMAT(`update_time`,"%Y-%m-%d %H:%i:%s") AS update_time, `update_user`',",",ifnull(@count,0),' as',"`",'count',"`",'  
	from `goods_category` ',@wheresql,'  ORDER BY `category_id` asc  limit ',(pageNum-1)*pageRow,',',pageRow,';');

	prepare executesql from @executesql;            

	execute executesql;			
           
	deallocate prepare executesql; 
  ELSE
	set @executesql=concat('select `category_id`,fu_getFatherCategoryName(ifnull(`isparent`,0),`parent_id`,`category_id`,1) as fatherCategoryName, `category_name`, `category_img`, `category_describe`,ifnull(isusable,1) as isusable, ifnull(isparent,0) as isparent, `parent_id`, DATE_FORMAT(`add_time`,"%Y-%m-%d %H:%i:%s") AS add_time, `add_user`, DATE_FORMAT(`update_time`,"%Y-%m-%d %H:%i:%s") AS update_time, `update_user`',",",ifnull(@count,0),' as',"`",'count',"`",'  
	from `goods_category` ',@wheresql,'  ORDER BY `category_id` asc;');

	prepare executesql from @executesql;            

	execute executesql;			
           
	deallocate prepare executesql; 
  end if;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for s_getCategoryName
-- ----------------------------
DROP PROCEDURE IF EXISTS `s_getCategoryName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_getCategoryName`(IN `id` int,OUT `categoryName` varchar(100))
BEGIN
	#Routine body goes here...
	set `categoryName`=(SELECT category_name FROM goods_category WHERE `category_id`=`id`);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for s_getSelectSpecsNameList
-- ----------------------------
DROP PROCEDURE IF EXISTS `s_getSelectSpecsNameList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_getSelectSpecsNameList`()
BEGIN
	#查询所有规格名，商品添加使用
  SELECT specs_name_id as value,specs_name as label FROM specs_name;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for s_goods_spu_list
-- ----------------------------
DROP PROCEDURE IF EXISTS `s_goods_spu_list`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_goods_spu_list`(IN `spuid` int,IN `categoryid` int,IN `keyword` varchar(50),IN `onlines` bit,IN `rootcategoryid` int,IN `pageNum` int,IN `pageRow` int,IN `isLimit` bit)
BEGIN
	#查询商品spu列表
	#查询条件拼装
	set @wheresql=concat(' where 1=1 ');
	if (ifnull(keyword,null) is not null)THEN
		set @wheresql=concat(@wheresql,'and (subtitle like  ',"'%",keyword,"%' ", 'or tags like ',"'%",keyword,"%'", 'or title like ',"'%",keyword,"%'",') ');
	end if;

	if (ifnull(`spuid`,0)>0)THEN
		set @wheresql=concat(@wheresql,'and `spu_id` =',spuid);
	end if;

	if (ifnull(`categoryid`,0)>0)THEN
		set @wheresql=concat(@wheresql,'and `category_id` =',categoryid);
	end if;

	if ifnull(`onlines`,-1)in(0,1) THEN
		set @wheresql=concat(@wheresql,' and  ifnull(`online`,1) =',ifnull(`onlines`,-1));
	end if;

	if (ifnull(`rootcategoryid`,0)>0)THEN
		set @wheresql=concat(@wheresql,'and `root_category_id` =',rootcategoryid);
	end if;

  #查询总条数
	set @sumsql=concat('select count(`spu_id`) INTO @count from `goods_spu` ',@wheresql); 
	prepare sumsql from @sumsql;            
	execute sumsql;			           
	deallocate prepare sumsql; 
	
	if (ifnull(`isLimit`,1)=1)then
  #执行分页查询
	set @executesql=concat('select `spu_id`, `category_id`,fu_getFatherCategoryName(null,`category_id`,`root_category_id`,2) as categoryName, `discount_price`, `for_theme_img`, `img`, ifnull(`online`,1) as online, `price`, `root_category_id`, `sketch_spec_id`, `sketch_spec_name`, `subtitle`, `tags`, `title`, `banner_imgs`, `details`, `specs_json`,fu_getSpecsName(`specs_json`) as specsname, DATE_FORMAT(`add_time`,"%Y-%m-%d %H:%i:%s") AS add_time, `add_user`,DATE_FORMAT(`update_time`,"%Y-%m-%d %H:%i:%s") AS update_time, `update_user`',",",ifnull(@count,0),' as',"`",'count',"`",'  
	from `goods_spu` ',@wheresql,'  ORDER BY `add_time` desc  limit ',(pageNum-1)*pageRow,',',pageRow,';');

	prepare executesql from @executesql;            

	execute executesql;			
           
	deallocate prepare executesql; 
  ELSE
	set @executesql=concat('select `spu_id`, `category_id`,fu_getFatherCategoryName(null,`category_id`,`root_category_id`,2) as categoryName, `discount_price`, `for_theme_img`, `img`,ifnull(`online`,1) as online, `price`, `root_category_id`, `sketch_spec_id`, `sketch_spec_name`, `subtitle`, `tags`, `title`, `banner_imgs`, `details`,`specs_json`,fu_getSpecsName(`specs_json`) as specsname, DATE_FORMAT(`add_time`,"%Y-%m-%d %H:%i:%s") AS add_time, `add_user`, DATE_FORMAT(`update_time`,"%Y-%m-%d %H:%i:%s") AS update_time, `update_user`',",",ifnull(@count,0),' as',"`",'count',"`",'  
	from `goods_spu` ',@wheresql,'  ORDER BY `add_time` desc;');

	prepare executesql from @executesql;            

	execute executesql;			
           
	deallocate prepare executesql; 
  end if;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for s_specs_name_list
-- ----------------------------
DROP PROCEDURE IF EXISTS `s_specs_name_list`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_specs_name_list`(IN `pageNum` int,IN `pageRow` int,IN `keyword` varchar(50),IN `specsnameid` int,in `isLimit` bit)
BEGIN
	#查询规格名列表

	#查询条件拼装
	set @wheresql=concat(' where 1=1 ');
	if (ifnull(keyword,null) is not null)THEN
		set @wheresql=concat(@wheresql,'and (specs_name like  ',"'%",keyword,"%' ", 'or specs_unit like ',"'%",keyword,"%'",') ');
	end if;

	if (ifnull(`specsnameid`,0)>0)THEN
		set @wheresql=concat(@wheresql,'and `specs_name_id` =',specsnameid);
	end if;

  
  #查询总条数
	set @sumsql=concat('select count(`specs_name_id`) INTO @count from `specs_name` ',@wheresql); 
	prepare sumsql from @sumsql;            
	execute sumsql;			           
	deallocate prepare sumsql; 
	
	if (ifnull(`isLimit`,1)=1)then
  #执行分页查询
	set @executesql=concat('select `specs_name_id`, `specs_name`, `specs_description`, ifnull(`specs_standard`,0) as specs_standard, `specs_unit`, DATE_FORMAT(`add_time`,"%Y-%m-%d %H:%i:%s") AS add_time, `add_user`,DATE_FORMAT(`update_time`,"%Y-%m-%d %H:%i:%s") AS update_time, `update_user`',",",ifnull(@count,0),' as',"`",'count',"`",'  
	from `specs_name` ',@wheresql,'  ORDER BY `add_time` desc  limit ',(pageNum-1)*pageRow,',',pageRow,';');

	prepare executesql from @executesql;            

	execute executesql;			
           
	deallocate prepare executesql; 
  ELSE
	set @executesql=concat('select `specs_name_id`, `specs_name`, `specs_description`, ifnull(`specs_standard`,0) as specs_standard, `specs_unit`, DATE_FORMAT(`add_time`,"%Y-%m-%d %H:%i:%s") AS add_time, `add_user`, DATE_FORMAT(`update_time`,"%Y-%m-%d %H:%i:%s") AS update_time, `update_user`',",",ifnull(@count,0),' as',"`",'count',"`",'  
	from `specs_name` ',@wheresql,'  ORDER BY `add_time` desc;');

	prepare executesql from @executesql;            

	execute executesql;			
           
	deallocate prepare executesql; 
  end if;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for s_specs_value_list
-- ----------------------------
DROP PROCEDURE IF EXISTS `s_specs_value_list`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_specs_value_list`(IN `pageNum` int,IN `pageRow` int,IN `keyword` varchar(50),IN `specsvalueid` int,in `specsnameid` int,in `isLimit` bit)
BEGIN
	#查询规格值列表

	#查询条件拼装
	set @wheresql=concat(' where 1=1 ');
	if (ifnull(keyword,null) is not null)THEN
		set @wheresql=concat(@wheresql,'and specs_value like  ',"'%",keyword,"%' " );
	end if;

	if (ifnull(`specsvalueid`,0)>0)THEN
		set @wheresql=concat(@wheresql,'and `specs_value_id` =',specsvalueid);
	end if;

	if (ifnull(`specsnameid`,0)>0)THEN
		set @wheresql=concat(@wheresql,'and `specs_name_id` =',specsnameid);
	end if;


  #查询总条数
	set @sumsql=concat('select count(`specs_value_id`) INTO @count from `specs_value` ',@wheresql); 
	prepare sumsql from @sumsql;            
	execute sumsql;			           
	deallocate prepare sumsql; 
	
	if (ifnull(`isLimit`,1)=1)then
  #执行分页查询
	set @executesql=concat('select `specs_value_id`, `specs_value`, `specs_name_id`, `specs_extend`,  `add_user`,DATE_FORMAT(`add_time`,"%Y-%m-%d %H:%i:%s") AS add_time, `add_user`,DATE_FORMAT(`update_time`,"%Y-%m-%d %H:%i:%s") AS update_time,  `update_user`',",",ifnull(@count,0),' as',"`",'count',"`",'  
	from `specs_value` ',@wheresql,'  ORDER BY `add_time` desc  limit ',(pageNum-1)*pageRow,',',pageRow,';');

	prepare executesql from @executesql;            

	execute executesql;			
           
	deallocate prepare executesql; 
  ELSE
	set @executesql=concat('select `specs_value_id`, `specs_value`, `specs_name_id`, `specs_extend`,  `add_user`,DATE_FORMAT(`add_time`,"%Y-%m-%d %H:%i:%s") AS add_time, `add_user`,DATE_FORMAT(`update_time`,"%Y-%m-%d %H:%i:%s") AS update_time,  `update_user`',",",ifnull(@count,0),' as',"`",'count',"`",'  
	from `specs_value` ',@wheresql,'  ORDER BY `add_time` desc;');

	prepare executesql from @executesql;            

	execute executesql;			
           
	deallocate prepare executesql; 

  end if;

END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for fu_getFatherCategoryName
-- ----------------------------
DROP FUNCTION IF EXISTS `fu_getFatherCategoryName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fu_getFatherCategoryName`(`isparent` bit,`parent_id` int,`categoryid` int,`type` int) RETURNS varchar(100) CHARSET utf8
BEGIN
	#查询父级分类名称
	declare fatherCategoryName varchar (100);
	if `type`=1 then
  IF ifnull(`isparent`,0)=0 THEN
		CALL s_getCategoryName(`parent_id`,@f);
		CALL s_getCategoryName(`categoryid`,@s);
		set fatherCategoryName=CONCAT(@f,'--->',@s);
  ELSE
		CALL s_getCategoryName(`categoryid`,@n);
    SET fatherCategoryName = @n;
  END IF;
  ELSEIF `type`=2 then
		CALL s_getCategoryName(`parent_id`,@f);
		CALL s_getCategoryName(`categoryid`,@s);
		set fatherCategoryName=CONCAT(@f,'--->',@s);
  end if;

	RETURN fatherCategoryName;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for fu_getSpecsName
-- ----------------------------
DROP FUNCTION IF EXISTS `fu_getSpecsName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fu_getSpecsName`(`specs_json` varchar(1000)) RETURNS varchar(500) CHARSET utf8
BEGIN
	#Routine body goes here...
	SELECT GROUP_CONCAT(specs_name SEPARATOR ',') into @specsname FROM specs_name WHERE FIND_IN_SET(specs_name_id,`specs_json`) > 0;
	RETURN @specsname;
END
;;
DELIMITER ;
