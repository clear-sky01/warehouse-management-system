/*
Navicat MySQL Data Transfer

Source Server         : MySql
Source Server Version : 80013
Source Host           : localhost:3306
Source Database       : crush

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2020-04-26 15:37:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for application
-- ----------------------------
DROP TABLE IF EXISTS `application`;
CREATE TABLE `application` (
  `id` varchar(128) NOT NULL,
  `warehouse_id` varchar(128) NOT NULL,
  `user_id` varchar(128) NOT NULL,
  `name` varchar(255) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_cancel_application` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  `approval_status` tinyint(2) NOT NULL,
  `approval_instructions` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for application_detail
-- ----------------------------
DROP TABLE IF EXISTS `application_detail`;
CREATE TABLE `application_detail` (
  `id` varchar(128) NOT NULL,
  `application_id` varchar(128) NOT NULL,
  `consumable_id` varchar(128) NOT NULL,
  `applicate_count` int(11) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `is_cancel_application` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  `approval_status` tinyint(2) NOT NULL,
  `approval_instructions` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for consumable
-- ----------------------------
DROP TABLE IF EXISTS `consumable`;
CREATE TABLE `consumable` (
  `id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `warehouse_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `count` int(11) NOT NULL,
  `safety_count` int(11) NOT NULL,
  `price` double(11,2) NOT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `state` tinyint(2) DEFAULT NULL,
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_lock` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for consumable_inbound_batch
-- ----------------------------
DROP TABLE IF EXISTS `consumable_inbound_batch`;
CREATE TABLE `consumable_inbound_batch` (
  `id` varchar(128) NOT NULL,
  `consumable_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `count` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `create_time` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for consumable_operation_detail
-- ----------------------------
DROP TABLE IF EXISTS `consumable_operation_detail`;
CREATE TABLE `consumable_operation_detail` (
  `id` varchar(128) NOT NULL,
  `consumable_operation_history_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `consumable_id` varchar(128) NOT NULL,
  `operation_type` int(2) NOT NULL,
  `operation_count` int(11) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for consumable_operation_history
-- ----------------------------
DROP TABLE IF EXISTS `consumable_operation_history`;
CREATE TABLE `consumable_operation_history` (
  `id` varchar(128) NOT NULL,
  `warehouse_id` varchar(128) NOT NULL,
  `user_id` varchar(128) NOT NULL,
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for consumable_reference_information
-- ----------------------------
DROP TABLE IF EXISTS `consumable_reference_information`;
CREATE TABLE `consumable_reference_information` (
  `id` varchar(128) NOT NULL,
  `consumable_id` varchar(128) NOT NULL,
  `reference_key` varchar(255) DEFAULT NULL,
  `reference_value` varchar(255) DEFAULT NULL,
  `display_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for operation
-- ----------------------------
DROP TABLE IF EXISTS `operation`;
CREATE TABLE `operation` (
  `id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作履历ID',
  `user_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户ID',
  `operation` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作',
  `ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IP地址',
  `create_time` datetime NOT NULL COMMENT '操作日期',
  `method` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作请求路径',
  `params` varchar(8192) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作请求参数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` varchar(128) NOT NULL COMMENT '权限ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名',
  `str` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限标识',
  `display_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for reference_information_template
-- ----------------------------
DROP TABLE IF EXISTS `reference_information_template`;
CREATE TABLE `reference_information_template` (
  `id` varchar(128) NOT NULL,
  `warehouse_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_system` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for reference_information_template_detail
-- ----------------------------
DROP TABLE IF EXISTS `reference_information_template_detail`;
CREATE TABLE `reference_information_template_detail` (
  `id` varchar(128) NOT NULL,
  `reference_information_template_id` varchar(255) NOT NULL,
  `reference_key` varchar(255) NOT NULL,
  `display_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名',
  `str` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色标识',
  `type` int(11) NOT NULL COMMENT '角色类型',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建日期',
  `is_stop` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否停用',
  `is_delete` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
  `permission_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `role_warehouse`;
CREATE TABLE `role_warehouse` (
  `role_id` varchar(128) NOT NULL,
  `warehouse_id` varchar(128) NOT NULL,
  PRIMARY KEY (`role_id`,`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` varchar(128) NOT NULL,
  `name` varchar(200) NOT NULL,
  `remarks` varchar(64) DEFAULT NULL,
  `parent_id` varchar(128) DEFAULT NULL,
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for type_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `type_warehouse`;
CREATE TABLE `type_warehouse` (
  `type_id` varchar(128) NOT NULL,
  `warehouse_id` varchar(128) NOT NULL,
  PRIMARY KEY (`type_id`,`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(128) NOT NULL,
  `account` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(20) NOT NULL,
  `gender` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `avatar` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `register_time` timestamp NOT NULL,
  `is_enable` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_extension
-- ----------------------------
DROP TABLE IF EXISTS `user_extension`;
CREATE TABLE `user_extension` (
  `user_id` varchar(128) NOT NULL,
  `initialized_password` varchar(255) DEFAULT NULL COMMENT '新增管理员时保存初始化的密码',
  `department` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_permission
-- ----------------------------
DROP TABLE IF EXISTS `user_permission`;
CREATE TABLE `user_permission` (
  `user_id` varchar(128) NOT NULL,
  `permission_id` varchar(128) NOT NULL,
  PRIMARY KEY (`user_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` varchar(128) NOT NULL,
  `role_id` varchar(128) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `user_warehouse`;
CREATE TABLE `user_warehouse` (
  `user_id` varchar(128) NOT NULL,
  `warehouse_id` varchar(128) NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_warehouse_application_setting
-- ----------------------------
DROP TABLE IF EXISTS `user_warehouse_application_setting`;
CREATE TABLE `user_warehouse_application_setting` (
  `user_id` varchar(128) NOT NULL,
  `warehouse_id` varchar(128) NOT NULL,
  PRIMARY KEY (`user_id`,`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for warehouse
-- ----------------------------
DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse` (
  `id` varchar(128) NOT NULL,
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) NOT NULL,
  `picture_url` varchar(1028) DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `display_order` int(11) NOT NULL,
  `is_enable` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_delete` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
