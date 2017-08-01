/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : tp5_layer_demo

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2017-07-27 14:11:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dx_tp5_admin
-- ----------------------------
DROP TABLE IF EXISTS `dx_tp5_admin`;
CREATE TABLE `dx_tp5_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `group_id` int(11) DEFAULT '0' COMMENT '用户组ID',
  `username` varchar(30) NOT NULL COMMENT '账号',
  `true_name` varchar(30) DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱号',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `status` tinyint(2) DEFAULT '1' COMMENT '账号状态：1-正常，2-禁用',
  `last_login_time` int(11) DEFAULT NULL COMMENT '最后一次登录时间',
  `ip` varchar(30) DEFAULT NULL COMMENT '当前IP',
  `area` varchar(50) DEFAULT NULL COMMENT 'IP区域',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `login_key` varchar(50) DEFAULT NULL COMMENT '登陆成功标记',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_tp5_admin_username` (`username`),
  UNIQUE KEY `uni_tp5_admin_email` (`email`),
  UNIQUE KEY `uni_tp5_admin_mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='新后台用户表';

-- ----------------------------
-- Records of dx_tp5_admin
-- ----------------------------
INSERT INTO `dx_tp5_admin` VALUES ('1', '0', 'sky001', null, '936957321@qq.com', null, 'MDAwMDAwMDAwMDU1NzQ4NTJiYjU2MTlmMjlza3kxMjM', '1', '1501135787', '127.0.0.1', '', '1500016980', '1501135787', '49c7f9319ba7d160820f7383423a0e4d');
INSERT INTO `dx_tp5_admin` VALUES ('2', '1', 'sky002', '', '', '15710615015', 'MDAwMDAwMDAwMDU1NzQ4NTJiYjU2MTlmMjlza3kxMjM', '1', '1500868496', '127.0.0.1', '', '1500020213', '1500868496', 'f21648acae0b433d7599d427661a9f06');
INSERT INTO `dx_tp5_admin` VALUES ('5', '2', 'sky003', null, null, null, 'MDAwMDAwMDAwMDU1NzQ4NTJiYjU2MTlmMjlza3kxMjM', '1', '1501118616', '127.0.0.1', '', '1500020398', '1501118617', '2dcb5a422104907aca6f5c279ce9b861');
INSERT INTO `dx_tp5_admin` VALUES ('6', '3', 'sky004', null, null, null, 'MDAwMDAwMDAwMDU1NzQ4NTJiYjU2MTlmMjlza3kxMjM', '1', null, null, null, '1500020539', '1500020539', null);
INSERT INTO `dx_tp5_admin` VALUES ('7', '4', 'sky005', null, null, null, 'MDAwMDAwMDAwMDU1NzQ4NTJiYjU2MTlmMjlza3kxMjM', '2', null, null, null, '1500020670', '1500020670', null);
INSERT INTO `dx_tp5_admin` VALUES ('8', '5', 'sky073', null, null, null, 'MDAwMDAwMDAwMDU1NzQ4NTJiYjU2MTlmMjlza3kxMjM', '1', null, null, null, '1500020822', '1500020822', null);
INSERT INTO `dx_tp5_admin` VALUES ('9', '4', 'sky083', '11', null, null, 'MDAwMDAwMDAwMGZjN2VkZDk3MWUzYmFmMmUxMTExMTE', '1', null, '127.0.0.1', '', '1500020868', '1501116436', null);

-- ----------------------------
-- Table structure for dx_tp5_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `dx_tp5_admin_group`;
CREATE TABLE `dx_tp5_admin_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '用户组名称',
  `menu_id` text COMMENT '菜单ID',
  `status` tinyint(2) DEFAULT '1' COMMENT '用户组状态：1-正常，2-禁用',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='新后台用户组表';

