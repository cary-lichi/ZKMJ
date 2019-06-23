/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : mj_game

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-06-02 14:34:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) DEFAULT '' COMMENT '活动名称',
  `detail` varchar(4096) DEFAULT '' COMMENT '活动详情',
  `icon` varchar(1024) DEFAULT '' COMMENT '活动图片地址',
  `url` varchar(1024) DEFAULT '' COMMENT '活动详情页面url',
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '记录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `passWord` varchar(255) NOT NULL,
  `admin` int(11) unsigned zerofill DEFAULT '00000000000' COMMENT '管理员权限',
  `token` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for broadcast
-- ----------------------------
DROP TABLE IF EXISTS `broadcast`;
CREATE TABLE `broadcast` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) DEFAULT '' COMMENT '活动名称',
  `detail` varchar(4096) DEFAULT '' COMMENT '活动详情',
  `icon` varchar(1024) DEFAULT '' COMMENT '活动图片地址',
  `url` varchar(1024) DEFAULT '' COMMENT '活动详情页面url',
  `time` varchar(64) DEFAULT '' COMMENT '记录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cztime
-- ----------------------------
DROP TABLE IF EXISTS `cztime`;
CREATE TABLE `cztime` (
  `time` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for delegate
-- ----------------------------
DROP TABLE IF EXISTS `delegate`;
CREATE TABLE `delegate` (
  `id` int(11) NOT NULL,
  `logintime` timestamp NULL DEFAULT NULL,
  `awards` int(11) DEFAULT '0',
  `shareaward` int(11) DEFAULT '0' COMMENT '分享奖励',
  `newaward` int(11) DEFAULT '0' COMMENT '新人奖励',
  `levelaward` int(11) DEFAULT '0' COMMENT '分级贡献奖励',
  `actaward` int(11) DEFAULT '0' COMMENT '活动奖励',
  `level` tinyint(4) DEFAULT '0' COMMENT ' 当前代理等级1，2，3',
  `slevel` tinyint(4) DEFAULT '0' COMMENT '初始等级',
  `parent` int(11) DEFAULT '0',
  `parentslevel` tinyint(4) DEFAULT '0' COMMENT '上级代理原始等级',
  `icode` varchar(32) DEFAULT '' COMMENT '邀请码，唯一',
  `children` varchar(4096) DEFAULT '' COMMENT '下级代理集合',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for friends
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `id` int(11) NOT NULL COMMENT '好友id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int(11) NOT NULL,
  `name` varchar(32) DEFAULT '' COMMENT '商品名称',
  `priceg` int(11) DEFAULT NULL COMMENT '商品游戏币价格',
  `pricem` int(11) DEFAULT NULL COMMENT '商品人民币价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mail
-- ----------------------------
DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '谁的邮件',
  `type` int(8) DEFAULT '0' COMMENT '邮件类型',
  `content` varchar(1024) DEFAULT '' COMMENT '邮件内容，根据情况设置',
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=411 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for operate
-- ----------------------------
DROP TABLE IF EXISTS `operate`;
CREATE TABLE `operate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `aid` int(11) NOT NULL COMMENT '管理员id',
  `operate` varchar(255) NOT NULL COMMENT '操作类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for recharge
-- ----------------------------
DROP TABLE IF EXISTS `recharge`;
CREATE TABLE `recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '充值时间',
  `money` int(11) DEFAULT '0' COMMENT '充值金额',
  `uid` int(11) DEFAULT '0',
  `good` varchar(64) DEFAULT '',
  `count` int(11) DEFAULT '0',
  `fromc` tinyint(4) unsigned zerofill DEFAULT '0000' COMMENT '充值来源 0 正常充值 1苹果充值 2后台充值 3代理充值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT NULL COMMENT '记录产生时间',
  `gameplay` varchar(64) DEFAULT '' COMMENT '本局玩法1：1，2，3',
  `gamers` varchar(512) DEFAULT '' COMMENT '玩家信息 1：score-win 积分需要加500，win1赢0负',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=469 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for suggest
-- ----------------------------
DROP TABLE IF EXISTS `suggest`;
CREATE TABLE `suggest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detail` varchar(256) DEFAULT '',
  `phone` varchar(32) DEFAULT '',
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '游戏账号',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '游戏密码',
  `account` varchar(32) DEFAULT '' COMMENT '代理账号',
  `dpassword` varchar(32) DEFAULT '' COMMENT '代理密码',
  `nick` varchar(32) DEFAULT '',
  `exp` int(32) DEFAULT '0',
  `gold` int(11) DEFAULT '0' COMMENT '游戏币',
  `money` int(11) DEFAULT '0' COMMENT '钻石',
  `headimg` varchar(512) DEFAULT '' COMMENT '头像所在路径',
  `phone` varchar(32) DEFAULT '' COMMENT '手机号码',
  `records` varchar(1024) DEFAULT '' COMMENT '玩家对局记录集合',
  `assets` varchar(1024) DEFAULT '' COMMENT '玩家个人资产集合（商品道具）',
  `room` varchar(64) DEFAULT '' COMMENT '房间id，uuid',
  `invitetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `vcode` varchar(32) DEFAULT '' COMMENT '验证码',
  `sfz` varchar(64) DEFAULT '' COMMENT '身份证',
  `realname` varchar(64) DEFAULT '' COMMENT '真实姓名',
  `luckytime` timestamp NULL DEFAULT NULL,
  `welfaretime` timestamp NULL DEFAULT NULL,
  `gender` tinyint(4) DEFAULT '0',
  `rankaward` varchar(16) DEFAULT '“0；0；0；0”' COMMENT '排行奖励领取记录，定时更新',
  `logintime` timestamp NULL DEFAULT NULL,
  `gamestate` tinyint(4) DEFAULT '0' COMMENT '玩家游戏状态0：正常 1:被封禁',
  `totalmoney` int(11) DEFAULT '0' COMMENT '充的总钻数',
  `totalrmb` int(11) DEFAULT '0' COMMENT '充的总钱数',
  `sharetime` timestamp NULL DEFAULT NULL COMMENT '分享奖励领取时间',
  `wincount` int(11) DEFAULT '0',
  `totalcount` int(11) DEFAULT '0',
  `mails` varchar(512) DEFAULT '' COMMENT '邮件集合',
  `actawards` varchar(512) DEFAULT '' COMMENT '活动奖励记录，刮刮乐，新人奖等是否领过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8;
