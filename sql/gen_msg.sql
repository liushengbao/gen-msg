/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50626
Source Host           : 127.0.0.1:3306
Source Database       : gen_msg

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2018-04-19 11:40:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for msg_cat
-- ----------------------------
DROP TABLE IF EXISTS `msg_cat`;
CREATE TABLE `msg_cat` (
  `msg_cat_id` int(20) NOT NULL,
  `msg_cat` varchar(255) DEFAULT NULL,
  `msg_cat_type` int(20) DEFAULT NULL,
  PRIMARY KEY (`msg_cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for msg_info
-- ----------------------------
DROP TABLE IF EXISTS `msg_info`;
CREATE TABLE `msg_info` (
  `msg_id` int(10) NOT NULL,
  `msg_cat` int(20) DEFAULT NULL,
  `msg_desc` text,
  `req_id` int(10) NOT NULL,
  `req_body` text,
  `rsp_id` int(10) DEFAULT NULL,
  `rsp_body` text,
  `msg_note` text,
  PRIMARY KEY (`msg_id`),
  UNIQUE KEY `req_id_key` (`req_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