-- ----------------------------
-- Records of dx_tp5_admin_group
-- ----------------------------
INSERT INTO `dx_tp5_admin_group` VALUES ('1', '超级管理员', '2,17,18,3,5,8,9,10,6,11,4,7,14,15,16,19', '1', '1500252275', '1501062029');
INSERT INTO `dx_tp5_admin_group` VALUES ('2', '测试', '2,17,18,3,5,8,9,10,4,7,19', '1', '1500252289', '1501061998');
INSERT INTO `dx_tp5_admin_group` VALUES ('3', '开发', '2,17,18,4,7,19', '2', '1500252297', '1501062017');
INSERT INTO `dx_tp5_admin_group` VALUES ('4', 'ceshi', '2,17,18,3,5,8,9,10,6,11', '1', '1500434162', '1501061971');
INSERT INTO `dx_tp5_admin_group` VALUES ('5', 'cscs', '1,3,6,4,9', '2', '1500434402', '1500435306');
INSERT INTO `dx_tp5_admin_group` VALUES ('6', 'saasf', '1,3,7,2,5', '1', '1500434767', '1500434767');

-- ----------------------------
-- Table structure for dx_tp5_behavior_log
-- ----------------------------
DROP TABLE IF EXISTS `dx_tp5_behavior_log`;
CREATE TABLE `dx_tp5_behavior_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '行为名称',
  `module` varchar(30) NOT NULL COMMENT '模块',
  `controller` varchar(50) NOT NULL COMMENT '控制器',
  `action` varchar(255) NOT NULL COMMENT '方法',
  `url` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `type` varchar(100) DEFAULT NULL COMMENT '请求类型',
  `params` text COMMENT '请求参数',
  `result` text COMMENT '处理结果',
  `ip` varchar(30) DEFAULT NULL COMMENT '当前IP',
  `area` varchar(50) DEFAULT NULL COMMENT 'IP区域',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作管理员ID',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8 COMMENT='后台用户行为记录';

-- ----------------------------
-- Records of dx_tp5_behavior_log
-- ----------------------------
INSERT INTO `dx_tp5_behavior_log` VALUES ('1', '', 'admin', 'Index', 'index', '/', null, 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501035228', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('2', '', 'admin', 'Index', 'main', '/index/main.html', null, 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501035228', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('3', '', 'admin', 'Datas', 'ajaxmenu', '/datas/ajaxmenu.html', null, 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501035228', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('4', '', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', null, 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501035360', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('5', '', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', null, 'a:2:{s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501035360', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('6', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'post', 'a:4:{s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501035984', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('7', '添加菜单', 'admin', 'Menus', 'add', 'http://admin.thinkphp5.com/menus/add.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501035986', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('8', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'post', 'a:4:{s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036012', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('9', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036146', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('10', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036146', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('11', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036146', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('12', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036281', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('13', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036281', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('14', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036281', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('15', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036380', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('16', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036381', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('17', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036381', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('18', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036438', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('19', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036439', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('20', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036439', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('21', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036454', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('22', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036455', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('23', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036455', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('24', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036480', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('25', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036480', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('26', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036480', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('27', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036530', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('28', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036530', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('29', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036530', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('30', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036555', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('31', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036571', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('32', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036588', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('33', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501036628', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('34', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037737', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('35', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037737', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('36', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037737', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('37', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037760', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('38', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'post', 'a:2:{s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037761', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('39', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037803', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('40', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'post', 'a:2:{s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037804', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('41', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037822', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('42', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'post', 'a:2:{s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037823', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('43', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037859', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('44', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501037859325\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037859', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('45', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037863', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('46', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501037859325\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037874', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('47', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037894', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('48', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037894', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('49', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037894', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('50', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037897', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('51', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'post', 'a:2:{s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037898', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('52', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037900', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('53', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501037900533\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037900', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('54', '管理员分组列表', 'admin', 'Group', 'getlist', 'http://admin.thinkphp5.com/group/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037901', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('55', '管理员分组列表', 'admin', 'Group', 'getlist', 'http://admin.thinkphp5.com/group/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501037902051\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037902', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('56', null, 'admin', 'Group', 'edit', 'http://admin.thinkphp5.com/group/edit/id/2.html', 'get', 'a:1:{s:2:\"id\";s:1:\"2\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037904', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('57', null, 'admin', 'Menus', 'menutree', 'http://admin.thinkphp5.com/menus/menutree.html', 'post', 'a:1:{s:8:\"group_id\";s:1:\"2\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037904', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('58', null, 'admin', 'Group', 'edit', 'http://admin.thinkphp5.com/group/edit.html', 'post', 'a:4:{s:4:\"name\";s:6:\"测试\";s:6:\"status\";s:1:\"1\";s:2:\"id\";s:1:\"2\";s:7:\"menu_id\";a:8:{i:0;s:1:\"1\";i:1;s:1:\"3\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"4\";i:5;s:1:\"9\";i:6;s:2:\"15\";i:7;s:2:\"16\";}}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037906', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('59', '管理员分组列表', 'admin', 'Group', 'getlist', 'http://admin.thinkphp5.com/group/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501037902051\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037910', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('60', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037914', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('61', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501037900533\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501037916', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('62', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038185', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('63', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038186', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('64', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038186', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('65', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038248', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('66', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038248', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('67', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038248', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('68', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038259', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('69', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038260', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('70', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038260', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('71', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038322', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('72', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038323', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('73', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038323', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('74', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038324', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('75', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038325', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('76', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038325', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('77', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038331', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('78', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038332', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('79', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038332', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('80', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038591', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('81', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038591', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('82', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038591', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('83', null, 'admin', 'Account', 'myinfo', 'http://admin.thinkphp5.com/account/myinfo.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038600', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('84', null, 'admin', 'Account', 'myinfo', 'http://admin.thinkphp5.com/account/myinfo.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038624', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('85', null, 'admin', 'Account', 'myinfo', 'http://admin.thinkphp5.com/account/myinfo.html?username=sky001&true_name=www&mobile=&email=936957321%40qq.com&password=&check_password=&id=1', 'get', 'a:7:{s:8:\"username\";s:6:\"sky001\";s:9:\"true_name\";s:3:\"www\";s:6:\"mobile\";N;s:5:\"email\";s:16:\"936957321@qq.com\";s:8:\"password\";N;s:14:\"check_password\";N;s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038675', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('86', null, 'admin', 'Account', 'myinfo', 'http://admin.thinkphp5.com/account/myinfo.html?username=sky001&true_name=111&mobile=&email=936957321%40qq.com&password=&check_password=&id=1', 'get', 'a:7:{s:8:\"username\";s:6:\"sky001\";s:9:\"true_name\";s:3:\"111\";s:6:\"mobile\";N;s:5:\"email\";s:16:\"936957321@qq.com\";s:8:\"password\";N;s:14:\"check_password\";N;s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038687', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('87', null, 'admin', 'Account', 'myinfo', 'http://admin.thinkphp5.com/account/myinfo.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038736', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('88', null, 'admin', 'Account', 'myinfo', 'http://admin.thinkphp5.com/account/myinfo.html', 'post', 'a:7:{s:8:\"username\";s:6:\"sky001\";s:9:\"true_name\";s:3:\"www\";s:6:\"mobile\";N;s:5:\"email\";s:16:\"936957321@qq.com\";s:8:\"password\";N;s:14:\"check_password\";N;s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038740', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('89', null, 'admin', 'Account', 'myinfo', 'http://admin.thinkphp5.com/account/myinfo.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038741', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('90', null, 'admin', 'Account', 'myinfo', 'http://admin.thinkphp5.com/account/myinfo.html', 'post', 'a:7:{s:8:\"username\";s:6:\"sky001\";s:9:\"true_name\";N;s:6:\"mobile\";N;s:5:\"email\";s:16:\"936957321@qq.com\";s:8:\"password\";N;s:14:\"check_password\";N;s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038747', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('91', null, 'admin', 'Account', 'myinfo', 'http://admin.thinkphp5.com/account/myinfo.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038748', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('92', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038754', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('93', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501038754504\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038754', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('94', null, 'admin', 'Account', 'editstatus', 'http://admin.thinkphp5.com/account/editstatus.html', 'post', 'a:2:{s:2:\"id\";s:1:\"9\";s:6:\"status\";s:1:\"2\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038758', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('95', null, 'admin', 'Account', 'editstatus', 'http://admin.thinkphp5.com/account/editstatus.html', 'post', 'a:2:{s:2:\"id\";s:1:\"9\";s:6:\"status\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038759', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('96', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/9.html', 'get', 'a:1:{s:2:\"id\";s:1:\"9\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038762', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('97', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit.html', 'post', 'a:9:{s:8:\"group_id\";s:1:\"4\";s:8:\"username\";s:6:\"sky083\";s:9:\"true_name\";s:2:\"11\";s:6:\"mobile\";N;s:5:\"email\";N;s:8:\"password\";N;s:14:\"check_password\";N;s:6:\"status\";s:1:\"1\";s:2:\"id\";s:1:\"9\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038767', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('98', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501038754504\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038769', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('99', '新增管理员', 'admin', 'Account', 'add', 'http://admin.thinkphp5.com/account/add.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038771', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('100', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501038754504\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038777', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('101', null, 'admin', 'Account', 'lock', 'http://admin.thinkphp5.com/account/lock.html', 'post', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038779', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('102', null, 'admin', 'Account', 'unlock', 'http://admin.thinkphp5.com/account/unlock.html', 'post', 'a:2:{s:8:\"username\";N;s:8:\"password\";s:6:\"sky123\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501038785', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('103', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041262', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('104', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041262', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('105', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041262', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('106', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041264', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('107', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501041264915\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041265', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('108', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041267', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('109', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041264915\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041272', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('110', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041464', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('111', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501041464629\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041464', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('112', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041466', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('113', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041464629\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041469', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('114', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041567', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('115', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041568', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('116', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041568', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('117', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041569', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('118', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501041569936\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041570', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('119', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/2.html', 'get', 'a:1:{s:2:\"id\";s:1:\"2\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041573', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('120', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041569936\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041576', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('121', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/2.html', 'get', 'a:1:{s:2:\"id\";s:1:\"2\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041578', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('122', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041569936\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041585', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('123', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041612', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('124', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041612', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('125', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041612', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('126', '管理员分组列表', 'admin', 'Group', 'getlist', 'http://admin.thinkphp5.com/group/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041614', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('127', '管理员分组列表', 'admin', 'Group', 'getlist', 'http://admin.thinkphp5.com/group/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501041615023\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041615', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('128', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041615', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('129', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501041615806\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041615', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('130', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041615806\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041622', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('131', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041650', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('132', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501041650444\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041650', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('133', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/2.html', 'get', 'a:1:{s:2:\"id\";s:1:\"2\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041651', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('134', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041650444\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041655', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('135', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041693', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('136', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041694', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('137', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041694', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('138', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041696', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('139', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501041696559\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041696', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('140', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041698', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('141', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041696559\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041702', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('142', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041731', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('143', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501041731527\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041731', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('144', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041733', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('145', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041731527\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041849', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('146', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041850', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('147', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041731527\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041862', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('148', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041863', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('149', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041731527\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041890', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('150', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041891', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('151', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041731527\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041905', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('152', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041907', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('153', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041731527\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041919', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('154', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041920', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('155', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041731527\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041934', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('156', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041935', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('157', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041731527\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041939', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('158', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/1.html', 'get', 'a:1:{s:2:\"id\";s:1:\"1\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041950', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('159', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041731527\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041952', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('160', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/2.html', 'get', 'a:1:{s:2:\"id\";s:1:\"2\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041953', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('161', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501041731527\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501041956', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('162', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050829', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('163', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050830', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('164', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050830', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('165', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050859', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('166', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050860', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('167', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050860', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('168', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050865', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('169', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050865', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('170', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050865', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('171', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050970', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('172', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050970', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('173', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050970', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('174', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050972', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('175', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'post', 'a:2:{s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050972', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('176', '添加菜单', 'admin', 'Menus', 'add', 'http://admin.thinkphp5.com/menus/add.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501050978', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('177', '添加菜单', 'admin', 'Menus', 'add', 'http://admin.thinkphp5.com/menus/add.html', 'post', 'a:9:{s:5:\"title\";s:12:\"清除缓存\";s:3:\"pid\";s:1:\"0\";s:6:\"module\";s:5:\"admin\";s:10:\"controller\";s:5:\"Index\";s:6:\"action\";s:11:\"clearCached\";s:4:\"icon\";N;s:4:\"sort\";s:1:\"1\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"2\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051129', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('178', '修改菜单', 'admin', 'Menus', 'edit', 'http://admin.thinkphp5.com/menus/edit/id/18.html', 'get', 'a:1:{s:2:\"id\";s:2:\"18\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051132', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('179', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'post', 'a:4:{s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051134', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('180', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051151', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('181', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051151', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('182', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051151', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('183', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051180', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('184', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051180', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('185', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051180', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('186', '清除缓存', 'admin', 'Index', 'clearcached', 'http://admin.thinkphp5.com/index/clearcached.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051191', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('187', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051195', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('188', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051196', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('189', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051196', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('190', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051481', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('191', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501051481276\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051481', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('192', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051481', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('193', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051481', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('194', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051481', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('195', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051491', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('196', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501051491771\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051491', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('197', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051497', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('198', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501051497193\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051497', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('199', '首页', 'admin', 'Index', 'index', 'http://admin.thinkphp5.com/', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051565', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('200', '欢迎页', 'admin', 'Index', 'main', 'http://admin.thinkphp5.com/index/main.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051566', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('201', '获取菜单信息', 'admin', 'Datas', 'ajaxmenu', 'http://admin.thinkphp5.com/datas/ajaxmenu.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051566', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('202', '管理员分组列表', 'admin', 'Group', 'getlist', 'http://admin.thinkphp5.com/group/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051568', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('203', '管理员分组列表', 'admin', 'Group', 'getlist', 'http://admin.thinkphp5.com/group/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501051568631\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051568', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('204', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051570', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('205', '菜单列表', 'admin', 'Menus', 'getlist', 'http://admin.thinkphp5.com/menus/getlist.html', 'post', 'a:2:{s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051571', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('206', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051573', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('207', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501051573431\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501051573', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('208', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'get', 'a:0:{}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501135803', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('209', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:3:{s:1:\"t\";s:13:\"1501135803716\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501135803', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('210', '修改管理员信息', 'admin', 'Account', 'edit', 'http://admin.thinkphp5.com/account/edit/id/9.html', 'get', 'a:1:{s:2:\"id\";s:1:\"9\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501135818', null);
INSERT INTO `dx_tp5_behavior_log` VALUES ('211', '管理员列表', 'admin', 'Account', 'getlist', 'http://admin.thinkphp5.com/account/getlist.html', 'post', 'a:5:{s:1:\"t\";s:13:\"1501135803716\";s:9:\"pageIndex\";s:1:\"1\";s:8:\"pageSize\";s:2:\"20\";s:6:\"status\";N;s:7:\"keyword\";N;}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501135821', null);

-- ----------------------------
-- Table structure for dx_tp5_login_log
-- ----------------------------
DROP TABLE IF EXISTS `dx_tp5_login_log`;
CREATE TABLE `dx_tp5_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '后台管理员ID',
  `account` varchar(255) DEFAULT NULL COMMENT '账号信息',
  `ip` varchar(30) DEFAULT NULL COMMENT '当前IP',
  `area` varchar(50) DEFAULT NULL COMMENT 'IP区域',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='后台账号登录日志';

