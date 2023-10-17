/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : shequ-product

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 18/10/2023 01:15:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for attr
-- ----------------------------
DROP TABLE IF EXISTS `attr`;
CREATE TABLE `attr`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '属性id',
  `name` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属性名',
  `input_type` int NULL DEFAULT NULL COMMENT '属性录入方式：0->手工录入；1->从列表中选取',
  `select_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '可选值列表[用逗号分隔]',
  `attr_group_id` bigint NULL DEFAULT NULL COMMENT '属性分组id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品属性' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of attr
-- ----------------------------
INSERT INTO `attr` VALUES (1, '品牌', 0, '', 1, '2021-06-06 17:43:46', '2021-06-06 17:43:46', 0);
INSERT INTO `attr` VALUES (2, '规格', 0, '', 1, '2021-06-06 17:43:58', '2021-06-06 17:43:58', 0);
INSERT INTO `attr` VALUES (3, '产地', 0, '', 1, '2021-06-06 17:44:08', '2021-06-06 17:44:08', 0);
INSERT INTO `attr` VALUES (4, '保质期', 0, '', 1, '2021-06-06 17:44:20', '2021-06-06 17:44:20', 0);
INSERT INTO `attr` VALUES (5, '储存条件', 1, '常温,冷场', 1, '2021-06-06 17:46:08', '2021-06-06 17:46:08', 0);
INSERT INTO `attr` VALUES (6, '品牌名称', 0, '', 5, '2023-10-05 14:58:44', '2023-10-05 14:58:44', 0);
INSERT INTO `attr` VALUES (7, '规格尺寸', 1, '10*10,20*20', 5, '2023-10-05 14:59:03', '2023-10-06 21:49:45', 0);

-- ----------------------------
-- Table structure for attr_group
-- ----------------------------
DROP TABLE IF EXISTS `attr_group`;
CREATE TABLE `attr_group`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分组id',
  `name` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组名',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '属性分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of attr_group
-- ----------------------------
INSERT INTO `attr_group` VALUES (1, '蔬菜水果', 1, '蔬菜水果', '2021-06-06 17:43:21', '2021-06-06 17:43:21', 0);
INSERT INTO `attr_group` VALUES (2, '海鲜水品', 2, '海鲜水品', '2021-11-17 03:31:25', '2021-11-17 03:31:25', 0);
INSERT INTO `attr_group` VALUES (3, '速冻食品', 3, '速冻食品', '2021-11-17 03:31:53', '2021-11-17 03:31:53', 0);
INSERT INTO `attr_group` VALUES (4, '测试', 4, 'test', '2023-10-05 14:46:33', '2023-10-05 14:46:41', 1);
INSERT INTO `attr_group` VALUES (5, '益智玩具', 4, '', '2023-10-05 14:57:51', '2023-10-05 14:57:51', 0);

-- ----------------------------
-- Table structure for base_category_trademark
-- ----------------------------
DROP TABLE IF EXISTS `base_category_trademark`;
CREATE TABLE `base_category_trademark`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `category3_id` bigint NOT NULL DEFAULT 0 COMMENT '三级级分类id',
  `trademark_id` bigint NOT NULL DEFAULT 0 COMMENT '品牌id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '三级分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of base_category_trademark
-- ----------------------------
INSERT INTO `base_category_trademark` VALUES (1, 61, 1, '2021-08-20 15:22:50', '2021-08-20 15:23:14', 1);
INSERT INTO `base_category_trademark` VALUES (2, 61, 2, '2021-08-20 15:22:50', '2021-08-25 19:11:47', 1);
INSERT INTO `base_category_trademark` VALUES (4, 61, 1, '2021-08-20 15:23:27', '2021-08-20 15:34:36', 1);
INSERT INTO `base_category_trademark` VALUES (5, 61, 1, '2021-08-23 17:47:49', '2021-08-23 17:47:49', 0);
INSERT INTO `base_category_trademark` VALUES (6, 62, 1, '2021-08-23 17:48:00', '2021-08-23 17:48:00', 0);
INSERT INTO `base_category_trademark` VALUES (7, 62, 2, '2021-08-23 17:48:00', '2021-08-25 19:11:58', 1);
INSERT INTO `base_category_trademark` VALUES (8, 61, 2, '2021-08-25 19:11:52', '2021-08-25 19:12:25', 1);
INSERT INTO `base_category_trademark` VALUES (10, 63, 2, '2021-10-09 08:44:57', '2021-10-09 08:44:57', 0);
INSERT INTO `base_category_trademark` VALUES (11, 63, 3, '2021-10-09 08:45:05', '2021-10-09 08:45:05', 0);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类名称',
  `img_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父分类id',
  `status` tinyint NULL DEFAULT NULL COMMENT '是否显示[0-不显示，1显示]',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品三级分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '新鲜蔬菜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/1.jpg', NULL, NULL, 1, '2021-06-06 17:36:18', '2023-10-13 14:53:47', 0);
