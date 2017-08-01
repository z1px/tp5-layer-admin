/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 100122
Source Host           : localhost:3306
Source Database       : tp5_layer_demo

Target Server Type    : MYSQL
Target Server Version : 100122
File Encoding         : 65001

Date: 2017-08-01 23:28:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tp5_admin
-- ----------------------------
DROP TABLE IF EXISTS `tp5_admin`;
CREATE TABLE `tp5_admin` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='新后台用户表';

-- ----------------------------
-- Records of tp5_admin
-- ----------------------------
INSERT INTO `tp5_admin` VALUES ('1', '0', 'sky001', '系统管理员', null, null, 'MDAwMDAwMDAwMDU1NzQ4NTJiYjU2MTlmMjlza3kxMjM', '1', '1501515557', '127.0.0.1', '', '1500016980', '1501515557', '56ac1f51e9048a27d9a30f9d74f339b2');

-- ----------------------------
-- Table structure for tp5_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `tp5_admin_group`;
CREATE TABLE `tp5_admin_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '用户组名称',
  `menu_id` text COMMENT '菜单ID',
  `status` tinyint(2) DEFAULT '1' COMMENT '用户组状态：1-正常，2-禁用',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新后台用户组表';

-- ----------------------------
-- Records of tp5_admin_group
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_behavior_log
-- ----------------------------
DROP TABLE IF EXISTS `tp5_behavior_log`;
CREATE TABLE `tp5_behavior_log` (
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='后台用户行为记录';

-- ----------------------------
-- Records of tp5_behavior_log
-- ----------------------------
INSERT INTO `tp5_behavior_log` VALUES ('1', '修改菜单', 'admin', 'Menus', 'edit', 'http://admin.tp5.com/menus/edit.html', 'post', 'a:10:{s:5:\"title\";s:18:\"修改个人信息\";s:3:\"pid\";s:1:\"2\";s:6:\"module\";s:5:\"admin\";s:10:\"controller\";s:7:\"Account\";s:6:\"action\";s:6:\"myinfo\";s:4:\"icon\";N;s:4:\"sort\";s:1:\"1\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"2\";s:2:\"id\";s:2:\"29\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501601101', null);
INSERT INTO `tp5_behavior_log` VALUES ('2', '修改菜单', 'admin', 'Menus', 'edit', 'http://admin.tp5.com/menus/edit.html', 'post', 'a:10:{s:5:\"title\";s:6:\"设置\";s:3:\"pid\";s:1:\"2\";s:6:\"module\";s:5:\"admin\";s:10:\"controller\";s:7:\"Account\";s:6:\"action\";s:7:\"setting\";s:4:\"icon\";N;s:4:\"sort\";s:1:\"1\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"2\";s:2:\"id\";s:2:\"28\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501601109', null);
INSERT INTO `tp5_behavior_log` VALUES ('3', '修改菜单', 'admin', 'Menus', 'edit', 'http://admin.tp5.com/menus/edit.html', 'post', 'a:10:{s:5:\"title\";s:12:\"解除锁屏\";s:3:\"pid\";s:1:\"2\";s:6:\"module\";s:5:\"admin\";s:10:\"controller\";s:7:\"Account\";s:6:\"action\";s:6:\"unlock\";s:4:\"icon\";N;s:4:\"sort\";s:1:\"1\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"2\";s:2:\"id\";s:2:\"27\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501601117', null);
INSERT INTO `tp5_behavior_log` VALUES ('4', '修改菜单', 'admin', 'Menus', 'edit', 'http://admin.tp5.com/menus/edit.html', 'post', 'a:10:{s:5:\"title\";s:6:\"锁屏\";s:3:\"pid\";s:1:\"2\";s:6:\"module\";s:5:\"admin\";s:10:\"controller\";s:7:\"Account\";s:6:\"action\";s:4:\"lock\";s:4:\"icon\";N;s:4:\"sort\";s:1:\"1\";s:4:\"type\";s:1:\"1\";s:6:\"status\";s:1:\"2\";s:2:\"id\";s:2:\"26\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501601124', null);
INSERT INTO `tp5_behavior_log` VALUES ('5', '修改菜单', 'admin', 'Menus', 'edit', 'http://admin.tp5.com/menus/edit.html', 'post', 'a:10:{s:5:\"title\";s:6:\"退出\";s:3:\"pid\";s:1:\"2\";s:6:\"module\";s:5:\"admin\";s:10:\"controller\";s:7:\"Account\";s:6:\"action\";s:6:\"logout\";s:4:\"icon\";N;s:4:\"sort\";s:1:\"1\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"2\";s:2:\"id\";s:2:\"13\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501601161', null);
INSERT INTO `tp5_behavior_log` VALUES ('6', '修改菜单', 'admin', 'Menus', 'edit', 'http://admin.tp5.com/menus/edit.html', 'post', 'a:10:{s:5:\"title\";s:6:\"登录\";s:3:\"pid\";s:1:\"2\";s:6:\"module\";s:5:\"admin\";s:10:\"controller\";s:7:\"Account\";s:6:\"action\";s:5:\"login\";s:4:\"icon\";N;s:4:\"sort\";s:1:\"1\";s:4:\"type\";s:1:\"2\";s:6:\"status\";s:1:\"2\";s:2:\"id\";s:2:\"12\";}', 'a:3:{s:4:\"code\";i:1;s:3:\"msg\";s:11:\"data normal\";s:4:\"data\";a:0:{}}', '127.0.0.1', '', '1', '1501601177', null);

-- ----------------------------
-- Table structure for tp5_login_log
-- ----------------------------
DROP TABLE IF EXISTS `tp5_login_log`;
CREATE TABLE `tp5_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '后台管理员ID',
  `account` varchar(255) DEFAULT NULL COMMENT '账号信息',
  `ip` varchar(30) DEFAULT NULL COMMENT '当前IP',
  `area` varchar(50) DEFAULT NULL COMMENT 'IP区域',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台账号登录日志';

