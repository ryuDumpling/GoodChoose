/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : shequ-order

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 18/10/2023 01:15:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart_info
-- ----------------------------
DROP TABLE IF EXISTS `cart_info`;
CREATE TABLE `cart_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `category_id` bigint NULL DEFAULT NULL COMMENT '分类id',
  `sku_type` tinyint NULL DEFAULT NULL COMMENT 'sku类型',
  `sku_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'sku名称 (冗余)',
  `sku_id` bigint NULL DEFAULT NULL COMMENT 'skuid',
  `cart_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '放入购物车时价格',
  `sku_num` int NULL DEFAULT NULL COMMENT '数量',
  `per_limit` int NULL DEFAULT NULL COMMENT '限购个数',
  `img_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片文件',
  `is_checked` tinyint(1) NOT NULL DEFAULT 1,
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态（1：正常 0：无效）',
  `ware_id` bigint NULL DEFAULT NULL COMMENT '仓库id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart_info
-- ----------------------------

-- ----------------------------
-- Table structure for order_deliver
-- ----------------------------
DROP TABLE IF EXISTS `order_deliver`;
CREATE TABLE `order_deliver`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `deliver_date` datetime NULL DEFAULT NULL COMMENT '配送日期',
  `leader_id` bigint NOT NULL DEFAULT 0 COMMENT '团长id',
  `driver_id` bigint NULL DEFAULT NULL COMMENT '司机id',
  `driver_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '司机名称',
  `driver_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '司机电话',
  `status` tinyint NULL DEFAULT NULL COMMENT '状态（0：默认，1：已发货，2：团长收货）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单配送表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_deliver
-- ----------------------------

-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '会员_id',
  `nick_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `order_no` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `coupon_id` bigint NULL DEFAULT NULL COMMENT '使用的优惠券',
  `total_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '订单总额',
  `activity_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '促销金额',
  `coupon_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '优惠券',
  `original_total_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '原价金额',
  `feight_fee` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '运费',
  `feight_fee_reduce` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '减免运费',
  `refundable_time` datetime NULL DEFAULT NULL COMMENT '可退款日期（签收后1天）',
  `pay_type` tinyint NULL DEFAULT NULL COMMENT '支付方式【1->微信】',
  `source_type` tinyint NULL DEFAULT NULL COMMENT '订单来源[0->小程序；1->H5]',
  `order_status` tinyint NOT NULL DEFAULT 0 COMMENT '订单状态【0->待付款；1->待发货；2->已发货；3->待用户收货，已完成；-1->已取消】',
  `process_status` tinyint NOT NULL DEFAULT 0,
  `leader_id` bigint NOT NULL DEFAULT 0 COMMENT '团长id',
  `leader_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '团长名称',
  `leader_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '团长电话',
  `take_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提货点名称',
  `receiver_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人电话',
  `receiver_post_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人邮编',
  `receiver_province` bigint NULL DEFAULT NULL COMMENT '省份/直辖市',
  `receiver_city` bigint NULL DEFAULT NULL COMMENT '城市',
  `receiver_district` bigint NULL DEFAULT NULL COMMENT '区',
  `receiver_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `payment_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `take_time` datetime NULL DEFAULT NULL COMMENT '提货时间',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '确认收货时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '取消订单时间',
  `cancel_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '取消订单原因',
  `ware_id` bigint NOT NULL DEFAULT 0 COMMENT '仓库id',
  `commission_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '团长佣金',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 176 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_info
-- ----------------------------
INSERT INTO `order_info` VALUES (164, 38, NULL, '1697429236968', 0, 17.39, 0.00, 0.00, 17.39, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', 'ryu', '13958479568', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 12:07:28', '2023-10-16 12:07:28', 0);
INSERT INTO `order_info` VALUES (165, 38, NULL, '1697437389865', 0, 20.90, 0.00, 0.00, 20.90, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', 'ryu', '13984579568', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 14:23:21', '2023-10-16 14:23:21', 0);
INSERT INTO `order_info` VALUES (166, 38, NULL, '1697437884722', 0, 20.60, 0.00, 0.00, 20.60, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', '1', '15875849568', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 14:31:41', '2023-10-16 14:31:41', 0);
INSERT INTO `order_info` VALUES (167, 38, NULL, '1697438420089', 0, 3.60, 0.00, 0.00, 3.60, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', '1', '18594578695', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 14:40:36', '2023-10-16 14:40:36', 0);
INSERT INTO `order_info` VALUES (168, 38, NULL, '1697441529823', 0, 3.60, 0.00, 0.00, 3.60, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', 'e', '18475849568', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 15:32:17', '2023-10-16 15:32:17', 0);
INSERT INTO `order_info` VALUES (169, 38, NULL, '1697442422973', 0, 3.60, 0.00, 0.00, 3.60, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', '1', '15875849632', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 15:47:11', '2023-10-16 15:47:11', 0);
INSERT INTO `order_info` VALUES (170, 38, NULL, '1697442713796', 0, 50.00, 0.00, 0.00, 50.00, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', '1', '15698578457', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 15:52:30', '2023-10-16 15:52:30', 0);
INSERT INTO `order_info` VALUES (171, 38, NULL, '1697442847216', 0, 7.00, 0.00, 0.00, 7.00, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', '8', '15986958754', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 15:54:22', '2023-10-16 15:54:22', 0);
INSERT INTO `order_info` VALUES (172, 38, NULL, '1697443148266', 0, 5.00, 0.00, 0.00, 5.00, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', '1', '13958699568', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 15:59:38', '2023-10-16 15:59:38', 0);
INSERT INTO `order_info` VALUES (173, 38, NULL, '1697443501194', 0, 3.60, 0.00, 0.00, 3.60, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', '1', '13975869584', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 16:05:15', '2023-10-16 16:05:15', 0);
INSERT INTO `order_info` VALUES (174, 38, NULL, '1697443695368', 8, 5.30, 0.00, 0.00, 5.30, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', '1', '19584759586', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 16:08:23', '2023-10-16 16:08:23', 0);
INSERT INTO `order_info` VALUES (175, 38, NULL, '1697444234206', 0, 3.50, 0.00, 0.00, 3.50, 0.00, 0.00, NULL, NULL, NULL, 0, 1, 1, '张晓二', '15012345433', '北师大东方门店', '1', '18789588457', NULL, NULL, NULL, NULL, '北师大东方门', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0.00, '2023-10-16 16:19:01', '2023-10-16 16:19:01', 0);

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint NULL DEFAULT NULL COMMENT 'order_id',
  `category_id` bigint NULL DEFAULT NULL COMMENT '商品分类id',
  `sku_type` tinyint NULL DEFAULT NULL COMMENT 'sku类型',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '商品sku编号',
  `sku_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品sku名字',
  `img_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品sku图片',
  `sku_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品sku价格',
  `sku_num` int NULL DEFAULT NULL COMMENT '商品购买的数量',
  `split_activity_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品促销分解金额',
  `split_coupon_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠券优惠分解金额',
  `split_total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '该商品经过优惠后的分解金额',
  `leader_id` bigint NULL DEFAULT NULL COMMENT '团长id（冗余）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 378 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单项信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (362, 164, 1, 0, 2, '红薯', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E7%BA%A2%E8%96%AF.jpg', 1.79, 1, 0.00, 0.00, 1.79, 1, '2023-10-16 12:07:28', '2023-10-16 12:07:28', 0);
