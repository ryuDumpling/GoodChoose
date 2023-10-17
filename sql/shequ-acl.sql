/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : shequ-acl

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 18/10/2023 01:15:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '会员id',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '密码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机',
  `ware_id` bigint NOT NULL DEFAULT 0 COMMENT '仓库id（默认为：0为平台用户）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uname`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'dbe236c0fce6dc0a6bed67606cc87f86', 'admin', NULL, 0, '2021-05-31 18:08:43', '2022-01-17 16:36:41', 0);
INSERT INTO `admin` VALUES (2, 'pingtai', '96e79218965eb72c92a549dd5a330112', '张华', NULL, 0, '2021-06-01 08:46:22', '2022-01-18 14:54:00', 0);
INSERT INTO `admin` VALUES (3, 'chengdu', '96e79218965eb72c92a549dd5a330112', '李二清', NULL, 1, '2021-06-18 17:18:29', '2022-01-18 14:54:31', 0);
INSERT INTO `admin` VALUES (4, 'shangguigu', 'dbe236c0fce6dc0a6bed67606cc87f86', '张晓霞', NULL, 0, '2021-09-27 09:37:39', '2023-10-03 16:34:28', 0);
INSERT INTO `admin` VALUES (5, 'liziran', 'dbe236c0fce6dc0a6bed67606cc87f86', '李00', NULL, 0, '2022-01-18 14:54:59', '2023-10-03 15:15:01', 0);
INSERT INTO `admin` VALUES (6, 'huanghua', 'dbe236c0fce6dc0a6bed67606cc87f86', '黄华', NULL, 0, '2022-01-18 14:55:17', '2023-10-03 15:33:06', 1);
INSERT INTO `admin` VALUES (7, 'licui', 'dbe236c0fce6dc0a6bed67606cc87f86', '李翠', NULL, 0, '2022-01-18 14:55:35', '2023-10-03 15:33:06', 1);
INSERT INTO `admin` VALUES (8, 'guoqing', 'dbe236c0fce6dc0a6bed67606cc87f86', '郭庆', NULL, 0, '2022-01-18 14:55:58', '2023-10-03 15:31:59', 1);
INSERT INTO `admin` VALUES (9, 'test', '96e79218965eb72c92a549dd5a330112', '测试哦', NULL, 0, '2023-10-03 15:26:36', '2023-10-03 15:31:59', 1);

-- ----------------------------
-- Table structure for admin_login_log
-- ----------------------------
DROP TABLE IF EXISTS `admin_login_log`;
CREATE TABLE `admin_login_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admin_id` bigint NULL DEFAULT NULL,
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_agent` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器登录类型',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户登录日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_id` bigint NOT NULL DEFAULT 0 COMMENT '角色id',
  `admin_id` bigint NOT NULL DEFAULT 0 COMMENT '用户id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`admin_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role
