/*
 Navicat Premium Data Transfer

 Source Server         : 陈林
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : easy_restaurant

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 27/09/2022 14:49:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dine_in_order
-- ----------------------------
DROP TABLE IF EXISTS `dine_in_order`;
CREATE TABLE `dine_in_order`  (
  `oid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `finish_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dishes` json NULL,
  `state` int NULL DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `score` decimal(10, 2) NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`oid`) USING BTREE,
  INDEX `search_rid`(`rid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dine_in_order
-- ----------------------------
INSERT INTO `dine_in_order` VALUES ('O10001', 'R10001', 'T100001', '2022-08-30', '2022-08-30', '[{\"did\": \"D10001\", \"num\": 3}, {\"did\": \"D10002\", \"num\": 2}, {\"did\": \"D10003\", \"num\": 2}]', 2, NULL, 4.50, 904.00);
INSERT INTO `dine_in_order` VALUES ('O10002', 'R10001', 'T100001', '2022-08-30', '2022-08-30', '[{\"did\": \"D10002\", \"num\": 2}]', 2, NULL, 4.60, 10.20);
INSERT INTO `dine_in_order` VALUES ('O10003', 'R10001', 'T100001', '2022-08-30', '2022-08-30', '[{\"did\": \"D10003\", \"num\": 2}]', 2, NULL, 4.70, 10.20);
INSERT INTO `dine_in_order` VALUES ('O10004', 'R10001', 'T100003', '2022-08-30', '2022-08-30', '[{\"did\": \"D10001\", \"num\": 2}, {\"did\": \"D10004\", \"num\": 2}]', 1, NULL, 4.80, 442.00);
INSERT INTO `dine_in_order` VALUES ('O10005', 'R10001', 'T100003', '2022-08-30', '2022-08-30', '[{\"did\": \"D10005\", \"num\": 1}]', 1, NULL, 1.00, 20.00);
INSERT INTO `dine_in_order` VALUES ('O10006', 'R10001', 'T100001', '2022-09-05', '2022-09-05', '[{\"did\": \"D10001\", \"num\": 1}, {\"did\": \"D10002\", \"num\": 1}]', 2, NULL, NULL, 261.00);
INSERT INTO `dine_in_order` VALUES ('O10007', 'R10001', 'T100005', '2022-09-06', '2022-09-06', '[{\"did\": \"D10001\", \"num\": 2}, {\"did\": \"D10002\", \"num\": 1}]', 2, NULL, NULL, 383.00);
INSERT INTO `dine_in_order` VALUES ('O10008', 'R10001', 'T100004', '2022-09-06', NULL, '[{\"did\": \"D10001\", \"num\": 1}, {\"did\": \"D10003\", \"num\": 4}]', 1, NULL, NULL, 642.00);
INSERT INTO `dine_in_order` VALUES ('O10009', 'R10001', 'T100001', '2022-09-06', '2022-09-06', '[{\"did\": \"D10001\", \"num\": 1}]', 2, NULL, NULL, 122.00);
INSERT INTO `dine_in_order` VALUES ('O10010', 'R10001', 'T100002', '2022-09-26', NULL, '[{\"did\": \"D10001\", \"num\": 1}, {\"did\": \"D10004\", \"num\": 1}]', 1, NULL, NULL, 221.00);

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish`  (
  `did` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `taste` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `materials` json NULL,
  `format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `valid` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`did`) USING BTREE,
  INDEX `search_rid`(`rid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES ('D10001', '青花椒蒸鲈鱼', 122.00, '鲜嫩美味', '好吃', '[{\"mid\": \"M100001\", \"total\": 1.0}, {\"mid\": \"M100011\", \"total\": 1.0}]', 'jpg', 'R10001', 1);
INSERT INTO `dish` VALUES ('D10002', '白卤虾丸', 139.00, '滑嫩美味', '好吃', '[{\"mid\": \"M100002\", \"total\": 5.0}, {\"mid\": \"M100012\", \"total\": 1.0}]', 'jpg', 'R10001', 1);
INSERT INTO `dish` VALUES ('D10003', '黑椒牛肉粒', 130.00, '肉质滑嫩', '好吃', '[{\"mid\": \"M100003\", \"total\": 1.0}]', 'jpg', 'R10001', 1);
INSERT INTO `dish` VALUES ('D10004', '吮指虾尾', 99.00, '麻辣', '好吃', '[{\"mid\": \"M100004\", \"total\": 1.0}]', 'jpg', 'R10001', 1);
INSERT INTO `dish` VALUES ('D10005', '虫草干贝鸡汤', 200.00, '营养健康', '好吃', '[{\"mid\": \"M100005\", \"total\": 1.0}]', 'jpg', 'R10001', 1);
INSERT INTO `dish` VALUES ('D10006', '滑炒肉丝', 100.00, '肉质滑嫩', '好吃', '[{\"mid\": \"M100006\", \"total\": 5.0}, {\"mid\": \"M100001\", \"total\": 1.0}]', 'jpg', 'R10001', 1);
INSERT INTO `dish` VALUES ('D10007', 'qwe', 123.00, '123', 'asdasd', '[{\"mid\": \"M100001\", \"total\": 1.0}]', 'jpg', 'R10001', 0);
INSERT INTO `dish` VALUES ('D10008', 'asd', 123.00, '权威', '123.0', '[{\"mid\": \"M100001\", \"total\": 1.0}]', 'jpg', 'R10001', 1);
INSERT INTO `dish` VALUES ('D10009', 'asd', 123.00, '阿松大', '123.0', '[{\"mid\": \"M100002\", \"total\": 1.0}]', 'jpg', 'R10001', 1);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `eid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` tinyint(1) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `home` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `buyer` tinyint(1) NULL DEFAULT NULL,
  `server` tinyint(1) NULL DEFAULT NULL,
  `manager` tinyint(1) NULL DEFAULT NULL,
  `salary` decimal(10, 2) NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `entry_time` date NULL DEFAULT NULL,
  `valid` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`eid`) USING BTREE,
  INDEX `search_rid`(`rid`) USING BTREE,
  CONSTRAINT `rid_` FOREIGN KEY (`rid`) REFERENCES `restaurant` (`rid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('13114391081', 0, '管理员', '无', 'R10002', 1, 0, 1, 0.00, '2A938E4A2BC83080E73C9145E57C47F2', '2022-07-02', 1);
INSERT INTO `employee` VALUES ('13114391084', 1, '王子涵', '山东大学软件园', 'R10001', 1, 0, 0, 1000.00, '2A938E4A2BC83080E73C9145E57C47F2', '2022-08-02', 1);
INSERT INTO `employee` VALUES ('13114391085', 0, '王森', '山东大学软件园', 'R10001', 0, 1, 0, 1000.00, '2A938E4A2BC83080E73C9145E57C47F2', '2022-08-02', 1);
INSERT INTO `employee` VALUES ('13114391086', 1, '付晨光', '东华大学', 'R10001', 1, 0, 0, 1000.00, '2A938E4A2BC83080E73C9145E57C47F2', '2022-08-02', 1);
INSERT INTO `employee` VALUES ('13114391087', 1, '陈林(管理员)', '山东大学软件园', 'R10001', 1, 1, 1, 4000.00, '2A938E4A2BC83080E73C9145E57C47F2', '2022-08-02', 1);
INSERT INTO `employee` VALUES ('15039370169', 0, '管理员', '无', 'R10003', 1, 1, 1, 0.00, '2A938E4A2BC83080E73C9145E57C47F2', '2022-09-05', 1);

-- ----------------------------
-- Table structure for have
-- ----------------------------
DROP TABLE IF EXISTS `have`;
CREATE TABLE `have`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `oid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `did` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `num` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of have
-- ----------------------------
INSERT INTO `have` VALUES (1, 'O100001', 'D10005', 2);
INSERT INTO `have` VALUES (2, 'O100001', 'D10005', 2);
INSERT INTO `have` VALUES (3, 'O100002', 'D10002', 1);
INSERT INTO `have` VALUES (4, 'O100003', 'D10003', 2);
INSERT INTO `have` VALUES (5, 'O100003', 'D10004', 1);
INSERT INTO `have` VALUES (6, 'O100004', 'D10004', 1);
INSERT INTO `have` VALUES (7, 'O100004', 'D10002', 2);
INSERT INTO `have` VALUES (11, 'O10002', 'D10002', 2);
INSERT INTO `have` VALUES (12, 'O10003', 'D10003', 2);
INSERT INTO `have` VALUES (14, 'O10005', 'D10005', 1);
INSERT INTO `have` VALUES (15, 'O10006', 'D10001', 1);
INSERT INTO `have` VALUES (16, 'O10006', 'D10002', 1);
INSERT INTO `have` VALUES (33, 'O10001', 'D10001', 3);
INSERT INTO `have` VALUES (34, 'O10001', 'D10002', 2);
INSERT INTO `have` VALUES (35, 'O10001', 'D10003', 2);
INSERT INTO `have` VALUES (47, 'O10004', 'D10001', 2);
INSERT INTO `have` VALUES (48, 'O10004', 'D10004', 2);
INSERT INTO `have` VALUES (49, 'O10007', 'D10001', 2);
INSERT INTO `have` VALUES (50, 'O10007', 'D10002', 1);
INSERT INTO `have` VALUES (54, 'O10008', 'D10001', 1);
INSERT INTO `have` VALUES (55, 'O10008', 'D10003', 4);
INSERT INTO `have` VALUES (58, 'O10009', 'D10001', 1);
INSERT INTO `have` VALUES (59, 'O10010', 'D10001', 1);
INSERT INTO `have` VALUES (60, 'O10010', 'D10004', 1);

-- ----------------------------
-- Table structure for make
-- ----------------------------
DROP TABLE IF EXISTS `make`;
CREATE TABLE `make`  (
  `did` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `num` double NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `search_dish_material`(`did`) USING BTREE COMMENT '此表经常需要对did聚集操作',
  INDEX `natural_join`(`mid`) USING BTREE COMMENT 'dish表需要和其进行自然连接'
) ENGINE = InnoDB AUTO_INCREMENT = 154 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of make
-- ----------------------------
INSERT INTO `make` VALUES ('D10001', 'M100001', 1, 17);
INSERT INTO `make` VALUES ('D10002', 'M100002', 5, 18);
INSERT INTO `make` VALUES ('D10003', 'M100003', 1, 19);
INSERT INTO `make` VALUES ('D10004', 'M100004', 1, 20);
INSERT INTO `make` VALUES ('D10005', 'M100005', 1, 21);
INSERT INTO `make` VALUES ('D10006', 'M100006', 5, 22);
INSERT INTO `make` VALUES ('D10006', 'M100001', 1, 23);
INSERT INTO `make` VALUES ('D10023', 'M100001', 1, 73);
INSERT INTO `make` VALUES ('D10024', 'M100001', 1, 75);
INSERT INTO `make` VALUES ('D10025', 'M100001', 1, 76);
INSERT INTO `make` VALUES ('D10026', 'M100001', 1, 78);
INSERT INTO `make` VALUES ('D10016', 'M100002', 1, 108);
INSERT INTO `make` VALUES ('D10017', 'M100001', 1, 109);
INSERT INTO `make` VALUES ('D10018', 'M100001', 1, 111);
INSERT INTO `make` VALUES ('D10019', 'M100001', 1, 112);
INSERT INTO `make` VALUES ('D10020', 'M100001', 1, 114);
INSERT INTO `make` VALUES ('D10021', 'M100001', 1, 115);
INSERT INTO `make` VALUES ('D10022', 'M100001', 1, 116);
INSERT INTO `make` VALUES ('D10010', 'M100001', 1, 141);
INSERT INTO `make` VALUES ('D10011', 'M100002', 1, 142);
INSERT INTO `make` VALUES ('D10012', 'M100001', 1, 144);
INSERT INTO `make` VALUES ('D10013', 'M100001', 1, 145);
INSERT INTO `make` VALUES ('D10014', 'M100001', 1, 146);
INSERT INTO `make` VALUES ('D10015', 'M100002', 1, 147);
INSERT INTO `make` VALUES ('D10007', 'M100001', 1, 151);
INSERT INTO `make` VALUES ('D10008', 'M100001', 1, 152);
INSERT INTO `make` VALUES ('D10009', 'M100002', 1, 153);

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material`  (
  `mid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `measure` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total` decimal(10, 0) NULL DEFAULT NULL,
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `valid` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`mid`) USING BTREE,
  INDEX `search_rid`(`rid`) USING BTREE,
  CONSTRAINT `rid` FOREIGN KEY (`rid`) REFERENCES `restaurant` (`rid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES ('M100001', '鲈鱼', 312.00, '条', 11, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100002', '虾丸', 5.00, '个', 50, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100003', '牛肉', 50.00, '斤', 10, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100004', '虾尾', 50.00, '斤', 10, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100005', '鸡', 35.00, '只', 10, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100006', '猪肉', 20.00, '斤', 10, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100007', '青椒', 2.00, '个', 10, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100008', '黑椒', 2.00, '个', 10, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100009', '虫草', 20.00, '个', 10, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100010', '盐', 2.00, '勺', 10, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100011', '醋', 0.50, '毫升', 10, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100012', '酱油', 1.00, '毫升', 10, 'R10001', NULL, 'jpg', 1);
INSERT INTO `material` VALUES ('M100014', '123', 132.00, '123', 10, 'R10001', NULL, 'jpg', 0);

-- ----------------------------
-- Table structure for restaurant
-- ----------------------------
DROP TABLE IF EXISTS `restaurant`;
CREATE TABLE `restaurant`  (
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `administrator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `utility_bill` double NULL DEFAULT NULL,
  `rent` double NULL DEFAULT NULL,
  `other` double NULL DEFAULT NULL,
  PRIMARY KEY (`rid`, `name`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of restaurant
-- ----------------------------
INSERT INTO `restaurant` VALUES ('R10001', '软件园食堂', '13114391087', '山东大学软件园校区', 10, 20, 30);
INSERT INTO `restaurant` VALUES ('R10002', '超意兴', '13114391081', '舜泰广场', 0, 0, 0);
INSERT INTO `restaurant` VALUES ('R10003', '中心食堂', '15039370169', '山东大学中心校区', 0, 0, 0);

-- ----------------------------
-- Table structure for table_
-- ----------------------------
DROP TABLE IF EXISTS `table_`;
CREATE TABLE `table_`  (
  `tid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `state` int NULL DEFAULT NULL,
  `num` int NULL DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `valid` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`tid`) USING BTREE,
  INDEX `search_rid`(`rid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of table_
-- ----------------------------
INSERT INTO `table_` VALUES ('T100001', 'R10001', 1, 4, '第一排左一', 1);
INSERT INTO `table_` VALUES ('T100002', 'R10001', 1, 6, '第一排左二', 1);
INSERT INTO `table_` VALUES ('T100003', 'R10001', 1, 8, '第一排左三', 1);
INSERT INTO `table_` VALUES ('T100004', 'R10001', 1, 2, '第二排左一', 1);
INSERT INTO `table_` VALUES ('T100005', 'R10001', 1, 4, '第二排左二', 1);
INSERT INTO `table_` VALUES ('T100006', 'R10001', 1, 6, '第二排左三', 1);
INSERT INTO `table_` VALUES ('T100007', 'R10001', 1, 8, '第四排左一', 1);
INSERT INTO `table_` VALUES ('T100008', 'R10001', 1, 2, '第四排左二', 1);
INSERT INTO `table_` VALUES ('T100009', 'R10001', 2, 4, '第四排左三', 1);
INSERT INTO `table_` VALUES ('T100010', 'R10001', 2, 6, '第三排左一', 1);
INSERT INTO `table_` VALUES ('T100011', 'R10001', 2, 12, '第三排左二', 1);
INSERT INTO `table_` VALUES ('T100012', 'R10001', 2, 6, '第三排左三', 1);

-- ----------------------------
-- Table structure for take_out_order
-- ----------------------------
DROP TABLE IF EXISTS `take_out_order`;
CREATE TABLE `take_out_order`  (
  `oid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dishes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `finish_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `score` decimal(10, 0) NULL DEFAULT NULL,
  INDEX `search_rid`(`rid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of take_out_order
-- ----------------------------
INSERT INTO `take_out_order` VALUES ('O100001', '13114391087', 'R10001', '[{\"did\": \"D10001\", \"num\": 2}, {\"did\": \"D10005\", \"num\": 2}]', '0', '2022-08-28', '2022-08-28', '山东大学软件园', 10.00, '不要辣', 5);
INSERT INTO `take_out_order` VALUES ('O100002', '13114391087', 'R10001', '[{\"did\": \"D10002\", \"num\": 1}]', '3', '2022-08-28', '2022-08-28', '山东大学软件园', 10.00, '不要香菜', 4);
INSERT INTO `take_out_order` VALUES ('O100003', '13114391087', 'R10001', '[{\"did\": \"D10003\", \"num\": 2}, {\"did\": \"D10004\", \"num\": 1}]', '2', '2022-08-28', '2022-08-28', '山东大学软件园', 10.00, '要香菜', 5);
INSERT INTO `take_out_order` VALUES ('O100004', '13114391087', 'R10001', '[{\"did\": \"D10004\", \"num\": 1}, {\"did\": \"D10002\", \"num\": 2}]', '3', '2022-08-28', '2022-08-28', '山东大学软件园', 10.00, '越辣越好', 5);

-- ----------------------------
-- Table structure for verification
-- ----------------------------
DROP TABLE IF EXISTS `verification`;
CREATE TABLE `verification`  (
  `tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `code` int NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `type` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of verification
-- ----------------------------
INSERT INTO `verification` VALUES ('13114391087', 634066, '2022-08-24 17:52:30', 1);
INSERT INTO `verification` VALUES ('13114391087', 248080, '2022-08-24 12:01:44', 1);
INSERT INTO `verification` VALUES ('13114391087', 997034, '2022-08-24 12:01:59', 1);
INSERT INTO `verification` VALUES ('13114391087', 430761, '2022-08-30 18:54:47', 1);
INSERT INTO `verification` VALUES ('13114391081', 914264, '2022-08-31 08:21:00', 1);
INSERT INTO `verification` VALUES ('13114391087', 539297, '2022-08-31 08:22:24', 1);
INSERT INTO `verification` VALUES ('13114391087', 962135, '2022-08-31 08:50:13', 3);
INSERT INTO `verification` VALUES ('13114391087', 432990, '2022-09-04 09:23:08', 3);
INSERT INTO `verification` VALUES ('15039370169', 872728, '2022-09-05 18:37:42', 1);
INSERT INTO `verification` VALUES ('13114391087', 201027, '2022-09-05 18:55:48', 3);
INSERT INTO `verification` VALUES ('13114391087', 686708, '2022-09-06 00:15:58', 3);
INSERT INTO `verification` VALUES ('13114391087', 299072, '2022-09-06 00:28:24', 3);
INSERT INTO `verification` VALUES ('13114391087', 790712, '2022-09-06 00:28:25', 3);

-- ----------------------------
-- View structure for cost
-- ----------------------------
DROP VIEW IF EXISTS `cost`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `cost` AS select `temp1`.`rid` AS `rid`,ifnull(`temp2`.`total_cost`,0) AS `IFNULL(total_cost,0)`,ifnull(`temp1`.`utility_bill`,0) AS `IFNULL(utility_bill,0)`,ifnull(`temp1`.`rent`,0) AS `IFNULL(rent,0)`,ifnull(`temp1`.`other`,0) AS `IFNULL(other,0)`,ifnull(`temp2`.`total_sales`,0) AS `IFNULL(total_sales,0)`,ifnull(`temp3`.`total_salary`,0) AS `IFNULL(total_salary,0)`,ifnull((((((`temp2`.`total_sales` - `temp2`.`total_cost`) - `temp3`.`total_salary`) - `temp1`.`utility_bill`) - `temp1`.`rent`) - `temp1`.`other`),0) AS `total_profit` from (((select `restaurant`.`rid` AS `rid`,`restaurant`.`utility_bill` AS `utility_bill`,`restaurant`.`rent` AS `rent`,`restaurant`.`other` AS `other` from `restaurant`) `temp1` left join (select `dish_meta`.`rid` AS `rid`,sum((`dish_meta`.`sales` * `dish_meta`.`cost`)) AS `total_cost`,sum((`dish_meta`.`sales` * `dish_meta`.`price`)) AS `total_sales` from `dish_meta` group by `dish_meta`.`rid`) `temp2` on((`temp1`.`rid` = `temp2`.`rid`))) left join (select `employee_meta`.`rid` AS `rid`,sum((`employee_meta`.`time` * `employee_meta`.`salary`)) AS `total_salary` from `employee_meta` group by `employee_meta`.`rid`) `temp3` on((`temp1`.`rid` = `temp3`.`rid`)));

-- ----------------------------
-- View structure for dish_meta
-- ----------------------------
DROP VIEW IF EXISTS `dish_meta`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `dish_meta` AS select `temp1`.`did` AS `did`,`temp1`.`name` AS `name`,`temp1`.`price` AS `price`,`temp1`.`taste` AS `taste`,`temp1`.`comment` AS `comment`,`temp1`.`materials` AS `materials`,`temp1`.`format` AS `format`,`temp1`.`rid` AS `rid`,`temp1`.`valid` AS `valid`,`temp2`.`cost` AS `cost`,ifnull(`temp3`.`sales`,0) AS `sales`,`temp6`.`remain` AS `remain` from ((((select `dish`.`did` AS `did`,`dish`.`name` AS `name`,`dish`.`price` AS `price`,`dish`.`taste` AS `taste`,`dish`.`comment` AS `comment`,`dish`.`materials` AS `materials`,`dish`.`format` AS `format`,`dish`.`rid` AS `rid`,`dish`.`valid` AS `valid` from `dish`) `temp1` left join (select `make`.`did` AS `did`,sum((`make`.`num` * `material`.`price`)) AS `cost` from (`make` join `material` on((`make`.`mid` = `material`.`mid`))) group by `make`.`did`) `temp2` on((`temp1`.`did` = `temp2`.`did`))) left join (select `have`.`did` AS `did`,ifnull(sum(`have`.`num`),0) AS `sales` from `have` group by `have`.`did`) `temp3` on((`temp1`.`did` = `temp3`.`did`))) left join (select `temp4`.`did` AS `did`,floor(min((`temp5`.`remain` / `temp4`.`num`))) AS `remain` from ((select `make`.`did` AS `did`,`make`.`mid` AS `mid`,`make`.`num` AS `num` from `make`) `temp4` left join (select `material_meta`.`mid` AS `mid`,`material_meta`.`name` AS `name`,`material_meta`.`price` AS `price`,`material_meta`.`measure` AS `measure`,`material_meta`.`total` AS `total`,`material_meta`.`rid` AS `rid`,`material_meta`.`comment` AS `comment`,`material_meta`.`format` AS `format`,`material_meta`.`valid` AS `valid`,`material_meta`.`remain` AS `remain` from `material_meta`) `temp5` on((`temp4`.`mid` = `temp5`.`mid`))) group by `temp4`.`did`) `temp6` on((`temp1`.`did` = `temp6`.`did`)));

-- ----------------------------
-- View structure for dish_meta_temp
-- ----------------------------
DROP VIEW IF EXISTS `dish_meta_temp`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `dish_meta_temp` AS select `temp1`.`did` AS `did`,`temp1`.`name` AS `name`,`temp1`.`price` AS `price`,`temp1`.`taste` AS `taste`,`temp1`.`comment` AS `comment`,`temp1`.`materials` AS `materials`,`temp1`.`format` AS `format`,`temp1`.`rid` AS `rid`,`temp1`.`valid` AS `valid`,`temp2`.`cost` AS `cost`,ifnull(`temp3`.`sales`,0) AS `sales` from (((select `dish`.`did` AS `did`,`dish`.`name` AS `name`,`dish`.`price` AS `price`,`dish`.`taste` AS `taste`,`dish`.`comment` AS `comment`,`dish`.`materials` AS `materials`,`dish`.`format` AS `format`,`dish`.`rid` AS `rid`,`dish`.`valid` AS `valid` from `dish`) `temp1` left join (select `make`.`did` AS `did`,sum((`make`.`num` * `material`.`price`)) AS `cost` from (`make` join `material` on((`make`.`mid` = `material`.`mid`))) group by `make`.`did`) `temp2` on((`temp1`.`did` = `temp2`.`did`))) left join (select `have`.`did` AS `did`,ifnull(sum(`have`.`num`),0) AS `sales` from `have` group by `have`.`did`) `temp3` on((`temp1`.`did` = `temp3`.`did`)));

-- ----------------------------
-- View structure for employee_meta
-- ----------------------------
DROP VIEW IF EXISTS `employee_meta`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `employee_meta` AS select `temp1`.`eid` AS `eid`,`temp1`.`sex` AS `sex`,`temp1`.`name` AS `name`,`temp1`.`home` AS `home`,`temp1`.`rid` AS `rid`,`temp1`.`buyer` AS `buyer`,`temp1`.`server` AS `server`,`temp1`.`manager` AS `manager`,`temp1`.`salary` AS `salary`,`temp1`.`password` AS `password`,`temp1`.`entry_time` AS `entry_time`,`temp2`.`time` AS `time` from ((select `employee`.`eid` AS `eid`,`employee`.`sex` AS `sex`,`employee`.`name` AS `name`,`employee`.`home` AS `home`,`employee`.`rid` AS `rid`,`employee`.`buyer` AS `buyer`,`employee`.`server` AS `server`,`employee`.`manager` AS `manager`,`employee`.`salary` AS `salary`,`employee`.`password` AS `password`,`employee`.`entry_time` AS `entry_time` from `employee`) `temp1` left join (select `employee`.`eid` AS `eid`,timestampdiff(MONTH,`employee`.`entry_time`,date_format(now(),'%Y-%m-%d')) AS `time` from `employee`) `temp2` on((`temp1`.`eid` = `temp2`.`eid`)));

-- ----------------------------
-- View structure for exception
-- ----------------------------
DROP VIEW IF EXISTS `exception`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `exception` AS select `dish_meta`.`rid` AS `rid`,`dish_meta`.`did` AS `id`,1 AS `type` from `dish_meta` where (`dish_meta`.`cost` > `dish_meta`.`price`) union select `dish_meta`.`rid` AS `rid`,`dish_meta`.`did` AS `id`,2 AS `type` from `dish_meta` where (`dish_meta`.`sales` < (select avg(`dish_meta`.`sales`) from `dish_meta`)) union select `material_meta`.`rid` AS `rid`,`material_meta`.`mid` AS `id`,3 AS `type` from `material_meta` where ((`material_meta`.`total` - `material_meta`.`remain`) < 5) union select `employee_meta`.`rid` AS `rid`,`employee_meta`.`eid` AS `id`,4 AS `type` from `employee_meta` where (`employee_meta`.`salary` < (select avg(`employee_meta`.`salary`) from `employee_meta`));

-- ----------------------------
-- View structure for material_meta
-- ----------------------------
DROP VIEW IF EXISTS `material_meta`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `material_meta` AS select `material`.`mid` AS `mid`,`material`.`name` AS `name`,`material`.`price` AS `price`,`material`.`measure` AS `measure`,`material`.`total` AS `total`,`material`.`rid` AS `rid`,`material`.`comment` AS `comment`,`material`.`format` AS `format`,`material`.`valid` AS `valid`,`temp4`.`remain` AS `remain` from (`material` left join (select `temp1`.`mid` AS `mid`,ifnull((`temp1`.`total` - sum((`temp3`.`sales` * `temp2`.`num`))),`temp1`.`total`) AS `remain` from (((select `material`.`mid` AS `mid`,`material`.`total` AS `total` from `material`) `temp1` left join (select `make`.`mid` AS `mid`,`make`.`did` AS `did`,`make`.`num` AS `num` from `make`) `temp2` on((`temp1`.`mid` = `temp2`.`mid`))) left join (select `dish_meta_temp`.`did` AS `did`,`dish_meta_temp`.`sales` AS `sales` from `dish_meta_temp`) `temp3` on((`temp2`.`did` = `temp3`.`did`))) group by `temp1`.`mid`,`temp1`.`total`) `temp4` on((`material`.`mid` = `temp4`.`mid`)));

-- ----------------------------
-- View structure for restaurant_meta
-- ----------------------------
DROP VIEW IF EXISTS `restaurant_meta`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `restaurant_meta` AS select `temp1`.`rid` AS `rid`,`temp1`.`name` AS `name`,`temp1`.`location` AS `location`,`temp1`.`tel` AS `tel`,`temp2`.`count(did)` AS `count(did)`,`temp3`.`count(mid)` AS `count(mid)`,`temp4`.`total_order` AS `total_order`,`temp5`.`score` AS `score`,`temp6`.`total_num` AS `total_num`,`temp7`.`count(tid)` AS `count(tid)`,`temp8`.`count(eid)` AS `count(eid)` from ((((((((select `restaurant`.`rid` AS `rid`,`restaurant`.`name` AS `name`,`restaurant`.`location` AS `location`,`restaurant`.`administrator` AS `tel` from `restaurant`) `temp1` left join (select `dish`.`rid` AS `rid`,count(`dish`.`did`) AS `count(did)` from `dish` group by `dish`.`rid`) `temp2` on((`temp1`.`rid` = `temp2`.`rid`))) left join (select `material`.`rid` AS `rid`,count(`material`.`mid`) AS `count(mid)` from `material` group by `material`.`rid`) `temp3` on((`temp1`.`rid` = `temp3`.`rid`))) left join (select `temp`.`rid` AS `rid`,sum(`temp`.`num`) AS `total_order` from (select `take_out_order`.`rid` AS `rid`,count(`take_out_order`.`oid`) AS `num` from `take_out_order` group by `take_out_order`.`rid` union select `dine_in_order`.`rid` AS `rid`,count(`dine_in_order`.`oid`) AS `num` from `dine_in_order` group by `dine_in_order`.`rid`) `temp` group by `temp`.`rid`) `temp4` on((`temp1`.`rid` = `temp4`.`rid`))) left join (select `temp`.`rid` AS `rid`,sum(`temp`.`num`) AS `score` from (select `take_out_order`.`rid` AS `rid`,sum(`take_out_order`.`score`) AS `num` from `take_out_order` group by `take_out_order`.`rid` union select `dine_in_order`.`rid` AS `rid`,sum(`dine_in_order`.`score`) AS `num` from `dine_in_order` group by `dine_in_order`.`rid`) `temp` group by `temp`.`rid`) `temp5` on((`temp1`.`rid` = `temp5`.`rid`))) left join (select `temp`.`rid` AS `rid`,sum(`temp`.`num`) AS `total_num` from (select `take_out_order`.`rid` AS `rid`,count(`take_out_order`.`score`) AS `num` from `take_out_order` group by `take_out_order`.`rid` union select `dine_in_order`.`rid` AS `rid`,count(`dine_in_order`.`score`) AS `num` from `dine_in_order` group by `dine_in_order`.`rid`) `temp` group by `temp`.`rid`) `temp6` on((`temp1`.`rid` = `temp6`.`rid`))) left join (select `table_`.`rid` AS `rid`,count(`table_`.`tid`) AS `count(tid)` from `table_` group by `table_`.`rid`) `temp7` on((`temp1`.`rid` = `temp7`.`rid`))) left join (select `employee`.`rid` AS `rid`,count(`employee`.`eid`) AS `count(eid)` from `employee` group by `employee`.`rid`) `temp8` on((`temp1`.`rid` = `temp8`.`rid`)));

-- ----------------------------
-- View structure for table_meta
-- ----------------------------
DROP VIEW IF EXISTS `table_meta`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `table_meta` AS select `temp1`.`tid` AS `tid`,`temp1`.`rid` AS `rid`,`temp1`.`num` AS `num`,`temp1`.`location` AS `location`,`temp1`.`valid` AS `valid`,ifnull(`temp2`.`state`,2) AS `state` from ((select `table_`.`tid` AS `tid`,`table_`.`rid` AS `rid`,`table_`.`num` AS `num`,`table_`.`location` AS `location`,`table_`.`valid` AS `valid` from `table_`) `temp1` left join (select `dine_in_order`.`tid` AS `tid`,1 AS `state` from `dine_in_order` where (`dine_in_order`.`state` = 1) group by `dine_in_order`.`tid`) `temp2` on((`temp1`.`tid` = `temp2`.`tid`)));

SET FOREIGN_KEY_CHECKS = 1;