INSERT INTO `order_item` VALUES (363, 164, 1, 0, 10, '南瓜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%8D%97%E7%93%9C.jpg', 5.00, 1, 0.00, 0.00, 5.00, 1, '2023-10-16 12:07:28', '2023-10-16 12:07:28', 0);
INSERT INTO `order_item` VALUES (364, 164, 1, 0, 5, '土豆', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%9C%9F%E8%B1%86.jpg', 5.30, 2, 0.00, 0.00, 10.60, 1, '2023-10-16 12:07:28', '2023-10-16 12:07:28', 0);
INSERT INTO `order_item` VALUES (365, 165, 1, 0, 10, '南瓜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%8D%97%E7%93%9C.jpg', 5.00, 1, 0.00, 0.00, 5.00, 1, '2023-10-16 14:23:21', '2023-10-16 14:23:21', 0);
INSERT INTO `order_item` VALUES (366, 165, 1, 0, 5, '土豆', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%9C%9F%E8%B1%86.jpg', 5.30, 3, 0.00, 0.00, 15.90, 1, '2023-10-16 14:23:21', '2023-10-16 14:23:21', 0);
INSERT INTO `order_item` VALUES (367, 166, 1, 0, 10, '南瓜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%8D%97%E7%93%9C.jpg', 5.00, 2, 0.00, 0.00, 10.00, 1, '2023-10-16 14:31:41', '2023-10-16 14:31:41', 0);
INSERT INTO `order_item` VALUES (368, 166, 1, 0, 5, '土豆', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%9C%9F%E8%B1%86.jpg', 5.30, 2, 0.00, 0.00, 10.60, 1, '2023-10-16 14:31:41', '2023-10-16 14:31:41', 0);
INSERT INTO `order_item` VALUES (369, 167, 1, 0, 6, '丝瓜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E4%B8%9D%E7%93%9C.jpg', 3.60, 1, 0.00, 0.00, 3.60, 1, '2023-10-16 14:40:36', '2023-10-16 14:40:36', 0);
INSERT INTO `order_item` VALUES (370, 168, 1, 0, 6, '丝瓜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E4%B8%9D%E7%93%9C.jpg', 3.60, 1, 0.00, 0.00, 3.60, 1, '2023-10-16 15:32:17', '2023-10-16 15:32:17', 0);
INSERT INTO `order_item` VALUES (371, 169, 1, 0, 6, '丝瓜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E4%B8%9D%E7%93%9C.jpg', 3.60, 1, 0.00, 0.00, 3.60, 1, '2023-10-16 15:47:11', '2023-10-16 15:47:11', 0);
INSERT INTO `order_item` VALUES (372, 170, 1, 0, 13, '蔬菜拼盘', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E8%94%AC%E8%8F%9C%E6%8B%BC%E7%9B%98.jpg', 50.00, 1, 0.00, 0.00, 50.00, 1, '2023-10-16 15:52:30', '2023-10-16 15:52:30', 0);
INSERT INTO `order_item` VALUES (373, 171, 2, 0, 12, '橘子', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E6%A9%98%E5%AD%90.jpg', 7.00, 1, 0.00, 0.00, 7.00, 1, '2023-10-16 15:54:22', '2023-10-16 15:54:22', 0);
INSERT INTO `order_item` VALUES (374, 172, 1, 0, 10, '南瓜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%8D%97%E7%93%9C.jpg', 5.00, 1, 0.00, 0.00, 5.00, 1, '2023-10-16 15:59:38', '2023-10-16 15:59:38', 0);
INSERT INTO `order_item` VALUES (375, 173, 1, 0, 6, '丝瓜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E4%B8%9D%E7%93%9C.jpg', 3.60, 1, 0.00, 0.00, 3.60, 1, '2023-10-16 16:05:15', '2023-10-16 16:05:15', 0);
INSERT INTO `order_item` VALUES (376, 174, 1, 0, 5, '土豆', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%9C%9F%E8%B1%86.jpg', 5.30, 1, 0.00, 0.00, 5.30, 1, '2023-10-16 16:08:23', '2023-10-16 16:08:23', 0);
INSERT INTO `order_item` VALUES (377, 175, 1, 0, 3, '四季豆', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%9B%9B%E5%AD%A3%E8%B1%86.png', 3.50, 1, 0.00, 0.00, 3.50, 1, '2023-10-16 16:19:01', '2023-10-16 16:19:01', 0);

-- ----------------------------
-- Table structure for order_log
-- ----------------------------
DROP TABLE IF EXISTS `order_log`;
CREATE TABLE `order_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单id',
  `operate_user` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人：用户；系统；后台管理员',
  `process_status` int NULL DEFAULT NULL COMMENT '订单状态',
  `note` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 175 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_log
-- ----------------------------
INSERT INTO `order_log` VALUES (1, 1, NULL, 1, NULL, '2021-08-18 14:14:01', '2021-08-18 14:14:01', 0);
INSERT INTO `order_log` VALUES (2, 2, NULL, 1, NULL, '2021-09-14 16:17:35', '2021-09-14 16:17:35', 0);
INSERT INTO `order_log` VALUES (3, 3, NULL, 1, NULL, '2021-09-14 19:46:10', '2021-09-14 19:46:10', 0);
INSERT INTO `order_log` VALUES (4, 4, NULL, 1, NULL, '2021-09-14 20:34:03', '2021-09-14 20:34:03', 0);
INSERT INTO `order_log` VALUES (5, 5, NULL, 1, NULL, '2021-09-14 21:09:14', '2021-09-14 21:09:14', 0);
INSERT INTO `order_log` VALUES (6, 6, NULL, 1, NULL, '2021-09-14 21:29:21', '2021-09-14 21:29:21', 0);
INSERT INTO `order_log` VALUES (7, 7, NULL, 1, NULL, '2021-09-14 21:30:22', '2021-09-14 21:30:22', 0);
INSERT INTO `order_log` VALUES (8, 8, NULL, 1, NULL, '2021-09-14 21:35:19', '2021-09-14 21:35:19', 0);
INSERT INTO `order_log` VALUES (9, 9, NULL, 1, NULL, '2021-09-14 21:50:04', '2021-09-14 21:50:04', 0);
INSERT INTO `order_log` VALUES (10, 10, NULL, 1, NULL, '2021-09-15 17:07:21', '2021-09-15 17:07:21', 0);
INSERT INTO `order_log` VALUES (11, 11, NULL, 1, NULL, '2021-09-15 17:09:17', '2021-09-15 17:09:17', 0);
INSERT INTO `order_log` VALUES (12, 12, NULL, 1, NULL, '2021-09-15 17:10:32', '2021-09-15 17:10:32', 0);
INSERT INTO `order_log` VALUES (13, 13, NULL, 1, NULL, '2021-09-15 18:23:41', '2021-09-15 18:23:41', 0);
INSERT INTO `order_log` VALUES (14, 14, NULL, 1, NULL, '2021-09-15 18:24:18', '2021-09-15 18:24:18', 0);
INSERT INTO `order_log` VALUES (15, 15, NULL, 1, NULL, '2021-09-15 18:25:14', '2021-09-15 18:25:14', 0);
INSERT INTO `order_log` VALUES (16, 16, NULL, 1, NULL, '2021-09-15 18:27:52', '2021-09-15 18:27:52', 0);
INSERT INTO `order_log` VALUES (17, 17, NULL, 1, NULL, '2021-09-15 18:30:22', '2021-09-15 18:30:22', 0);
INSERT INTO `order_log` VALUES (18, 18, NULL, 1, NULL, '2021-09-15 18:31:49', '2021-09-15 18:31:49', 0);
INSERT INTO `order_log` VALUES (19, 19, NULL, 1, NULL, '2021-09-15 18:36:05', '2021-09-15 18:36:05', 0);
INSERT INTO `order_log` VALUES (20, 20, NULL, 1, NULL, '2021-09-15 18:38:09', '2021-09-15 18:38:09', 0);
INSERT INTO `order_log` VALUES (21, 21, NULL, 1, NULL, '2021-09-15 18:39:56', '2021-09-15 18:39:56', 0);
INSERT INTO `order_log` VALUES (22, 22, NULL, 1, NULL, '2021-09-15 18:41:35', '2021-09-15 18:41:35', 0);
INSERT INTO `order_log` VALUES (23, 23, NULL, 1, NULL, '2021-09-15 18:44:45', '2021-09-15 18:44:45', 0);
INSERT INTO `order_log` VALUES (24, 24, NULL, 1, NULL, '2021-09-15 18:45:42', '2021-09-15 18:45:42', 0);
INSERT INTO `order_log` VALUES (25, 25, NULL, 1, NULL, '2021-09-15 18:51:35', '2021-09-15 18:51:35', 0);
INSERT INTO `order_log` VALUES (26, 26, NULL, 1, NULL, '2021-09-15 18:55:58', '2021-09-15 18:55:58', 0);
INSERT INTO `order_log` VALUES (27, 27, NULL, 1, NULL, '2021-09-15 18:57:56', '2021-09-15 18:57:56', 0);
INSERT INTO `order_log` VALUES (28, 28, NULL, 1, NULL, '2021-09-15 19:42:42', '2021-09-15 19:42:42', 0);
INSERT INTO `order_log` VALUES (29, 29, NULL, 1, NULL, '2021-09-15 19:44:42', '2021-09-15 19:44:42', 0);
INSERT INTO `order_log` VALUES (30, 30, NULL, 1, NULL, '2021-09-15 20:11:28', '2021-09-15 20:11:28', 0);
INSERT INTO `order_log` VALUES (31, 31, NULL, 1, NULL, '2021-09-15 20:15:06', '2021-09-15 20:15:06', 0);
INSERT INTO `order_log` VALUES (32, 32, NULL, 1, NULL, '2021-09-15 20:16:52', '2021-09-15 20:16:52', 0);
INSERT INTO `order_log` VALUES (33, 33, NULL, 1, NULL, '2021-09-15 20:18:37', '2021-09-15 20:18:37', 0);
INSERT INTO `order_log` VALUES (34, 31, NULL, 2, NULL, '2021-09-15 21:16:27', '2021-09-15 21:16:27', 0);
INSERT INTO `order_log` VALUES (35, 31, NULL, 2, NULL, '2021-09-15 21:16:29', '2021-09-15 21:16:29', 0);
INSERT INTO `order_log` VALUES (36, 32, NULL, 2, NULL, '2021-09-15 21:17:05', '2021-09-15 21:17:05', 0);
INSERT INTO `order_log` VALUES (37, 33, NULL, 2, NULL, '2021-09-15 21:17:19', '2021-09-15 21:17:19', 0);
INSERT INTO `order_log` VALUES (38, 34, NULL, 1, NULL, '2021-09-16 07:30:24', '2021-09-16 07:30:24', 0);
INSERT INTO `order_log` VALUES (39, 34, NULL, 2, NULL, '2021-09-16 07:38:20', '2021-09-16 07:38:20', 0);
INSERT INTO `order_log` VALUES (40, 20, NULL, 2, NULL, '2021-09-16 08:53:52', '2021-09-16 08:53:52', 0);
INSERT INTO `order_log` VALUES (41, 35, NULL, 1, NULL, '2021-09-16 20:06:47', '2021-09-16 20:06:47', 0);
INSERT INTO `order_log` VALUES (42, 36, NULL, 1, NULL, '2021-09-16 20:08:00', '2021-09-16 20:08:00', 0);
INSERT INTO `order_log` VALUES (43, 36, NULL, 2, NULL, '2021-09-16 20:08:13', '2021-09-16 20:08:13', 0);
INSERT INTO `order_log` VALUES (44, 37, NULL, 1, NULL, '2021-09-18 15:18:50', '2021-09-18 15:18:50', 0);
INSERT INTO `order_log` VALUES (45, 37, NULL, 2, NULL, '2021-09-18 15:19:19', '2021-09-18 15:19:19', 0);
INSERT INTO `order_log` VALUES (46, 38, NULL, 1, NULL, '2021-09-19 16:46:03', '2021-09-19 16:46:03', 0);
INSERT INTO `order_log` VALUES (47, 38, NULL, 2, NULL, '2021-09-19 16:46:18', '2021-09-19 16:46:18', 0);
INSERT INTO `order_log` VALUES (48, 39, NULL, 1, NULL, '2021-09-27 17:17:59', '2021-09-27 17:17:59', 0);
INSERT INTO `order_log` VALUES (49, 39, NULL, 2, NULL, '2021-09-27 17:18:12', '2021-09-27 17:18:12', 0);
INSERT INTO `order_log` VALUES (50, 40, NULL, 1, NULL, '2021-09-28 07:21:33', '2021-09-28 07:21:33', 0);
INSERT INTO `order_log` VALUES (51, 41, NULL, 1, NULL, '2021-09-28 08:17:39', '2021-09-28 08:17:39', 0);
INSERT INTO `order_log` VALUES (52, 42, NULL, 1, NULL, '2021-09-28 08:18:59', '2021-09-28 08:18:59', 0);
INSERT INTO `order_log` VALUES (53, 42, NULL, 2, NULL, '2021-09-28 08:19:13', '2021-09-28 08:19:13', 0);
INSERT INTO `order_log` VALUES (54, 43, NULL, 1, NULL, '2021-09-29 05:33:05', '2021-09-29 05:33:05', 0);
INSERT INTO `order_log` VALUES (55, 44, NULL, 1, NULL, '2021-09-29 09:31:27', '2021-09-29 09:31:27', 0);
INSERT INTO `order_log` VALUES (56, 45, NULL, 1, NULL, '2021-09-29 23:40:59', '2021-09-29 23:40:59', 0);
INSERT INTO `order_log` VALUES (57, 46, NULL, 1, NULL, '2021-09-29 23:41:22', '2021-09-29 23:41:22', 0);
INSERT INTO `order_log` VALUES (58, 47, NULL, 1, NULL, '2021-09-29 23:43:19', '2021-09-29 23:43:19', 0);
INSERT INTO `order_log` VALUES (59, 48, NULL, 1, NULL, '2021-10-12 07:39:20', '2021-10-12 07:39:20', 0);
INSERT INTO `order_log` VALUES (60, 49, NULL, 1, NULL, '2021-10-13 01:51:16', '2021-10-13 01:51:16', 0);
INSERT INTO `order_log` VALUES (61, 50, NULL, 1, NULL, '2021-10-19 04:56:43', '2021-10-19 04:56:43', 0);
INSERT INTO `order_log` VALUES (62, 51, NULL, 1, NULL, '2021-10-19 05:42:26', '2021-10-19 05:42:26', 0);
INSERT INTO `order_log` VALUES (63, 52, NULL, 1, NULL, '2021-10-20 07:37:17', '2021-10-20 07:37:17', 0);
INSERT INTO `order_log` VALUES (64, 53, NULL, 1, NULL, '2021-10-20 07:42:36', '2021-10-20 07:42:36', 0);
INSERT INTO `order_log` VALUES (65, 54, NULL, 1, NULL, '2021-10-21 03:01:48', '2021-10-21 03:01:48', 0);
INSERT INTO `order_log` VALUES (66, 55, NULL, 1, NULL, '2021-10-21 03:38:41', '2021-10-21 03:38:41', 0);
INSERT INTO `order_log` VALUES (67, 56, NULL, 1, NULL, '2021-11-12 08:28:20', '2021-11-12 08:28:20', 0);
INSERT INTO `order_log` VALUES (68, 57, NULL, 1, NULL, '2021-11-12 09:20:35', '2021-11-12 09:20:35', 0);
INSERT INTO `order_log` VALUES (69, 58, NULL, 1, NULL, '2021-11-12 09:22:05', '2021-11-12 09:22:05', 0);
INSERT INTO `order_log` VALUES (70, 59, NULL, 1, NULL, '2021-11-12 12:11:24', '2021-11-12 12:11:24', 0);
INSERT INTO `order_log` VALUES (71, 60, NULL, 1, NULL, '2021-11-15 09:15:42', '2021-11-15 09:15:42', 0);
INSERT INTO `order_log` VALUES (72, 61, NULL, 1, NULL, '2021-11-19 07:26:29', '2021-11-19 07:26:29', 0);
INSERT INTO `order_log` VALUES (73, 62, NULL, 1, NULL, '2021-11-19 07:28:54', '2021-11-19 07:28:54', 0);
INSERT INTO `order_log` VALUES (74, 63, NULL, 1, NULL, '2021-11-19 07:39:28', '2021-11-19 07:39:28', 0);
INSERT INTO `order_log` VALUES (75, 64, NULL, 1, NULL, '2021-11-19 07:41:05', '2021-11-19 07:41:05', 0);
INSERT INTO `order_log` VALUES (76, 65, NULL, 1, NULL, '2021-11-19 08:26:38', '2021-11-19 08:26:38', 0);
INSERT INTO `order_log` VALUES (77, 66, NULL, 1, NULL, '2021-11-19 08:30:49', '2021-11-19 08:30:49', 0);
INSERT INTO `order_log` VALUES (78, 67, NULL, 1, NULL, '2021-11-19 10:21:30', '2021-11-19 10:21:30', 0);
INSERT INTO `order_log` VALUES (79, 68, NULL, 1, NULL, '2021-11-19 14:59:36', '2021-11-19 14:59:36', 0);
INSERT INTO `order_log` VALUES (80, 69, NULL, 1, NULL, '2021-11-19 14:59:37', '2021-11-19 14:59:37', 0);
INSERT INTO `order_log` VALUES (81, 70, NULL, 1, NULL, '2021-11-19 14:59:37', '2021-11-19 14:59:37', 0);
INSERT INTO `order_log` VALUES (82, 71, NULL, 1, NULL, '2021-11-19 16:34:57', '2021-11-19 16:34:57', 0);
INSERT INTO `order_log` VALUES (83, 72, NULL, 1, NULL, '2021-11-20 01:58:25', '2021-11-20 01:58:25', 0);
INSERT INTO `order_log` VALUES (84, 73, NULL, 1, NULL, '2021-11-20 02:24:59', '2021-11-20 02:24:59', 0);
INSERT INTO `order_log` VALUES (85, 74, NULL, 1, NULL, '2021-11-20 02:35:15', '2021-11-20 02:35:15', 0);
INSERT INTO `order_log` VALUES (86, 75, NULL, 1, NULL, '2021-11-20 04:58:09', '2021-11-20 04:58:09', 0);
INSERT INTO `order_log` VALUES (87, 76, NULL, 1, NULL, '2021-11-20 05:02:46', '2021-11-20 05:02:46', 0);
INSERT INTO `order_log` VALUES (88, 77, NULL, 1, NULL, '2021-11-20 06:46:45', '2021-11-20 06:46:45', 0);
INSERT INTO `order_log` VALUES (89, 78, NULL, 1, NULL, '2021-11-20 07:55:31', '2021-11-20 07:55:31', 0);
INSERT INTO `order_log` VALUES (90, 79, NULL, 1, NULL, '2021-11-20 08:54:05', '2021-11-20 08:54:05', 0);
INSERT INTO `order_log` VALUES (91, 80, NULL, 1, NULL, '2021-11-20 09:32:21', '2021-11-20 09:32:21', 0);
INSERT INTO `order_log` VALUES (92, 81, NULL, 1, NULL, '2021-11-20 09:33:28', '2021-11-20 09:33:28', 0);
INSERT INTO `order_log` VALUES (93, 82, NULL, 1, NULL, '2021-11-20 13:45:43', '2021-11-20 13:45:43', 0);
INSERT INTO `order_log` VALUES (94, 83, NULL, 1, NULL, '2021-11-20 13:59:58', '2021-11-20 13:59:58', 0);
INSERT INTO `order_log` VALUES (95, 84, NULL, 1, NULL, '2021-11-22 00:53:36', '2021-11-22 00:53:36', 0);
INSERT INTO `order_log` VALUES (96, 85, NULL, 1, NULL, '2021-11-22 03:56:22', '2021-11-22 03:56:22', 0);
INSERT INTO `order_log` VALUES (97, 86, NULL, 1, NULL, '2021-11-22 06:21:16', '2021-11-22 06:21:16', 0);
INSERT INTO `order_log` VALUES (98, 87, NULL, 1, NULL, '2021-11-22 06:37:03', '2021-11-22 06:37:03', 0);
INSERT INTO `order_log` VALUES (99, 88, NULL, 1, NULL, '2021-11-22 11:07:35', '2021-11-22 11:07:35', 0);
INSERT INTO `order_log` VALUES (100, 89, NULL, 1, NULL, '2021-11-22 11:08:22', '2021-11-22 11:08:22', 0);
INSERT INTO `order_log` VALUES (101, 90, NULL, 1, NULL, '2021-11-22 11:21:46', '2021-11-22 11:21:46', 0);
INSERT INTO `order_log` VALUES (102, 91, NULL, 1, NULL, '2021-11-23 01:11:47', '2021-11-23 01:11:47', 0);
INSERT INTO `order_log` VALUES (103, 92, NULL, 1, NULL, '2021-11-23 01:15:47', '2021-11-23 01:15:47', 0);
INSERT INTO `order_log` VALUES (104, 93, NULL, 1, NULL, '2021-11-23 01:17:31', '2021-11-23 01:17:31', 0);
INSERT INTO `order_log` VALUES (105, 94, NULL, 1, NULL, '2021-11-23 01:18:21', '2021-11-23 01:18:21', 0);
INSERT INTO `order_log` VALUES (106, 95, NULL, 1, NULL, '2021-11-23 01:19:39', '2021-11-23 01:19:39', 0);
INSERT INTO `order_log` VALUES (107, 96, NULL, 1, NULL, '2021-11-23 01:23:14', '2021-11-23 01:23:14', 0);
INSERT INTO `order_log` VALUES (108, 97, NULL, 1, NULL, '2021-11-23 01:33:25', '2021-11-23 01:33:25', 0);
INSERT INTO `order_log` VALUES (109, 98, NULL, 1, NULL, '2021-11-23 01:49:42', '2021-11-23 01:49:42', 0);
INSERT INTO `order_log` VALUES (110, 99, NULL, 1, NULL, '2021-11-23 01:55:31', '2021-11-23 01:55:31', 0);
INSERT INTO `order_log` VALUES (111, 100, NULL, 1, NULL, '2021-11-23 01:57:31', '2021-11-23 01:57:31', 0);
INSERT INTO `order_log` VALUES (112, 101, NULL, 1, NULL, '2021-11-23 01:59:38', '2021-11-23 01:59:38', 0);
INSERT INTO `order_log` VALUES (113, 102, NULL, 1, NULL, '2021-11-23 02:00:09', '2021-11-23 02:00:09', 0);
INSERT INTO `order_log` VALUES (114, 103, NULL, 1, NULL, '2021-11-23 02:00:10', '2021-11-23 02:00:10', 0);
INSERT INTO `order_log` VALUES (115, 104, NULL, 1, NULL, '2021-11-23 02:05:51', '2021-11-23 02:05:51', 0);
INSERT INTO `order_log` VALUES (116, 105, NULL, 1, NULL, '2021-11-23 02:13:26', '2021-11-23 02:13:26', 0);
INSERT INTO `order_log` VALUES (117, 106, NULL, 1, NULL, '2021-11-23 02:13:51', '2021-11-23 02:13:51', 0);
INSERT INTO `order_log` VALUES (118, 107, NULL, 1, NULL, '2021-11-23 02:14:59', '2021-11-23 02:14:59', 0);
INSERT INTO `order_log` VALUES (119, 108, NULL, 1, NULL, '2021-11-23 02:15:47', '2021-11-23 02:15:47', 0);
INSERT INTO `order_log` VALUES (120, 109, NULL, 1, NULL, '2021-11-23 02:26:16', '2021-11-23 02:26:16', 0);
INSERT INTO `order_log` VALUES (121, 110, NULL, 1, NULL, '2021-11-23 02:30:24', '2021-11-23 02:30:24', 0);
INSERT INTO `order_log` VALUES (122, 111, NULL, 1, NULL, '2021-11-23 02:32:51', '2021-11-23 02:32:51', 0);
INSERT INTO `order_log` VALUES (123, 112, NULL, 1, NULL, '2021-11-23 07:01:12', '2021-11-23 07:01:12', 0);
INSERT INTO `order_log` VALUES (124, 113, NULL, 1, NULL, '2021-11-23 07:01:46', '2021-11-23 07:01:46', 0);
INSERT INTO `order_log` VALUES (125, 114, NULL, 1, NULL, '2021-11-23 07:02:44', '2021-11-23 07:02:44', 0);
INSERT INTO `order_log` VALUES (126, 115, NULL, 1, NULL, '2021-11-23 07:15:25', '2021-11-23 07:15:25', 0);
INSERT INTO `order_log` VALUES (127, 116, NULL, 1, NULL, '2021-11-23 07:18:28', '2021-11-23 07:18:28', 0);
INSERT INTO `order_log` VALUES (128, 117, NULL, 1, NULL, '2021-11-23 07:18:45', '2021-11-23 07:18:45', 0);
INSERT INTO `order_log` VALUES (129, 118, NULL, 1, NULL, '2021-11-23 07:20:25', '2021-11-23 07:20:25', 0);
INSERT INTO `order_log` VALUES (130, 119, NULL, 1, NULL, '2021-11-23 07:38:28', '2021-11-23 07:38:28', 0);
INSERT INTO `order_log` VALUES (131, 120, NULL, 1, NULL, '2021-11-23 07:48:15', '2021-11-23 07:48:15', 0);
INSERT INTO `order_log` VALUES (132, 121, NULL, 1, NULL, '2021-11-23 07:48:31', '2021-11-23 07:48:31', 0);
INSERT INTO `order_log` VALUES (133, 122, NULL, 1, NULL, '2021-11-23 07:50:48', '2021-11-23 07:50:48', 0);
INSERT INTO `order_log` VALUES (134, 123, NULL, 1, NULL, '2021-11-23 08:02:51', '2021-11-23 08:02:51', 0);
INSERT INTO `order_log` VALUES (135, 124, NULL, 1, NULL, '2021-11-23 08:45:21', '2021-11-23 08:45:21', 0);
INSERT INTO `order_log` VALUES (136, 125, NULL, 1, NULL, '2021-11-23 08:47:22', '2021-11-23 08:47:22', 0);
INSERT INTO `order_log` VALUES (137, 126, NULL, 1, NULL, '2021-11-23 12:12:22', '2021-11-23 12:12:22', 0);
INSERT INTO `order_log` VALUES (138, 127, NULL, 1, NULL, '2021-11-24 00:43:29', '2021-11-24 00:43:29', 0);
INSERT INTO `order_log` VALUES (139, 128, NULL, 1, NULL, '2021-11-24 00:47:21', '2021-11-24 00:47:21', 0);
INSERT INTO `order_log` VALUES (140, 129, NULL, 1, NULL, '2021-11-24 00:48:26', '2021-11-24 00:48:26', 0);
INSERT INTO `order_log` VALUES (141, 130, NULL, 1, NULL, '2021-11-24 00:48:50', '2021-11-24 00:48:50', 0);
INSERT INTO `order_log` VALUES (142, 131, NULL, 1, NULL, '2021-11-24 00:57:07', '2021-11-24 00:57:07', 0);
INSERT INTO `order_log` VALUES (143, 132, NULL, 1, NULL, '2021-11-24 01:01:43', '2021-11-24 01:01:43', 0);
INSERT INTO `order_log` VALUES (144, 133, NULL, 1, NULL, '2021-11-24 01:03:45', '2021-11-24 01:03:45', 0);
INSERT INTO `order_log` VALUES (145, 134, NULL, 1, NULL, '2021-11-24 01:18:33', '2021-11-24 01:18:33', 0);
INSERT INTO `order_log` VALUES (146, 135, NULL, 1, NULL, '2021-11-24 01:28:08', '2021-11-24 01:28:08', 0);
INSERT INTO `order_log` VALUES (147, 136, NULL, 1, NULL, '2021-11-24 01:30:36', '2021-11-24 01:30:36', 0);
INSERT INTO `order_log` VALUES (148, 137, NULL, 1, NULL, '2021-11-24 07:53:39', '2021-11-24 07:53:39', 0);
INSERT INTO `order_log` VALUES (149, 138, NULL, 1, NULL, '2021-11-24 08:13:03', '2021-11-24 08:13:03', 0);
INSERT INTO `order_log` VALUES (150, 139, NULL, 1, NULL, '2021-11-24 08:28:35', '2021-11-24 08:28:35', 0);
INSERT INTO `order_log` VALUES (151, 140, NULL, 1, NULL, '2021-11-24 08:31:13', '2021-11-24 08:31:13', 0);
INSERT INTO `order_log` VALUES (152, 141, NULL, 1, NULL, '2021-11-24 08:42:12', '2021-11-24 08:42:12', 0);
INSERT INTO `order_log` VALUES (153, 142, NULL, 1, NULL, '2021-11-24 08:53:00', '2021-11-24 08:53:00', 0);
INSERT INTO `order_log` VALUES (154, 143, NULL, 1, NULL, '2021-11-24 08:54:37', '2021-11-24 08:54:37', 0);
INSERT INTO `order_log` VALUES (155, 144, NULL, 1, NULL, '2021-11-24 08:55:26', '2021-11-24 08:55:26', 0);
INSERT INTO `order_log` VALUES (156, 145, NULL, 1, NULL, '2021-11-24 09:44:52', '2021-11-24 09:44:52', 0);
INSERT INTO `order_log` VALUES (157, 146, NULL, 1, NULL, '2021-11-24 10:00:16', '2021-11-24 10:00:16', 0);
INSERT INTO `order_log` VALUES (158, 147, NULL, 1, NULL, '2021-11-25 01:23:08', '2021-11-25 01:23:08', 0);
INSERT INTO `order_log` VALUES (159, 148, NULL, 1, NULL, '2021-11-25 02:23:50', '2021-11-25 02:23:50', 0);
INSERT INTO `order_log` VALUES (160, 149, NULL, 1, NULL, '2021-11-25 02:33:49', '2021-11-25 02:33:49', 0);
INSERT INTO `order_log` VALUES (161, 150, NULL, 1, NULL, '2021-11-25 02:34:44', '2021-11-25 02:34:44', 0);
INSERT INTO `order_log` VALUES (162, 151, NULL, 1, NULL, '2021-11-25 02:36:41', '2021-11-25 02:36:41', 0);
INSERT INTO `order_log` VALUES (163, 152, NULL, 1, NULL, '2021-11-25 02:37:21', '2021-11-25 02:37:21', 0);
INSERT INTO `order_log` VALUES (164, 153, NULL, 1, NULL, '2021-11-25 02:39:19', '2021-11-25 02:39:19', 0);
INSERT INTO `order_log` VALUES (165, 154, NULL, 1, NULL, '2021-11-25 02:48:13', '2021-11-25 02:48:13', 0);
INSERT INTO `order_log` VALUES (166, 155, NULL, 1, NULL, '2021-11-25 02:48:56', '2021-11-25 02:48:56', 0);
INSERT INTO `order_log` VALUES (167, 156, NULL, 1, NULL, '2021-11-25 02:51:05', '2021-11-25 02:51:05', 0);
INSERT INTO `order_log` VALUES (168, 157, NULL, 1, NULL, '2021-11-25 02:51:23', '2021-11-25 02:51:23', 0);
INSERT INTO `order_log` VALUES (169, 158, NULL, 1, NULL, '2021-11-25 02:55:53', '2021-11-25 02:55:53', 0);
INSERT INTO `order_log` VALUES (170, 159, NULL, 1, NULL, '2021-11-25 02:56:26', '2021-11-25 02:56:26', 0);
INSERT INTO `order_log` VALUES (171, 160, NULL, 1, NULL, '2021-11-25 03:00:53', '2021-11-25 03:00:53', 0);
INSERT INTO `order_log` VALUES (172, 161, NULL, 1, NULL, '2021-11-26 01:25:31', '2021-11-26 01:25:31', 0);
INSERT INTO `order_log` VALUES (173, 162, NULL, 1, NULL, '2021-11-26 03:28:41', '2021-11-26 03:28:41', 0);
INSERT INTO `order_log` VALUES (174, 163, NULL, 1, NULL, '2021-11-26 03:49:56', '2021-11-26 03:49:56', 0);

-- ----------------------------
-- Table structure for order_return_apply
-- ----------------------------
DROP TABLE IF EXISTS `order_return_apply`;
CREATE TABLE `order_return_apply`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单id',
  `merchant_id` bigint NULL DEFAULT NULL COMMENT '团长门店id',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '退货商品id',
  `order_sn` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员用户名',
  `return_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '退款金额',
  `return_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货人姓名',
  `return_phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货人电话',
  `status` int NULL DEFAULT NULL COMMENT '申请状态：0->待处理；1->退货中；2->已完成；3->已拒绝',
  `handle_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `sku_pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `sku_num` int NULL DEFAULT NULL COMMENT '退货数量',
  `sku_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品单价',
  `sku_real_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品实际支付单价',
  `reason` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原因',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `proof_pics` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '凭证图片，以逗号隔开',
  `handle_note` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理备注',
  `handle_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理人员',
  `receive_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `receive_note` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单退货申请' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_return_apply
-- ----------------------------

-- ----------------------------
-- Table structure for order_return_reason
-- ----------------------------
DROP TABLE IF EXISTS `order_return_reason`;
CREATE TABLE `order_return_reason`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货类型',
  `sort` int NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL COMMENT '状态：0->不启用；1->启用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '退货原因表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_return_reason
-- ----------------------------

-- ----------------------------
-- Table structure for order_set
-- ----------------------------
DROP TABLE IF EXISTS `order_set`;
CREATE TABLE `order_set`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seckill_order_overtime` int NULL DEFAULT NULL COMMENT '秒杀订单超时关闭时间(分)',
  `normal_order_overtime` int NULL DEFAULT NULL COMMENT '正常订单超时时间(分)',
  `confirm_overtime` int NULL DEFAULT NULL COMMENT '发货后自动确认收货时间（天）',
  `finish_overtime` int NULL DEFAULT NULL COMMENT '自动完成交易时间，不能申请售后（天）',
  `profit_rate` decimal(10, 2) NULL DEFAULT NULL COMMENT '佣金分成比例',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单设置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_set
-- ----------------------------
INSERT INTO `order_set` VALUES (1, 1, 1, 10, 10, 0.10, '2021-06-09 11:55:54', '2021-07-01 15:14:55', 0);

-- ----------------------------
-- Table structure for payment_info
-- ----------------------------
DROP TABLE IF EXISTS `payment_info`;
CREATE TABLE `payment_info`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `order_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `order_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `payment_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付类型（微信 支付宝）',
  `trade_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易编号',
  `total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '支付金额',
  `subject` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易内容',
  `payment_status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付状态',
  `callback_time` datetime NULL DEFAULT NULL COMMENT '回调时间',
  `callback_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回调信息',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '支付信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment_info
-- ----------------------------
INSERT INTO `payment_info` VALUES (88, '1697438420089', '167', 38, '2', NULL, 0.01, 'userId38下订单', '1', NULL, NULL, '2023-10-16 14:40:41', '2023-10-16 14:40:41', 0);
INSERT INTO `payment_info` VALUES (89, '1697441529823', '168', 38, '2', NULL, 0.01, 'userId38下订单', '1', NULL, NULL, '2023-10-16 15:32:22', '2023-10-16 15:32:21', 0);
INSERT INTO `payment_info` VALUES (90, '1697442422973', '169', 38, '2', NULL, 0.01, 'userId38下订单', '1', NULL, NULL, '2023-10-16 15:47:16', '2023-10-16 15:47:15', 0);
INSERT INTO `payment_info` VALUES (91, '1697442713796', '170', 38, '2', NULL, 0.01, 'userId38下订单', '1', NULL, NULL, '2023-10-16 15:52:34', '2023-10-16 15:52:33', 0);
INSERT INTO `payment_info` VALUES (92, '1697442847216', '171', 38, '2', NULL, 0.01, 'userId38下订单', '1', NULL, NULL, '2023-10-16 15:54:24', '2023-10-16 15:54:24', 0);
INSERT INTO `payment_info` VALUES (93, '1697443148266', '172', 38, '2', NULL, 0.01, 'userId38下订单', '1', NULL, NULL, '2023-10-16 15:59:42', '2023-10-16 15:59:42', 0);
INSERT INTO `payment_info` VALUES (94, '1697443501194', '173', 38, '2', NULL, 0.01, 'userId38下订单', '2', NULL, NULL, '2023-10-16 16:05:19', '2023-10-16 16:05:19', 0);
INSERT INTO `payment_info` VALUES (95, '1697443695368', '174', 38, '2', NULL, 0.01, 'userId38下订单', '2', NULL, NULL, '2023-10-16 16:09:14', '2023-10-16 16:09:14', 0);
INSERT INTO `payment_info` VALUES (96, '1697444234206', '175', 38, '2', NULL, 0.01, 'userId38下订单', '2', NULL, NULL, '2023-10-16 16:19:04', '2023-10-16 16:19:04', 0);

-- ----------------------------
-- Table structure for refund_info
-- ----------------------------
DROP TABLE IF EXISTS `refund_info`;
CREATE TABLE `refund_info`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `out_trade_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对外业务编号',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单编号',
  `sku_id` bigint NULL DEFAULT NULL,
  `payment_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付类型（微信 支付宝）',
  `trade_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易编号',
  `total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '退款金额',
  `subject` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易内容',
  `refund_status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退款状态',
  `callback_time` datetime NULL DEFAULT NULL COMMENT '回调时间',
  `callback_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回调信息',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_out_trade_no`(`out_trade_no` ASC) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '退款信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of refund_info
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