-- ----------------------------
INSERT INTO `admin_role` VALUES (1, 1, 1, '2021-05-31 18:09:02', '2021-05-31 18:09:02', 0);
INSERT INTO `admin_role` VALUES (12, 3, 2, '2023-10-03 16:33:31', '2023-10-03 16:33:43', 1);
INSERT INTO `admin_role` VALUES (13, 2, 2, '2023-10-03 16:33:31', '2023-10-03 16:33:43', 1);
INSERT INTO `admin_role` VALUES (14, 2, 2, '2023-10-03 16:33:43', '2023-10-03 16:33:43', 0);
INSERT INTO `admin_role` VALUES (15, 3, 2, '2023-10-03 16:33:43', '2023-10-03 16:33:43', 0);
INSERT INTO `admin_role` VALUES (16, 4, 2, '2023-10-03 16:33:43', '2023-10-03 16:33:43', 0);
INSERT INTO `admin_role` VALUES (17, 2, 3, '2023-10-03 16:34:05', '2023-10-03 16:34:05', 0);
INSERT INTO `admin_role` VALUES (18, 3, 3, '2023-10-03 16:34:05', '2023-10-03 16:34:05', 0);
INSERT INTO `admin_role` VALUES (19, 4, 3, '2023-10-03 16:34:05', '2023-10-03 16:34:05', 0);
INSERT INTO `admin_role` VALUES (20, 8, 4, '2023-10-03 16:34:34', '2023-10-03 16:34:34', 0);
INSERT INTO `admin_role` VALUES (21, 7, 4, '2023-10-03 16:34:34', '2023-10-03 16:34:34', 0);
INSERT INTO `admin_role` VALUES (22, 5, 4, '2023-10-03 16:34:34', '2023-10-03 16:34:34', 0);
INSERT INTO `admin_role` VALUES (23, 6, 5, '2023-10-03 16:34:42', '2023-10-03 16:34:42', 0);
INSERT INTO `admin_role` VALUES (24, 4, 5, '2023-10-03 16:34:42', '2023-10-03 16:34:42', 0);
INSERT INTO `admin_role` VALUES (25, 5, 5, '2023-10-03 16:34:42', '2023-10-03 16:34:42', 0);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `pid` bigint NOT NULL DEFAULT 0 COMMENT '所属上级',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称code',
  `to_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转页面code',
  `type` tinyint NOT NULL DEFAULT 0 COMMENT '类型(1:菜单,2:按钮)',
  `status` tinyint NULL DEFAULT NULL COMMENT '状态(0:禁止,1:正常)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_pid`(`pid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 0, '全部数据', NULL, NULL, 1, NULL, '2021-05-31 18:05:37', '2021-09-27 13:37:59', 0);
INSERT INTO `permission` VALUES (2, 1, '权限管理', 'Acl', NULL, 1, NULL, '2021-05-31 18:05:37', '2021-05-31 19:36:53', 0);
INSERT INTO `permission` VALUES (3, 2, '用户管理', 'User', NULL, 1, NULL, '2021-05-31 18:05:37', '2021-05-31 19:36:58', 0);
INSERT INTO `permission` VALUES (4, 2, '角色管理', 'Role', NULL, 1, NULL, '2021-05-31 18:05:37', '2021-05-31 19:37:02', 0);
INSERT INTO `permission` VALUES (5, 2, '菜单管理', 'Permission', NULL, 1, NULL, '2021-05-31 18:05:37', '2021-05-31 19:37:05', 0);
INSERT INTO `permission` VALUES (6, 3, '分配角色', 'btn.User.assgin', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:35:35', 0);
INSERT INTO `permission` VALUES (7, 3, '添加', 'btn.User.add', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:34:29', 0);
INSERT INTO `permission` VALUES (8, 3, '修改', 'btn.User.update', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:34:45', 0);
INSERT INTO `permission` VALUES (9, 3, '删除', 'btn.User.remove', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:34:38', 0);
INSERT INTO `permission` VALUES (10, 4, '修改', 'btn.Role.update', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:36:20', 0);
INSERT INTO `permission` VALUES (11, 4, '分配权限', 'btn.Role.assgin', 'RoleAuth', 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:36:56', 0);
INSERT INTO `permission` VALUES (12, 4, '添加', 'btn.Role.add', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:36:08', 0);
INSERT INTO `permission` VALUES (13, 4, '删除', 'btn.Role.remove', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:36:32', 0);
INSERT INTO `permission` VALUES (14, 4, '角色权限', 'role.acl', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:37:22', 1);
INSERT INTO `permission` VALUES (15, 5, '查看', 'btn.permission.list', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-05-31 19:32:52', 0);
INSERT INTO `permission` VALUES (16, 5, '添加', 'btn.Permission.add', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:37:39', 0);
INSERT INTO `permission` VALUES (17, 5, '修改', 'btn.Permission.update', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:37:47', 0);
INSERT INTO `permission` VALUES (18, 5, '删除', 'btn.Permission.remove', NULL, 2, NULL, '2021-05-31 18:05:37', '2021-06-01 08:37:54', 0);
INSERT INTO `permission` VALUES (19, 1, '订单管理', 'Order', NULL, 1, NULL, '2021-06-18 16:38:51', '2021-06-18 16:48:22', 0);
INSERT INTO `permission` VALUES (20, 19, '订单列表', 'OrderInfo', '', 1, NULL, '2021-06-18 16:39:21', '2021-06-18 16:42:36', 0);
INSERT INTO `permission` VALUES (21, 19, '发货列表', 'DetailList', NULL, 1, NULL, '2021-06-18 16:40:07', '2021-06-18 16:40:16', 0);
INSERT INTO `permission` VALUES (22, 19, '订单详情', 'btn.OrderInfo.show', 'OrderInfoShow', 2, NULL, '2021-06-18 16:42:30', '2021-06-18 16:43:03', 0);
INSERT INTO `permission` VALUES (23, 1, '商品管理', 'Product', NULL, 1, NULL, '2021-06-18 16:45:55', '2021-06-18 16:48:27', 0);
INSERT INTO `permission` VALUES (24, 23, '商品分类', 'Category', NULL, 1, NULL, '2021-06-18 16:46:44', '2021-06-18 16:46:55', 0);
INSERT INTO `permission` VALUES (25, 24, '添加分类', 'btn.Category.add', 'CategoryAdd', 2, NULL, '2021-06-18 16:48:01', '2021-06-18 16:48:57', 0);
INSERT INTO `permission` VALUES (26, 24, '修改分类', 'btn.Category.edit', 'CategoryEdit', 2, NULL, '2021-06-18 16:50:11', '2021-06-18 16:50:11', 0);
INSERT INTO `permission` VALUES (27, 23, '平台属性分组', 'AttrGroup', '', 1, NULL, '2021-06-18 16:52:12', '2021-06-18 16:52:12', 0);
INSERT INTO `permission` VALUES (28, 27, '添加', 'btn.AttrGroup.add', 'AttrGroupAdd', 2, NULL, '2021-06-18 16:53:04', '2021-06-18 16:54:05', 0);
INSERT INTO `permission` VALUES (29, 27, '修改', 'btn.AttrGroup.edit', 'AttrGroupEdit', 2, NULL, '2021-06-18 16:53:22', '2021-06-18 16:54:04', 0);
INSERT INTO `permission` VALUES (30, 27, '平台属性列表', 'btn.AttrGroup.list', 'AttrList', 2, NULL, '2021-06-18 16:54:34', '2021-06-18 16:54:57', 0);
INSERT INTO `permission` VALUES (31, 27, '属性添加', NULL, 'AttrAdd', 2, NULL, '2021-06-18 16:56:42', '2021-06-18 16:57:09', 0);
INSERT INTO `permission` VALUES (32, 27, '属性修改', NULL, 'AttrEdit', 2, NULL, '2021-06-18 16:56:57', '2021-06-18 16:57:10', 0);
INSERT INTO `permission` VALUES (33, 23, 'SKU列表', 'SkuInfo', NULL, 1, NULL, '2021-06-18 16:59:13', '2021-06-18 16:59:13', 0);
INSERT INTO `permission` VALUES (34, 33, '添加', NULL, 'SkuInfoAdd', 2, NULL, '2021-06-18 16:59:30', '2021-06-18 17:01:14', 0);
INSERT INTO `permission` VALUES (35, 33, '修改', NULL, 'SkuInfoEdit', 2, NULL, '2021-06-18 16:59:43', '2021-06-18 17:01:14', 0);
INSERT INTO `permission` VALUES (36, 1, '营销活动管理', 'Activity', NULL, 1, NULL, '2021-06-18 17:04:15', '2021-06-18 17:04:15', 0);
INSERT INTO `permission` VALUES (37, 36, '活动列表', 'ActivityInfo', NULL, 1, NULL, '2021-06-18 17:05:13', '2021-06-18 17:06:22', 0);
INSERT INTO `permission` VALUES (38, 37, '添加', '', 'ActivityInfoAdd', 2, NULL, '2021-06-18 17:05:41', '2021-06-18 17:06:13', 0);
INSERT INTO `permission` VALUES (39, 37, '修改', NULL, 'ActivityInfoEdit', 2, NULL, '2021-06-18 17:05:54', '2021-06-18 17:06:20', 0);
INSERT INTO `permission` VALUES (40, 36, '优惠券列表', 'CouponInfo', NULL, 1, NULL, '2021-06-18 17:06:41', '2021-06-18 17:07:18', 0);
INSERT INTO `permission` VALUES (41, 40, '添加', NULL, 'CouponInfoAdd', 2, NULL, '2021-06-18 17:06:57', '2021-06-18 17:07:22', 0);
INSERT INTO `permission` VALUES (42, 40, '修改', NULL, 'CouponInfoEdit', 2, NULL, '2021-06-18 17:07:11', '2021-06-18 17:07:25', 0);
INSERT INTO `permission` VALUES (43, 40, '规则', NULL, 'CouponInfoRule', 2, NULL, '2021-06-18 17:07:49', '2021-06-18 17:07:49', 0);
INSERT INTO `permission` VALUES (44, 37, '规则', NULL, 'ActivityInfoRule', 2, NULL, '2021-06-18 17:08:09', '2021-06-18 17:08:12', 0);
INSERT INTO `permission` VALUES (45, 36, '秒杀活动列表', 'Seckill', NULL, 1, NULL, '2021-06-18 17:08:44', '2021-06-18 17:08:44', 0);
INSERT INTO `permission` VALUES (46, 45, '秒杀时间段', NULL, 'SeckillTime', 2, NULL, '2021-06-18 17:09:23', '2021-06-18 17:15:15', 0);
INSERT INTO `permission` VALUES (47, 45, '秒杀时间段选择', NULL, 'SelectSeckillTime', 2, NULL, '2021-06-18 17:09:28', '2021-06-18 17:10:03', 0);
INSERT INTO `permission` VALUES (48, 45, '秒杀商品列表', NULL, 'SeckillSku', 2, NULL, '2021-06-18 17:09:43', '2021-06-18 17:10:00', 0);
INSERT INTO `permission` VALUES (49, 1, '团长管理', 'Leader', NULL, 1, NULL, '2021-06-18 17:15:44', '2021-06-18 17:17:24', 0);
INSERT INTO `permission` VALUES (50, 49, '团长待审核', 'LeaderCheck', '', 1, NULL, '2021-06-18 17:16:02', '2021-06-18 17:17:25', 0);
INSERT INTO `permission` VALUES (51, 49, '团长已审核', 'leader', NULL, 1, NULL, '2021-06-18 17:16:17', '2021-06-18 17:17:30', 0);
INSERT INTO `permission` VALUES (52, 1, '系统管理', 'Sys', NULL, 1, NULL, '2021-06-22 13:44:36', '2023-10-03 18:24:34', 0);
INSERT INTO `permission` VALUES (53, 52, '开通区域', 'RegionWare', NULL, 1, NULL, '2021-06-22 13:45:06', '2023-10-03 18:24:38', 0);
INSERT INTO `permission` VALUES (54, 3, '查看', 'btn.User.list', NULL, 2, NULL, '2021-09-27 09:42:24', '2021-09-27 09:42:24', 0);
INSERT INTO `permission` VALUES (55, 4, '查看', ' btn.Role.list', '', 2, NULL, '2021-09-27 09:43:49', '2021-09-27 09:43:49', 0);
INSERT INTO `permission` VALUES (100, 1, '全部', 'btn.all', NULL, 2, NULL, '2021-09-27 13:35:24', '2022-01-18 17:47:37', 1);
INSERT INTO `permission` VALUES (101, 0, '测试二层组', NULL, NULL, 2, 1, '2023-10-03 18:22:35', '2023-10-03 18:22:42', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `role_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色编码',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '系统管理员', 'SYSTEM', NULL, '2021-05-31 18:09:18', '2021-05-31 18:09:18', 0);
INSERT INTO `role` VALUES (2, '平台管理员', NULL, NULL, '2021-06-01 08:38:40', '2021-06-18 17:13:17', 0);
INSERT INTO `role` VALUES (3, '区域仓库管理员', NULL, NULL, '2021-06-18 17:12:21', '2021-06-18 17:12:21', 0);
INSERT INTO `role` VALUES (4, '产品管理员', NULL, NULL, '2021-09-27 09:37:13', '2022-01-18 14:57:30', 0);
INSERT INTO `role` VALUES (5, '区域运营', NULL, NULL, '2022-01-18 14:57:40', '2022-01-18 14:57:40', 0);
INSERT INTO `role` VALUES (6, '产品录入人员', NULL, NULL, '2022-01-18 14:58:02', '2022-01-18 14:58:02', 0);
INSERT INTO `role` VALUES (7, '产品审核人员', NULL, NULL, '2022-01-18 14:58:12', '2022-01-18 14:58:12', 0);
INSERT INTO `role` VALUES (8, '团长管理员', NULL, NULL, '2022-01-18 14:58:30', '2022-01-18 14:58:30', 0);

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL DEFAULT 0,
  `permission_id` bigint NOT NULL DEFAULT 0,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE,
  INDEX `idx_permission_id`(`permission_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 317 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (1, 1, 1, '2021-05-31 18:09:40', '2021-05-31 18:09:40', 0);
INSERT INTO `role_permission` VALUES (2, 1, 2, '2021-05-31 18:09:44', '2021-05-31 18:09:44', 0);
INSERT INTO `role_permission` VALUES (3, 1, 3, '2021-05-31 18:09:51', '2021-05-31 18:09:51', 0);
INSERT INTO `role_permission` VALUES (4, 1, 4, '2021-05-31 18:09:55', '2021-05-31 18:09:55', 0);
INSERT INTO `role_permission` VALUES (5, 1, 5, '2021-05-31 18:09:59', '2021-05-31 18:09:59', 0);
INSERT INTO `role_permission` VALUES (6, 1, 6, '2021-05-31 18:10:04', '2021-05-31 18:10:04', 0);
INSERT INTO `role_permission` VALUES (7, 1, 7, '2021-05-31 18:10:11', '2021-05-31 18:10:11', 0);
INSERT INTO `role_permission` VALUES (8, 1, 8, '2021-05-31 18:10:16', '2021-05-31 18:10:16', 0);
INSERT INTO `role_permission` VALUES (9, 1, 9, '2021-05-31 18:10:20', '2021-05-31 18:10:20', 0);
INSERT INTO `role_permission` VALUES (10, 1, 10, '2021-05-31 18:10:26', '2021-05-31 18:10:26', 0);
INSERT INTO `role_permission` VALUES (11, 1, 11, '2021-05-31 18:10:30', '2021-05-31 18:10:30', 0);
INSERT INTO `role_permission` VALUES (297, 2, 3, '2023-10-03 20:22:07', '2023-10-03 20:22:48', 1);
INSERT INTO `role_permission` VALUES (298, 2, 6, '2023-10-03 20:22:07', '2023-10-03 20:22:48', 1);
INSERT INTO `role_permission` VALUES (299, 2, 7, '2023-10-03 20:22:07', '2023-10-03 20:22:48', 1);
INSERT INTO `role_permission` VALUES (300, 2, 8, '2023-10-03 20:22:07', '2023-10-03 20:22:48', 1);
INSERT INTO `role_permission` VALUES (301, 2, 9, '2023-10-03 20:22:07', '2023-10-03 20:22:48', 1);
INSERT INTO `role_permission` VALUES (302, 2, 54, '2023-10-03 20:22:07', '2023-10-03 20:22:48', 1);
INSERT INTO `role_permission` VALUES (303, 2, 6, '2023-10-03 20:22:48', '2023-10-03 20:22:48', 0);
INSERT INTO `role_permission` VALUES (304, 2, 7, '2023-10-03 20:22:48', '2023-10-03 20:22:48', 0);
INSERT INTO `role_permission` VALUES (305, 2, 8, '2023-10-03 20:22:48', '2023-10-03 20:22:48', 0);
INSERT INTO `role_permission` VALUES (306, 3, 5, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (307, 3, 15, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (308, 3, 16, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (309, 3, 17, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (310, 3, 18, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (311, 3, 33, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (312, 3, 34, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (313, 3, 35, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (314, 3, 40, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (315, 3, 41, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (316, 3, 42, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);
INSERT INTO `role_permission` VALUES (317, 3, 43, '2023-10-03 20:32:28', '2023-10-03 20:32:28', 0);

SET FOREIGN_KEY_CHECKS = 1;