INSERT INTO `category` VALUES (2, '时令水果', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/2.jpg', NULL, NULL, 2, '2021-06-06 17:36:45', '2023-10-13 14:54:19', 0);
INSERT INTO `category` VALUES (3, '肉禽蛋品', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/3.jpg', NULL, NULL, 3, '2021-06-06 17:37:22', '2023-10-13 14:54:24', 0);
INSERT INTO `category` VALUES (4, '海鲜水产', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/4.jpg', NULL, NULL, 4, '2021-06-06 17:37:42', '2023-10-13 14:54:28', 0);
INSERT INTO `category` VALUES (5, '速食冻品', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/5.jpg', NULL, NULL, 5, '2021-06-06 17:38:07', '2023-10-13 14:54:30', 0);
INSERT INTO `category` VALUES (6, '乳品烘焙', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/6.jpg', NULL, NULL, 6, '2021-06-06 17:39:14', '2023-10-13 14:54:34', 0);
INSERT INTO `category` VALUES (7, '面包蛋糕', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/7.jpg', NULL, NULL, 7, '2021-06-06 17:39:37', '2023-10-13 14:54:38', 0);
INSERT INTO `category` VALUES (8, '酒饮冲调', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/8.jpg', NULL, NULL, 8, '2021-06-06 17:40:05', '2023-10-13 14:54:41', 0);
INSERT INTO `category` VALUES (9, '休闲零食', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/9.jpg', NULL, NULL, 10, '2021-06-06 17:40:33', '2023-10-13 14:54:44', 0);
INSERT INTO `category` VALUES (10, '粮油调味', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/10.jpg', NULL, NULL, 10, '2021-06-06 17:40:51', '2023-10-13 14:54:46', 0);
INSERT INTO `category` VALUES (11, '日用百货', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/11.jpg', NULL, NULL, 11, '2021-06-06 17:41:06', '2023-10-13 14:54:48', 0);
INSERT INTO `category` VALUES (12, '鲜花宠物', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/12.jpg', NULL, NULL, 12, '2021-06-06 17:41:25', '2023-10-13 14:54:51', 0);
INSERT INTO `category` VALUES (13, '母婴玩具', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/13.jpg', NULL, NULL, 13, '2021-06-06 17:41:43', '2023-10-13 14:54:53', 0);
INSERT INTO `category` VALUES (14, '数码家电', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/categoryPic/14.jpg', NULL, NULL, 14, '2021-06-06 17:42:08', '2023-10-13 14:54:56', 0);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint NULL DEFAULT NULL COMMENT 'sku_id',
  `sku_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名字',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员昵称',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `star` tinyint(1) NULL DEFAULT NULL COMMENT '星级',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员ip',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '显示状态[0-不显示，1-显示]',
  `follow_count` int NULL DEFAULT NULL COMMENT '点赞数',
  `reply_count` int NULL DEFAULT NULL COMMENT '回复数',
  `resources` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论图片/视频[json数据；[{type:文件类型,url:资源路径}]]',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `type` tinyint NULL DEFAULT NULL COMMENT '评论类型[0 - 对商品的直接评论，1 - 对评论的回复]',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品评价' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for comment_replay
-- ----------------------------
DROP TABLE IF EXISTS `comment_replay`;
CREATE TABLE `comment_replay`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment_id` bigint NULL DEFAULT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 1 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品评价回复表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment_replay
-- ----------------------------

-- ----------------------------
-- Table structure for mq_repeat_record
-- ----------------------------
DROP TABLE IF EXISTS `mq_repeat_record`;
CREATE TABLE `mq_repeat_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `business_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务编号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'mq去重表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mq_repeat_record
-- ----------------------------

-- ----------------------------
-- Table structure for region_ware
-- ----------------------------
DROP TABLE IF EXISTS `region_ware`;
CREATE TABLE `region_ware`  (
  `id` bigint NOT NULL DEFAULT 0 COMMENT 'id',
  `region` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '开通区域',
  `region_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '区域名称',
  `ware_id` bigint NOT NULL DEFAULT 0 COMMENT '仓库',
  `ware_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '仓库名称',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 1 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '城市仓库关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of region_ware
-- ----------------------------

-- ----------------------------
-- Table structure for sku_attr_value
-- ----------------------------
DROP TABLE IF EXISTS `sku_attr_value`;
CREATE TABLE `sku_attr_value`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `attr_id` bigint NULL DEFAULT NULL COMMENT '属性id',
  `attr_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属性名',
  `attr_value` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属性值',
  `sort` int NULL DEFAULT NULL COMMENT '顺序',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 208 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'spu属性值' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sku_attr_value
-- ----------------------------
INSERT INTO `sku_attr_value` VALUES (1, 1, 1, '品牌', '自产', 1, '2021-06-06 17:53:03', '2021-08-17 11:25:47', 1);
INSERT INTO `sku_attr_value` VALUES (2, 1, 2, '规格', '300g±30g', 2, '2021-06-06 17:53:03', '2021-08-17 11:25:47', 1);
INSERT INTO `sku_attr_value` VALUES (3, 1, 3, '产地', '成都龙泉', 3, '2021-06-06 17:53:03', '2021-08-17 11:25:47', 1);
INSERT INTO `sku_attr_value` VALUES (4, 1, 4, '保质期', '3天', 4, '2021-06-06 17:53:03', '2021-08-17 11:25:47', 1);
INSERT INTO `sku_attr_value` VALUES (5, 1, 5, '储存条件', '常温', 5, '2021-06-06 17:53:03', '2021-08-17 11:25:47', 1);
INSERT INTO `sku_attr_value` VALUES (6, 2, 1, '品牌', '自产', 1, '2021-06-06 18:04:27', '2021-08-17 11:26:23', 1);
INSERT INTO `sku_attr_value` VALUES (7, 2, 2, '规格', '250', 2, '2021-06-06 18:04:27', '2021-08-17 11:26:23', 1);
INSERT INTO `sku_attr_value` VALUES (8, 2, 3, '产地', '成都郫县', 3, '2021-06-06 18:04:27', '2021-08-17 11:26:23', 1);
INSERT INTO `sku_attr_value` VALUES (9, 2, 4, '保质期', '180天', 4, '2021-06-06 18:04:27', '2021-08-17 11:26:23', 1);
INSERT INTO `sku_attr_value` VALUES (10, 2, 5, '储存条件', '常温', 5, '2021-06-06 18:04:27', '2021-08-17 11:26:23', 1);
INSERT INTO `sku_attr_value` VALUES (11, 3, 1, '品牌', '宏达', 1, '2021-06-06 18:05:57', '2021-08-17 11:26:43', 1);
INSERT INTO `sku_attr_value` VALUES (12, 3, 2, '规格', '300g±30g', 2, '2021-06-06 18:05:57', '2021-08-17 11:26:43', 1);
INSERT INTO `sku_attr_value` VALUES (13, 3, 3, '产地', '成都龙泉', 3, '2021-06-06 18:05:57', '2021-08-17 11:26:43', 1);
INSERT INTO `sku_attr_value` VALUES (14, 3, 4, '保质期', '3天', 4, '2021-06-06 18:05:57', '2021-08-17 11:26:43', 1);
INSERT INTO `sku_attr_value` VALUES (15, 3, 5, '储存条件', '冷场', 5, '2021-06-06 18:05:57', '2021-08-17 11:26:43', 1);
INSERT INTO `sku_attr_value` VALUES (16, 4, 1, '品牌', '三菱', 1, '2021-06-06 18:09:42', '2021-08-17 11:27:12', 1);
INSERT INTO `sku_attr_value` VALUES (17, 4, 2, '规格', '500g±30g', 2, '2021-06-06 18:09:42', '2021-08-17 11:27:12', 1);
INSERT INTO `sku_attr_value` VALUES (18, 4, 3, '产地', '成都达州', 3, '2021-06-06 18:09:42', '2021-08-17 11:27:12', 1);
INSERT INTO `sku_attr_value` VALUES (19, 4, 4, '保质期', '180天', 4, '2021-06-06 18:09:42', '2021-08-17 11:27:12', 1);
INSERT INTO `sku_attr_value` VALUES (20, 4, 5, '储存条件', '常温', 5, '2021-06-06 18:09:42', '2021-08-17 11:27:12', 1);
INSERT INTO `sku_attr_value` VALUES (21, 5, 1, '品牌', '自产', 1, '2021-06-06 18:10:56', '2021-08-17 11:27:29', 1);
INSERT INTO `sku_attr_value` VALUES (22, 5, 2, '规格', '500±30g', 2, '2021-06-06 18:10:56', '2021-08-17 11:27:29', 1);
INSERT INTO `sku_attr_value` VALUES (23, 5, 3, '产地', '四川巴中', 3, '2021-06-06 18:10:56', '2021-08-17 11:27:29', 1);
INSERT INTO `sku_attr_value` VALUES (24, 5, 4, '保质期', '200天', 4, '2021-06-06 18:10:56', '2021-08-17 11:27:29', 1);
INSERT INTO `sku_attr_value` VALUES (25, 5, 5, '储存条件', '常温', 5, '2021-06-06 18:10:56', '2021-08-17 11:27:29', 1);
INSERT INTO `sku_attr_value` VALUES (26, 6, 1, '品牌', '自产', 1, '2021-06-06 18:13:46', '2021-08-17 11:27:49', 1);
INSERT INTO `sku_attr_value` VALUES (27, 6, 2, '规格', '500g±30g', 2, '2021-06-06 18:13:46', '2021-08-17 11:27:49', 1);
INSERT INTO `sku_attr_value` VALUES (28, 6, 3, '产地', '四川达州', 3, '2021-06-06 18:13:46', '2021-08-17 11:27:49', 1);
INSERT INTO `sku_attr_value` VALUES (29, 6, 4, '保质期', '3', 4, '2021-06-06 18:13:46', '2021-08-17 11:27:49', 1);
INSERT INTO `sku_attr_value` VALUES (30, 6, 5, '储存条件', '冷场', 5, '2021-06-06 18:13:46', '2021-08-17 11:27:49', 1);
INSERT INTO `sku_attr_value` VALUES (31, 7, 1, '品牌', '自产', 1, '2021-06-06 18:15:18', '2021-08-17 11:28:10', 1);
INSERT INTO `sku_attr_value` VALUES (32, 7, 2, '规格', '300g±30g', 2, '2021-06-06 18:15:18', '2021-08-17 11:28:10', 1);
INSERT INTO `sku_attr_value` VALUES (33, 7, 3, '产地', '四川达州', 3, '2021-06-06 18:15:18', '2021-08-17 11:28:10', 1);
INSERT INTO `sku_attr_value` VALUES (34, 7, 4, '保质期', '4天', 4, '2021-06-06 18:15:18', '2021-08-17 11:28:10', 1);
INSERT INTO `sku_attr_value` VALUES (35, 7, 5, '储存条件', '常温', 5, '2021-06-06 18:15:18', '2021-08-17 11:28:10', 1);
INSERT INTO `sku_attr_value` VALUES (36, 8, 1, '品牌', '自产', 1, '2021-06-06 18:16:26', '2021-06-06 18:25:29', 1);
INSERT INTO `sku_attr_value` VALUES (37, 8, 2, '规格', '500g±30g', 2, '2021-06-06 18:16:26', '2021-06-06 18:25:29', 1);
INSERT INTO `sku_attr_value` VALUES (38, 8, 3, '产地', '四川内江', 3, '2021-06-06 18:16:26', '2021-06-06 18:25:29', 1);
INSERT INTO `sku_attr_value` VALUES (39, 8, 4, '保质期', '5天', 4, '2021-06-06 18:16:26', '2021-06-06 18:25:29', 1);
INSERT INTO `sku_attr_value` VALUES (40, 8, 5, '储存条件', '常温', 5, '2021-06-06 18:16:26', '2021-06-06 18:25:29', 1);
INSERT INTO `sku_attr_value` VALUES (41, 9, 1, '品牌', '自产', 1, '2021-06-06 18:17:47', '2021-08-17 11:28:42', 1);
INSERT INTO `sku_attr_value` VALUES (42, 9, 2, '规格', '500g±30g', 2, '2021-06-06 18:17:47', '2021-08-17 11:28:42', 1);
INSERT INTO `sku_attr_value` VALUES (43, 9, 3, '产地', '四川巴中', 3, '2021-06-06 18:17:47', '2021-08-17 11:28:42', 1);
INSERT INTO `sku_attr_value` VALUES (44, 9, 4, '保质期', '5天', 4, '2021-06-06 18:17:47', '2021-08-17 11:28:42', 1);
INSERT INTO `sku_attr_value` VALUES (45, 9, 5, '储存条件', '冷场', 5, '2021-06-06 18:17:47', '2021-08-17 11:28:42', 1);
INSERT INTO `sku_attr_value` VALUES (46, 8, 1, '品牌', '自产', 1, '2021-06-06 18:16:26', '2021-08-17 11:28:25', 1);
INSERT INTO `sku_attr_value` VALUES (47, 8, 2, '规格', '500g±30g', 2, '2021-06-06 18:16:26', '2021-08-17 11:28:25', 1);
INSERT INTO `sku_attr_value` VALUES (48, 8, 3, '产地', '四川内江', 3, '2021-06-06 18:16:26', '2021-08-17 11:28:25', 1);
INSERT INTO `sku_attr_value` VALUES (49, 8, 4, '保质期', '5天', 4, '2021-06-06 18:16:26', '2021-08-17 11:28:25', 1);
INSERT INTO `sku_attr_value` VALUES (50, 8, 5, '储存条件', '常温', 5, '2021-06-06 18:16:26', '2021-08-17 11:28:25', 1);
INSERT INTO `sku_attr_value` VALUES (51, 10, 1, '品牌', '农家', 1, '2021-08-14 21:02:56', '2021-09-18 09:28:28', 1);
INSERT INTO `sku_attr_value` VALUES (52, 10, 2, '规格', '南瓜+2kg', 2, '2021-08-14 21:02:56', '2021-09-18 09:28:28', 1);
INSERT INTO `sku_attr_value` VALUES (53, 10, 3, '产地', '成都', 3, '2021-08-14 21:02:56', '2021-09-18 09:28:28', 1);
INSERT INTO `sku_attr_value` VALUES (54, 10, 4, '保质期', '180天 ', 4, '2021-08-14 21:02:56', '2021-09-18 09:28:28', 1);
INSERT INTO `sku_attr_value` VALUES (55, 10, 5, '储存条件', '常温', 5, '2021-08-14 21:02:56', '2021-09-18 09:28:28', 1);
INSERT INTO `sku_attr_value` VALUES (56, 11, 1, '品牌', '农家', 1, '2021-08-14 21:26:30', '2021-08-17 11:03:54', 1);
INSERT INTO `sku_attr_value` VALUES (57, 11, 2, '规格', '300g±30g', 2, '2021-08-14 21:26:30', '2021-08-17 11:03:54', 1);
INSERT INTO `sku_attr_value` VALUES (58, 11, 3, '产地', '成都', 3, '2021-08-14 21:26:30', '2021-08-17 11:03:54', 1);
INSERT INTO `sku_attr_value` VALUES (59, 11, 4, '保质期', '7', 4, '2021-08-14 21:26:30', '2021-08-17 11:03:54', 1);
INSERT INTO `sku_attr_value` VALUES (60, 11, 5, '储存条件', '常温', 5, '2021-08-14 21:26:30', '2021-08-17 11:03:54', 1);
INSERT INTO `sku_attr_value` VALUES (61, 12, 1, '品牌', '农家', 1, '2021-08-14 21:28:16', '2021-08-17 11:03:36', 1);
INSERT INTO `sku_attr_value` VALUES (62, 12, 2, '规格', '300g±30g', 2, '2021-08-14 21:28:16', '2021-08-17 11:03:36', 1);
INSERT INTO `sku_attr_value` VALUES (63, 12, 3, '产地', '成都', 3, '2021-08-14 21:28:16', '2021-08-17 11:03:36', 1);
INSERT INTO `sku_attr_value` VALUES (64, 12, 4, '保质期', '7', 4, '2021-08-14 21:28:16', '2021-08-17 11:03:36', 1);
INSERT INTO `sku_attr_value` VALUES (65, 12, 5, '储存条件', '常温', 5, '2021-08-14 21:28:16', '2021-08-17 11:03:36', 1);
INSERT INTO `sku_attr_value` VALUES (66, 13, 1, '品牌', '农商', 1, '2021-08-14 21:51:50', '2021-08-17 10:44:20', 1);
INSERT INTO `sku_attr_value` VALUES (67, 13, 2, '规格', '500g±30g', 2, '2021-08-14 21:51:50', '2021-08-17 10:44:20', 1);
INSERT INTO `sku_attr_value` VALUES (68, 13, 3, '产地', '成都', 3, '2021-08-14 21:51:50', '2021-08-17 10:44:20', 1);
INSERT INTO `sku_attr_value` VALUES (69, 13, 4, '保质期', '7', 4, '2021-08-14 21:51:50', '2021-08-17 10:44:20', 1);
INSERT INTO `sku_attr_value` VALUES (70, 13, 5, '储存条件', '冷场', 5, '2021-08-14 21:51:50', '2021-08-17 10:44:20', 1);
INSERT INTO `sku_attr_value` VALUES (71, 13, 1, '品牌', '农商', 1, '2021-08-14 21:51:50', '2021-08-17 10:46:50', 1);
INSERT INTO `sku_attr_value` VALUES (72, 13, 2, '规格', '500g±30g', 2, '2021-08-14 21:51:50', '2021-08-17 10:46:50', 1);
INSERT INTO `sku_attr_value` VALUES (73, 13, 3, '产地', '成都', 3, '2021-08-14 21:51:50', '2021-08-17 10:46:50', 1);
INSERT INTO `sku_attr_value` VALUES (74, 13, 4, '保质期', '7', 4, '2021-08-14 21:51:50', '2021-08-17 10:46:50', 1);
INSERT INTO `sku_attr_value` VALUES (75, 13, 5, '储存条件', '冷场', 5, '2021-08-14 21:51:50', '2021-08-17 10:46:50', 1);
INSERT INTO `sku_attr_value` VALUES (76, 13, 1, '品牌', '农商', 1, '2021-08-14 21:51:50', '2021-08-17 10:54:16', 1);
INSERT INTO `sku_attr_value` VALUES (77, 13, 2, '规格', '500g±30g', 2, '2021-08-14 21:51:50', '2021-08-17 10:54:16', 1);
INSERT INTO `sku_attr_value` VALUES (78, 13, 3, '产地', '成都', 3, '2021-08-14 21:51:50', '2021-08-17 10:54:16', 1);
INSERT INTO `sku_attr_value` VALUES (79, 13, 4, '保质期', '7', 4, '2021-08-14 21:51:50', '2021-08-17 10:54:16', 1);
INSERT INTO `sku_attr_value` VALUES (80, 13, 5, '储存条件', '冷场', 5, '2021-08-14 21:51:50', '2021-08-17 10:54:16', 1);
INSERT INTO `sku_attr_value` VALUES (81, 13, 1, '品牌', '农商', 1, '2021-08-14 21:51:50', '2021-08-17 11:02:50', 1);
INSERT INTO `sku_attr_value` VALUES (82, 13, 2, '规格', '500g±30g', 2, '2021-08-14 21:51:50', '2021-08-17 11:02:50', 1);
INSERT INTO `sku_attr_value` VALUES (83, 13, 3, '产地', '成都', 3, '2021-08-14 21:51:50', '2021-08-17 11:02:50', 1);
INSERT INTO `sku_attr_value` VALUES (84, 13, 4, '保质期', '7', 4, '2021-08-14 21:51:50', '2021-08-17 11:02:50', 1);
INSERT INTO `sku_attr_value` VALUES (85, 13, 5, '储存条件', '冷场', 5, '2021-08-14 21:51:50', '2021-08-17 11:02:50', 1);
INSERT INTO `sku_attr_value` VALUES (86, 13, 1, '品牌', '农商', 1, '2021-08-17 11:02:50', '2021-08-17 11:02:50', 0);
INSERT INTO `sku_attr_value` VALUES (87, 13, 2, '规格', '500g±30g', 2, '2021-08-17 11:02:50', '2021-08-17 11:02:50', 0);
INSERT INTO `sku_attr_value` VALUES (88, 13, 3, '产地', '成都', 3, '2021-08-17 11:02:50', '2021-08-17 11:02:50', 0);
INSERT INTO `sku_attr_value` VALUES (89, 13, 4, '保质期', '7', 4, '2021-08-17 11:02:50', '2021-08-17 11:02:50', 0);
INSERT INTO `sku_attr_value` VALUES (90, 13, 5, '储存条件', '冷场', 5, '2021-08-17 11:02:50', '2021-08-17 11:02:50', 0);
INSERT INTO `sku_attr_value` VALUES (91, 12, 1, '品牌', '农家', 1, '2021-08-17 11:03:36', '2021-08-17 11:28:59', 1);
INSERT INTO `sku_attr_value` VALUES (92, 12, 2, '规格', '300g±30g', 2, '2021-08-17 11:03:36', '2021-08-17 11:28:59', 1);
INSERT INTO `sku_attr_value` VALUES (93, 12, 3, '产地', '成都', 3, '2021-08-17 11:03:36', '2021-08-17 11:28:59', 1);
INSERT INTO `sku_attr_value` VALUES (94, 12, 4, '保质期', '7', 4, '2021-08-17 11:03:36', '2021-08-17 11:28:59', 1);
INSERT INTO `sku_attr_value` VALUES (95, 12, 5, '储存条件', '常温', 5, '2021-08-17 11:03:36', '2021-08-17 11:28:59', 1);
INSERT INTO `sku_attr_value` VALUES (96, 11, 1, '品牌', '农家', 1, '2021-08-17 11:03:54', '2021-08-17 11:03:54', 0);
INSERT INTO `sku_attr_value` VALUES (97, 11, 2, '规格', '300g±30g', 2, '2021-08-17 11:03:54', '2021-08-17 11:03:54', 0);
INSERT INTO `sku_attr_value` VALUES (98, 11, 3, '产地', '成都', 3, '2021-08-17 11:03:54', '2021-08-17 11:03:54', 0);
INSERT INTO `sku_attr_value` VALUES (99, 11, 4, '保质期', '7', 4, '2021-08-17 11:03:54', '2021-08-17 11:03:54', 0);
INSERT INTO `sku_attr_value` VALUES (100, 11, 5, '储存条件', '常温', 5, '2021-08-17 11:03:54', '2021-08-17 11:03:54', 0);
INSERT INTO `sku_attr_value` VALUES (101, 1, 1, '品牌', '自产', 1, '2021-08-17 11:25:47', '2021-09-18 09:40:23', 1);
INSERT INTO `sku_attr_value` VALUES (102, 1, 2, '规格', '300g±30g', 2, '2021-08-17 11:25:47', '2021-09-18 09:40:23', 1);
INSERT INTO `sku_attr_value` VALUES (103, 1, 3, '产地', '成都龙泉', 3, '2021-08-17 11:25:47', '2021-09-18 09:40:23', 1);
INSERT INTO `sku_attr_value` VALUES (104, 1, 4, '保质期', '3天', 4, '2021-08-17 11:25:47', '2021-09-18 09:40:23', 1);
INSERT INTO `sku_attr_value` VALUES (105, 1, 5, '储存条件', '常温', 5, '2021-08-17 11:25:48', '2021-09-18 09:40:23', 1);
INSERT INTO `sku_attr_value` VALUES (106, 2, 1, '品牌', '自产', 1, '2021-08-17 11:26:23', '2021-08-17 11:26:23', 0);
INSERT INTO `sku_attr_value` VALUES (107, 2, 2, '规格', '250', 2, '2021-08-17 11:26:23', '2021-08-17 11:26:23', 0);
INSERT INTO `sku_attr_value` VALUES (108, 2, 3, '产地', '成都郫县', 3, '2021-08-17 11:26:23', '2021-08-17 11:26:23', 0);
INSERT INTO `sku_attr_value` VALUES (109, 2, 4, '保质期', '180天', 4, '2021-08-17 11:26:23', '2021-08-17 11:26:23', 0);
INSERT INTO `sku_attr_value` VALUES (110, 2, 5, '储存条件', '常温', 5, '2021-08-17 11:26:23', '2021-08-17 11:26:23', 0);
INSERT INTO `sku_attr_value` VALUES (111, 3, 1, '品牌', '宏达', 1, '2021-08-17 11:26:44', '2021-08-17 11:26:44', 0);
INSERT INTO `sku_attr_value` VALUES (112, 3, 2, '规格', '300g±30g', 2, '2021-08-17 11:26:44', '2021-08-17 11:26:44', 0);
INSERT INTO `sku_attr_value` VALUES (113, 3, 3, '产地', '成都龙泉', 3, '2021-08-17 11:26:44', '2021-08-17 11:26:44', 0);
INSERT INTO `sku_attr_value` VALUES (114, 3, 4, '保质期', '3天', 4, '2021-08-17 11:26:44', '2021-08-17 11:26:44', 0);
INSERT INTO `sku_attr_value` VALUES (115, 3, 5, '储存条件', '冷场', 5, '2021-08-17 11:26:44', '2021-08-17 11:26:44', 0);
INSERT INTO `sku_attr_value` VALUES (116, 4, 1, '品牌', '三菱', 1, '2021-08-17 11:27:12', '2021-09-18 09:35:51', 1);
INSERT INTO `sku_attr_value` VALUES (117, 4, 2, '规格', '500g±30g', 2, '2021-08-17 11:27:12', '2021-09-18 09:35:51', 1);
INSERT INTO `sku_attr_value` VALUES (118, 4, 3, '产地', '成都达州', 3, '2021-08-17 11:27:12', '2021-09-18 09:35:51', 1);
INSERT INTO `sku_attr_value` VALUES (119, 4, 4, '保质期', '180天', 4, '2021-08-17 11:27:12', '2021-09-18 09:35:51', 1);
INSERT INTO `sku_attr_value` VALUES (120, 4, 5, '储存条件', '常温', 5, '2021-08-17 11:27:12', '2021-09-18 09:35:51', 1);
INSERT INTO `sku_attr_value` VALUES (121, 5, 1, '品牌', '自产', 1, '2021-08-17 11:27:29', '2021-09-28 06:08:58', 1);
INSERT INTO `sku_attr_value` VALUES (122, 5, 2, '规格', '500±30g', 2, '2021-08-17 11:27:29', '2021-09-28 06:08:58', 1);
INSERT INTO `sku_attr_value` VALUES (123, 5, 3, '产地', '四川巴中', 3, '2021-08-17 11:27:29', '2021-09-28 06:08:58', 1);
INSERT INTO `sku_attr_value` VALUES (124, 5, 4, '保质期', '200天', 4, '2021-08-17 11:27:29', '2021-09-28 06:08:58', 1);
INSERT INTO `sku_attr_value` VALUES (125, 5, 5, '储存条件', '常温', 5, '2021-08-17 11:27:29', '2021-09-28 06:08:58', 1);
INSERT INTO `sku_attr_value` VALUES (126, 6, 1, '品牌', '自产', 1, '2021-08-17 11:27:49', '2021-08-17 11:27:49', 0);
INSERT INTO `sku_attr_value` VALUES (127, 6, 2, '规格', '500g±30g', 2, '2021-08-17 11:27:49', '2021-08-17 11:27:49', 0);
INSERT INTO `sku_attr_value` VALUES (128, 6, 3, '产地', '四川达州', 3, '2021-08-17 11:27:49', '2021-08-17 11:27:49', 0);
INSERT INTO `sku_attr_value` VALUES (129, 6, 4, '保质期', '3', 4, '2021-08-17 11:27:49', '2021-08-17 11:27:49', 0);
INSERT INTO `sku_attr_value` VALUES (130, 6, 5, '储存条件', '冷场', 5, '2021-08-17 11:27:49', '2021-08-17 11:27:49', 0);
INSERT INTO `sku_attr_value` VALUES (131, 7, 1, '品牌', '自产', 1, '2021-08-17 11:28:10', '2021-09-27 10:38:32', 1);
INSERT INTO `sku_attr_value` VALUES (132, 7, 2, '规格', '300g±30g', 2, '2021-08-17 11:28:10', '2021-09-27 10:38:32', 1);
INSERT INTO `sku_attr_value` VALUES (133, 7, 3, '产地', '四川达州', 3, '2021-08-17 11:28:10', '2021-09-27 10:38:32', 1);
INSERT INTO `sku_attr_value` VALUES (134, 7, 4, '保质期', '4天', 4, '2021-08-17 11:28:10', '2021-09-27 10:38:32', 1);
INSERT INTO `sku_attr_value` VALUES (135, 7, 5, '储存条件', '常温', 5, '2021-08-17 11:28:10', '2021-09-27 10:38:32', 1);
INSERT INTO `sku_attr_value` VALUES (136, 8, 1, '品牌', '自产', 1, '2021-08-17 11:28:25', '2021-08-17 11:28:25', 0);
INSERT INTO `sku_attr_value` VALUES (137, 8, 2, '规格', '500g±30g', 2, '2021-08-17 11:28:25', '2021-08-17 11:28:25', 0);
INSERT INTO `sku_attr_value` VALUES (138, 8, 3, '产地', '四川内江', 3, '2021-08-17 11:28:25', '2021-08-17 11:28:25', 0);
INSERT INTO `sku_attr_value` VALUES (139, 8, 4, '保质期', '5天', 4, '2021-08-17 11:28:26', '2021-08-17 11:28:26', 0);
INSERT INTO `sku_attr_value` VALUES (140, 8, 5, '储存条件', '常温', 5, '2021-08-17 11:28:26', '2021-08-17 11:28:26', 0);
INSERT INTO `sku_attr_value` VALUES (141, 9, 1, '品牌', '自产', 1, '2021-08-17 11:28:42', '2021-08-17 11:28:42', 0);
INSERT INTO `sku_attr_value` VALUES (142, 9, 2, '规格', '500g±30g', 2, '2021-08-17 11:28:42', '2021-08-17 11:28:42', 0);
INSERT INTO `sku_attr_value` VALUES (143, 9, 3, '产地', '四川巴中', 3, '2021-08-17 11:28:42', '2021-08-17 11:28:42', 0);
INSERT INTO `sku_attr_value` VALUES (144, 9, 4, '保质期', '5天', 4, '2021-08-17 11:28:42', '2021-08-17 11:28:42', 0);
INSERT INTO `sku_attr_value` VALUES (145, 9, 5, '储存条件', '冷场', 5, '2021-08-17 11:28:42', '2021-08-17 11:28:42', 0);
INSERT INTO `sku_attr_value` VALUES (146, 12, 1, '品牌', '农家', 1, '2021-08-17 11:28:59', '2021-08-17 11:28:59', 0);
INSERT INTO `sku_attr_value` VALUES (147, 12, 2, '规格', '300g±30g', 2, '2021-08-17 11:28:59', '2021-08-17 11:28:59', 0);
INSERT INTO `sku_attr_value` VALUES (148, 12, 3, '产地', '成都', 3, '2021-08-17 11:28:59', '2021-08-17 11:28:59', 0);
INSERT INTO `sku_attr_value` VALUES (149, 12, 4, '保质期', '7', 4, '2021-08-17 11:28:59', '2021-08-17 11:28:59', 0);
INSERT INTO `sku_attr_value` VALUES (150, 12, 5, '储存条件', '常温', 5, '2021-08-17 11:28:59', '2021-08-17 11:28:59', 0);
INSERT INTO `sku_attr_value` VALUES (151, 10, 1, '品牌', '农家', 1, '2021-09-18 09:28:28', '2021-09-18 09:28:28', 0);
INSERT INTO `sku_attr_value` VALUES (152, 10, 2, '规格', '南瓜+2kg', 2, '2021-09-18 09:28:28', '2021-09-18 09:28:28', 0);
INSERT INTO `sku_attr_value` VALUES (153, 10, 3, '产地', '成都', 3, '2021-09-18 09:28:28', '2021-09-18 09:28:28', 0);
INSERT INTO `sku_attr_value` VALUES (154, 10, 4, '保质期', '180天 ', 4, '2021-09-18 09:28:28', '2021-09-18 09:28:28', 0);
INSERT INTO `sku_attr_value` VALUES (155, 10, 5, '储存条件', '常温', 5, '2021-09-18 09:28:28', '2021-09-18 09:28:28', 0);
INSERT INTO `sku_attr_value` VALUES (156, 4, 1, '品牌', '三菱', 1, '2021-09-18 09:35:51', '2021-09-18 09:35:51', 0);
INSERT INTO `sku_attr_value` VALUES (157, 4, 2, '规格', '500g±30g', 2, '2021-09-18 09:35:51', '2021-09-18 09:35:51', 0);
INSERT INTO `sku_attr_value` VALUES (158, 4, 3, '产地', '成都达州', 3, '2021-09-18 09:35:51', '2021-09-18 09:35:51', 0);
INSERT INTO `sku_attr_value` VALUES (159, 4, 4, '保质期', '180天', 4, '2021-09-18 09:35:51', '2021-09-18 09:35:51', 0);
INSERT INTO `sku_attr_value` VALUES (160, 4, 5, '储存条件', '常温', 5, '2021-09-18 09:35:51', '2021-09-18 09:35:51', 0);
INSERT INTO `sku_attr_value` VALUES (161, 1, 1, '品牌', '自产', 1, '2021-09-18 09:40:23', '2021-09-18 09:41:28', 1);
INSERT INTO `sku_attr_value` VALUES (162, 1, 2, '规格', '300g±30g', 2, '2021-09-18 09:40:23', '2021-09-18 09:41:28', 1);
INSERT INTO `sku_attr_value` VALUES (163, 1, 3, '产地', '成都龙泉', 3, '2021-09-18 09:40:23', '2021-09-18 09:41:28', 1);
INSERT INTO `sku_attr_value` VALUES (164, 1, 4, '保质期', '3天', 4, '2021-09-18 09:40:23', '2021-09-18 09:41:28', 1);
INSERT INTO `sku_attr_value` VALUES (165, 1, 5, '储存条件', '常温', 5, '2021-09-18 09:40:23', '2021-09-18 09:41:28', 1);
INSERT INTO `sku_attr_value` VALUES (166, 1, 1, '品牌', '自产', 1, '2021-09-18 09:41:29', '2021-09-18 09:55:42', 1);
INSERT INTO `sku_attr_value` VALUES (167, 1, 2, '规格', '300g±30g', 2, '2021-09-18 09:41:29', '2021-09-18 09:55:42', 1);
INSERT INTO `sku_attr_value` VALUES (168, 1, 3, '产地', '成都龙泉', 3, '2021-09-18 09:41:29', '2021-09-18 09:55:42', 1);
INSERT INTO `sku_attr_value` VALUES (169, 1, 4, '保质期', '3天', 4, '2021-09-18 09:41:29', '2021-09-18 09:55:42', 1);
INSERT INTO `sku_attr_value` VALUES (170, 1, 5, '储存条件', '常温', 5, '2021-09-18 09:41:29', '2021-09-18 09:55:42', 1);
INSERT INTO `sku_attr_value` VALUES (171, 1, 1, '品牌', '自产', 1, '2021-09-18 09:55:42', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_attr_value` VALUES (172, 1, 2, '规格', '300g±30g', 2, '2021-09-18 09:55:42', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_attr_value` VALUES (173, 1, 3, '产地', '成都龙泉', 3, '2021-09-18 09:55:42', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_attr_value` VALUES (174, 1, 4, '保质期', '3天', 4, '2021-09-18 09:55:42', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_attr_value` VALUES (175, 1, 5, '储存条件', '常温', 5, '2021-09-18 09:55:42', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_attr_value` VALUES (176, 1, 1, '品牌', '自产', 1, '2021-09-18 09:56:00', '2021-09-18 09:56:11', 1);
INSERT INTO `sku_attr_value` VALUES (177, 1, 2, '规格', '300g±30g', 2, '2021-09-18 09:56:01', '2021-09-18 09:56:11', 1);
INSERT INTO `sku_attr_value` VALUES (178, 1, 3, '产地', '成都龙泉', 3, '2021-09-18 09:56:01', '2021-09-18 09:56:11', 1);
INSERT INTO `sku_attr_value` VALUES (179, 1, 4, '保质期', '3天', 4, '2021-09-18 09:56:01', '2021-09-18 09:56:11', 1);
INSERT INTO `sku_attr_value` VALUES (180, 1, 5, '储存条件', '常温', 5, '2021-09-18 09:56:01', '2021-09-18 09:56:11', 1);
INSERT INTO `sku_attr_value` VALUES (181, 1, 1, '品牌', '自产', 1, '2021-09-18 09:56:11', '2021-09-18 09:56:11', 0);
INSERT INTO `sku_attr_value` VALUES (182, 1, 2, '规格', '300g±30g', 2, '2021-09-18 09:56:11', '2021-09-18 09:56:11', 0);
INSERT INTO `sku_attr_value` VALUES (183, 1, 3, '产地', '成都龙泉', 3, '2021-09-18 09:56:11', '2021-09-18 09:56:11', 0);
INSERT INTO `sku_attr_value` VALUES (184, 1, 4, '保质期', '3天', 4, '2021-09-18 09:56:11', '2021-09-18 09:56:11', 0);
INSERT INTO `sku_attr_value` VALUES (185, 1, 5, '储存条件', '常温', 5, '2021-09-18 09:56:11', '2021-09-18 09:56:11', 0);
INSERT INTO `sku_attr_value` VALUES (186, 7, 1, '品牌', '自产', 1, '2021-09-27 10:38:32', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_attr_value` VALUES (187, 7, 2, '规格', '300g±30g', 2, '2021-09-27 10:38:32', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_attr_value` VALUES (188, 7, 3, '产地', '四川达州', 3, '2021-09-27 10:38:32', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_attr_value` VALUES (189, 7, 4, '保质期', '4天', 4, '2021-09-27 10:38:32', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_attr_value` VALUES (190, 7, 5, '储存条件', '常温', 5, '2021-09-27 10:38:32', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_attr_value` VALUES (191, 7, 1, '品牌', '自产', 1, '2021-09-27 10:42:35', '2021-09-27 10:42:35', 0);
INSERT INTO `sku_attr_value` VALUES (192, 7, 2, '规格', '300g±30g', 2, '2021-09-27 10:42:35', '2021-09-27 10:42:35', 0);
INSERT INTO `sku_attr_value` VALUES (193, 7, 3, '产地', '四川达州', 3, '2021-09-27 10:42:35', '2021-09-27 10:42:35', 0);
INSERT INTO `sku_attr_value` VALUES (194, 7, 4, '保质期', '4天', 4, '2021-09-27 10:42:35', '2021-09-27 10:42:35', 0);
INSERT INTO `sku_attr_value` VALUES (195, 7, 5, '储存条件', '常温', 5, '2021-09-27 10:42:35', '2021-09-27 10:42:35', 0);
INSERT INTO `sku_attr_value` VALUES (196, 5, 1, '品牌', '自产', 1, '2021-09-28 06:08:58', '2021-09-28 06:08:58', 0);
INSERT INTO `sku_attr_value` VALUES (197, 5, 2, '规格', '500±30g', 2, '2021-09-28 06:08:58', '2021-09-28 06:08:58', 0);
INSERT INTO `sku_attr_value` VALUES (198, 5, 3, '产地', '四川巴中', 3, '2021-09-28 06:08:58', '2021-09-28 06:08:58', 0);
INSERT INTO `sku_attr_value` VALUES (199, 5, 4, '保质期', '200天', 4, '2021-09-28 06:08:58', '2021-09-28 06:08:58', 0);
INSERT INTO `sku_attr_value` VALUES (200, 5, 5, '储存条件', '常温', 5, '2021-09-28 06:08:58', '2021-09-28 06:08:58', 0);
INSERT INTO `sku_attr_value` VALUES (201, 14, 6, '品牌名称', '春秋争霸', NULL, '2023-10-06 21:52:44', '2023-10-06 22:57:01', 1);
INSERT INTO `sku_attr_value` VALUES (202, 14, 7, '规格尺寸', '10*10', NULL, '2023-10-06 21:52:44', '2023-10-06 22:57:01', 1);
INSERT INTO `sku_attr_value` VALUES (203, 14, 6, '品牌名称', '春秋争霸', NULL, '2023-10-06 22:57:01', '2023-10-06 22:59:10', 1);
INSERT INTO `sku_attr_value` VALUES (204, 14, 7, '规格尺寸', '10*10', NULL, '2023-10-06 22:57:01', '2023-10-06 22:59:10', 1);
INSERT INTO `sku_attr_value` VALUES (205, 14, 6, '品牌名称', '春争霸', NULL, '2023-10-06 22:59:10', '2023-10-06 22:59:10', 0);
INSERT INTO `sku_attr_value` VALUES (206, 14, 7, '规格尺寸', '20*20', NULL, '2023-10-06 22:59:10', '2023-10-06 22:59:10', 0);
INSERT INTO `sku_attr_value` VALUES (207, 15, 6, '品牌名称', 'Tank', NULL, '2023-10-10 01:25:02', '2023-10-10 01:25:02', 0);
INSERT INTO `sku_attr_value` VALUES (208, 15, 7, '规格尺寸', '20*20', NULL, '2023-10-10 01:25:02', '2023-10-10 01:25:02', 0);

-- ----------------------------
-- Table structure for sku_detail
-- ----------------------------
DROP TABLE IF EXISTS `sku_detail`;
CREATE TABLE `sku_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `detail_html` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '详情内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'spu属性值' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sku_detail
-- ----------------------------
INSERT INTO `sku_detail` VALUES (1, 1, '西红柿', '2021-06-06 17:53:03', '2021-06-06 18:00:18', 0);
INSERT INTO `sku_detail` VALUES (2, 2, '红薯', '2021-06-06 18:04:27', '2021-06-06 18:04:27', 0);
INSERT INTO `sku_detail` VALUES (3, 3, '红薯', '2021-06-06 18:05:57', '2021-06-06 18:05:57', 0);
INSERT INTO `sku_detail` VALUES (4, 4, '大蒜', '2021-06-06 18:09:42', '2021-06-06 18:09:42', 0);
INSERT INTO `sku_detail` VALUES (5, 5, '土豆', '2021-06-06 18:10:56', '2021-06-06 18:10:56', 0);
INSERT INTO `sku_detail` VALUES (6, 6, '丝瓜', '2021-06-06 18:13:46', '2021-06-06 18:13:46', 0);
INSERT INTO `sku_detail` VALUES (7, 7, '辣椒', '2021-06-06 18:15:18', '2021-06-06 18:15:18', 0);
INSERT INTO `sku_detail` VALUES (8, 8, '茄子', '2021-06-06 18:16:26', '2021-06-06 18:16:26', 0);
INSERT INTO `sku_detail` VALUES (9, 9, '玉米', '2021-06-06 18:17:47', '2021-06-06 18:17:47', 0);
INSERT INTO `sku_detail` VALUES (10, 10, '南瓜', '2021-08-14 21:02:56', '2021-08-14 21:02:56', 0);
INSERT INTO `sku_detail` VALUES (11, 11, '苹果300g±30g', '2021-08-14 21:26:30', '2021-08-14 21:26:30', 0);
INSERT INTO `sku_detail` VALUES (12, 12, '橘子300g±30g', '2021-08-14 21:28:16', '2021-08-14 21:28:16', 0);
INSERT INTO `sku_detail` VALUES (13, 13, NULL, '2021-08-14 21:51:50', '2021-08-27 21:17:30', 0);

-- ----------------------------
-- Table structure for sku_image
-- ----------------------------
DROP TABLE IF EXISTS `sku_image`;
CREATE TABLE `sku_image`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint NULL DEFAULT NULL COMMENT 'sku_id',
  `img_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品图片' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sku_image
-- ----------------------------
INSERT INTO `sku_image` VALUES (1, 1, '微信图片_20210606173007.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173007.jpg', 1, '2021-06-06 17:53:03', '2021-08-17 11:25:47', 1);
INSERT INTO `sku_image` VALUES (2, 1, '微信图片_20210606172954.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606172954.jpg', 2, '2021-06-06 17:53:03', '2021-08-17 11:25:47', 1);
INSERT INTO `sku_image` VALUES (3, 1, '微信图片_20210606173011.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173011.jpg', 3, '2021-06-06 17:53:03', '2021-08-17 11:25:47', 1);
INSERT INTO `sku_image` VALUES (4, 2, '微信图片_20210606173023.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173023.jpg', 1, '2021-06-06 18:04:27', '2021-08-17 11:26:22', 1);
INSERT INTO `sku_image` VALUES (5, 2, '微信图片_20210606173027.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173027.jpg', 2, '2021-06-06 18:04:27', '2021-08-17 11:26:22', 1);
INSERT INTO `sku_image` VALUES (6, 2, '微信图片_20210606173019.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173019.jpg', 3, '2021-06-06 18:04:27', '2021-08-17 11:26:22', 1);
INSERT INTO `sku_image` VALUES (7, 2, '微信图片_20210606173015.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173015.jpg', 4, '2021-06-06 18:04:27', '2021-08-17 11:26:22', 1);
INSERT INTO `sku_image` VALUES (12, 3, '微信图片_20210606173037.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173037.jpg', 5, '2021-06-06 18:05:57', '2021-08-17 11:26:43', 1);
INSERT INTO `sku_image` VALUES (13, 3, '微信图片_20210606173034.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173034.jpg', 6, '2021-06-06 18:05:57', '2021-08-17 11:26:43', 1);
INSERT INTO `sku_image` VALUES (14, 3, '微信图片_20210606173030.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173030.jpg', 7, '2021-06-06 18:05:57', '2021-08-17 11:26:43', 1);
INSERT INTO `sku_image` VALUES (15, 4, '微信图片_20210606173049.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173049.jpg', 1, '2021-06-06 18:09:42', '2021-08-17 11:27:12', 1);
INSERT INTO `sku_image` VALUES (16, 4, '微信图片_20210606173045.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173045.jpg', 2, '2021-06-06 18:09:42', '2021-08-17 11:27:12', 1);
INSERT INTO `sku_image` VALUES (17, 4, '微信图片_20210606173041.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173041.jpg', 3, '2021-06-06 18:09:42', '2021-08-17 11:27:12', 1);
INSERT INTO `sku_image` VALUES (21, 5, '微信图片_20210606173059.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173059.jpg', 4, '2021-06-06 18:10:56', '2021-08-17 11:27:29', 1);
INSERT INTO `sku_image` VALUES (22, 5, '微信图片_20210606173055.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173055.jpg', 5, '2021-06-06 18:10:56', '2021-08-17 11:27:29', 1);
INSERT INTO `sku_image` VALUES (23, 5, '微信图片_20210606173052.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173052.jpg', 6, '2021-06-06 18:10:56', '2021-08-17 11:27:29', 1);
INSERT INTO `sku_image` VALUES (24, 6, '微信图片_20210606173109.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173109.jpg', 1, '2021-06-06 18:13:46', '2021-08-17 11:27:49', 1);
INSERT INTO `sku_image` VALUES (25, 6, '微信图片_20210606173105.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173105.jpg', 2, '2021-06-06 18:13:46', '2021-08-17 11:27:49', 1);
INSERT INTO `sku_image` VALUES (26, 6, '微信图片_20210606173102.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173102.jpg', 3, '2021-06-06 18:13:46', '2021-08-17 11:27:49', 1);
INSERT INTO `sku_image` VALUES (27, 7, '微信图片_20210606173118.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173118.jpg', 1, '2021-06-06 18:15:18', '2021-08-17 11:28:10', 1);
INSERT INTO `sku_image` VALUES (28, 7, '微信图片_20210606173115.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173115.jpg', 2, '2021-06-06 18:15:18', '2021-08-17 11:28:10', 1);
INSERT INTO `sku_image` VALUES (29, 7, '微信图片_20210606173112.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173112.jpg', 3, '2021-06-06 18:15:18', '2021-08-17 11:28:10', 1);
INSERT INTO `sku_image` VALUES (30, 8, '微信图片_20210606173127.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173127.jpg', 1, '2021-06-06 18:16:26', '2021-06-06 18:25:28', 1);
INSERT INTO `sku_image` VALUES (31, 8, '微信图片_20210606173131.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173131.jpg', 2, '2021-06-06 18:16:26', '2021-06-06 18:25:28', 1);
INSERT INTO `sku_image` VALUES (32, 8, '微信图片_20210606173122.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173122.jpg', 3, '2021-06-06 18:16:26', '2021-06-06 18:25:28', 1);
INSERT INTO `sku_image` VALUES (33, 9, '微信图片_20210606173139.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173139.jpg', 1, '2021-06-06 18:17:47', '2021-08-17 11:28:42', 1);
INSERT INTO `sku_image` VALUES (34, 9, '微信图片_20210606173135.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173135.jpg', 2, '2021-06-06 18:17:47', '2021-08-17 11:28:42', 1);
INSERT INTO `sku_image` VALUES (35, 8, '微信图片_20210606173127.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173127.jpg', 1, '2021-06-06 18:16:26', '2021-08-17 11:28:25', 1);
INSERT INTO `sku_image` VALUES (36, 8, '微信图片_20210606173131.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173131.jpg', 2, '2021-06-06 18:16:26', '2021-08-17 11:28:25', 1);
INSERT INTO `sku_image` VALUES (37, 8, '微信图片_20210606173122.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173122.jpg', 3, '2021-06-06 18:16:26', '2021-08-17 11:28:25', 1);
INSERT INTO `sku_image` VALUES (38, 11, 'src=http___tu1.whhost.net_u4t.jpg', 'http://39.99.159.121:9000/shequ/20210814/src=http___tu1.whhost.net_u4t.jpg', 1, '2021-08-14 21:26:30', '2021-08-17 11:03:53', 1);
INSERT INTO `sku_image` VALUES (39, 12, 'src=http___tu1.whhost.net_u4t.jpg', 'http://39.99.159.121:9000/shequ/20210814/src=http___tu1.whhost.net_u4t.jpg', 1, '2021-08-14 21:28:16', '2021-08-17 11:03:36', 1);
INSERT INTO `sku_image` VALUES (40, 12, '5.jpg', 'http://39.99.159.121:9000/shequ/20210814/5.jpg', 2, '2021-08-14 21:28:16', '2021-08-17 11:03:36', 1);
INSERT INTO `sku_image` VALUES (47, 13, '4.jpg', 'http://39.99.159.121:9000/shequ/20210814/4.jpg', 1, '2021-08-14 21:51:50', '2021-08-17 11:02:50', 1);
INSERT INTO `sku_image` VALUES (52, 12, '5.jpg', 'http://47.93.148.192:9000/gmall/20210817/5.jpg', 1, '2021-08-17 11:03:36', '2021-08-17 11:28:59', 1);
INSERT INTO `sku_image` VALUES (53, 11, 'src=http___tu1.whhost.net_u4t.jpg', 'http://47.93.148.192:9000/gmall/20210817/src=http___tu1.whhost.net_u4t.jpg', 1, '2021-08-17 11:03:54', '2021-08-17 11:03:54', 0);
INSERT INTO `sku_image` VALUES (54, 1, '微信图片_2021081711240720.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240720.jpg', 1, '2021-08-17 11:25:47', '2021-09-18 09:40:23', 1);
INSERT INTO `sku_image` VALUES (55, 1, '微信图片_2021081711240721.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240721.jpg', 2, '2021-08-17 11:25:47', '2021-09-18 09:40:23', 1);
INSERT INTO `sku_image` VALUES (56, 2, '微信图片_2021081711240719.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240719.jpg', 1, '2021-08-17 11:26:23', '2021-08-17 11:26:23', 0);
INSERT INTO `sku_image` VALUES (57, 2, '微信图片_2021081711240718.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240718.jpg', 2, '2021-08-17 11:26:23', '2021-08-17 11:26:23', 0);
INSERT INTO `sku_image` VALUES (58, 3, '微信图片_2021081711240717.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240717.jpg', 1, '2021-08-17 11:26:43', '2021-08-17 11:26:43', 0);
INSERT INTO `sku_image` VALUES (59, 3, '微信图片_2021081711240716.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240716.jpg', 2, '2021-08-17 11:26:43', '2021-08-17 11:26:43', 0);
INSERT INTO `sku_image` VALUES (60, 3, '微信图片_2021081711240715.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240715.jpg', 3, '2021-08-17 11:26:43', '2021-08-17 11:26:43', 0);
INSERT INTO `sku_image` VALUES (61, 4, '微信图片_2021081711240712.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240712.jpg', 1, '2021-08-17 11:27:12', '2021-09-18 09:35:51', 1);
INSERT INTO `sku_image` VALUES (62, 4, '微信图片_2021081711240714.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240714.jpg', 2, '2021-08-17 11:27:12', '2021-09-18 09:35:51', 1);
INSERT INTO `sku_image` VALUES (63, 4, '微信图片_2021081711240713.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240713.jpg', 3, '2021-08-17 11:27:12', '2021-09-18 09:35:51', 1);
INSERT INTO `sku_image` VALUES (64, 5, '微信图片_2021081711240710.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240710.jpg', 1, '2021-08-17 11:27:29', '2021-09-28 06:08:58', 1);
INSERT INTO `sku_image` VALUES (65, 5, '微信图片_2021081711240711.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240711.jpg', 2, '2021-08-17 11:27:29', '2021-09-28 06:08:58', 1);
INSERT INTO `sku_image` VALUES (66, 6, '微信图片_202108171124079.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124079.jpg', 1, '2021-08-17 11:27:49', '2021-08-17 11:27:49', 0);
INSERT INTO `sku_image` VALUES (67, 6, '微信图片_202108171124078.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124078.jpg', 2, '2021-08-17 11:27:49', '2021-08-17 11:27:49', 0);
INSERT INTO `sku_image` VALUES (68, 7, '微信图片_202108171124074.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124074.jpg', 1, '2021-08-17 11:28:10', '2021-09-27 10:38:31', 1);
INSERT INTO `sku_image` VALUES (69, 7, '微信图片_202108171124076.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124076.jpg', 2, '2021-08-17 11:28:10', '2021-09-27 10:38:31', 1);
INSERT INTO `sku_image` VALUES (70, 7, '微信图片_202108171124075.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124075.jpg', 3, '2021-08-17 11:28:10', '2021-09-27 10:38:31', 1);
INSERT INTO `sku_image` VALUES (71, 8, '微信图片_202108171124077.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124077.jpg', 1, '2021-08-17 11:28:25', '2021-08-17 11:28:25', 0);
INSERT INTO `sku_image` VALUES (72, 8, '微信图片_202108171124073.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124073.jpg', 2, '2021-08-17 11:28:25', '2021-08-17 11:28:25', 0);
INSERT INTO `sku_image` VALUES (73, 9, '微信图片_202108171124072.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124072.jpg', 1, '2021-08-17 11:28:42', '2021-08-17 11:28:42', 0);
INSERT INTO `sku_image` VALUES (74, 9, '微信图片_202108171124071.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124071.jpg', 2, '2021-08-17 11:28:42', '2021-08-17 11:28:42', 0);
INSERT INTO `sku_image` VALUES (75, 9, '微信图片_20210817112407.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_20210817112407.jpg', 3, '2021-08-17 11:28:42', '2021-08-17 11:28:42', 0);
INSERT INTO `sku_image` VALUES (76, 12, '123.jpg', 'http://47.93.148.192:9000/gmall/20210817/123.jpg', 1, '2021-08-17 11:28:59', '2021-08-17 11:28:59', 0);
INSERT INTO `sku_image` VALUES (77, 10, '236.jpg', 'http://47.93.148.192:9000/gmall/20210918/236.jpg', 1, '2021-09-18 09:28:28', '2021-09-18 09:28:28', 0);
INSERT INTO `sku_image` VALUES (78, 10, '235.jpg', 'http://47.93.148.192:9000/gmall/20210918/235.jpg', 2, '2021-09-18 09:28:28', '2021-09-18 09:28:28', 0);
INSERT INTO `sku_image` VALUES (79, 4, '微信图片_2021081711240712.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240712.jpg', 1, '2021-08-17 11:27:12', '2021-08-17 11:27:12', 0);
INSERT INTO `sku_image` VALUES (80, 4, '微信图片_2021081711240714.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240714.jpg', 2, '2021-08-17 11:27:12', '2021-08-17 11:27:12', 0);
INSERT INTO `sku_image` VALUES (81, 4, '微信图片_2021081711240713.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240713.jpg', 3, '2021-08-17 11:27:12', '2021-08-17 11:27:12', 0);
INSERT INTO `sku_image` VALUES (82, 1, '微信图片_2021081711240720.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240720.jpg', 1, '2021-08-17 11:25:47', '2021-09-18 09:41:28', 1);
INSERT INTO `sku_image` VALUES (83, 1, '微信图片_2021081711240721.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240721.jpg', 2, '2021-08-17 11:25:47', '2021-09-18 09:41:28', 1);
INSERT INTO `sku_image` VALUES (84, 1, '微信图片_2021081711240720.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240720.jpg', 1, '2021-08-17 11:25:47', '2021-09-18 09:55:42', 1);
INSERT INTO `sku_image` VALUES (85, 1, '微信图片_2021081711240721.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240721.jpg', 2, '2021-08-17 11:25:47', '2021-09-18 09:55:42', 1);
INSERT INTO `sku_image` VALUES (86, 1, '微信图片_2021081711240720.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240720.jpg', 1, '2021-08-17 11:25:47', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_image` VALUES (87, 1, '微信图片_2021081711240721.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240721.jpg', 2, '2021-08-17 11:25:47', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_image` VALUES (88, 1, '微信图片_202108171124072.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_202108171124072.jpg', 3, '2021-09-18 09:55:42', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_image` VALUES (89, 1, '微信图片_202108171124073.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_202108171124073.jpg', 4, '2021-09-18 09:55:42', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_image` VALUES (90, 1, '微信图片_2021081711240720.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240720.jpg', 1, '2021-08-17 11:25:47', '2021-09-18 09:56:11', 1);
INSERT INTO `sku_image` VALUES (91, 1, '微信图片_2021081711240721.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240721.jpg', 2, '2021-08-17 11:25:47', '2021-09-18 09:56:11', 1);
INSERT INTO `sku_image` VALUES (92, 1, '微信图片_2021081711240720.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240720.jpg', 1, '2021-08-17 11:25:47', '2021-08-17 11:25:47', 0);
INSERT INTO `sku_image` VALUES (93, 1, '微信图片_2021081711240721.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240721.jpg', 2, '2021-08-17 11:25:47', '2021-08-17 11:25:47', 0);
INSERT INTO `sku_image` VALUES (94, 7, '微信图片_202108171124074.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124074.jpg', 1, '2021-08-17 11:28:10', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_image` VALUES (95, 7, '微信图片_202108171124076.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124076.jpg', 2, '2021-08-17 11:28:10', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_image` VALUES (96, 7, '微信图片_202108171124075.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124075.jpg', 3, '2021-08-17 11:28:10', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_image` VALUES (97, 7, '微信图片_202108171124074.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124074.jpg', 1, '2021-08-17 11:28:10', '2021-08-17 11:28:10', 0);
INSERT INTO `sku_image` VALUES (98, 7, '微信图片_202108171124076.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124076.jpg', 2, '2021-08-17 11:28:10', '2021-08-17 11:28:10', 0);
INSERT INTO `sku_image` VALUES (99, 7, '微信图片_202108171124075.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124075.jpg', 3, '2021-08-17 11:28:10', '2021-08-17 11:28:10', 0);
INSERT INTO `sku_image` VALUES (100, 5, '微信图片_2021081711240710.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240710.jpg', 1, '2021-08-17 11:27:29', '2021-08-17 11:27:29', 0);
INSERT INTO `sku_image` VALUES (101, 5, '微信图片_2021081711240711.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240711.jpg', 2, '2021-08-17 11:27:29', '2021-08-17 11:27:29', 0);
INSERT INTO `sku_image` VALUES (102, 14, '01.jpg', 'http://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/2023/10/06/30d4bb2451294a23afc601e8ec21c4fa01.jpg', NULL, '2023-10-06 21:52:44', '2023-10-06 22:57:01', 1);
INSERT INTO `sku_image` VALUES (103, 14, '01.jpg', 'http://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/2023/10/06/30d4bb2451294a23afc601e8ec21c4fa01.jpg', NULL, '2023-10-06 21:52:44', '2023-10-06 22:59:10', 1);
INSERT INTO `sku_image` VALUES (104, 14, '01.jpg', 'http://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/2023/10/06/30d4bb2451294a23afc601e8ec21c4fa01.jpg', NULL, '2023-10-06 21:52:44', '2023-10-06 21:52:44', 0);
INSERT INTO `sku_image` VALUES (105, 15, '大舅与他的阿鸭们.jpg', 'http://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/2023/10/10/a65bc7c229fa4ed6a5c16a84b5863147%E5%A4%A7%E8%88%85%E4%B8%8E%E4%BB%96%E7%9A%84%E9%98%BF%E9%B8%AD%E4%BB%AC.jpg', NULL, '2023-10-10 01:25:02', '2023-10-10 01:25:02', 0);

-- ----------------------------
-- Table structure for sku_info
-- ----------------------------
DROP TABLE IF EXISTS `sku_info`;
CREATE TABLE `sku_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_id` bigint NOT NULL DEFAULT 0 COMMENT '分类id',
  `attr_group_id` bigint NOT NULL DEFAULT 0 COMMENT '平台属性分组id',
  `sku_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '商品类型：0->普通商品 1->秒杀商品',
  `sku_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'sku名称',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '展示图片',
  `per_limit` int NOT NULL DEFAULT 1 COMMENT '限购个数/每天（0：不限购）',
  `publish_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '上架状态：0->下架；1->上架',
  `check_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '审核状态：0->未审核；1->审核通过',
  `is_new_person` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否新人专享：0->否；1->是',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序',
  `sku_code` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '价格',
  `market_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '市场价',
  `stock` int NOT NULL DEFAULT 0 COMMENT '库存',
  `lock_stock` int NOT NULL DEFAULT 0 COMMENT '锁定库存',
  `low_stock` int NOT NULL DEFAULT 0 COMMENT '预警库存',
  `sale` int NOT NULL DEFAULT 0 COMMENT '销量',
  `ware_id` bigint NOT NULL DEFAULT 0 COMMENT '仓库',
  `version` bigint NOT NULL DEFAULT 0,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'sku信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sku_info
-- ----------------------------
INSERT INTO `sku_info` VALUES (1, 1, 1, 0, '西红柿', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E8%A5%BF%E7%BA%A2%E6%9F%BF.png', 5, 1, 1, 0, 1, '0001', 2.20, 2.90, 100, 0, 10, 0, 1, 2, '2021-06-06 17:53:03', '2023-10-16 11:59:14', 0);
INSERT INTO `sku_info` VALUES (2, 1, 1, 0, '红薯', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E7%BA%A2%E8%96%AF.jpg', 5, 1, 1, 0, 2, '0002', 1.79, 2.50, 100, 2, 10, 0, 1, 2, '2021-06-06 18:04:27', '2023-10-16 12:07:28', 0);
INSERT INTO `sku_info` VALUES (3, 1, 1, 0, '四季豆', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%9B%9B%E5%AD%A3%E8%B1%86.png', 5, 1, 1, 0, 3, '0003', 3.50, 4.10, 100, 1, 10, 0, 1, 1, '2021-06-06 18:05:57', '2023-10-16 16:19:01', 0);
INSERT INTO `sku_info` VALUES (4, 1, 1, 0, '大蒜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%A4%A7%E8%92%9C.jpg', 5, 1, 1, 1, 4, '0004', 5.50, 7.80, 100, 0, 10, 0, 1, 2, '2021-06-06 18:09:42', '2023-10-16 11:59:20', 0);
INSERT INTO `sku_info` VALUES (5, 1, 1, 0, '土豆', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%9C%9F%E8%B1%86.jpg', 5, 1, 1, 1, 5, '0005', 5.30, 5.90, 100, 10, 10, 0, 1, 1, '2021-06-06 18:10:56', '2023-10-16 16:08:23', 0);
INSERT INTO `sku_info` VALUES (6, 1, 1, 0, '丝瓜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E4%B8%9D%E7%93%9C.jpg', 5, 1, 1, 1, 6, '0006', 3.60, 4.50, 100, 4, 10, 0, 1, 1, '2021-06-06 18:13:46', '2023-10-16 16:05:15', 0);
INSERT INTO `sku_info` VALUES (7, 1, 1, 1, '辣椒', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E8%BE%A3%E6%A4%92.jpg', 5, 1, 1, 0, 7, '0007', 3.20, 3.80, 100, 0, 10, 0, 1, 1, '2021-06-06 18:15:18', '2023-10-13 10:53:43', 0);
INSERT INTO `sku_info` VALUES (8, 1, 1, 1, '茄子', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E8%8C%84%E5%AD%90.jpg', 5, 1, 1, 0, 8, '0008', 3.50, 4.40, 100, 0, 10, 0, 1, 1, '2021-06-06 18:16:26', '2023-10-13 10:53:30', 0);
INSERT INTO `sku_info` VALUES (9, 1, 1, 1, '玉米', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E7%8E%89%E7%B1%B3.jpg', 5, 1, 1, 0, 9, '0009', 1.90, 3.00, 100, 0, 10, 0, 1, 1, '2021-06-06 18:17:47', '2023-10-13 10:53:12', 0);
INSERT INTO `sku_info` VALUES (10, 1, 1, 0, '南瓜', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%8D%97%E7%93%9C.jpg', 5, 1, 1, 1, 10, '555667', 5.00, 4.00, 100, 7, 10, 0, 1, 0, '2021-08-14 21:02:56', '2023-10-16 15:59:38', 0);
INSERT INTO `sku_info` VALUES (11, 2, 1, 0, '苹果', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E8%8B%B9%E6%9E%9C.jpg', 5, 1, 1, 0, 11, '0011', 5.00, 7.00, 100, 0, 10, 0, 1, 0, '2021-08-14 21:26:30', '2023-10-16 11:59:27', 0);
INSERT INTO `sku_info` VALUES (12, 2, 1, 0, '橘子', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E6%A9%98%E5%AD%90.jpg', 5, 1, 1, 0, 12, '0012', 7.00, 8.00, 100, 1, 10, 0, 1, 0, '2021-08-14 21:28:16', '2023-10-16 15:54:21', 0);
INSERT INTO `sku_info` VALUES (13, 1, 1, 0, '蔬菜拼盘', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E8%94%AC%E8%8F%9C%E6%8B%BC%E7%9B%98.jpg', 5, 1, 1, 0, 13, '0013', 50.00, 70.00, 100, 1, 10, 0, 1, 0, '2021-08-14 21:51:50', '2023-10-16 15:52:30', 0);
INSERT INTO `sku_info` VALUES (14, 13, 5, 0, '斗兽棋', 'http://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/2023/10/06/30d4bb2451294a23afc601e8ec21c4fa01.jpg', 3, 1, 1, 1, 0, '10003', 30.00, 40.00, 30, 0, 4, 0, 1, 0, '2023-10-06 21:52:44', '2023-10-13 17:00:05', 0);
INSERT INTO `sku_info` VALUES (15, 13, 5, 0, 'Tank火车', 'http://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/2023/10/10/a65bc7c229fa4ed6a5c16a84b5863147%E5%A4%A7%E8%88%85%E4%B8%8E%E4%BB%96%E7%9A%84%E9%98%BF%E9%B8%AD%E4%BB%AC.jpg', 10, 1, 1, 1, 0, '200', 50.00, 60.00, 50, 0, 10, 0, 1, 0, '2023-10-10 01:25:02', '2023-10-13 17:00:07', 0);

-- ----------------------------
-- Table structure for sku_poster
-- ----------------------------
DROP TABLE IF EXISTS `sku_poster`;
CREATE TABLE `sku_poster`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `img_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `img_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 150 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品海报表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sku_poster
-- ----------------------------
INSERT INTO `sku_poster` VALUES (4, 1, '%E8%A5%BF%E7%BA%A2%E6%9F%BF.png', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E8%A5%BF%E7%BA%A2%E6%9F%BF.png', '2021-09-18 09:40:01', '2023-10-14 00:48:01', 0);
INSERT INTO `sku_poster` VALUES (5, 1, '%E8%A5%BF%E7%BA%A2%E6%9F%BF.png', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E8%A5%BF%E7%BA%A2%E6%9F%BF.png', '2021-09-18 09:40:01', '2023-10-14 00:48:04', 0);
INSERT INTO `sku_poster` VALUES (6, 2, '微信图片_20210606173019.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173019.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (7, 2, '微信图片_20210606173015.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173015.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (8, 3, '微信图片_20210606173037.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173037.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (9, 3, '微信图片_20210606173034.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173034.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (10, 3, '微信图片_20210606173030.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173030.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (11, 4, '微信图片_20210606173049.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173049.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (12, 4, '微信图片_20210606173045.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173045.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (13, 4, '微信图片_20210606173041.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173041.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (14, 5, '%E5%9C%9F%E8%B1%86.jpg', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%9C%9F%E8%B1%86.jpg', '2021-09-18 09:40:01', '2023-10-14 00:40:27', 0);
INSERT INTO `sku_poster` VALUES (15, 5, '%E5%9C%9F%E8%B1%86.jpg', 'https://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/productPic/%E5%9C%9F%E8%B1%86.jpg', '2021-09-18 09:40:01', '2023-10-14 00:40:32', 0);
INSERT INTO `sku_poster` VALUES (16, 5, '微信图片_20210606173052.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173052.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (17, 6, '微信图片_20210606173109.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173109.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (18, 6, '微信图片_20210606173105.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173105.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (19, 6, '微信图片_20210606173102.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173102.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (20, 7, '微信图片_20210606173118.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173118.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (21, 7, '微信图片_20210606173115.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173115.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (22, 7, '微信图片_20210606173112.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173112.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (23, 8, '微信图片_20210606173127.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173127.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (24, 8, '微信图片_20210606173131.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173131.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (25, 8, '微信图片_20210606173122.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173122.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (26, 9, '微信图片_20210606173139.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173139.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (27, 9, '微信图片_20210606173135.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173135.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (28, 8, '微信图片_20210606173127.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173127.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (29, 8, '微信图片_20210606173131.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173131.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (30, 8, '微信图片_20210606173122.jpg', 'http://39.99.159.121:9000/gmall/20210606/微信图片_20210606173122.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (31, 11, 'src=http___tu1.whhost.net_u4t.jpg', 'http://39.99.159.121:9000/shequ/20210814/src=http___tu1.whhost.net_u4t.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (32, 12, 'src=http___tu1.whhost.net_u4t.jpg', 'http://39.99.159.121:9000/shequ/20210814/src=http___tu1.whhost.net_u4t.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (33, 12, '5.jpg', 'http://39.99.159.121:9000/shequ/20210814/5.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (34, 13, '4.jpg', 'http://39.99.159.121:9000/shequ/20210814/4.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (35, 12, '5.jpg', 'http://47.93.148.192:9000/gmall/20210817/5.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (36, 11, 'src=http___tu1.whhost.net_u4t.jpg', 'http://47.93.148.192:9000/gmall/20210817/src=http___tu1.whhost.net_u4t.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (39, 2, '微信图片_2021081711240719.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240719.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (40, 2, '微信图片_2021081711240718.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240718.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (41, 3, '微信图片_2021081711240717.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240717.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (42, 3, '微信图片_2021081711240716.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240716.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (43, 3, '微信图片_2021081711240715.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240715.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (44, 4, '微信图片_2021081711240712.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240712.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (45, 4, '微信图片_2021081711240714.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240714.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (46, 4, '微信图片_2021081711240713.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240713.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 1);
INSERT INTO `sku_poster` VALUES (47, 5, '微信图片_2021081711240710.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240710.jpg', '2021-09-18 09:40:01', '2021-09-28 06:08:58', 1);
INSERT INTO `sku_poster` VALUES (48, 5, '微信图片_2021081711240711.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240711.jpg', '2021-09-18 09:40:01', '2021-09-28 06:08:58', 1);
INSERT INTO `sku_poster` VALUES (49, 6, '微信图片_202108171124079.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124079.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (50, 6, '微信图片_202108171124078.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124078.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (51, 7, '微信图片_202108171124074.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124074.jpg', '2021-09-18 09:40:01', '2021-09-27 10:38:31', 1);
INSERT INTO `sku_poster` VALUES (52, 7, '微信图片_202108171124076.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124076.jpg', '2021-09-18 09:40:01', '2021-09-27 10:38:31', 1);
INSERT INTO `sku_poster` VALUES (53, 7, '微信图片_202108171124075.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124075.jpg', '2021-09-18 09:40:01', '2021-09-27 10:38:31', 1);
INSERT INTO `sku_poster` VALUES (54, 8, '微信图片_202108171124077.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124077.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (55, 8, '微信图片_202108171124073.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124073.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (56, 9, '微信图片_202108171124072.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124072.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (57, 9, '微信图片_202108171124071.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124071.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (58, 9, '微信图片_20210817112407.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_20210817112407.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (59, 12, '123.jpg', 'http://47.93.148.192:9000/gmall/20210817/123.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (60, 10, '236.jpg', 'http://47.93.148.192:9000/gmall/20210918/236.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (61, 10, '235.jpg', 'http://47.93.148.192:9000/gmall/20210918/235.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (62, 4, '微信图片_2021081711240712.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240712.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (63, 4, '微信图片_2021081711240714.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240714.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (64, 4, '微信图片_2021081711240713.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_2021081711240713.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (129, 1, '微信图片_2021081711240720.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_2021081711240720.jpg', '2021-09-18 09:41:28', '2021-09-18 09:55:42', 1);
INSERT INTO `sku_poster` VALUES (130, 1, '微信图片_2021081711240721.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_2021081711240721.jpg', '2021-09-18 09:41:28', '2021-09-18 09:55:42', 1);
INSERT INTO `sku_poster` VALUES (131, 1, '微信图片_2021081711240720.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_2021081711240720.jpg', '2021-09-18 09:41:28', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_poster` VALUES (132, 1, '微信图片_2021081711240721.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_2021081711240721.jpg', '2021-09-18 09:41:28', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_poster` VALUES (133, 1, '微信图片_202108171124078.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_202108171124078.jpg', '2021-09-18 09:55:42', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_poster` VALUES (134, 1, '微信图片_202108171124074.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_202108171124074.jpg', '2021-09-18 09:55:42', '2021-09-18 09:56:00', 1);
INSERT INTO `sku_poster` VALUES (135, 1, '微信图片_2021081711240720.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_2021081711240720.jpg', '2021-09-18 09:41:28', '2021-09-18 09:56:11', 1);
INSERT INTO `sku_poster` VALUES (136, 1, '微信图片_2021081711240721.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_2021081711240721.jpg', '2021-09-18 09:41:28', '2021-09-18 09:56:11', 1);
INSERT INTO `sku_poster` VALUES (137, 1, '微信图片_202108171124074.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_202108171124074.jpg', '2021-09-18 09:55:42', '2021-09-18 09:56:11', 1);
INSERT INTO `sku_poster` VALUES (138, 1, '微信图片_2021081711240720.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_2021081711240720.jpg', '2021-09-18 09:41:28', '2023-10-14 00:35:42', 1);
INSERT INTO `sku_poster` VALUES (139, 1, '微信图片_2021081711240721.jpg', 'http://47.93.148.192:9000/gmall/20210918/微信图片_2021081711240721.jpg', '2021-09-18 09:41:28', '2023-10-14 00:35:44', 1);
INSERT INTO `sku_poster` VALUES (140, 7, '微信图片_202108171124074.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124074.jpg', '2021-09-18 09:40:01', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_poster` VALUES (141, 7, '微信图片_202108171124076.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124076.jpg', '2021-09-18 09:40:01', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_poster` VALUES (142, 7, '微信图片_202108171124075.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124075.jpg', '2021-09-18 09:40:01', '2021-09-27 10:42:35', 1);
INSERT INTO `sku_poster` VALUES (143, 7, '微信图片_202108171124074.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124074.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (144, 7, '微信图片_202108171124076.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124076.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (145, 7, '微信图片_202108171124075.jpg', 'http://47.93.148.192:9000/gmall/20210817/微信图片_202108171124075.jpg', '2021-09-18 09:40:01', '2021-09-18 09:40:01', 0);
INSERT INTO `sku_poster` VALUES (148, 14, 'my.png', 'http://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/2023/10/06/8674af9a2b5b414a89ac041a2cb78cefmy.png', '2023-10-06 21:52:44', '2023-10-06 22:59:10', 1);
INSERT INTO `sku_poster` VALUES (149, 14, 'my.png', 'http://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/2023/10/06/8674af9a2b5b414a89ac041a2cb78cefmy.png', '2023-10-06 21:52:44', '2023-10-06 22:57:32', 0);
INSERT INTO `sku_poster` VALUES (150, 15, '大舅与他的阿鸭们.jpg', 'http://ryu-goodchoose.oss-cn-beijing.aliyuncs.com/2023/10/10/6edfab439bac4222a016483f34dea459%E5%A4%A7%E8%88%85%E4%B8%8E%E4%BB%96%E7%9A%84%E9%98%BF%E9%B8%AD%E4%BB%AC.jpg', '2023-10-10 01:25:02', '2023-10-10 01:25:02', 0);

-- ----------------------------
-- Table structure for sku_stock_history
-- ----------------------------
DROP TABLE IF EXISTS `sku_stock_history`;
CREATE TABLE `sku_stock_history`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sku_id` bigint NOT NULL DEFAULT 0,
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '销售价格',
  `stock` int NOT NULL DEFAULT 0 COMMENT '库存',
  `sale` int NOT NULL DEFAULT 0 COMMENT '销量',
  `sale_date` date NULL DEFAULT NULL COMMENT '销售日期',
  `ware_id` bigint NOT NULL DEFAULT 0 COMMENT '仓库',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 1 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'sku的库存历史记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sku_stock_history
-- ----------------------------

-- ----------------------------
-- Table structure for ware
-- ----------------------------
DROP TABLE IF EXISTS `ware`;
CREATE TABLE `ware`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `province` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省code',
  `city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市code',
  `district` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域code',
  `detail_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `longitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '经度',
  `latitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '纬度',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '仓库表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ware
-- ----------------------------
INSERT INTO `ware` VALUES (1, '成都仓库', NULL, NULL, NULL, NULL, NULL, NULL, '2021-06-15 08:07:17', '2021-06-15 08:07:17', 0);

SET FOREIGN_KEY_CHECKS = 1;
