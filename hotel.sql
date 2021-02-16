/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : hotel

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 16/02/2021 21:23:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for in_room_info
-- ----------------------------
DROP TABLE IF EXISTS `in_room_info`;
CREATE TABLE `in_room_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客人姓名',
  `gender` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '性别(1男 0女)',
  `is_vip` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '0普通，1vip',
  `idcard` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `money` float(10, 2) NULL DEFAULT NULL COMMENT '押金',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '入住时间',
  `room_id` bigint(20) NULL DEFAULT NULL COMMENT '房间表主键',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '显示状态：1显示， 0隐藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of in_room_info
-- ----------------------------
INSERT INTO `in_room_info` VALUES (22, '赵子龙', '1', '0', '411311199001015577', '17665457395', 100.00, '2021-02-16 00:00:00', 13, '1');
INSERT INTO `in_room_info` VALUES (23, '喻清明', '1', '1', '511023199902283879', '17665457395', 5.00, '2021-02-16 00:00:00', 14, '1');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_num` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `order_money` float(10, 2) NULL DEFAULT NULL COMMENT '订单总价',
  `order_status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '0未结算，1已结算',
  `room_id` bigint(20) NULL DEFAULT NULL COMMENT '房间主键',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '下单时间',
  `not_del` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '1没有被删除，0被删除',
  `consume_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消费的名称',
  `consume_count` bigint(255) NOT NULL DEFAULT 1 COMMENT '数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (14, '621a5bd0-fa61-4eba-a89d-dcd61fba6469', 5.00, '0', 14, '2021-02-16 21:03:16', '1', '方便面', 1);

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `room_type_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房间类型名',
  `room_price` float(10, 2) NULL DEFAULT NULL COMMENT '房间的单价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_type
-- ----------------------------
INSERT INTO `room_type` VALUES (1, '单人间', 140.00);
INSERT INTO `room_type` VALUES (2, '双人间', 180.00);
INSERT INTO `room_type` VALUES (3, '豪华间', 280.00);

-- ----------------------------
-- Table structure for rooms
-- ----------------------------
DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `room_num` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房间编号',
  `room_status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '房间的状态(0空闲，1已入住，2打扫)',
  `room_type_id` bigint(20) NULL DEFAULT NULL COMMENT '房间类型主键',
  `not_del` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '1没有删除0删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rooms
-- ----------------------------
INSERT INTO `rooms` VALUES (13, '1001', '1', 1, '1');
INSERT INTO `rooms` VALUES (14, '1002', '1', 2, '1');
INSERT INTO `rooms` VALUES (15, '1003', '0', 1, '1');
INSERT INTO `rooms` VALUES (16, '1004', '0', 2, '1');
INSERT INTO `rooms` VALUES (17, '1005', '0', 3, '1');

-- ----------------------------
-- Table structure for system_authority
-- ----------------------------
DROP TABLE IF EXISTS `system_authority`;
CREATE TABLE `system_authority`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `authority_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限名',
  `authority_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '权限跳转地址',
  `parent` bigint(20) NULL DEFAULT 0 COMMENT '记住上级的主键，0为一级节点',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_authority
-- ----------------------------
INSERT INTO `system_authority` VALUES (1, '入住管理', '#', 0);
INSERT INTO `system_authority` VALUES (2, '订单管理', '#', 0);
INSERT INTO `system_authority` VALUES (3, '会员管理', '#', 0);
INSERT INTO `system_authority` VALUES (4, '客房管理', '#', 0);
INSERT INTO `system_authority` VALUES (5, '用户管理', '#', 0);
INSERT INTO `system_authority` VALUES (6, '客人意见', '#', 0);
INSERT INTO `system_authority` VALUES (7, '入住信息查询', '/getInRoomInfo.do', 1);
INSERT INTO `system_authority` VALUES (8, '入住信息添加', '/getAllFreeRoomInfo.do', 1);
INSERT INTO `system_authority` VALUES (9, '消费记录', '/getConsumeInfo.do', 1);
INSERT INTO `system_authority` VALUES (10, '结账退房', '/getAllOccupyRoom.do', 1);
INSERT INTO `system_authority` VALUES (11, '订单信息', '/getOrderInfo.do', 2);
INSERT INTO `system_authority` VALUES (12, '订单添加', '/readyAddOrder.do', 2);
INSERT INTO `system_authority` VALUES (13, '会员信息查询', '/getVipInfo.do', 3);
INSERT INTO `system_authority` VALUES (14, '会员信息修改', '/readyModifyVipInfo.do', 3);
INSERT INTO `system_authority` VALUES (15, '添加会员', '/readyAddVipInfo.do', 3);
INSERT INTO `system_authority` VALUES (16, '客房信息查询', '/getAllRoomInfo.do', 4);
INSERT INTO `system_authority` VALUES (17, '客房信息修改', '/readyModifyRoomInfo.do', 4);
INSERT INTO `system_authority` VALUES (18, '添加客房', '/readyAddRoom.do', 4);