-- ----------------------------
-- Records of dx_tp5_login_log
-- ----------------------------
INSERT INTO `dx_tp5_login_log` VALUES ('1', '1', 'a:6:{s:2:\"id\";i:1;s:8:\"group_id\";i:1;s:8:\"username\";s:6:\"sky001\";s:9:\"true_name\";s:0:\"\";s:6:\"mobile\";s:0:\"\";s:5:\"email\";s:16:\"936957321@qq.com\";}', '127.0.0.1', '', '1500976533', null);
INSERT INTO `dx_tp5_login_log` VALUES ('2', '1', 'a:6:{s:2:\"id\";i:1;s:8:\"group_id\";i:1;s:8:\"username\";s:6:\"sky001\";s:9:\"true_name\";s:0:\"\";s:6:\"mobile\";s:0:\"\";s:5:\"email\";s:16:\"936957321@qq.com\";}', '127.0.0.1', '', '1501029501', null);
INSERT INTO `dx_tp5_login_log` VALUES ('3', '1', 'a:6:{s:2:\"id\";i:1;s:8:\"group_id\";i:1;s:8:\"username\";s:6:\"sky001\";s:9:\"true_name\";s:0:\"\";s:6:\"mobile\";s:0:\"\";s:5:\"email\";s:16:\"936957321@qq.com\";}', '127.0.0.1', '', '1501030050', null);
INSERT INTO `dx_tp5_login_log` VALUES ('4', '1', 'a:6:{s:2:\"id\";i:1;s:8:\"group_id\";i:1;s:8:\"username\";s:6:\"sky001\";s:9:\"true_name\";s:0:\"\";s:6:\"mobile\";s:0:\"\";s:5:\"email\";s:16:\"936957321@qq.com\";}', '127.0.0.1', '', '1501034295', null);
INSERT INTO `dx_tp5_login_log` VALUES ('5', '1', 'a:6:{s:2:\"id\";i:1;s:8:\"group_id\";i:1;s:8:\"username\";s:6:\"sky001\";s:9:\"true_name\";s:0:\"\";s:6:\"mobile\";s:0:\"\";s:5:\"email\";s:16:\"936957321@qq.com\";}', '127.0.0.1', '', '1501034452', null);
INSERT INTO `dx_tp5_login_log` VALUES ('6', '5', 'a:6:{s:2:\"id\";i:5;s:8:\"group_id\";i:2;s:8:\"username\";s:6:\"sky003\";s:9:\"true_name\";N;s:6:\"mobile\";N;s:5:\"email\";N;}', '127.0.0.1', '', '1501116335', null);
INSERT INTO `dx_tp5_login_log` VALUES ('7', '5', 'a:6:{s:2:\"id\";i:5;s:8:\"group_id\";i:2;s:8:\"username\";s:6:\"sky003\";s:9:\"true_name\";N;s:6:\"mobile\";N;s:5:\"email\";N;}', '127.0.0.1', '', '1501116428', null);
INSERT INTO `dx_tp5_login_log` VALUES ('8', '5', 'a:6:{s:2:\"id\";i:5;s:8:\"group_id\";i:2;s:8:\"username\";s:6:\"sky003\";s:9:\"true_name\";N;s:6:\"mobile\";N;s:5:\"email\";N;}', '127.0.0.1', '', '1501117604', null);
INSERT INTO `dx_tp5_login_log` VALUES ('9', '5', 'a:6:{s:2:\"id\";i:5;s:8:\"group_id\";i:2;s:8:\"username\";s:6:\"sky003\";s:9:\"true_name\";N;s:6:\"mobile\";N;s:5:\"email\";N;}', '127.0.0.1', '', '1501117885', null);
INSERT INTO `dx_tp5_login_log` VALUES ('10', '5', 'a:6:{s:2:\"id\";i:5;s:8:\"group_id\";i:2;s:8:\"username\";s:6:\"sky003\";s:9:\"true_name\";N;s:6:\"mobile\";N;s:5:\"email\";N;}', '127.0.0.1', '', '1501118617', null);
INSERT INTO `dx_tp5_login_log` VALUES ('11', '1', 'a:6:{s:2:\"id\";i:1;s:8:\"group_id\";i:0;s:8:\"username\";s:6:\"sky001\";s:9:\"true_name\";N;s:6:\"mobile\";N;s:5:\"email\";s:16:\"936957321@qq.com\";}', '127.0.0.1', '', '1501135787', null);

