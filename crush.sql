/*
 Navicat Premium Dump SQL

 Source Server         : crush
 Source Server Type    : MySQL
 Source Server Version : 80046 (8.0.46)
 Source Host           : localhost:3306
 Source Schema         : crush

 Target Server Type    : MySQL
 Target Server Version : 80046 (8.0.46)
 File Encoding         : 65001

 Date: 16/07/2026 10:57:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for application
-- ----------------------------
DROP TABLE IF EXISTS `application`;
CREATE TABLE `application`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `warehouse_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `user_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_cancel_application` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  `approval_status` tinyint NOT NULL,
  `approval_instructions` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of application
-- ----------------------------
INSERT INTO `application` VALUES ('demo_app_passed', 'demo_wh_main', '5fb04e29a8ef4c769a44cf5397e38620', '信息化耗材补领申请', '用于演示已通过申请单。', '2026-07-12 00:17:12', b'0', b'0', 1, '数量合理，同意领用。');
INSERT INTO `application` VALUES ('demo_app_pending', 'demo_wh_main', '5fb04e29a8ef4c769a44cf5397e38620', '行政部办公用品领用申请', '用于演示待审批申请单。', '2026-07-11 00:17:12', b'0', b'0', 0, '');
INSERT INTO `application` VALUES ('demo_app_rejected', 'demo_wh_backup', '5fb04e29a8ef4c769a44cf5397e38620', '包装材料临时申请', '用于演示驳回申请单。', '2026-07-13 00:17:12', b'0', b'0', 2, '请补充用途说明后重新提交。');

-- ----------------------------
-- Table structure for application_detail
-- ----------------------------
DROP TABLE IF EXISTS `application_detail`;
CREATE TABLE `application_detail`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `application_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `consumable_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `applicate_count` int NOT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `is_cancel_application` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  `approval_status` tinyint NOT NULL,
  `approval_instructions` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of application_detail
-- ----------------------------
INSERT INTO `application_detail` VALUES ('demo_app_detail_1', 'demo_app_pending', 'demo_c_a4', 5, '培训资料打印', b'0', b'0', 0, '');
INSERT INTO `application_detail` VALUES ('demo_app_detail_2', 'demo_app_pending', 'demo_c_pen', 20, '会议签到使用', b'0', b'0', 0, '');
INSERT INTO `application_detail` VALUES ('demo_app_detail_3', 'demo_app_passed', 'demo_c_mouse', 3, '新工位补充', b'0', b'0', 1, '同意');
INSERT INTO `application_detail` VALUES ('demo_app_detail_4', 'demo_app_rejected', 'demo_c_box', 20, '临时打包使用', b'0', b'0', 2, '用途不清晰');

-- ----------------------------
-- Table structure for consumable
-- ----------------------------
DROP TABLE IF EXISTS `consumable`;
CREATE TABLE `consumable`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `warehouse_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `type_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `count` int NOT NULL,
  `safety_count` int NOT NULL,
  `price` double(11, 2) NOT NULL,
  `summary` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `state` tinyint NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_lock` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  `supplier_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '供应商ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consumable
-- ----------------------------
INSERT INTO `consumable` VALUES ('demo_c_a4', 'demo_wh_main', 'demo_type_office', 'BG-A4-001', 'A4打印纸', 120, 30, 22.50, '行政办公日常打印用纸，按包管理。', 1, '2026-07-02 00:17:12', b'0', b'0', NULL);
INSERT INTO `consumable` VALUES ('demo_c_bag', 'demo_wh_main', 'demo_type_clean', 'QJ-LJD-001', '大号垃圾袋', 15, 25, 12.00, '低库存示例，适合讲解安全库存。', 1, '2026-07-07 00:17:12', b'0', b'0', NULL);
INSERT INTO `consumable` VALUES ('demo_c_box', 'demo_wh_backup', 'demo_type_pack', 'BZ-ZX-001', '中号纸箱', 90, 40, 3.20, '备用仓包装材料。', 1, '2026-07-08 00:17:12', b'0', b'0', NULL);
INSERT INTO `consumable` VALUES ('demo_c_cleaner', 'demo_wh_main', 'demo_type_clean', 'QJ-XSY-001', '洗手液', 35, 20, 18.80, '公共区域补充用品，按瓶管理。', 1, '2026-07-06 00:17:12', b'0', b'0', NULL);
INSERT INTO `consumable` VALUES ('demo_c_keyboard', 'demo_wh_main', 'demo_type_it', 'IT-KEY-001', '有线键盘', 8, 12, 58.00, '低库存示例，用于演示库存预警。', 1, '2026-07-05 00:17:12', b'0', b'0', NULL);
INSERT INTO `consumable` VALUES ('demo_c_mouse', 'demo_wh_main', 'demo_type_it', 'IT-MOUSE-001', '无线鼠标', 18, 10, 49.00, '工位替换和临时办公使用。', 1, '2026-07-04 00:17:12', b'0', b'0', NULL);
INSERT INTO `consumable` VALUES ('demo_c_pen', 'demo_wh_main', 'demo_type_office', 'BG-QZB-002', '黑色签字笔', 260, 80, 1.80, '会议签到、办公领用，按支管理。', 1, '2026-07-03 00:17:12', b'0', b'0', NULL);
INSERT INTO `consumable` VALUES ('demo_c_tape', 'demo_wh_backup', 'demo_type_pack', 'BZ-JD-001', '透明胶带', 10, 30, 4.50, '库房打包使用。', 1, '2026-07-16 10:47:04', b'0', b'0', NULL);

-- ----------------------------
-- Table structure for consumable_inbound_batch
-- ----------------------------
DROP TABLE IF EXISTS `consumable_inbound_batch`;
CREATE TABLE `consumable_inbound_batch`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `consumable_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `count` int NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `create_time` timestamp NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consumable_inbound_batch
-- ----------------------------
INSERT INTO `consumable_inbound_batch` VALUES ('demo_batch_a4_1', 'demo_c_a4', 80, 22.00, '2026-07-02 00:17:12');
INSERT INTO `consumable_inbound_batch` VALUES ('demo_batch_a4_2', 'demo_c_a4', 40, 23.00, '2026-07-10 00:17:12');
INSERT INTO `consumable_inbound_batch` VALUES ('demo_batch_bag_1', 'demo_c_bag', 40, 12.00, '2026-07-07 00:17:12');
INSERT INTO `consumable_inbound_batch` VALUES ('demo_batch_box_1', 'demo_c_box', 100, 3.20, '2026-07-08 00:17:12');
INSERT INTO `consumable_inbound_batch` VALUES ('demo_batch_cleaner_1', 'demo_c_cleaner', 50, 18.80, '2026-07-06 00:17:12');
INSERT INTO `consumable_inbound_batch` VALUES ('demo_batch_keyboard_1', 'demo_c_keyboard', 20, 58.00, '2026-07-05 00:17:12');
INSERT INTO `consumable_inbound_batch` VALUES ('demo_batch_mouse_1', 'demo_c_mouse', 25, 49.00, '2026-07-04 00:17:12');
INSERT INTO `consumable_inbound_batch` VALUES ('demo_batch_pen_1', 'demo_c_pen', 300, 1.80, '2026-07-03 00:17:12');
INSERT INTO `consumable_inbound_batch` VALUES ('demo_batch_tape_1', 'demo_c_tape', 25, 4.50, '2026-07-09 00:17:12');

-- ----------------------------
-- Table structure for consumable_operation_detail
-- ----------------------------
DROP TABLE IF EXISTS `consumable_operation_detail`;
CREATE TABLE `consumable_operation_detail`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `consumable_operation_history_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `consumable_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `operation_type` int NOT NULL,
  `operation_count` int NOT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consumable_operation_detail
-- ----------------------------
INSERT INTO `consumable_operation_detail` VALUES ('5b8232c0a2a549e7af42e4f48b3d853c', '9e596ac0292848b49cb6999e2d0f5db7', 'demo_c_tape', 0, 40, '');
INSERT INTO `consumable_operation_detail` VALUES ('741ffe4604f44a31b212cfe8ef7ac742', '37b013292af7439aa9dcee2d4bdb92af', 'demo_c_tape', 0, 5, '');
INSERT INTO `consumable_operation_detail` VALUES ('demo_op_detail_1', 'demo_op_1', 'demo_c_a4', 2, 40, '期初入库');
INSERT INTO `consumable_operation_detail` VALUES ('demo_op_detail_2', 'demo_op_1', 'demo_c_pen', 2, 300, '期初入库');
INSERT INTO `consumable_operation_detail` VALUES ('demo_op_detail_3', 'demo_op_2', 'demo_c_keyboard', 0, 12, '设备替换领用');
INSERT INTO `consumable_operation_detail` VALUES ('demo_op_detail_4', 'demo_op_2', 'demo_c_bag', 0, 25, '保洁日常领用');
INSERT INTO `consumable_operation_detail` VALUES ('demo_op_detail_5', 'demo_op_3', 'demo_c_box', 2, 100, '备用仓补货');

-- ----------------------------
-- Table structure for consumable_operation_history
-- ----------------------------
DROP TABLE IF EXISTS `consumable_operation_history`;
CREATE TABLE `consumable_operation_history`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `warehouse_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `user_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作人IP地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consumable_operation_history
-- ----------------------------
INSERT INTO `consumable_operation_history` VALUES ('37b013292af7439aa9dcee2d4bdb92af', 'demo_wh_backup', '5fb04e29a8ef4c769a44cf5397e38620', '2026-07-16 10:46:00', NULL);
INSERT INTO `consumable_operation_history` VALUES ('9e596ac0292848b49cb6999e2d0f5db7', 'demo_wh_backup', '5fb04e29a8ef4c769a44cf5397e38620', '2026-07-16 10:47:00', NULL);
INSERT INTO `consumable_operation_history` VALUES ('demo_op_1', 'demo_wh_main', '5fb04e29a8ef4c769a44cf5397e38620', '2026-07-08 00:17:12', NULL);
INSERT INTO `consumable_operation_history` VALUES ('demo_op_2', 'demo_wh_main', '5fb04e29a8ef4c769a44cf5397e38620', '2026-07-10 00:17:12', NULL);
INSERT INTO `consumable_operation_history` VALUES ('demo_op_3', 'demo_wh_backup', '5fb04e29a8ef4c769a44cf5397e38620', '2026-07-12 00:17:12', NULL);

-- ----------------------------
-- Table structure for consumable_reference_information
-- ----------------------------
DROP TABLE IF EXISTS `consumable_reference_information`;
CREATE TABLE `consumable_reference_information`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `consumable_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `reference_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `reference_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `display_order` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consumable_reference_information
-- ----------------------------
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_a4_1', 'demo_c_a4', '存放位置', 'A区-01货架', 1);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_a4_2', 'demo_c_a4', '计量单位', '包', 2);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_a4_3', 'demo_c_a4', '采购周期', '7天', 3);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_bag_1', 'demo_c_bag', '存放位置', 'C区-02货架', 1);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_bag_2', 'demo_c_bag', '计量单位', '卷', 2);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_box_1', 'demo_c_box', '存放位置', 'D区-01货架', 1);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_box_2', 'demo_c_box', '计量单位', '个', 2);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_cleaner_1', 'demo_c_cleaner', '存放位置', 'C区-01货架', 1);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_cleaner_2', 'demo_c_cleaner', '计量单位', '瓶', 2);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_keyboard_1', 'demo_c_keyboard', '存放位置', 'B区-02货架', 1);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_keyboard_2', 'demo_c_keyboard', '计量单位', '个', 2);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_mouse_1', 'demo_c_mouse', '存放位置', 'B区-01货架', 1);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_mouse_2', 'demo_c_mouse', '计量单位', '个', 2);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_pen_1', 'demo_c_pen', '存放位置', 'A区-02货架', 1);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_pen_2', 'demo_c_pen', '计量单位', '支', 2);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_tape_1', 'demo_c_tape', '存放位置', 'D区-02货架', 1);
INSERT INTO `consumable_reference_information` VALUES ('demo_ref_tape_2', 'demo_c_tape', '计量单位', '卷', 2);

-- ----------------------------
-- Table structure for operation
-- ----------------------------
DROP TABLE IF EXISTS `operation`;
CREATE TABLE `operation`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '操作履历ID',
  `user_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户ID',
  `operation` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '操作',
  `ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'IP地址',
  `create_time` datetime NOT NULL COMMENT '操作日期',
  `method` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '操作请求路径',
  `params` varchar(8192) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作请求参数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operation
-- ----------------------------
INSERT INTO `operation` VALUES ('00284ec387f944639c3d2b3e03a0bffe', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取操作履历(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.COperationHistoryController.getOperationHistorys', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('03f475cea06b4dcd98d5394c8a38eb2c', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_main\"]');
INSERT INTO `operation` VALUES ('05ba724fa8fe4b39bdc35539fc31d754', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '192.168.1.154', '2026-07-16 10:47:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables [4ms]', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('071065ba91db43a7b3ef9a86feda24cd', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables [5ms]', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('0918c3961bd3465cafa950b53dd5bd91', '', '登录', '127.0.0.1', '2026-07-13 16:42:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"2\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('094dca56234f4fbdb788da00a4ead2a7', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('0a2a043143ba48fcb7447720d62163e0', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [4ms]', '[{\"pageNum\":2,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('0e51a7e13a5746e7a7898863d0658776', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部类型信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CTypeController.getTypes', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('10410112e5564c01aad918b6af7f4f75', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables [4ms]', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('105fc0046f5f45ccb6d5c08e2d968689', '', '登录', '127.0.0.1', '2026-07-14 00:16:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('12fe1f57ba32497fa154ed60ea3d3924', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部基准信息模板(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CReferenceInformationTempalteController.getReferenceInformationTemplates', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('134667f46e284c1e88bacdc9f5ba7c68', '', '登录', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.LoginController.login [10ms]', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"3\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('15b1e659887a4ccf8d89619750903c99', '', '登录', '127.0.0.1', '2026-07-13 16:27:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('172b2257af6f4f9f83ba81416a36a67c', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：切换仓库', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.LoginController.switchSystem [6ms]', '');
INSERT INTO `operation` VALUES ('1bf4a1d5c6d8462596b482e8567ee74a', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：出库', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CConsumableController.outboundConsumables [7ms]', '[{\"id\":\"demo_c_tape\",\"outboundCount\":10000,\"remarks\":\"\",\"type\":0,\"warehouseId\":\"demo_wh_backup\"}]');
INSERT INTO `operation` VALUES ('1db193a594e9425d8c424c6cee48073d', '', '登录', '127.0.0.1', '2026-07-13 16:41:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"3\"}]');
INSERT INTO `operation` VALUES ('1dfd629c2c8244ee86b85cb74c14a437', '', '登录', '127.0.0.1', '2026-07-13 16:25:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('21580c2f8c48471ea4824b59cc46ea8e', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品申请系统：获取全部申请信息(分页)', '192.168.1.154', '2026-07-16 10:45:00', 'frame.server.controller.application.AApplicationController.getApplications [13ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{}}]');
INSERT INTO `operation` VALUES ('238ada83bd804c13820239e8a69cdcd3', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('23c7339891fd402aa754eb3274def767', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [5ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('246d3cbe73e341c0ad3f1719b2df30dd', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('26aaee9bef2e47b7b8cb68b2b737a1ce', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CStatisticsController.getConsumables', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('27f4371ef943439d85093d27d86cb360', '', '登录', '192.168.1.154', '2026-07-16 10:45:00', 'frame.server.controller.LoginController.login [221ms]', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"2\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('29c1cc4e207949febfc575e66c4830c6', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取用户信息(分页)', '10.215.66.233', '2026-07-15 16:14:00', 'frame.server.controller.warehouse.WUserController.getUsers', '[{\"pageNum\":1,\"pageSize\":30}]');
INSERT INTO `operation` VALUES ('2b0e493c20814d74a58e756c11038c04', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:47:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [4ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\",\"isViewAlarmData\":true}}]');
INSERT INTO `operation` VALUES ('2b5b904d34df44a8ab048825a67dde89', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:49:00', 'frame.server.controller.consumables.COperationLogController.getLogs [2ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('2c2ac68bd7ff4237ba516531eaa103d9', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [3ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('2cbcdaccfe8a4feea1af8533278a9067', '', '登录', '127.0.0.1', '2026-07-13 16:41:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"2\"}]');
INSERT INTO `operation` VALUES ('2d312f147c6c4168b5cf9e970edadd58', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables [4ms]', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('2f3bdcaffc7644ea8de1759ff42d17d1', '', '登录', '127.0.0.1', '2026-07-13 16:24:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('30fda640f7014b56bdbf6c766428185a', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取首页数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getInitData', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('31c638c79c7c4b31b734ee0b142b687f', 'demo_user_admin', '登出', '127.0.0.1', '2026-07-13 16:24:00', 'frame.server.controller.LoginController.logout', '');
INSERT INTO `operation` VALUES ('333a6d897451401bbc9ac4373bfb304a', 'demo_user_admin', '消耗品管理系统-获取全部消耗品信息(分页)', '127.0.0.1', '2026-07-13 16:24:00', 'frame.server.controller.consumables.CConsumableController.getConsumables', '[{\"pageNum\":1,\"pageSize\":5}]');
INSERT INTO `operation` VALUES ('33626261b10d49f8a1553bc52aea65ee', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('359e542e940e4c89b9f5e86edeb86a1c', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('3720fb8e16dc42f6913783e57360b97e', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [8ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"searchStr\":\"\",\"warehouseId\":\"demo_wh_backup\",\"searchType\":\"1\",\"startTime\":\"\",\"endTime\":\"\",\"isViewAlarmData\":true}}]');
INSERT INTO `operation` VALUES ('39a2eb9866d54d0a9d2a8f7996fc2d20', '', '登录', '127.0.0.1', '2026-07-13 16:42:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('3ab620ab887142519441fb6c6495c5d6', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部类型信息(分页)', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CTypeController.getTypes', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('3aeb9d2261904c9980a1be68ed5e2690', '', '登录', '127.0.0.1', '2026-07-13 16:42:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"2\"}]');
INSERT INTO `operation` VALUES ('3ea08f012caa4f9784ec5b4a5ed8f103', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部类型信息(分页)', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CTypeController.getTypes', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('401c1d8cb2814156bab8c0edd33dfd5a', '', '登录', '127.0.0.1', '2026-07-13 16:42:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\"}]');
INSERT INTO `operation` VALUES ('4033077646774a22a7e65d1f5dbd767c', '', '登录', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('404d7b1c0b06476c868d6ace60be03b9', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('40658659958a4144a1afdf365ef75b47', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：出库', '192.168.1.154', '2026-07-16 10:47:00', 'frame.server.controller.consumables.CConsumableController.outboundConsumables [20ms]', '[{\"id\":\"demo_c_tape\",\"outboundCount\":40,\"remarks\":\"\",\"type\":0,\"warehouseId\":\"demo_wh_backup\"}]');
INSERT INTO `operation` VALUES ('41200ad0992d416ab0b0ad0660d3c1c4', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部申请信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CApplicationController.getApplications', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('444a9b7e86334d008c1391f7f6b4cd2e', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('45325c29095c43828c93bc15893d6370', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [2ms]', '[{\"pageNum\":5,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('461e40fc929841db99695414d5c77d20', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取首页数据', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CHomeController.getInitData [10ms]', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('471d6f3e2b1e438bb7fa4648dc2cbbd1', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('4ab6131b0c3e428a91213cde82810622', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('4ae90d54ba3147888cc471f8f70bed7b', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取用户信息(分页)', '10.215.66.233', '2026-07-15 16:14:00', 'frame.server.controller.warehouse.WUserController.getUsers', '[{\"pageNum\":1,\"pageSize\":30}]');
INSERT INTO `operation` VALUES ('4c28cb3d15fb46c1b6a9c3016db3c45e', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('4e8801713f2243c4874584b8edb191a7', '5fb04e29a8ef4c769a44cf5397e38620', '登出', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.LoginController.logout', '');
INSERT INTO `operation` VALUES ('4ee4e418d3914ea8b48c0ed7ea5a271e', '', '登录', '127.0.0.1', '2026-07-14 00:17:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('51943210bc8848409b8eb1fcec7f3b1c', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部用户信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CUserController.getUsers', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('529975e8d4c9457ca9883e30802aec54', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '192.168.1.154', '2026-07-16 10:47:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables [4ms]', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('548684ea8df249e6951c4e9b8b1f80dd', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [6ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"searchStr\":\"\",\"warehouseId\":\"demo_wh_backup\",\"searchType\":\"1\",\"startTime\":\"\",\"endTime\":\"\",\"isViewAlarmData\":true}}]');
INSERT INTO `operation` VALUES ('56213686d84649bd8223dabbe4ebf854', '', '登录', '127.0.0.1', '2026-07-13 16:24:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('58d54fa7ca6f499baae3765ad7ddadc1', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [2ms]', '[{\"pageNum\":2,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('58fd7eb45cbe4925b0fc1c2b63ecb3f5', '', '登录', '127.0.0.1', '2026-07-13 16:26:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"2\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('5a3e3ec461684e9f863d9430616e8afa', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('5df513a1935445d39abeb84c23cd4b7d', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取初始化数据', '10.215.66.233', '2026-07-15 16:14:00', 'frame.server.controller.warehouse.WHomeController.getInitData', '');
INSERT INTO `operation` VALUES ('621194bf0be94a6ea8d9c2d236681a23', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [8ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"searchStr\":\"\",\"warehouseId\":\"demo_wh_backup\",\"searchType\":\"1\",\"startTime\":\"\",\"endTime\":\"\",\"isViewAlarmData\":false}}]');
INSERT INTO `operation` VALUES ('627e5fb545da4300b8187b1c2c05aec6', '', '登录', '127.0.0.1', '2026-07-13 16:21:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('62c9323ef996414d86868bb6eb748f8d', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部申请信息(分页)', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CApplicationController.getApplications', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('665e8eb6eea44b1a9795ffeb90237ccd', '', '登录', '10.215.66.233', '2026-07-14 18:32:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"3\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('66fbd155436a40ad9c04a6e0b01dab1d', 'demo_user_admin', '消耗品管理系统-获取全部消耗品信息(分页)', '127.0.0.1', '2026-07-13 16:24:00', 'frame.server.controller.consumables.CConsumableController.getConsumables', '[{\"pageNum\":1,\"pageSize\":5}]');
INSERT INTO `operation` VALUES ('6773eb6cc35c475491e5929eb7b0a628', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('68a77f8a9ad84cdca883b893888d8d26', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:47:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [8ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"searchStr\":\"\",\"warehouseId\":\"demo_wh_backup\",\"searchType\":\"1\",\"startTime\":\"\",\"endTime\":\"\",\"isViewAlarmData\":true}}]');
INSERT INTO `operation` VALUES ('6a7426e0c06c4da6a75f68ca6b30ce7d', '', '登录', '127.0.0.1', '2026-07-14 00:16:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('6b5f73df06a245a2afbe4499ed145e4f', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [2ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('6e106db3d4a54bdf8ff69080e61db153', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('71cef3233321444ba7ce3a7c184645a9', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('727bb5f04153479b9f0f02b8c8e67608', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('765f2fa004c940e3aa50a76999faf965', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '192.168.1.154', '2026-07-16 10:49:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables [5ms]', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('77276f87d3d7430cbe73faf773cbcd35', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取仓库信息(分页)', '10.215.66.233', '2026-07-15 16:14:00', 'frame.server.controller.warehouse.WWarehouseController.getWarehouses', '[{\"pageNum\":1,\"pageSize\":30}]');
INSERT INTO `operation` VALUES ('77e67a3af5ac4b898a8d4ec84da46354', '5fb04e29a8ef4c769a44cf5397e38620', '登出', '192.168.1.154', '2026-07-16 10:45:00', 'frame.server.controller.LoginController.logout [0ms]', '');
INSERT INTO `operation` VALUES ('77ecb59cf829407bbcfc761b24c9892a', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品申请系统：获取全部申请信息(分页)', '192.168.1.154', '2026-07-16 10:45:00', 'frame.server.controller.application.AApplicationController.getApplications [9ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{}}]');
INSERT INTO `operation` VALUES ('78a1afdfba104e5294dca22f05d7bc39', '', '登录', '127.0.0.1', '2026-07-13 16:24:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('78b2e02a08bb43329bb0620bcb466f3a', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取操作履历(分页)', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.COperationHistoryController.getOperationHistorys', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('78ead16aeff244e9bfcecf283152a2bc', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('7a835f663bbe4e38b439b93e297f9d18', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:47:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [3ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\",\"isViewAlarmData\":true}}]');
INSERT INTO `operation` VALUES ('7cfcd41ad1ea47a288babd1736777dc1', '', '登录', '127.0.0.1', '2026-07-13 16:19:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('7d0c17a52958414eb24efd147276aa9f', '', '登录', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('7d47bc83fe12407e988951b6b89a3982', '', '登录', '127.0.0.1', '2026-07-13 16:26:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('7f2d913210d4440ca3eb4fdbb3be289a', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部用户信息(分页)', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CUserController.getUsers', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('81d1132d2c68428380e66b95e0f93d02', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('83ff77ebc9644b19bc92d6b47939166e', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('8468291b6eec4608aba93136cf1e2422', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取初始化数据', '10.215.66.233', '2026-07-15 16:14:00', 'frame.server.controller.warehouse.WHomeController.getInitData', '');
INSERT INTO `operation` VALUES ('8cc978b0353245b9a7188713f3ea0873', '', '登录', '127.0.0.1', '2026-07-13 16:42:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"3\"}]');
INSERT INTO `operation` VALUES ('8f44e8d0c3964a63870825939d97f391', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部用户信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CUserController.getUsers', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('902022f22e1b47cf919de2bf4ec9be35', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [3ms]', '[{\"pageNum\":2,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('90cb959796324eab9da1173b3f524e94', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取用户信息(分页)', '10.215.66.233', '2026-07-15 16:14:00', 'frame.server.controller.warehouse.WUserController.getUsers', '[{\"pageNum\":1,\"pageSize\":30}]');
INSERT INTO `operation` VALUES ('916273bf76274f9aac607db1e1f404e1', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [3ms]', '[{\"pageNum\":4,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('91627f1aa58e4a229d7fc6db4ed3e8c7', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('941c43f4f2e94b67aac69b929c3dce65', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：出库', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CConsumableController.outboundConsumables [28ms]', '[{\"id\":\"demo_c_tape\",\"outboundCount\":5,\"remarks\":\"\",\"type\":0,\"warehouseId\":\"demo_wh_backup\"}]');
INSERT INTO `operation` VALUES ('958369bf23cd4ece9946f6bbee536405', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('95ba471c750a446caf8c54bb8013f31d', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [22ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('96d48b8cd3384117a24e27924670fb14', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('9793222cb9db43e8930a1c52045336dd', '', '登录', '127.0.0.1', '2026-07-13 16:41:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\"}]');
INSERT INTO `operation` VALUES ('996bc287813548e7bfb658e5773e9114', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables [8ms]', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('99e0bbf0ccf940ef8310444eb9655c36', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [3ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('9b0e353f8ed44bd184b4a5696a22e03d', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部申请信息(分页)', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CApplicationController.getApplications', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('9dd5760f68ad4b249cf02b9e23117799', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取申请用户信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CUserController.getApplicationUsers', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('a21ff8274a944cb08da48b9eb9e8d8c2', '', '登录', '127.0.0.1', '2026-07-13 16:19:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('a31bcb4eebcd4c2882140f7e35d9199d', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [2ms]', '[{\"pageNum\":6,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('a8d13443a8b44ef68188747c96cefcf0', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取初始化数据', '10.215.66.233', '2026-07-14 18:32:00', 'frame.server.controller.warehouse.WHomeController.getInitData', '');
INSERT INTO `operation` VALUES ('aa470575812e4eff833f827bde40e05c', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [4ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"searchStr\":\"\",\"warehouseId\":\"demo_wh_backup\",\"searchType\":\"1\",\"startTime\":\"\",\"endTime\":\"\",\"isViewAlarmData\":false}}]');
INSERT INTO `operation` VALUES ('aa71fdb89e8c42269b1423dba4ef03d2', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('aa77c79154ca491a8d26b68d1f960aa4', 'demo_user_admin', '消耗品管理系统：获取首页数据', '127.0.0.1', '2026-07-13 16:25:00', 'frame.server.controller.consumables.CHomeController.getInitData', '[\"demo_wh_main\"]');
INSERT INTO `operation` VALUES ('ab535bf5bf76443e8257568bc1b6e350', 'demo_user_admin', '登出', '127.0.0.1', '2026-07-13 16:19:00', 'frame.server.controller.LoginController.logout', '');
INSERT INTO `operation` VALUES ('acc04cfba9a040459389c54b26997a0b', 'demo_user_admin', '登出', '127.0.0.1', '2026-07-13 16:25:00', 'frame.server.controller.LoginController.logout', '');
INSERT INTO `operation` VALUES ('aded5d21acda4e0ba3b4db711bcef818', 'demo_user_admin', '登出', '127.0.0.1', '2026-07-13 16:24:00', 'frame.server.controller.LoginController.logout', '');
INSERT INTO `operation` VALUES ('ae47f484af4444a4b64aa4f0b9643744', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables [6ms]', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('b1f2a27074114a639d107ae184ac1f68', '', '登录', '127.0.0.1', '2026-07-13 16:24:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('b211b93e517b4022be81dd9ac9bfefde', '', '登录', '127.0.0.1', '2026-07-13 16:27:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"3\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('b6473595aa224ea78806b9d91791719c', '', '登录', '127.0.0.1', '2026-07-13 16:27:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"3\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('b83874a73e9843e9a181a45be3a7e8a5', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [2ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('b9d2b31dd9af4a5db7f5af15eda52afa', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('bb83752498634800bb38ed7b67cb3894', '', '登录', '127.0.0.1', '2026-07-13 16:22:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('bbb8e28325aa45bb85535aff68f8ad58', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取用户信息(分页)', '10.215.66.233', '2026-07-14 18:33:00', 'frame.server.controller.warehouse.WUserController.getUsers', '[{\"pageNum\":1,\"pageSize\":30}]');
INSERT INTO `operation` VALUES ('bcfbdc2747e74db294b426b1cc41769f', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取首页数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getInitData', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('bf5f3014638343f8a3d362ebb39e54bb', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('c04a18448de647eba3a5a90258ac8c2c', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('c2c1d04b18c749a383186d314a703a98', '', '登录', '127.0.0.1', '2026-07-13 16:42:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('c2f69399486947d39b95fcee9d1405d0', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CStatisticsController.getConsumables', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('c3ff74932d7949ac9a93a24360f6a095', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('c581bc0114514377925b373190c22ffc', 'demo_user_admin', '消耗品管理系统：获取首页数据', '127.0.0.1', '2026-07-13 16:24:00', 'frame.server.controller.consumables.CHomeController.getInitData', '[\"demo_wh_main\"]');
INSERT INTO `operation` VALUES ('c6b020df68074d0d95916ab4f2905d8e', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部角色信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CRoleController.getRoles', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('ca6f9763ba08436b90729eae4523e5f9', '', '登录', '127.0.0.1', '2026-07-13 16:25:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('cb5086d9cb37466f826cf1e6bc768ac4', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取首页数据', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CHomeController.getInitData', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('cc1b8265bd18458898a3e4c2305e9367', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品申请系统：获取全部申请信息(分页)', '192.168.1.154', '2026-07-16 10:45:00', 'frame.server.controller.application.AApplicationController.getApplications [16ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{}}]');
INSERT INTO `operation` VALUES ('cdd2fb7dd9e042eea4520a0f8b527832', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('cebf2a938a824e7684cb99c30eb5b93a', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:48:00', 'frame.server.controller.consumables.COperationLogController.getLogs [6ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('cf1b4e7a359c4313aed3280b2ac72c51', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取仓库信息(分页)', '10.215.66.233', '2026-07-15 16:14:00', 'frame.server.controller.warehouse.WWarehouseController.getWarehouses', '[{\"pageNum\":1,\"pageSize\":30}]');
INSERT INTO `operation` VALUES ('cf3806eeae504b67ad9b971e56a46bdd', '', '登录', '127.0.0.1', '2026-07-13 16:25:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"3\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('cf7e4848159b40d3bdadaf012a0beece', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取系统操作日志', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationLogController.getLogs [2ms]', '[{\"pageNum\":3,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('d14eb62e1e7a4a6ea37f29cfbd41f251', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:47:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [6ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\",\"isViewAlarmData\":true}}]');
INSERT INTO `operation` VALUES ('d1a34c7662594e2487d21e6ff1b84bc1', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部角色信息(分页)', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CRoleController.getRoles', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_main\"}}]');
INSERT INTO `operation` VALUES ('d269cfdb0774448eb730067d4ea7c847', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('d2f8468b64b0452bb25c9333fa984789', '', '登录', '127.0.0.1', '2026-07-13 16:25:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"1\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('d359179254094e2cbc4fd95169bec55f', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:49:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [7ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('d5921b29bbe04224ae6928bd1b5b9604', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部用户信息(分页)', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CUserController.getUsers', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_main\"}}]');
INSERT INTO `operation` VALUES ('db0628316c3049efb2073531997854d1', 'demo_user_admin', '消耗品管理系统：获取首页数据', '127.0.0.1', '2026-07-13 16:24:00', 'frame.server.controller.consumables.CHomeController.getInitData', '[\"demo_wh_main\"]');
INSERT INTO `operation` VALUES ('db311a1f1d914c63a076df0c472dde5f', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部角色信息(分页)', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CRoleController.getRoles', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('dc4fa8e5a8bc4501a6cc6f0a43b2702c', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取操作履历(分页)', '192.168.1.154', '2026-07-16 10:50:00', 'frame.server.controller.consumables.COperationHistoryController.getOperationHistorys [9ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('dd97e3ccb8a54d43b2256517026e9479', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CConsumableController.getConsumables', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('e23e9963902a4c7385a1dcf86205bad4', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '192.168.1.154', '2026-07-16 10:47:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables [6ms]', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('e27f8387f99d4c589432a872263bdd0c', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取用户信息(分页)', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.warehouse.WUserController.getUsers [16ms]', '[{\"pageNum\":1,\"pageSize\":30}]');
INSERT INTO `operation` VALUES ('e3e9a45593e249138f87f2b41d7a679b', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('e5133f91f03041518875da69d30744bb', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CConsumableController.getConsumables', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('ea2db48fca7b4e6e9cc1c01dab0931b5', '', '登录', '127.0.0.1', '2026-07-13 16:26:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"3\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('f03dda3fa5f34b0ba42020ba4dab2a74', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部角色信息(分页)', '10.215.66.233', '2026-07-15 16:21:00', 'frame.server.controller.consumables.CRoleController.getRoles', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('f03fe35f9705453da3d63eef38e1f521', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部消耗品信息(分页)', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.consumables.CConsumableController.getConsumables [4ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\",\"isViewAlarmData\":true}}]');
INSERT INTO `operation` VALUES ('f0b01090884b4727bb8a070a08eb104f', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品申请系统：获取全部申请信息(分页)', '192.168.1.154', '2026-07-16 10:45:00', 'frame.server.controller.application.AApplicationController.getApplications [17ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{}}]');
INSERT INTO `operation` VALUES ('f0e3c018da354e5ea8cfae29e8c79860', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取申请用户信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CUserController.getApplicationUsers', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('f1fa9b8794b84750889e4abb50588bdc', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '127.0.0.1', '2026-07-14 00:41:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_main\"]');
INSERT INTO `operation` VALUES ('f309aa347e8746bba0e0652438a4840b', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取初始化数据', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.warehouse.WHomeController.getInitData [4ms]', '');
INSERT INTO `operation` VALUES ('f4b0bfcceb3f4c8e80abae508cbaf733', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('f5036e0ebb6842788b281377453519f7', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统-获取全部角色信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CRoleController.getRoles', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');
INSERT INTO `operation` VALUES ('f6f14e86cf5c469788bd0e6de63fab3a', 'demo_user_admin', '登出', '127.0.0.1', '2026-07-13 16:19:00', 'frame.server.controller.LoginController.logout', '');
INSERT INTO `operation` VALUES ('f7fa5ff41d9a42dc9d49a3656f45077f', '', '登录', '10.215.66.233', '2026-07-15 16:14:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"3\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('f89885c389b2456f98ddd2ee5f54b620', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取仓库信息(分页)', '10.215.66.233', '2026-07-15 16:14:00', 'frame.server.controller.warehouse.WWarehouseController.getWarehouses', '[{\"pageNum\":1,\"pageSize\":30}]');
INSERT INTO `operation` VALUES ('f9db29845f6a46eda11731749e230926', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品申请系统：获取全部申请信息(分页)', '192.168.1.154', '2026-07-16 10:45:00', 'frame.server.controller.application.AApplicationController.getApplications [64ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{}}]');
INSERT INTO `operation` VALUES ('fac373430206406dae535f28bfaa56fa', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取报警消耗品数据', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CHomeController.getAlarmConsumables', '[\"demo_wh_backup\"]');
INSERT INTO `operation` VALUES ('fbf69294c41d4a6cb914582ccde4d218', '', '登录', '127.0.0.1', '2026-07-13 16:42:00', 'frame.server.controller.LoginController.login', '[{\"account\":\"kmgzs0713@163.com\",\"password\":\"xA123456\",\"rememberMe\":false,\"target\":\"3\",\"type\":\"WEB\"}]');
INSERT INTO `operation` VALUES ('fe005d1b39cc403baa0383308e851147', '5fb04e29a8ef4c769a44cf5397e38620', '仓库管理系统：获取仓库信息(分页)', '192.168.1.154', '2026-07-16 10:46:00', 'frame.server.controller.warehouse.WWarehouseController.getWarehouses [9ms]', '[{\"pageNum\":1,\"pageSize\":30}]');
INSERT INTO `operation` VALUES ('fe0ad3bb1f5c404eaafbf523425cb375', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品申请系统：获取全部申请信息(分页)', '192.168.1.154', '2026-07-16 10:45:00', 'frame.server.controller.application.AApplicationController.getApplications [22ms]', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{}}]');
INSERT INTO `operation` VALUES ('fe4344ded7a84746814974a760961baa', '', '初始化数据库', '127.0.0.1', '2026-07-14 00:16:00', 'frame.server.controller.InitDatabaseController.initAll', '');
INSERT INTO `operation` VALUES ('fe9e579b0a6147f6b0d4d05c799fa8ac', '5fb04e29a8ef4c769a44cf5397e38620', '消耗品管理系统：获取全部用户信息(分页)', '10.215.66.233', '2026-07-15 16:15:00', 'frame.server.controller.consumables.CUserController.getUsers', '[{\"pageNum\":1,\"pageSize\":30,\"searchCondition\":{\"warehouseId\":\"demo_wh_backup\"}}]');

-- ----------------------------
-- Table structure for operation_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `operation_snapshot`;
CREATE TABLE `operation_snapshot`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `operation_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '关联operation表',
  `entity_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实体类型',
  `entity_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实体ID',
  `field_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '字段名',
  `old_value` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '修改前的值',
  `new_value` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '修改后的值',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_operation_id`(`operation_id` ASC) USING BTREE,
  INDEX `idx_entity`(`entity_type` ASC, `entity_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operation_snapshot
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '权限ID',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '权限名',
  `str` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '权限标识',
  `display_order` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('063a85552add445d8f7183db01a13797', '批量导入', 'c_user_import', 350);
INSERT INTO `permission` VALUES ('0a3adcc58ef94a7099069ec6e8ed374d', '批量导出', 'c_role_export', 250);
INSERT INTO `permission` VALUES ('0c2d6f746c8d4fbabdb1e738fa1d63dd', '添加', 'c_user_add', 300);
INSERT INTO `permission` VALUES ('0fedf05251574ccd9ed19b9d9d9800a3', '状态管理', 'c_user_state_management', 340);
INSERT INTO `permission` VALUES ('1097d1b5f75d472288f37478cbdcee44', '添加', 'c_role_add', 200);
INSERT INTO `permission` VALUES ('1271b1112cf84d5180aa14fdbc66dc1a', '删除', 'c_consumables_delete', 510);
INSERT INTO `permission` VALUES ('13b54205c96b42db8ad594a580135aca', '状态管理', 'c_application_state_management', 610);
INSERT INTO `permission` VALUES ('1882c9c84d624d99af20e0fb31c4cfa3', '查看', 'c_user_select', 330);
INSERT INTO `permission` VALUES ('18fbd704367b4f8aaf480f6daf07dcc0', '修改', 'c_role_update', 220);
INSERT INTO `permission` VALUES ('1ba1992c802f4f1eacb00184cb3150a0', '登录', 'c_login', 100);
INSERT INTO `permission` VALUES ('26c769f950374b63b7bcb09636188914', '修改', 'c_referenceInformationTemplate_update', 920);
INSERT INTO `permission` VALUES ('29ff790c59f5480396cd218c8e01d8b9', '批量导出', 'c_consumables_export', 580);
INSERT INTO `permission` VALUES ('390df43b60514eebb656bca660eae3a0', '删除', 'c_referenceInformationTemplate_delete', 910);
INSERT INTO `permission` VALUES ('4abb36e1bd754d95bed268b7a251f946', '出库', 'c_consumables_outbound', 560);
INSERT INTO `permission` VALUES ('4e8fda10295449a88597967ebd6d7083', '查看', 'c_referenceInformationTemplate_select', 930);
INSERT INTO `permission` VALUES ('4f45bf3a61fb432e85bdc5cd44dfb13d', '添加', 'c_referenceInformationTemplate_add', 900);
INSERT INTO `permission` VALUES ('4f6a7f5c3ba140239a4e3247249bd4f8', '查看', 'c_consumables_select', 530);
INSERT INTO `permission` VALUES ('50ce206a638c4119b095e5ae431cb3c8', '修改', 'c_consumablesType_update', 420);
INSERT INTO `permission` VALUES ('510af109337144aa83db9d8bc4c655be', '状态管理', 'c_consumablesType_state_management', 440);
INSERT INTO `permission` VALUES ('55658da1ad0e4286bdde9c07db79222e', '添加', 'c_consumables_add', 500);
INSERT INTO `permission` VALUES ('56997572ebb945d39bf7644e2cd25c4d', '批量导出', 'c_statistics_export', 810);
INSERT INTO `permission` VALUES ('5a3f925785274e3c9a5bff0dce40e20b', '修改', 'c_consumables_update', 520);
INSERT INTO `permission` VALUES ('5d8c78ac1fad43b09133881fb98af5fa', '批量导出', 'c_consumablesType_export', 460);
INSERT INTO `permission` VALUES ('6efb4f4dea96405ab1f783435ee4a369', '查看', 'c_userOperate_select', 700);
INSERT INTO `permission` VALUES ('718ebe29eae64e3c99b34840897a65f0', '状态管理', 'c_consumables_state_management', 540);
INSERT INTO `permission` VALUES ('7a8c0b7ca28d4ec19ef1b4508e08d8d4', '批量导入', 'c_consumablesType_import', 450);
INSERT INTO `permission` VALUES ('86ba7173d8ef4b9e918ab0b571935351', '删除', 'c_role_delete', 210);
INSERT INTO `permission` VALUES ('955a79b936a84ef8a10b520d2b2c58e4', '删除', 'c_user_delete', 310);
INSERT INTO `permission` VALUES ('9c4d07b5dea54110b8ad51eac40126f6', '批量导入', 'c_consumables_import', 570);
INSERT INTO `permission` VALUES ('a6015cd9bf7748269f77d36c3c2f10f5', '批量导入', 'c_role_import', 240);
INSERT INTO `permission` VALUES ('a90d25ff72ee4a478fd8e81721615f0b', '查看', 'c_statistics_select', 800);
INSERT INTO `permission` VALUES ('b5e6097de60940b28373dfb3ce000e18', '入库', 'c_consumables_inbound', 550);
INSERT INTO `permission` VALUES ('b91645763aab4c50878d3ab46b7d14a3', '查看', 'c_application_select', 600);
INSERT INTO `permission` VALUES ('b97ed15582884da190762edcb4c58741', '修改', 'c_user_update', 320);
INSERT INTO `permission` VALUES ('b9c83d703b6a457c8616ea7dd64375ae', '删除', 'c_consumablesType_delete', 410);
INSERT INTO `permission` VALUES ('bc1ad606dcd04208838dacc83c02abe7', '查看', 'c_role_select', 230);
INSERT INTO `permission` VALUES ('ce963e5091564b9aab60f7ac78a5ccc5', '登录', 'w_login', 0);
INSERT INTO `permission` VALUES ('d150347485c04b368d35f3b2a0f998ea', '查看', 'c_consumablesType_select', 430);
INSERT INTO `permission` VALUES ('e56dba6f6f5e430b8a7ed9894f6c81d1', '批量导出', 'c_user_export', 360);
INSERT INTO `permission` VALUES ('e5961316ba2547e29b838cd2ec3ee995', '批量导出', 'c_userOperate_export', 710);
INSERT INTO `permission` VALUES ('ecf137ca302741b38841e2693caf1c60', '添加', 'c_consumablesType_add', 400);
INSERT INTO `permission` VALUES ('fd29affcf02b4d11b3be0b721cac226d', '登录', 'a_login', 2000);

-- ----------------------------
-- Table structure for reference_information_template
-- ----------------------------
DROP TABLE IF EXISTS `reference_information_template`;
CREATE TABLE `reference_information_template`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `warehouse_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_system` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reference_information_template
-- ----------------------------
INSERT INTO `reference_information_template` VALUES ('1920b038fc0e4c338bfc4dfee3d494bb', '', '基准信息标准模板', '系统内置', '2026-07-14 00:16:00', b'1', b'0');

-- ----------------------------
-- Table structure for reference_information_template_detail
-- ----------------------------
DROP TABLE IF EXISTS `reference_information_template_detail`;
CREATE TABLE `reference_information_template_detail`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `reference_information_template_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `reference_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `display_order` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reference_information_template_detail
-- ----------------------------
INSERT INTO `reference_information_template_detail` VALUES ('03b4ca7609a947859e6347654a2ee352', '1920b038fc0e4c338bfc4dfee3d494bb', '适用工程1', 4);
INSERT INTO `reference_information_template_detail` VALUES ('0abcb0b6d8d14cfe866500eb00e5161d', '1920b038fc0e4c338bfc4dfee3d494bb', '安全库存', 10);
INSERT INTO `reference_information_template_detail` VALUES ('25174a78490e46589d6b45faec918150', '1920b038fc0e4c338bfc4dfee3d494bb', '适用工程', 3);
INSERT INTO `reference_information_template_detail` VALUES ('484a5fdbc84f4796954434b68d6c5bea', '1920b038fc0e4c338bfc4dfee3d494bb', '适用机种', 6);
INSERT INTO `reference_information_template_detail` VALUES ('52f6ba420ee04ff880a9213ee02a5248', '1920b038fc0e4c338bfc4dfee3d494bb', '前周出库', 12);
INSERT INTO `reference_information_template_detail` VALUES ('71fea34666d3452d81e9d1f33fe6cfbc', '1920b038fc0e4c338bfc4dfee3d494bb', '子类2', 8);
INSERT INTO `reference_information_template_detail` VALUES ('932e3db0d330441385ca55019a743396', '1920b038fc0e4c338bfc4dfee3d494bb', '采购周期', 17);
INSERT INTO `reference_information_template_detail` VALUES ('9bb5b93cb3d8434a8b101a1efaddd511', '1920b038fc0e4c338bfc4dfee3d494bb', '子类（小类）', 2);
INSERT INTO `reference_information_template_detail` VALUES ('a1dacb6031b24408b7326b538c8986d3', '1920b038fc0e4c338bfc4dfee3d494bb', '当前库存', 11);
INSERT INTO `reference_information_template_detail` VALUES ('aa3db994d682417f9aec425bc28e6c75', '1920b038fc0e4c338bfc4dfee3d494bb', '子类1', 7);
INSERT INTO `reference_information_template_detail` VALUES ('b20529858a964aeeac16dfdbcb0e6968', '1920b038fc0e4c338bfc4dfee3d494bb', '前月出库', 13);
INSERT INTO `reference_information_template_detail` VALUES ('cf7d6f1cd2ce4178996bf4325f3c2644', '1920b038fc0e4c338bfc4dfee3d494bb', '业体', 16);
INSERT INTO `reference_information_template_detail` VALUES ('e47549ae8c114947849c31ecb1e2fbdd', '1920b038fc0e4c338bfc4dfee3d494bb', '库存金额', 15);
INSERT INTO `reference_information_template_detail` VALUES ('edd4446f32c04699a5aa931e03018321', '1920b038fc0e4c338bfc4dfee3d494bb', '单价', 14);
INSERT INTO `reference_information_template_detail` VALUES ('f1dec2d583b1497a81caed702d777103', '1920b038fc0e4c338bfc4dfee3d494bb', '单位', 9);
INSERT INTO `reference_information_template_detail` VALUES ('fd09d8aea7fd4171a28955e7386bc571', '1920b038fc0e4c338bfc4dfee3d494bb', '适用工程2', 5);
INSERT INTO `reference_information_template_detail` VALUES ('fff42a3255ed4449b848ec606b716673', '1920b038fc0e4c338bfc4dfee3d494bb', '位置', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色ID',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色名',
  `str` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色标识',
  `type` int NOT NULL COMMENT '角色类型',
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建日期',
  `is_stop` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否停用',
  `is_delete` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '仓库管理员', 'warehouse_admin', 2, '系统默认', '2026-07-14 00:16:00', b'0', b'0');
INSERT INTO `role` VALUES ('1a58638443df47a8af2a3fdb06812101', '根管理员', 'root_admin', 0, '系统默认', '2026-07-14 00:16:00', b'0', b'0');
INSERT INTO `role` VALUES ('791c733713ef4fce99e17864415d3dae', '系统管理员', 'system_admin', 1, '系统默认', '2026-07-14 00:16:00', b'0', b'0');
INSERT INTO `role` VALUES ('a34494db894647e492a4375242e1f1ea', '临时员工', 'temporary_employee', 1024, '系统默认', '2026-07-14 00:16:00', b'0', b'0');
INSERT INTO `role` VALUES ('be42fef38c324840a2e297869955a6d6', '普通员工', 'general_employee', 4, '系统默认', '2026-07-14 00:16:00', b'0', b'0');
INSERT INTO `role` VALUES ('d49ae3a0c98e45d791a5e09d9a884240', '申请人员', 'other_employee', 8, '系统默认', '2026-07-14 00:16:00', b'0', b'0');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `role_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色ID',
  `permission_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`, `permission_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '063a85552add445d8f7183db01a13797');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '0a3adcc58ef94a7099069ec6e8ed374d');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '0c2d6f746c8d4fbabdb1e738fa1d63dd');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '0fedf05251574ccd9ed19b9d9d9800a3');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '1097d1b5f75d472288f37478cbdcee44');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '1271b1112cf84d5180aa14fdbc66dc1a');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '13b54205c96b42db8ad594a580135aca');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '1882c9c84d624d99af20e0fb31c4cfa3');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '18fbd704367b4f8aaf480f6daf07dcc0');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '1ba1992c802f4f1eacb00184cb3150a0');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '26c769f950374b63b7bcb09636188914');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '29ff790c59f5480396cd218c8e01d8b9');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '390df43b60514eebb656bca660eae3a0');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '4abb36e1bd754d95bed268b7a251f946');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '4e8fda10295449a88597967ebd6d7083');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '4f45bf3a61fb432e85bdc5cd44dfb13d');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '4f6a7f5c3ba140239a4e3247249bd4f8');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '50ce206a638c4119b095e5ae431cb3c8');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '510af109337144aa83db9d8bc4c655be');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '55658da1ad0e4286bdde9c07db79222e');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '56997572ebb945d39bf7644e2cd25c4d');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '5a3f925785274e3c9a5bff0dce40e20b');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '5d8c78ac1fad43b09133881fb98af5fa');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '6efb4f4dea96405ab1f783435ee4a369');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '718ebe29eae64e3c99b34840897a65f0');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '7a8c0b7ca28d4ec19ef1b4508e08d8d4');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '86ba7173d8ef4b9e918ab0b571935351');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '955a79b936a84ef8a10b520d2b2c58e4');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', '9c4d07b5dea54110b8ad51eac40126f6');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'a6015cd9bf7748269f77d36c3c2f10f5');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'a90d25ff72ee4a478fd8e81721615f0b');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'b5e6097de60940b28373dfb3ce000e18');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'b91645763aab4c50878d3ab46b7d14a3');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'b97ed15582884da190762edcb4c58741');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'b9c83d703b6a457c8616ea7dd64375ae');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'bc1ad606dcd04208838dacc83c02abe7');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'd150347485c04b368d35f3b2a0f998ea');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'e56dba6f6f5e430b8a7ed9894f6c81d1');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'e5961316ba2547e29b838cd2ec3ee995');
INSERT INTO `role_permission` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'ecf137ca302741b38841e2693caf1c60');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '063a85552add445d8f7183db01a13797');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '0a3adcc58ef94a7099069ec6e8ed374d');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '0c2d6f746c8d4fbabdb1e738fa1d63dd');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '0fedf05251574ccd9ed19b9d9d9800a3');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '1097d1b5f75d472288f37478cbdcee44');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '1271b1112cf84d5180aa14fdbc66dc1a');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '13b54205c96b42db8ad594a580135aca');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '1882c9c84d624d99af20e0fb31c4cfa3');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '18fbd704367b4f8aaf480f6daf07dcc0');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '1ba1992c802f4f1eacb00184cb3150a0');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '26c769f950374b63b7bcb09636188914');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '29ff790c59f5480396cd218c8e01d8b9');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '390df43b60514eebb656bca660eae3a0');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '4abb36e1bd754d95bed268b7a251f946');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '4e8fda10295449a88597967ebd6d7083');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '4f45bf3a61fb432e85bdc5cd44dfb13d');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '4f6a7f5c3ba140239a4e3247249bd4f8');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '50ce206a638c4119b095e5ae431cb3c8');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '510af109337144aa83db9d8bc4c655be');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '55658da1ad0e4286bdde9c07db79222e');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '56997572ebb945d39bf7644e2cd25c4d');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '5a3f925785274e3c9a5bff0dce40e20b');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '5d8c78ac1fad43b09133881fb98af5fa');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '6efb4f4dea96405ab1f783435ee4a369');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '718ebe29eae64e3c99b34840897a65f0');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '7a8c0b7ca28d4ec19ef1b4508e08d8d4');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '86ba7173d8ef4b9e918ab0b571935351');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '955a79b936a84ef8a10b520d2b2c58e4');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', '9c4d07b5dea54110b8ad51eac40126f6');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'a6015cd9bf7748269f77d36c3c2f10f5');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'a90d25ff72ee4a478fd8e81721615f0b');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'b5e6097de60940b28373dfb3ce000e18');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'b91645763aab4c50878d3ab46b7d14a3');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'b97ed15582884da190762edcb4c58741');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'b9c83d703b6a457c8616ea7dd64375ae');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'bc1ad606dcd04208838dacc83c02abe7');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'ce963e5091564b9aab60f7ac78a5ccc5');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'd150347485c04b368d35f3b2a0f998ea');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'e56dba6f6f5e430b8a7ed9894f6c81d1');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'e5961316ba2547e29b838cd2ec3ee995');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'ecf137ca302741b38841e2693caf1c60');
INSERT INTO `role_permission` VALUES ('1a58638443df47a8af2a3fdb06812101', 'fd29affcf02b4d11b3be0b721cac226d');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '063a85552add445d8f7183db01a13797');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '0a3adcc58ef94a7099069ec6e8ed374d');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '0c2d6f746c8d4fbabdb1e738fa1d63dd');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '0fedf05251574ccd9ed19b9d9d9800a3');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '1097d1b5f75d472288f37478cbdcee44');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '1271b1112cf84d5180aa14fdbc66dc1a');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '13b54205c96b42db8ad594a580135aca');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '1882c9c84d624d99af20e0fb31c4cfa3');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '18fbd704367b4f8aaf480f6daf07dcc0');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '1ba1992c802f4f1eacb00184cb3150a0');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '26c769f950374b63b7bcb09636188914');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '29ff790c59f5480396cd218c8e01d8b9');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '390df43b60514eebb656bca660eae3a0');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '4abb36e1bd754d95bed268b7a251f946');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '4e8fda10295449a88597967ebd6d7083');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '4f45bf3a61fb432e85bdc5cd44dfb13d');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '4f6a7f5c3ba140239a4e3247249bd4f8');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '50ce206a638c4119b095e5ae431cb3c8');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '510af109337144aa83db9d8bc4c655be');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '55658da1ad0e4286bdde9c07db79222e');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '56997572ebb945d39bf7644e2cd25c4d');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '5a3f925785274e3c9a5bff0dce40e20b');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '5d8c78ac1fad43b09133881fb98af5fa');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '6efb4f4dea96405ab1f783435ee4a369');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '718ebe29eae64e3c99b34840897a65f0');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '7a8c0b7ca28d4ec19ef1b4508e08d8d4');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '86ba7173d8ef4b9e918ab0b571935351');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '955a79b936a84ef8a10b520d2b2c58e4');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', '9c4d07b5dea54110b8ad51eac40126f6');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'a6015cd9bf7748269f77d36c3c2f10f5');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'a90d25ff72ee4a478fd8e81721615f0b');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'b5e6097de60940b28373dfb3ce000e18');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'b91645763aab4c50878d3ab46b7d14a3');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'b97ed15582884da190762edcb4c58741');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'b9c83d703b6a457c8616ea7dd64375ae');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'bc1ad606dcd04208838dacc83c02abe7');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'ce963e5091564b9aab60f7ac78a5ccc5');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'd150347485c04b368d35f3b2a0f998ea');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'e56dba6f6f5e430b8a7ed9894f6c81d1');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'e5961316ba2547e29b838cd2ec3ee995');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'ecf137ca302741b38841e2693caf1c60');
INSERT INTO `role_permission` VALUES ('791c733713ef4fce99e17864415d3dae', 'fd29affcf02b4d11b3be0b721cac226d');
INSERT INTO `role_permission` VALUES ('d49ae3a0c98e45d791a5e09d9a884240', 'fd29affcf02b4d11b3be0b721cac226d');

-- ----------------------------
-- Table structure for role_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `role_warehouse`;
CREATE TABLE `role_warehouse`  (
  `role_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `warehouse_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`role_id`, `warehouse_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_warehouse
-- ----------------------------
INSERT INTO `role_warehouse` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'demo_wh_backup');
INSERT INTO `role_warehouse` VALUES ('154c9fcc08a44fb0ad97d8030375e36b', 'demo_wh_main');
INSERT INTO `role_warehouse` VALUES ('791c733713ef4fce99e17864415d3dae', 'demo_wh_backup');
INSERT INTO `role_warehouse` VALUES ('791c733713ef4fce99e17864415d3dae', 'demo_wh_main');
INSERT INTO `role_warehouse` VALUES ('be42fef38c324840a2e297869955a6d6', 'demo_wh_backup');
INSERT INTO `role_warehouse` VALUES ('be42fef38c324840a2e297869955a6d6', 'demo_wh_main');
INSERT INTO `role_warehouse` VALUES ('d49ae3a0c98e45d791a5e09d9a884240', 'demo_wh_backup');
INSERT INTO `role_warehouse` VALUES ('d49ae3a0c98e45d791a5e09d9a884240', 'demo_wh_main');

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '供应商ID',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '供应商名称',
  `contact_person` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '地址',
  `qualification` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '供应商资质',
  `supply_category` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '供应种类',
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `is_delete` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES ('s001', '华为科技有限公司', '张经理', '13800001111', '深圳市龙岗区华为基地', 'ISO9001、ISO14001', '电子元器件、网络设备', '长期合作供应商', '2026-07-13 13:42:23', b'0');
INSERT INTO `supplier` VALUES ('s002', '中兴通讯股份有限公司', '李经理', '13800002222', '深圳市南山区科技园', 'ISO9001、CCC认证', '通信设备、光纤配件', '年度框架协议', '2026-07-13 13:42:23', b'0');
INSERT INTO `supplier` VALUES ('s003', '得力办公用品有限公司', '王经理', '13800003333', '浙江省宁波市宁海县', 'ISO14001、环保认证', '办公耗材、文具用品', '季度结算', '2026-07-13 13:42:23', b'0');
INSERT INTO `supplier` VALUES ('s004', '万可电子（天津）有限公司', '赵经理', '13800004444', '天津市滨海新区', 'ISO9001、CE认证', '接线端子、连接器', '', '2026-07-13 13:42:23', b'0');
INSERT INTO `supplier` VALUES ('s005', '施耐德电气（中国）有限公司', '刘经理', '13800005555', '北京市朝阳区', 'ISO9001、ISO14001、OHSAS18001', '低压电器、自动化设备', '战略合作伙伴', '2026-07-13 13:42:23', b'0');

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `remarks` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `parent_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` bit(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES ('demo_type_clean', '清洁用品', '洗手液、垃圾袋、纸巾等公共区域耗材', '', '2026-06-26 00:17:12', b'0');
INSERT INTO `type` VALUES ('demo_type_it', 'IT耗材', '鼠标、键盘、网线、U盘等信息化耗材', '', '2026-06-26 00:17:12', b'0');
INSERT INTO `type` VALUES ('demo_type_office', '办公用品', '纸张、笔、本册等日常办公耗材', '', '2026-06-26 00:17:12', b'0');
INSERT INTO `type` VALUES ('demo_type_pack', '包装材料', '纸箱、胶带、标签纸等库房包装材料', '', '2026-06-26 00:17:12', b'0');

-- ----------------------------
-- Table structure for type_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `type_warehouse`;
CREATE TABLE `type_warehouse`  (
  `type_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `warehouse_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`type_id`, `warehouse_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type_warehouse
-- ----------------------------
INSERT INTO `type_warehouse` VALUES ('demo_type_clean', 'demo_wh_main');
INSERT INTO `type_warehouse` VALUES ('demo_type_it', 'demo_wh_main');
INSERT INTO `type_warehouse` VALUES ('demo_type_office', 'demo_wh_backup');
INSERT INTO `type_warehouse` VALUES ('demo_type_office', 'demo_wh_main');
INSERT INTO `type_warehouse` VALUES ('demo_type_pack', 'demo_wh_backup');
INSERT INTO `type_warehouse` VALUES ('demo_type_pack', 'demo_wh_main');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `account` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `gender` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `avatar` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `register_time` timestamp NOT NULL,
  `is_enable` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'kmgzs0713@163.com', '7f492b23340c84c655f9af5960df1ccd', '根管理员', '男', 'http://127.0.0.1/EchoCrushResources/defaultLogo/wUserDefaultLogo.png', '', '', '1', '2026-07-14 00:16:00', b'1', b'0');

-- ----------------------------
-- Table structure for user_extension
-- ----------------------------
DROP TABLE IF EXISTS `user_extension`;
CREATE TABLE `user_extension`  (
  `user_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `initialized_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '新增管理员时保存初始化的密码',
  `department` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_extension
-- ----------------------------
INSERT INTO `user_extension` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '', '');

-- ----------------------------
-- Table structure for user_permission
-- ----------------------------
DROP TABLE IF EXISTS `user_permission`;
CREATE TABLE `user_permission`  (
  `user_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `permission_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`user_id`, `permission_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_permission
-- ----------------------------
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '063a85552add445d8f7183db01a13797');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '0a3adcc58ef94a7099069ec6e8ed374d');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '0c2d6f746c8d4fbabdb1e738fa1d63dd');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '0fedf05251574ccd9ed19b9d9d9800a3');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '1097d1b5f75d472288f37478cbdcee44');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '1271b1112cf84d5180aa14fdbc66dc1a');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '13b54205c96b42db8ad594a580135aca');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '1882c9c84d624d99af20e0fb31c4cfa3');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '18fbd704367b4f8aaf480f6daf07dcc0');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '1ba1992c802f4f1eacb00184cb3150a0');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '26c769f950374b63b7bcb09636188914');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '29ff790c59f5480396cd218c8e01d8b9');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '390df43b60514eebb656bca660eae3a0');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '4abb36e1bd754d95bed268b7a251f946');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '4e8fda10295449a88597967ebd6d7083');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '4f45bf3a61fb432e85bdc5cd44dfb13d');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '4f6a7f5c3ba140239a4e3247249bd4f8');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '50ce206a638c4119b095e5ae431cb3c8');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '510af109337144aa83db9d8bc4c655be');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '55658da1ad0e4286bdde9c07db79222e');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '56997572ebb945d39bf7644e2cd25c4d');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '5a3f925785274e3c9a5bff0dce40e20b');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '5d8c78ac1fad43b09133881fb98af5fa');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '6efb4f4dea96405ab1f783435ee4a369');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '718ebe29eae64e3c99b34840897a65f0');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '7a8c0b7ca28d4ec19ef1b4508e08d8d4');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '86ba7173d8ef4b9e918ab0b571935351');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '955a79b936a84ef8a10b520d2b2c58e4');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '9c4d07b5dea54110b8ad51eac40126f6');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'a6015cd9bf7748269f77d36c3c2f10f5');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'a90d25ff72ee4a478fd8e81721615f0b');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'b5e6097de60940b28373dfb3ce000e18');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'b91645763aab4c50878d3ab46b7d14a3');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'b97ed15582884da190762edcb4c58741');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'b9c83d703b6a457c8616ea7dd64375ae');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'bc1ad606dcd04208838dacc83c02abe7');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'ce963e5091564b9aab60f7ac78a5ccc5');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'd150347485c04b368d35f3b2a0f998ea');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'e56dba6f6f5e430b8a7ed9894f6c81d1');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'e5961316ba2547e29b838cd2ec3ee995');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'ecf137ca302741b38841e2693caf1c60');
INSERT INTO `user_permission` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'fd29affcf02b4d11b3be0b721cac226d');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `user_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `role_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', '791c733713ef4fce99e17864415d3dae');

-- ----------------------------
-- Table structure for user_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `user_warehouse`;
CREATE TABLE `user_warehouse`  (
  `user_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `warehouse_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `warehouse_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_warehouse
-- ----------------------------
INSERT INTO `user_warehouse` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'demo_wh_backup', '2026-06-29 00:17:12');
INSERT INTO `user_warehouse` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'demo_wh_main', '2026-06-24 00:17:12');

-- ----------------------------
-- Table structure for user_warehouse_application_setting
-- ----------------------------
DROP TABLE IF EXISTS `user_warehouse_application_setting`;
CREATE TABLE `user_warehouse_application_setting`  (
  `user_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `warehouse_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`user_id`, `warehouse_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_warehouse_application_setting
-- ----------------------------
INSERT INTO `user_warehouse_application_setting` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'demo_wh_backup');
INSERT INTO `user_warehouse_application_setting` VALUES ('5fb04e29a8ef4c769a44cf5397e38620', 'demo_wh_main');

-- ----------------------------
-- Table structure for warehouse
-- ----------------------------
DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse`  (
  `id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `code` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `picture_url` varchar(1028) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `display_order` int NOT NULL,
  `is_enable` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `is_delete` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warehouse
-- ----------------------------
INSERT INTO `warehouse` VALUES ('demo_wh_backup', 'WH002', '备用物资仓', '', '用于演示多仓库管理和跨仓库业务查询。', '2026-06-29 00:17:12', 2, '1', '0');
INSERT INTO `warehouse` VALUES ('demo_wh_main', 'WH001', '教学一号仓', '', '用于课堂演示办公、IT、清洁类消耗品的入库、出库、申请和库存预警。', '2026-06-24 00:17:12', 1, '1', '0');

SET FOREIGN_KEY_CHECKS = 1;