-- ----------------------------
-- Records of tp5_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_menu
-- ----------------------------
DROP TABLE IF EXISTS `tp5_menu`;
CREATE TABLE `tp5_menu` (
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='新后台菜单表（只支持两级目录）';

-- ----------------------------
-- Records of tp5_menu
-- ----------------------------
INSERT INTO `tp5_menu` VALUES ('1', '白名单菜单', 'admin', 'White', 'white', '', '1', '2', '2', '0', '1500284420', '1501052698');
INSERT INTO `tp5_menu` VALUES ('2', '系统菜单 ', 'admin', 'Default', 'system', null, '1', '1', '2', '0', '1501051129', '1501421918');
INSERT INTO `tp5_menu` VALUES ('3', '用户管理', 'admin', 'Account', 'default', 'fa-users', '1', '1', '1', '0', '1500284420', '1500430706');
INSERT INTO `tp5_menu` VALUES ('4', '菜单管理', 'admin', 'Menus', 'default', 'fa-th-list', '1', '1', '1', '0', '1500284488', '1500430733');
INSERT INTO `tp5_menu` VALUES ('5', '管理员列表', 'admin', 'Account', 'getList', 'fa-address-book', '1', '1', '1', '3', '1500430787', '1500430787');
INSERT INTO `tp5_menu` VALUES ('6', '管理员分组列表', 'admin', 'Group', 'getList', 'fa-user', '1', '1', '1', '3', '1500430839', '1500430839');
INSERT INTO `tp5_menu` VALUES ('7', '菜单列表', 'admin', 'Menus', 'getList', 'fa-list-ul', '1', '1', '1', '4', '1500430864', '1500430864');
INSERT INTO `tp5_menu` VALUES ('8', '新增管理员', 'admin', 'Account', 'add', '', '1', '1', '1', '5', '1500430961', '1501422615');
INSERT INTO `tp5_menu` VALUES ('9', '修改管理员信息', 'admin', 'Account', 'edit', '', '1', '1', '1', '5', '1500431150', '1500431150');
INSERT INTO `tp5_menu` VALUES ('10', '删除管理员', 'admin', 'Account', 'del', '', '1', '1', '1', '5', '1500431204', '1500431204');
INSERT INTO `tp5_menu` VALUES ('11', '添加用户组', 'admin', 'Group', 'add', '', '1', '1', '1', '6', '1500431316', '1500431316');
INSERT INTO `tp5_menu` VALUES ('12', '登录', 'admin', 'Account', 'login', null, '1', '2', '2', '2', '1500536049', '1501601177');
INSERT INTO `tp5_menu` VALUES ('13', '退出', 'admin', 'Account', 'logout', null, '1', '2', '2', '2', '1500536208', '1501601160');
INSERT INTO `tp5_menu` VALUES ('14', '添加菜单', 'admin', 'Menus', 'add', '', '1', '1', '1', '7', '1500536280', '1500620260');
INSERT INTO `tp5_menu` VALUES ('15', '删除菜单', 'admin', 'Menus', 'del', '', '1', '1', '2', '7', '1500536340', '1500620244');
INSERT INTO `tp5_menu` VALUES ('16', '修改菜单', 'admin', 'Menus', 'edit', '', '1', '1', '2', '7', '1500536434', '1500620314');
INSERT INTO `tp5_menu` VALUES ('17', '首页', 'admin', 'Index', 'index', null, '1', '1', '2', '2', '1500624582', '1501424466');
INSERT INTO `tp5_menu` VALUES ('18', '欢迎页', 'admin', 'Index', 'main', null, '1', '1', '2', '2', '1500624635', '1501421895');
INSERT INTO `tp5_menu` VALUES ('19', '获取菜单信息', 'admin', 'Datas', 'ajaxMenu', '', '1', '1', '2', '7', '1500624833', '1501052677');
INSERT INTO `tp5_menu` VALUES ('20', '清除缓存', 'admin', 'Index', 'clearCached', null, '1', '2', '2', '2', '1501051129', '1501053098');
INSERT INTO `tp5_menu` VALUES ('23', '日志管理', 'admin', 'Log', 'default', 'fa-file-text-o', '1', '1', '1', '0', '1501515781', '1501516531');
INSERT INTO `tp5_menu` VALUES ('24', '登录日志', 'admin', 'Log', 'getLogin', null, '1', '1', '1', '23', '1501515818', '1501515864');
INSERT INTO `tp5_menu` VALUES ('25', '行为日志', 'admin', 'Log', 'getBehavior', null, '1', '1', '1', '23', '1501515842', '1501515867');
INSERT INTO `tp5_menu` VALUES ('26', '锁屏', 'admin', 'Account', 'lock', null, '1', '1', '2', '2', '1500536208', '1501601124');
INSERT INTO `tp5_menu` VALUES ('27', '解除锁屏', 'admin', 'Account', 'unlock', null, '1', '1', '2', '2', '1500536208', '1501601117');
INSERT INTO `tp5_menu` VALUES ('28', '设置', 'admin', 'Account', 'setting', null, '1', '1', '2', '2', '1500536208', '1501601109');
INSERT INTO `tp5_menu` VALUES ('29', '修改个人信息', 'admin', 'Account', 'myinfo', null, '1', '1', '2', '2', '1500536208', '1501601100');
INSERT INTO `tp5_menu` VALUES ('30', '修改管理员账号状态', 'admin', 'Account', 'editStatus', '', '1', '1', '1', '5', '1500431150', '1500431150');
INSERT INTO `tp5_menu` VALUES ('31', '修改用户组', 'admin', 'Group', 'edit', '', '1', '1', '1', '6', '1500431316', '1500431316');
INSERT INTO `tp5_menu` VALUES ('32', '修改用户组状态', 'admin', 'Group', 'editStatus', '', '1', '1', '1', '6', '1500431316', '1500431316');
INSERT INTO `tp5_menu` VALUES ('33', '删除用户组', 'admin', 'Group', 'del', '', '1', '1', '1', '6', '1500431316', '1500431316');
INSERT INTO `tp5_menu` VALUES ('35', '修改菜单状态', 'admin', 'Menus', 'editStatus', '', '1', '1', '2', '7', '1500536434', '1500620314');
INSERT INTO `tp5_menu` VALUES ('37', '菜单授权列表', 'admin', 'Menus', 'menuTree', '', '1', '1', '2', '7', '1500536434', '1500620314');
INSERT INTO `tp5_menu` VALUES ('38', '获取所有菜单', 'admin', 'Menus', 'getAll', '', '1', '1', '2', '7', '1500536434', '1500620314');
INSERT INTO `tp5_menu` VALUES ('39', '修改菜单级别', 'admin', 'Menus', 'editMenuPid', '', '1', '1', '2', '7', '1500536434', '1500620314');
INSERT INTO `tp5_menu` VALUES ('40', '修改菜单名称', 'admin', 'Menus', 'editMenuTitle', '', '1', '1', '2', '7', '1500536434', '1500620314');
SET FOREIGN_KEY_CHECKS=1;