-- ----------------------------
-- Table structure for system_user
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `pwd` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_user
-- ----------------------------
INSERT INTO `system_user` VALUES (1, 'admin', 'd5d23b080c52f070e3dc61821f325c7d');
INSERT INTO `system_user` VALUES (2, 'bigbird', 'd5d23b080c52f070e3dc61821f325c7d');

-- ----------------------------
-- Table structure for user_authority
-- ----------------------------
DROP TABLE IF EXISTS `user_authority`;
CREATE TABLE `user_authority`  (
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '系统用户主键',
  `authority_id` bigint(20) NULL DEFAULT NULL COMMENT '权限主键'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_authority
-- ----------------------------
INSERT INTO `user_authority` VALUES (1, 1);
INSERT INTO `user_authority` VALUES (1, 7);
INSERT INTO `user_authority` VALUES (1, 8);
INSERT INTO `user_authority` VALUES (1, 9);
INSERT INTO `user_authority` VALUES (1, 10);
INSERT INTO `user_authority` VALUES (1, 11);
INSERT INTO `user_authority` VALUES (1, 12);
INSERT INTO `user_authority` VALUES (1, 2);
INSERT INTO `user_authority` VALUES (1, 3);
INSERT INTO `user_authority` VALUES (1, 13);
INSERT INTO `user_authority` VALUES (1, 14);
INSERT INTO `user_authority` VALUES (1, 15);
INSERT INTO `user_authority` VALUES (1, 16);
INSERT INTO `user_authority` VALUES (1, 17);
INSERT INTO `user_authority` VALUES (1, 18);
INSERT INTO `user_authority` VALUES (1, 4);

-- ----------------------------
-- Table structure for vip
-- ----------------------------
DROP TABLE IF EXISTS `vip`;
CREATE TABLE `vip`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `vip_num` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员卡编号',
  `vip_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员姓名',
  `vip_rate` float(2, 1) NULL DEFAULT 9.0 COMMENT '1~9折',
  `idcard` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员身份证',
  `phone` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '会员办理日期',
  `gender` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `not_del` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '1会员身份有效\r\n0身份无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vip
-- ----------------------------
INSERT INTO `vip` VALUES (7, 'de975e91-ab1c-40ea-ab83-b5eca79e4277', '喻清明', 9.5, '511023199902283879', '17665457395', '2021-02-16 21:02:28', '1', '1');

-- ----------------------------
-- Table structure for vip_rates
-- ----------------------------
DROP TABLE IF EXISTS `vip_rates`;
CREATE TABLE `vip_rates`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate` float(20, 1) NOT NULL DEFAULT 9.0 COMMENT '折扣',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vip_rates
-- ----------------------------
INSERT INTO `vip_rates` VALUES (1, 9.5);
INSERT INTO `vip_rates` VALUES (2, 9.0);
INSERT INTO `vip_rates` VALUES (3, 8.5);
INSERT INTO `vip_rates` VALUES (4, 8.0);
INSERT INTO `vip_rates` VALUES (5, 7.5);
INSERT INTO `vip_rates` VALUES (6, 7.0);
INSERT INTO `vip_rates` VALUES (7, 6.0);

SET FOREIGN_KEY_CHECKS = 1;