-- ----------------------------
-- Table structure for dx_tp5_menu
-- ----------------------------
DROP TABLE IF EXISTS `dx_tp5_menu`;
CREATE TABLE `dx_tp5_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL COMMENT '菜单名称',
  `module` varchar(30) NOT NULL COMMENT '模块',
  `controller` varchar(50) NOT NULL COMMENT '控制器',
  `action` varchar(255) NOT NULL COMMENT '方法',
  `icon` varchar(255) DEFAULT NULL COMMENT '菜单图标',
  `sort` int(11) DEFAULT '1' COMMENT '排序，倒序',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '权限类型：1-权限控制，2-权限白名单，3-权限黑名单',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '菜单展示，1-展示，2-隐藏',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父菜单ID',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_tp5_menu_module_controller_action` (`module`,`controller`,`action`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='新后台菜单表（只支持两级目录）';

-- ----------------------------
-- Records of dx_tp5_menu
-- ----------------------------
INSERT INTO `dx_tp5_menu` VALUES ('1', '白名单菜单', 'admin', 'White', 'white', '', '1', '2', '2', '0', '1500284420', '1501052698');
INSERT INTO `dx_tp5_menu` VALUES ('2', '系统菜单', 'admin', 'Default', 'system', null, '1', '1', '2', '0', '1501051129', '1501052989');
INSERT INTO `dx_tp5_menu` VALUES ('3', '用户管理', 'Account', 'Default', 'default', 'fa-users', '1', '1', '1', '0', '1500284420', '1500430706');
INSERT INTO `dx_tp5_menu` VALUES ('4', '菜单管理', 'admin', 'Menus', 'default', 'fa-th-list', '1', '1', '1', '0', '1500284488', '1500430733');
INSERT INTO `dx_tp5_menu` VALUES ('5', '管理员列表', 'admin', 'Account', 'getList', 'fa-address-book', '1', '1', '1', '3', '1500430787', '1500430787');
INSERT INTO `dx_tp5_menu` VALUES ('6', '管理员分组列表', 'admin', 'Group', 'getList', 'fa-user', '1', '1', '1', '3', '1500430839', '1500430839');
INSERT INTO `dx_tp5_menu` VALUES ('7', '菜单列表', 'admin', 'Menus', 'getList', 'fa-list-ul', '1', '1', '1', '4', '1500430864', '1500430864');
INSERT INTO `dx_tp5_menu` VALUES ('8', '新增管理员', 'admin', 'Account', 'add', '', '1', '1', '1', '5', '1500430961', '1500430961');
INSERT INTO `dx_tp5_menu` VALUES ('9', '修改管理员信息', 'admin', 'Account', 'edit', '', '1', '1', '1', '5', '1500431150', '1500431150');
INSERT INTO `dx_tp5_menu` VALUES ('10', '删除管理员', 'admin', 'Account', 'del', '', '1', '1', '1', '5', '1500431204', '1500431204');
INSERT INTO `dx_tp5_menu` VALUES ('11', '添加用户组', 'admin', 'Group', 'add', '', '1', '1', '1', '6', '1500431316', '1500431316');
INSERT INTO `dx_tp5_menu` VALUES ('12', '登陆界面', 'admin', 'Account', 'login', null, '1', '2', '2', '2', '1500536049', '1501053031');
INSERT INTO `dx_tp5_menu` VALUES ('13', '退出界面', 'admin', 'Account', 'logout', null, '1', '2', '2', '2', '1500536208', '1501053020');
INSERT INTO `dx_tp5_menu` VALUES ('14', '添加菜单', 'admin', 'Menus', 'add', '', '1', '1', '1', '7', '1500536280', '1500620260');
INSERT INTO `dx_tp5_menu` VALUES ('15', '删除菜单', 'admin', 'Menus', 'del', '', '1', '1', '2', '7', '1500536340', '1500620244');
INSERT INTO `dx_tp5_menu` VALUES ('16', '修改菜单', 'admin', 'Menus', 'edit', '', '1', '1', '2', '7', '1500536434', '1500620314');
INSERT INTO `dx_tp5_menu` VALUES ('17', '首页', 'admin', 'Index', 'index', null, '1', '1', '2', '2', '1500624582', '1501053065');
INSERT INTO `dx_tp5_menu` VALUES ('18', '欢迎页', 'admin', 'Index', 'main', null, '1', '1', '2', '2', '1500624635', '1501053057');
INSERT INTO `dx_tp5_menu` VALUES ('19', '获取菜单信息', 'admin', 'Datas', 'ajaxMenu', '', '1', '1', '2', '7', '1500624833', '1501052677');
INSERT INTO `dx_tp5_menu` VALUES ('20', '清除缓存', 'admin', 'Index', 'clearCached', null, '1', '2', '2', '2', '1501051129', '1501053098');
