/*
Navicat MySQL Data Transfer

Source Server         : 阿里云数据库
Source Server Version : 50722
Source Host           : 120.78.74.194:3306
Source Database       : hyskjf

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-08-20 15:08:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for Admin
-- ----------------------------
DROP TABLE IF EXISTS `Admin`;
CREATE TABLE `Admin` (
  `AdminID` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `AdminName` varchar(20) DEFAULT NULL COMMENT '管理员姓名',
  `AdminAcc` varchar(20) DEFAULT NULL COMMENT '管理员账户',
  `AdminPwd` varchar(50) DEFAULT NULL COMMENT '管理员密码',
  PRIMARY KEY (`AdminID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员';

-- ----------------------------
-- Table structure for AdminLog
-- ----------------------------
DROP TABLE IF EXISTS `AdminLog`;
CREATE TABLE `AdminLog` (
  `adlogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志编号',
  `AdminID` int(11) NOT NULL COMMENT '管理员ID',
  `adlogFunction` varchar(50) DEFAULT NULL COMMENT '操作功能',
  `adlogInfo` text COMMENT '操作内容',
  `adlogTime` date DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`adlogID`),
  KEY `FK_Relationship_34` (`AdminID`),
  CONSTRAINT `FK_Relationship_34` FOREIGN KEY (`AdminID`) REFERENCES `Admin` (`AdminID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员日志';

-- ----------------------------
-- Table structure for Advertise
-- ----------------------------
DROP TABLE IF EXISTS `Advertise`;
CREATE TABLE `Advertise` (
  `adverID` int(11) NOT NULL AUTO_INCREMENT COMMENT '广告位ID',
  `merID` int(11) DEFAULT NULL COMMENT '商家编号',
  `adverImage` varchar(200) DEFAULT NULL COMMENT '广告图片',
  `adverDescript` text COMMENT '广告描述',
  `adverURL` varchar(150) DEFAULT NULL COMMENT '链接地址',
  `adverType` varchar(10) DEFAULT NULL COMMENT '广告类型',
  `adverCost` float DEFAULT NULL COMMENT '广告金额',
  `adverStart` date DEFAULT NULL COMMENT '起始日',
  `adverEnd` date DEFAULT NULL COMMENT '终止日',
  PRIMARY KEY (`adverID`),
  KEY `FK_Relationship_19` (`merID`),
  CONSTRAINT `FK_Relationship_19` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='广告';

-- ----------------------------
-- Table structure for Application
-- ----------------------------
DROP TABLE IF EXISTS `Application`;
CREATE TABLE `Application` (
  `acaID` int(11) NOT NULL AUTO_INCREMENT COMMENT '申请编号',
  `acaMerchant` int(11) DEFAULT NULL COMMENT '申请商家（上级）',
  `acaStat` varchar(30) DEFAULT NULL COMMENT '申请状态',
  `acaReallo` int(11) DEFAULT NULL COMMENT '分配人',
  `acaReaTime` date DEFAULT NULL COMMENT '分配时间',
  `acaaMerchant` int(11) DEFAULT NULL COMMENT '入盟商家（本体）',
  PRIMARY KEY (`acaID`),
  KEY `FK_Reference_28` (`acaaMerchant`),
  KEY `FK_Relationship_21` (`acaMerchant`),
  KEY `FK_Relationship_24` (`acaReallo`),
  CONSTRAINT `FK_Reference_28` FOREIGN KEY (`acaaMerchant`) REFERENCES `Merchant` (`merID`),
  CONSTRAINT `FK_Relationship_21` FOREIGN KEY (`acaMerchant`) REFERENCES `Merchant` (`merID`),
  CONSTRAINT `FK_Relationship_24` FOREIGN KEY (`acaReallo`) REFERENCES `Admin` (`AdminID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='入盟申请';

-- ----------------------------
-- Table structure for BalanceHistory
-- ----------------------------
DROP TABLE IF EXISTS `BalanceHistory`;
CREATE TABLE `BalanceHistory` (
  `vhID` int(11) NOT NULL AUTO_INCREMENT COMMENT '储值编号',
  `mcPKID` int(11) NOT NULL,
  `vhMoney` float DEFAULT NULL COMMENT '修改金额',
  `vhTime` date DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`vhID`),
  KEY `FK_Relationship_27` (`mcPKID`),
  CONSTRAINT `FK_Relationship_27` FOREIGN KEY (`mcPKID`) REFERENCES `MemberCard` (`mcPKID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='储值余额历史';

-- ----------------------------
-- Table structure for BrandLabel
-- ----------------------------
DROP TABLE IF EXISTS `BrandLabel`;
CREATE TABLE `BrandLabel` (
  `LabelID` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `LabelName` varchar(30) DEFAULT NULL COMMENT '标签名',
  `LabelType` varchar(30) DEFAULT NULL COMMENT '标签类型',
  PRIMARY KEY (`LabelID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='标签表，与产品表ProductInfo是多对多关系，两者的关系表是LabelHaveProduct';

-- ----------------------------
-- Table structure for Consume
-- ----------------------------
DROP TABLE IF EXISTS `Consume`;
CREATE TABLE `Consume` (
  `cumID` int(11) NOT NULL AUTO_INCREMENT COMMENT '消费编号',
  `mcPKID` int(11) NOT NULL,
  `cumMoney` float DEFAULT NULL COMMENT '操作金额',
  `cumWay` varchar(20) DEFAULT NULL COMMENT '支付方式(积分消费、储值消费、现金消费)',
  `cumCredit` float DEFAULT NULL COMMENT '获得积分',
  `macID` int(11) DEFAULT NULL COMMENT '接待人',
  `cumTime` datetime DEFAULT NULL COMMENT '消费时间',
  `pduID` int(11) DEFAULT NULL COMMENT '商品编号',
  `hasComment` tinyint(1) DEFAULT '0' COMMENT '是否进行点评',
  PRIMARY KEY (`cumID`),
  KEY `FK_Reference_42` (`macID`),
  KEY `FK_Relationship_32` (`mcPKID`),
  CONSTRAINT `FK_Reference_42` FOREIGN KEY (`macID`) REFERENCES `MerchantAccount` (`macID`),
  CONSTRAINT `FK_Relationship_32` FOREIGN KEY (`mcPKID`) REFERENCES `MemberCard` (`mcPKID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='消费历史';

-- ----------------------------
-- Table structure for CreditCash
-- ----------------------------
DROP TABLE IF EXISTS `CreditCash`;
CREATE TABLE `CreditCash` (
  `ccID` int(11) NOT NULL AUTO_INCREMENT COMMENT '提现编号',
  `mcPKID` int(11) DEFAULT NULL,
  `ccWays` varchar(20) DEFAULT NULL COMMENT '提现方式',
  `ccBankAccount` varchar(25) DEFAULT NULL COMMENT '银行卡号',
  `ccCredit` float DEFAULT NULL COMMENT '消耗积分',
  `ccMoney` float DEFAULT NULL COMMENT '对应金额',
  `ccTime0` datetime DEFAULT NULL COMMENT '提现时间',
  PRIMARY KEY (`ccID`),
  KEY `FK_Relationship_41` (`mcPKID`),
  CONSTRAINT `FK_Relationship_41` FOREIGN KEY (`mcPKID`) REFERENCES `MemberCard` (`mcPKID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分提现历史';

-- ----------------------------
-- Table structure for CreditConsume
-- ----------------------------
DROP TABLE IF EXISTS `CreditConsume`;
CREATE TABLE `CreditConsume` (
  `creconId` int(11) NOT NULL AUTO_INCREMENT COMMENT '积分消费历史编号',
  `memID` int(11) DEFAULT NULL COMMENT '会员号',
  `merID` int(11) DEFAULT NULL COMMENT '商家编号',
  `AdminID` int(11) DEFAULT NULL COMMENT '管理员ID',
  `credits` float DEFAULT NULL COMMENT '消费积分',
  `value` float DEFAULT NULL COMMENT '积分消费金额',
  `handleState` tinyint(1) DEFAULT NULL COMMENT '记录处理状态',
  `recordTime` datetime DEFAULT NULL COMMENT '记录时间',
  `transferState` tinyint(1) DEFAULT NULL COMMENT '积分对应资金状态',
  `handleTime` datetime DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`creconId`),
  KEY `FK_Reference_51` (`memID`),
  KEY `FK_Reference_52` (`merID`),
  KEY `FK_Reference_53` (`AdminID`),
  CONSTRAINT `FK_Reference_51` FOREIGN KEY (`memID`) REFERENCES `Member` (`memID`),
  CONSTRAINT `FK_Reference_52` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`),
  CONSTRAINT `FK_Reference_53` FOREIGN KEY (`AdminID`) REFERENCES `Admin` (`AdminID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for CreditExchange
-- ----------------------------
DROP TABLE IF EXISTS `CreditExchange`;
CREATE TABLE `CreditExchange` (
  `ceID` int(11) NOT NULL AUTO_INCREMENT COMMENT '兑换编号',
  `ceStat` varchar(50) DEFAULT NULL COMMENT '兑换状态',
  `mcPKID` int(11) NOT NULL,
  `ceWays` varchar(50) DEFAULT NULL COMMENT '领取方式',
  `ceItem` text COMMENT '领取物品',
  `ceAmount` int(11) DEFAULT NULL COMMENT '领取数量',
  `ceCost` float DEFAULT NULL COMMENT '消耗积分',
  `ceAdress` text COMMENT '收货地址',
  `ceTime` datetime DEFAULT NULL COMMENT '兑换时间',
  PRIMARY KEY (`ceID`),
  KEY `FK_Relationship_40` (`mcPKID`),
  CONSTRAINT `FK_Relationship_40` FOREIGN KEY (`mcPKID`) REFERENCES `MemberCard` (`mcPKID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分兑换历史';

-- ----------------------------
-- Table structure for CreditHistory
-- ----------------------------
DROP TABLE IF EXISTS `CreditHistory`;
CREATE TABLE `CreditHistory` (
  `chID` int(11) NOT NULL AUTO_INCREMENT COMMENT '积分编号',
  `mcPKID` int(11) NOT NULL,
  `chCredit` float DEFAULT NULL COMMENT '变动积分',
  `chRemain` float DEFAULT NULL COMMENT '剩余积分',
  `chType` text COMMENT '变动原因',
  PRIMARY KEY (`chID`),
  KEY `FK_Relationship_31` (`mcPKID`),
  CONSTRAINT `FK_Relationship_31` FOREIGN KEY (`mcPKID`) REFERENCES `MemberCard` (`mcPKID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='积分历史';

-- ----------------------------
-- Table structure for CreditSubmit
-- ----------------------------
DROP TABLE IF EXISTS `CreditSubmit`;
CREATE TABLE `CreditSubmit` (
  `csID` int(11) NOT NULL AUTO_INCREMENT COMMENT '上缴记录编号',
  `merID` int(11) DEFAULT NULL COMMENT '商家编号',
  `csStat` tinyint(1) DEFAULT NULL COMMENT '上缴状态',
  `csMoney` float DEFAULT NULL COMMENT '上缴金额',
  `csCredit` float DEFAULT NULL COMMENT '上缴积分',
  PRIMARY KEY (`csID`),
  KEY `FK_Relationship_39` (`merID`),
  CONSTRAINT `FK_Relationship_39` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='积分上缴记录';

-- ----------------------------
-- Table structure for Evaluation
-- ----------------------------
DROP TABLE IF EXISTS `Evaluation`;
CREATE TABLE `Evaluation` (
  `evaID` int(11) NOT NULL AUTO_INCREMENT COMMENT '点评编号',
  `AdminID` int(11) DEFAULT NULL COMMENT '管理员ID',
  `merID` int(11) NOT NULL COMMENT '商家编号',
  `memID` int(11) NOT NULL COMMENT '会员号',
  `evaInfo` text COMMENT '点评内容',
  `evaIP` varchar(20) DEFAULT NULL COMMENT '留言IP',
  `evaBy` int(11) DEFAULT NULL COMMENT '留言人',
  `evaTime` datetime DEFAULT NULL COMMENT '留言时间',
  `evaEnable` tinyint(1) DEFAULT NULL COMMENT '是否有效',
  `evaReply` tinyint(1) DEFAULT NULL COMMENT '是否回复',
  `evaReplyBy` int(11) DEFAULT NULL COMMENT '回复人',
  `evaRepInfo` text COMMENT '回复内容',
  `evaRepTime` datetime DEFAULT NULL COMMENT '回复时间',
  `cumID` int(11) DEFAULT NULL,
  PRIMARY KEY (`evaID`),
  KEY `FK_Relationship_23` (`evaBy`),
  KEY `FK_Relationship_36` (`evaReplyBy`),
  KEY `FK_Relationship_7` (`merID`),
  CONSTRAINT `FK_Relationship_23` FOREIGN KEY (`evaBy`) REFERENCES `Member` (`memID`),
  CONSTRAINT `FK_Relationship_36` FOREIGN KEY (`evaReplyBy`) REFERENCES `Admin` (`AdminID`),
  CONSTRAINT `FK_Relationship_7` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='点评';

-- ----------------------------
-- Table structure for HotelRooms
-- ----------------------------
DROP TABLE IF EXISTS `HotelRooms`;
CREATE TABLE `HotelRooms` (
  `pduID` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `merID` int(11) DEFAULT NULL COMMENT '商家编号',
  `pduName` varchar(30) DEFAULT NULL COMMENT '商品名称',
  `pduPrice` float DEFAULT NULL COMMENT '商品价格',
  `pduMemPrice` float DEFAULT NULL COMMENT '商品会员价',
  `pduIntro` varchar(100) DEFAULT NULL COMMENT '商品介绍',
  `pduImage` varchar(150) DEFAULT NULL COMMENT '商品图片',
  `pduRemain` int(11) DEFAULT NULL COMMENT '商品剩余',
  `hrRoomtype` varchar(100) DEFAULT NULL COMMENT '房型',
  `hrBreadfast` varchar(100) DEFAULT NULL COMMENT '早餐',
  `hrBed` varchar(100) DEFAULT NULL COMMENT '床型',
  `hrNetwork` varchar(100) DEFAULT NULL COMMENT '宽带',
  `hrRoomStat` text COMMENT '房态',
  `hrSpecialPrice` float DEFAULT NULL COMMENT '特殊时段价格',
  `hrWeekendPrice` float DEFAULT NULL COMMENT '周末价格',
  `hrAvailable` tinyint(1) DEFAULT NULL COMMENT '可用状态',
  `hrComment` text COMMENT '备注',
  PRIMARY KEY (`pduID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='酒店房间';

-- ----------------------------
-- Table structure for LabelHaveProduct
-- ----------------------------
DROP TABLE IF EXISTS `LabelHaveProduct`;
CREATE TABLE `LabelHaveProduct` (
  `pduID` int(11) DEFAULT NULL COMMENT '商品编号',
  `LabelID` int(11) DEFAULT NULL COMMENT '标签编号',
  KEY `FK_Reference_44` (`pduID`),
  KEY `FK_Reference_45` (`LabelID`),
  CONSTRAINT `FK_Reference_44` FOREIGN KEY (`pduID`) REFERENCES `ProductInfo` (`pduID`),
  CONSTRAINT `FK_Reference_45` FOREIGN KEY (`LabelID`) REFERENCES `BrandLabel` (`LabelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品表和标签表多对多的关系表';

-- ----------------------------
-- Table structure for LoginLog
-- ----------------------------
DROP TABLE IF EXISTS `LoginLog`;
CREATE TABLE `LoginLog` (
  `llogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `macID` int(11) DEFAULT NULL COMMENT '账户编号',
  `llogAccount` int(11) DEFAULT NULL COMMENT '账号',
  `llogDate` datetime DEFAULT NULL COMMENT '日期',
  `llogType` varchar(10) DEFAULT NULL COMMENT '登录操作类型',
  PRIMARY KEY (`llogID`),
  KEY `FK_Relationship_30` (`macID`),
  CONSTRAINT `FK_Relationship_30` FOREIGN KEY (`macID`) REFERENCES `MerchantAccount` (`macID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录日志';

-- ----------------------------
-- Table structure for Member
-- ----------------------------
DROP TABLE IF EXISTS `Member`;
CREATE TABLE `Member` (
  `memID` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员号',
  `memCredit` float DEFAULT '0' COMMENT '积分值',
  `memCer` varchar(30) DEFAULT NULL COMMENT '证件类型',
  `memCerID` varchar(30) DEFAULT NULL COMMENT '证件号',
  `memName` varchar(50) DEFAULT NULL COMMENT '姓名',
  `memSex` varchar(8) DEFAULT NULL COMMENT '性别',
  `memBirth` date DEFAULT NULL COMMENT '生日',
  `memPhone` varchar(30) DEFAULT NULL COMMENT '手机号',
  `memAdress` text COMMENT '会员地址',
  `memEmail` varchar(100) DEFAULT NULL COMMENT '电邮地址',
  PRIMARY KEY (`memID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='会员';

-- ----------------------------
-- Table structure for MemberAccount
-- ----------------------------
DROP TABLE IF EXISTS `MemberAccount`;
CREATE TABLE `MemberAccount` (
  `memID` int(11) NOT NULL COMMENT '会员号',
  `maID` varchar(20) DEFAULT NULL COMMENT '账号',
  `maName` varchar(20) DEFAULT NULL COMMENT '账号名',
  `maPwd` varchar(50) DEFAULT NULL COMMENT '密码',
  `maCumPwd` varchar(50) DEFAULT NULL COMMENT '消费密码',
  `maEnable` tinyint(1) DEFAULT NULL COMMENT '是否停用',
  PRIMARY KEY (`memID`),
  CONSTRAINT `FK_Relationship_35` FOREIGN KEY (`memID`) REFERENCES `Member` (`memID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员账号';

-- ----------------------------
-- Table structure for MemberCard
-- ----------------------------
DROP TABLE IF EXISTS `MemberCard`;
CREATE TABLE `MemberCard` (
  `mcPKID` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员卡主键',
  `memID` int(11) NOT NULL COMMENT '会员号',
  `mcID` varchar(25) NOT NULL COMMENT '会员卡卡号',
  `merID` int(11) DEFAULT NULL COMMENT '商家编号',
  `mcType` varchar(30) DEFAULT NULL COMMENT '会员卡类型',
  `mcCredit` float DEFAULT '0' COMMENT '积分（废弃）',
  `mcBalance` float DEFAULT '0' COMMENT '余额',
  `mcEnable` tinyint(1) DEFAULT NULL COMMENT '是否启用',
  PRIMARY KEY (`mcPKID`),
  KEY `FK_Relationship_28` (`memID`),
  KEY `FK_Relationship_29` (`merID`),
  CONSTRAINT `FK_Relationship_28` FOREIGN KEY (`memID`) REFERENCES `Member` (`memID`),
  CONSTRAINT `FK_Relationship_29` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='会员卡';

-- ----------------------------
-- Table structure for MemberCardReceive
-- ----------------------------
DROP TABLE IF EXISTS `MemberCardReceive`;
CREATE TABLE `MemberCardReceive` (
  `mcrID` int(11) NOT NULL AUTO_INCREMENT COMMENT '领取编号',
  `AdminID` int(11) NOT NULL COMMENT '管理员ID',
  `merID` int(11) NOT NULL COMMENT '商家编号',
  `mcrReceivedCount` int(11) DEFAULT NULL COMMENT '领取数量',
  `mcrZone` varchar(100) DEFAULT NULL COMMENT '卡号段',
  `mcrTime` date DEFAULT NULL COMMENT '领取时间',
  PRIMARY KEY (`mcrID`),
  KEY `FK_Relationship_43` (`merID`),
  KEY `FK_Relationship_44` (`AdminID`),
  CONSTRAINT `FK_Relationship_43` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`),
  CONSTRAINT `FK_Relationship_44` FOREIGN KEY (`AdminID`) REFERENCES `Admin` (`AdminID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员卡领取记录';

-- ----------------------------
-- Table structure for MemberInfoChange
-- ----------------------------
DROP TABLE IF EXISTS `MemberInfoChange`;
CREATE TABLE `MemberInfoChange` (
  `micID` int(11) NOT NULL AUTO_INCREMENT COMMENT '变更编号',
  `memID` int(11) NOT NULL COMMENT '会员号',
  `micCer` varchar(16) DEFAULT NULL COMMENT '证件类型',
  `micCerID` varchar(30) DEFAULT NULL COMMENT '证件号',
  `micName` varchar(16) DEFAULT NULL COMMENT '会员姓名',
  `micSex` varchar(4) DEFAULT NULL COMMENT '性别',
  `micPhone` varchar(30) DEFAULT NULL COMMENT '手机号码',
  `micBirth` date DEFAULT NULL COMMENT '生日',
  `micAdredd` varchar(100) DEFAULT NULL COMMENT '会员地址',
  `micEmail` varchar(100) DEFAULT NULL COMMENT '电邮地址',
  `micReason` varchar(100) DEFAULT NULL COMMENT '变更原因',
  `micTime` datetime DEFAULT NULL COMMENT '变更时间',
  PRIMARY KEY (`micID`),
  KEY `FK_Relationship_13` (`memID`),
  CONSTRAINT `FK_Relationship_13` FOREIGN KEY (`memID`) REFERENCES `Member` (`memID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员信息变更历史';

-- ----------------------------
-- Table structure for MemberManager
-- ----------------------------
DROP TABLE IF EXISTS `MemberManager`;
CREATE TABLE `MemberManager` (
  `mmaID` int(11) NOT NULL AUTO_INCREMENT COMMENT '指定编号',
  `memID` int(11) NOT NULL COMMENT '会员号',
  `macID` int(11) DEFAULT NULL COMMENT '账户编号（废弃）',
  `mmaTime` date DEFAULT NULL COMMENT '指定日期',
  `mmanagerID` int(11) DEFAULT NULL COMMENT '客户经理编号',
  PRIMARY KEY (`mmaID`),
  KEY `FK_Relationship_37` (`mmanagerID`),
  KEY `FK_Relationship_38` (`memID`),
  CONSTRAINT `FK_Relationship_37` FOREIGN KEY (`mmanagerID`) REFERENCES `MerchantAccount` (`macID`),
  CONSTRAINT `FK_Relationship_38` FOREIGN KEY (`memID`) REFERENCES `Member` (`memID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='客户经理指定记录';

-- ----------------------------
-- Table structure for Merchant
-- ----------------------------
DROP TABLE IF EXISTS `Merchant`;
CREATE TABLE `Merchant` (
  `merID` int(11) NOT NULL AUTO_INCREMENT COMMENT '商家编号',
  `merSubID` int(11) DEFAULT NULL COMMENT '父编号',
  `merTopID` int(11) DEFAULT NULL COMMENT '顶级编号（废弃）',
  `merType` varchar(10) DEFAULT NULL COMMENT '商家类型',
  `merName` varchar(50) DEFAULT NULL COMMENT '商家名称',
  `merCumPresent` float DEFAULT '0' COMMENT '消费积分比例',
  `merDicPresent` float DEFAULT '0' COMMENT '会员折扣比例(改为积分还钱比例)',
  `merAppStat` tinyint(1) DEFAULT NULL COMMENT '入盟申请状态',
  `merRecommend` tinyint(1) DEFAULT NULL COMMENT '是否推荐商家',
  `isIndex` tinyint(1) DEFAULT NULL COMMENT '是否显示在首页',
  `oweCredit` float DEFAULT '0' COMMENT '所欠积分',
  PRIMARY KEY (`merID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='商家';

-- ----------------------------
-- Table structure for MerchantAccount
-- ----------------------------
DROP TABLE IF EXISTS `MerchantAccount`;
CREATE TABLE `MerchantAccount` (
  `macID` int(11) NOT NULL AUTO_INCREMENT COMMENT '账户编号',
  `merID` int(11) NOT NULL COMMENT '商家编号',
  `macAcc` varchar(20) DEFAULT NULL COMMENT '登录名',
  `macCumAcc` int(11) DEFAULT NULL COMMENT '结账账户',
  `macPasswd` varchar(50) DEFAULT NULL COMMENT '密码',
  `macAccType` int(11) DEFAULT NULL COMMENT '账号类型（11为管理员，2为前台账户，3为客户经理，14为部门经理,大于10的拥有为用户充值权限，管理员可为前台和客户经理添加充值权限，加权后数值为前台12和客户经理13）',
  `macLastLogin` datetime DEFAULT NULL COMMENT '最后登录时间',
  `macEnable` tinyint(1) DEFAULT NULL COMMENT '启用状态',
  PRIMARY KEY (`macID`),
  KEY `FK_Relationship_1` (`merID`),
  CONSTRAINT `FK_Relationship_1` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='商家账户';

-- ----------------------------
-- Table structure for MerchantAndLabel
-- ----------------------------
DROP TABLE IF EXISTS `MerchantAndLabel`;
CREATE TABLE `MerchantAndLabel` (
  `labelID` int(11) DEFAULT NULL COMMENT '标签ID',
  `merID` int(11) DEFAULT NULL COMMENT '商家ID',
  KEY `FK_MerchantAndLabel_MerchantLabel` (`labelID`),
  KEY `FK_MerchantAndLabel_Merchant` (`merID`),
  CONSTRAINT `FK_MerchantAndLabel_Merchant` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`),
  CONSTRAINT `FK_MerchantAndLabel_MerchantLabel` FOREIGN KEY (`labelID`) REFERENCES `MerchantLabel` (`labelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家与标签关系表';

-- ----------------------------
-- Table structure for MerchantConfigure
-- ----------------------------
DROP TABLE IF EXISTS `MerchantConfigure`;
CREATE TABLE `MerchantConfigure` (
  `merID` int(11) NOT NULL COMMENT '商家编号',
  `confIP` varchar(20) DEFAULT NULL COMMENT '前台结账IP',
  `confCNenable` tinyint(1) DEFAULT NULL COMMENT '允许卡号消费',
  `confMPenable` tinyint(1) DEFAULT NULL COMMENT '仅主账号充值',
  `confMerKind` varchar(10) DEFAULT NULL COMMENT '所属行业',
  `confEnableLevel` tinyint(1) DEFAULT NULL COMMENT '是否需要星级',
  `confEnableImage` tinyint(1) DEFAULT NULL COMMENT '是否提供商家图片展示',
  `confEnableHotel` tinyint(1) DEFAULT NULL COMMENT '是否适用酒店产品展示模板',
  `confMaxPurchase` float DEFAULT NULL COMMENT '单笔储值最大值',
  PRIMARY KEY (`merID`),
  CONSTRAINT `FK_Relationship_42` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家配置';

-- ----------------------------
-- Table structure for MerchantInfo
-- ----------------------------
DROP TABLE IF EXISTS `MerchantInfo`;
CREATE TABLE `MerchantInfo` (
  `merID` int(11) NOT NULL COMMENT '商家编号',
  `merIntroduce` text COMMENT '商家介绍',
  `merImage` varchar(100) DEFAULT NULL COMMENT '商家图片',
  `merMainImage` tinyint(1) DEFAULT NULL COMMENT '是否为主图片',
  `merAdress` text COMMENT '联系地址',
  `merTelphone` varchar(18) DEFAULT NULL COMMENT '联系电话',
  `merFax` varchar(50) DEFAULT NULL COMMENT '传真',
  `merURL` varchar(100) DEFAULT NULL COMMENT '网址',
  `merEmail` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `merPrincipal` varchar(50) DEFAULT NULL COMMENT '联系人',
  `merAppellation` varchar(100) DEFAULT NULL COMMENT '称谓',
  `merDuty` varchar(100) DEFAULT NULL COMMENT '职务',
  `merPhone` varchar(30) DEFAULT NULL COMMENT '手机',
  `merLevel` int(11) DEFAULT NULL COMMENT '星级',
  `merPostNum` varchar(15) DEFAULT NULL COMMENT '邮编',
  `merProvince` varchar(20) DEFAULT NULL COMMENT '所在省份（废除）',
  `merCity` varchar(20) DEFAULT NULL COMMENT '所在城市（废除）',
  `merArea` varchar(150) DEFAULT NULL COMMENT '所在区县（完整地址）',
  `merLandmark` text COMMENT '附近地标',
  `merDiscount` text COMMENT '会员特惠',
  `merDiscountEvent` text COMMENT '促销活动',
  PRIMARY KEY (`merID`),
  CONSTRAINT `FK_Relationship_3` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家资料';

-- ----------------------------
-- Table structure for merchantInfoModified
-- ----------------------------
DROP TABLE IF EXISTS `merchantInfoModified`;
CREATE TABLE `merchantInfoModified` (
  `modifiedId` int(11) NOT NULL AUTO_INCREMENT COMMENT '历史表编号',
  `merID` int(11) NOT NULL COMMENT '商家编号',
  `merIntroduce` text COMMENT '商家介绍',
  `merImage` varchar(100) DEFAULT NULL COMMENT '商家图片',
  `merMainImage` tinyint(1) DEFAULT NULL COMMENT '是否为主图片',
  `merAdress` text COMMENT '联系地址',
  `merTelphone` varchar(18) DEFAULT NULL COMMENT '联系电话',
  `merFax` varchar(50) DEFAULT NULL COMMENT '传真',
  `merURL` varchar(100) DEFAULT NULL COMMENT '网址',
  `merEmail` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `merPrincipal` varchar(50) DEFAULT NULL COMMENT '联系人',
  `merAppellation` varchar(100) DEFAULT NULL COMMENT '称谓',
  `merDuty` varchar(100) DEFAULT NULL COMMENT '职务',
  `merPhone` varchar(30) DEFAULT NULL COMMENT '手机',
  `merLevel` int(11) DEFAULT NULL COMMENT '星级',
  `merPostNum` varchar(15) DEFAULT NULL COMMENT '邮编',
  `merProvince` varchar(20) DEFAULT NULL COMMENT '所在省份',
  `merCity` varchar(20) DEFAULT NULL COMMENT '所在城市',
  `merArea` varchar(20) DEFAULT NULL COMMENT '所在区县',
  `merLandmark` text COMMENT '附近地标',
  `merDiscount` text COMMENT '会员特惠',
  `merDiscountEvent` text COMMENT '促销活动',
  `examineState` varchar(20) NOT NULL COMMENT '审核状态(未审批、通过、不通过)',
  PRIMARY KEY (`modifiedId`),
  KEY `FK_Inheritance_2` (`merID`),
  CONSTRAINT `FK_Inheritance_2` FOREIGN KEY (`merID`) REFERENCES `MerchantInfo` (`merID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商家资料变更历史';

-- ----------------------------
-- Table structure for MerchantLabel
-- ----------------------------
DROP TABLE IF EXISTS `MerchantLabel`;
CREATE TABLE `MerchantLabel` (
  `labelID` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `labelName` varchar(30) DEFAULT NULL COMMENT '标签名',
  `labelType` varchar(30) DEFAULT NULL COMMENT '标签类型',
  PRIMARY KEY (`labelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家标签表';

-- ----------------------------
-- Table structure for MerchantMoneyReturn
-- ----------------------------
DROP TABLE IF EXISTS `MerchantMoneyReturn`;
CREATE TABLE `MerchantMoneyReturn` (
  `merID` int(11) NOT NULL COMMENT '商家编号',
  `mmrID` int(11) DEFAULT NULL COMMENT '返还编号',
  `mmrMoney` float DEFAULT NULL COMMENT '返还金额',
  `mmrConsumoMoney` float DEFAULT NULL COMMENT '积分消费金额',
  `mmrStat` varchar(30) DEFAULT NULL COMMENT '处理状态',
  KEY `FK_Relationship_45` (`merID`),
  CONSTRAINT `FK_Relationship_45` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家积分消费返还记录';

-- ----------------------------
-- Table structure for MerPhoto
-- ----------------------------
DROP TABLE IF EXISTS `MerPhoto`;
CREATE TABLE `MerPhoto` (
  `photoID` int(11) NOT NULL COMMENT '主键',
  `merID` int(11) DEFAULT NULL COMMENT '商家编号',
  `photoLink` varchar(150) DEFAULT NULL COMMENT '照片链接',
  `note` varchar(30) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`photoID`),
  KEY `FK_Reference_54` (`merID`),
  CONSTRAINT `FK_Reference_54` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Message
-- ----------------------------
DROP TABLE IF EXISTS `Message`;
CREATE TABLE `Message` (
  `mesTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `mesID` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `mesTitle` varchar(50) DEFAULT NULL COMMENT '题目',
  `mesContent` text COMMENT '内容',
  `mesSource` int(11) DEFAULT NULL COMMENT '发送人',
  `mesDestination` int(11) DEFAULT NULL COMMENT '接收人',
  `mesRead` tinyint(1) DEFAULT NULL COMMENT '处理状态',
  `mesType` int(11) DEFAULT NULL,
  PRIMARY KEY (`mesID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='站内消息';

-- ----------------------------
-- Table structure for News
-- ----------------------------
DROP TABLE IF EXISTS `News`;
CREATE TABLE `News` (
  `newsID` int(11) NOT NULL AUTO_INCREMENT COMMENT '新闻编号',
  `newsTitle` varchar(50) DEFAULT NULL COMMENT '新闻题目',
  `newsContent` text COMMENT '新闻内容',
  `newsType` varchar(30) DEFAULT NULL COMMENT '新闻类型',
  `newsImage` varchar(50) DEFAULT NULL COMMENT '新闻图片',
  `newsBelong` varchar(30) DEFAULT NULL COMMENT '新闻所属栏目',
  `newsEnableHP` tinyint(1) DEFAULT NULL COMMENT '是否加入首页',
  `newsEnableAct` tinyint(1) DEFAULT NULL COMMENT '是否作为活动新闻',
  PRIMARY KEY (`newsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻';

-- ----------------------------
-- Table structure for OperationLog
-- ----------------------------
DROP TABLE IF EXISTS `OperationLog`;
CREATE TABLE `OperationLog` (
  `ologID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `macID` int(11) DEFAULT NULL COMMENT '账户编号',
  `ologAccount` int(11) DEFAULT NULL COMMENT '账号',
  `ologTime` datetime DEFAULT NULL COMMENT '日期',
  `ologURL` varchar(50) DEFAULT NULL COMMENT '操作URL',
  `ologFuntion` varchar(70) DEFAULT NULL COMMENT '操作功能名称',
  `ologOperation` text COMMENT '操作说明',
  `ologInfo` text COMMENT '备注',
  PRIMARY KEY (`ologID`),
  KEY `FK_Relationship_22` (`macID`),
  CONSTRAINT `FK_Relationship_22` FOREIGN KEY (`macID`) REFERENCES `MerchantAccount` (`macID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作日志';

-- ----------------------------
-- Table structure for PreMemberCard
-- ----------------------------
DROP TABLE IF EXISTS `PreMemberCard`;
CREATE TABLE `PreMemberCard` (
  `pmcID` int(11) NOT NULL AUTO_INCREMENT COMMENT '卡号',
  `merID` int(11) NOT NULL COMMENT '商家编号',
  `pmcStat` tinyint(1) DEFAULT NULL COMMENT '状态',
  `pmcMerMaker` int(11) DEFAULT NULL COMMENT '制卡人',
  `pmcProvider` int(11) DEFAULT NULL COMMENT '发卡人',
  `pmcMakeTime` date DEFAULT NULL COMMENT '制卡时间',
  `pmcProvideTime` date DEFAULT NULL COMMENT '发卡时间',
  PRIMARY KEY (`pmcID`),
  KEY `FK_Reference_41` (`pmcProvider`),
  KEY `FK_Relationship_9` (`pmcMerMaker`),
  CONSTRAINT `FK_Reference_41` FOREIGN KEY (`pmcProvider`) REFERENCES `MerchantAccount` (`macID`),
  CONSTRAINT `FK_Reference_47` FOREIGN KEY (`pmcMerMaker`) REFERENCES `Admin` (`AdminID`),
  CONSTRAINT `FK_Relationship_9` FOREIGN KEY (`pmcMerMaker`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预制会员卡';

-- ----------------------------
-- Table structure for ProductInfo
-- ----------------------------
DROP TABLE IF EXISTS `ProductInfo`;
CREATE TABLE `ProductInfo` (
  `pduID` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `merID` int(11) NOT NULL COMMENT '商家编号',
  `pduName` varchar(30) DEFAULT NULL COMMENT '商品名称',
  `pduPrice` float DEFAULT NULL COMMENT '商品价格',
  `pduMemPrice` float DEFAULT NULL COMMENT '商品会员价',
  `pduIntro` varchar(100) DEFAULT NULL COMMENT '商品介绍',
  `pduImage` varchar(150) DEFAULT NULL COMMENT '商品图片',
  `pduRemain` int(11) DEFAULT NULL COMMENT '商品剩余',
  PRIMARY KEY (`pduID`),
  KEY `FK_Relationship_16` (`merID`),
  CONSTRAINT `FK_Relationship_16` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商品资料';

-- ----------------------------
-- Table structure for Purchase
-- ----------------------------
DROP TABLE IF EXISTS `Purchase`;
CREATE TABLE `Purchase` (
  `purID` int(11) NOT NULL AUTO_INCREMENT COMMENT '充值编号',
  `mcPKID` int(11) NOT NULL,
  `purBelong` int(11) DEFAULT NULL COMMENT '会员卡所属商家',
  `purMerchant` int(11) DEFAULT NULL COMMENT '充值商家',
  `purMoney` float DEFAULT NULL COMMENT '充值金额',
  `purRemain` float DEFAULT NULL COMMENT '可用金额',
  `purTime` datetime DEFAULT NULL COMMENT '充值时间',
  PRIMARY KEY (`purID`),
  KEY `FK_Reference_24` (`purBelong`),
  KEY `FK_Reference_26` (`purMerchant`),
  KEY `FK_Relationship_26` (`mcPKID`),
  CONSTRAINT `FK_Reference_24` FOREIGN KEY (`purBelong`) REFERENCES `Merchant` (`merID`),
  CONSTRAINT `FK_Reference_26` FOREIGN KEY (`purMerchant`) REFERENCES `Merchant` (`merID`),
  CONSTRAINT `FK_Relationship_26` FOREIGN KEY (`mcPKID`) REFERENCES `MemberCard` (`mcPKID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值历史';

-- ----------------------------
-- Table structure for RechargeHistory
-- ----------------------------
DROP TABLE IF EXISTS `RechargeHistory`;
CREATE TABLE `RechargeHistory` (
  `rhID` int(11) NOT NULL AUTO_INCREMENT COMMENT '充值历史表Id',
  `merID` int(11) DEFAULT NULL COMMENT '商家编号',
  `memID` int(11) DEFAULT NULL COMMENT '会员号',
  `macID` int(11) DEFAULT NULL COMMENT '充值人编号',
  `mcID` varchar(25) DEFAULT NULL COMMENT '会员卡卡号',
  `rechargeMoney` float DEFAULT NULL COMMENT '充值金额',
  `balance` float DEFAULT NULL COMMENT '充值后余额',
  `rechargeTime` datetime DEFAULT NULL COMMENT '充值时间',
  PRIMARY KEY (`rhID`),
  KEY `FK_Reference_62` (`macID`),
  KEY `FK_Reference_65` (`merID`),
  KEY `FK_Reference_66` (`memID`),
  CONSTRAINT `FK_Reference_62` FOREIGN KEY (`macID`) REFERENCES `MerchantAccount` (`macID`),
  CONSTRAINT `FK_Reference_65` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`),
  CONSTRAINT `FK_Reference_66` FOREIGN KEY (`memID`) REFERENCES `Member` (`memID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for Reissue
-- ----------------------------
DROP TABLE IF EXISTS `Reissue`;
CREATE TABLE `Reissue` (
  `reiID` int(11) NOT NULL AUTO_INCREMENT COMMENT '补卡历史编号',
  `memID` int(11) DEFAULT NULL COMMENT '会员号',
  `reiReason` text COMMENT '补卡原因',
  `reiTime` date DEFAULT NULL COMMENT '补卡时间',
  `mcPKID` int(11) DEFAULT NULL,
  PRIMARY KEY (`reiID`),
  KEY `FK_Reference_29` (`mcPKID`),
  KEY `FK_Relationship_33` (`memID`),
  CONSTRAINT `FK_Reference_29` FOREIGN KEY (`mcPKID`) REFERENCES `MemberCard` (`mcPKID`),
  CONSTRAINT `FK_Relationship_33` FOREIGN KEY (`memID`) REFERENCES `Member` (`memID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='补卡历史';

-- ----------------------------
-- Table structure for Requirement
-- ----------------------------
DROP TABLE IF EXISTS `Requirement`;
CREATE TABLE `Requirement` (
  `reqID` int(11) NOT NULL AUTO_INCREMENT COMMENT '需求编号',
  `memID` int(11) NOT NULL COMMENT '会员号',
  `reqInfo` text COMMENT '内容',
  `reqTime` datetime DEFAULT NULL COMMENT '发布时间',
  `reqBy` int(11) DEFAULT NULL COMMENT '发布人',
  `reqReply` tinyint(1) DEFAULT NULL COMMENT '是否回复',
  `reqRepContent` text COMMENT '回复内容',
  `reqRepBy` int(11) DEFAULT NULL COMMENT '回复人',
  `reqRepTime` datetime DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`reqID`),
  KEY `FK_Reference_31` (`reqRepBy`),
  KEY `FK_Relationship_25` (`reqBy`),
  CONSTRAINT `FK_Reference_31` FOREIGN KEY (`reqRepBy`) REFERENCES `Admin` (`AdminID`),
  CONSTRAINT `FK_Relationship_25` FOREIGN KEY (`reqBy`) REFERENCES `Member` (`memID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='需求';

-- ----------------------------
-- Table structure for Suggestion
-- ----------------------------
DROP TABLE IF EXISTS `Suggestion`;
CREATE TABLE `Suggestion` (
  `sugID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `merID` int(11) NOT NULL COMMENT '商家编号',
  `sugTitle` varchar(100) DEFAULT NULL COMMENT '标题',
  `sugContent` text COMMENT '内容',
  `sugDate` date DEFAULT NULL COMMENT '日期',
  PRIMARY KEY (`sugID`),
  KEY `FK_Relationship_20` (`merID`),
  CONSTRAINT `FK_Relationship_20` FOREIGN KEY (`merID`) REFERENCES `Merchant` (`merID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='建议';

-- ----------------------------
-- View structure for ConsumeComment
-- ----------------------------
DROP VIEW IF EXISTS `ConsumeComment`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `ConsumeComment` AS select `Consume`.`cumID` AS `cumID`,`Consume`.`macID` AS `macID`,`Consume`.`mcPKID` AS `mcPKID`,`Consume`.`cumMoney` AS `cumMoney`,`Consume`.`cumWay` AS `cumWay`,`Consume`.`cumCredit` AS `cumCredit`,`Consume`.`cumTime` AS `cumTime`,`Consume`.`pduID` AS `pduID`,`Consume`.`hasComment` AS `hasComment`,`MemberCard`.`memID` AS `memID`,`MemberCard`.`merID` AS `merID`,`Merchant`.`merType` AS `merType`,`Merchant`.`merName` AS `merName`,`ProductInfo`.`pduName` AS `pduName`,`ProductInfo`.`pduPrice` AS `pduPrice`,`ProductInfo`.`pduIntro` AS `pduIntro`,`ProductInfo`.`pduImage` AS `pduImage` from ((((`Consume` join `MemberCard` on((`Consume`.`mcPKID` = `MemberCard`.`mcPKID`))) join `MerchantAccount` on(((`Consume`.`macID` = `MerchantAccount`.`macID`) and (`MemberCard`.`merID` = `MerchantAccount`.`merID`)))) join `Merchant` on((`MemberCard`.`merID` = `Merchant`.`merID`))) join `ProductInfo` on(((`MemberCard`.`merID` = `ProductInfo`.`merID`) and (`Consume`.`pduID` = `ProductInfo`.`pduID`)))) ;

-- ----------------------------
-- View structure for ConsumeDetail
-- ----------------------------
DROP VIEW IF EXISTS `ConsumeDetail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `ConsumeDetail` AS select `Consume`.`cumID` AS `cumID`,`Consume`.`macID` AS `macID`,`Consume`.`mcPKID` AS `mcPKID`,`Consume`.`cumMoney` AS `cumMoney`,`Consume`.`cumWay` AS `cumWay`,`Consume`.`cumCredit` AS `cumCredit`,`Consume`.`cumTime` AS `cumTime`,`Consume`.`pduID` AS `pduID`,`MemberCard`.`memID` AS `memID`,`MemberCard`.`merID` AS `merID`,`Merchant`.`merType` AS `merType`,`Merchant`.`merName` AS `merName` from (((`Consume` join `MemberCard` on((`Consume`.`mcPKID` = `MemberCard`.`mcPKID`))) join `MerchantAccount` on(((`Consume`.`macID` = `MerchantAccount`.`macID`) and (`MemberCard`.`merID` = `MerchantAccount`.`merID`)))) join `Merchant` on((`MemberCard`.`merID` = `Merchant`.`merID`))) ;

-- ----------------------------
-- View structure for CreditConsumeDetail
-- ----------------------------
DROP VIEW IF EXISTS `CreditConsumeDetail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `CreditConsumeDetail` AS select `CreditConsume`.`merID` AS `merID`,`CreditConsume`.`memID` AS `memID`,`CreditConsume`.`creconId` AS `creconId`,`CreditConsume`.`AdminID` AS `AdminID`,`CreditConsume`.`credits` AS `credits`,`CreditConsume`.`value` AS `value`,`CreditConsume`.`handleState` AS `handleState`,`CreditConsume`.`recordTime` AS `recordTime`,`CreditConsume`.`transferState` AS `transferState`,`CreditConsume`.`handleTime` AS `handleTime`,`Member`.`memCredit` AS `memCredit`,`Member`.`memCer` AS `memCer`,`Member`.`memCerID` AS `memCerID`,`Member`.`memName` AS `memName`,`Member`.`memSex` AS `memSex`,`Member`.`memBirth` AS `memBirth`,`Member`.`memPhone` AS `memPhone`,`Member`.`memAdress` AS `memAdress`,`Member`.`memEmail` AS `memEmail`,`Merchant`.`merSubID` AS `merSubID`,`Merchant`.`merTopID` AS `merTopID`,`Merchant`.`merType` AS `merType`,`Merchant`.`merName` AS `merName`,`Merchant`.`merCumPresent` AS `merCumPresent`,`Merchant`.`merDicPresent` AS `merDicPresent`,`Merchant`.`merAppStat` AS `merAppStat`,`Merchant`.`merRecommend` AS `merRecommend`,`Merchant`.`isIndex` AS `isIndex`,`Merchant`.`oweCredit` AS `oweCredit` from ((`CreditConsume` join `Member` on((`CreditConsume`.`memID` = `Member`.`memID`))) join `Merchant` on((`CreditConsume`.`merID` = `Merchant`.`merID`))) ;

-- ----------------------------
-- View structure for CreditHistoryView
-- ----------------------------
DROP VIEW IF EXISTS `CreditHistoryView`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `CreditHistoryView` AS select `MemberCard`.`merID` AS `merID`,`CreditHistory`.`mcPKID` AS `mcPKID`,`CreditHistory`.`chID` AS `chID`,`CreditHistory`.`chCredit` AS `chCredit`,`CreditHistory`.`chRemain` AS `chRemain`,`CreditHistory`.`chType` AS `chType`,`MemberCard`.`memID` AS `memID`,`Merchant`.`merType` AS `merType`,`Merchant`.`merName` AS `merName` from ((`CreditHistory` join `MemberCard` on((`CreditHistory`.`mcPKID` = `MemberCard`.`mcPKID`))) join `Merchant` on((`MemberCard`.`merID` = `Merchant`.`merID`))) ;

-- ----------------------------
-- View structure for CreditSubmitDetail
-- ----------------------------
DROP VIEW IF EXISTS `CreditSubmitDetail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `CreditSubmitDetail` AS select `CreditSubmit`.`merID` AS `merID`,`CreditSubmit`.`csID` AS `csID`,`CreditSubmit`.`csStat` AS `csStat`,`CreditSubmit`.`csMoney` AS `csMoney`,`CreditSubmit`.`csCredit` AS `csCredit`,`Merchant`.`merSubID` AS `merSubID`,`Merchant`.`merTopID` AS `merTopID`,`Merchant`.`merType` AS `merType`,`Merchant`.`merName` AS `merName`,`Merchant`.`merCumPresent` AS `merCumPresent`,`Merchant`.`merDicPresent` AS `merDicPresent`,`Merchant`.`merAppStat` AS `merAppStat`,`Merchant`.`merRecommend` AS `merRecommend`,`Merchant`.`isIndex` AS `isIndex`,`Merchant`.`oweCredit` AS `oweCredit`,`MerchantInfo`.`merIntroduce` AS `merIntroduce`,`MerchantInfo`.`merImage` AS `merImage`,`MerchantInfo`.`merMainImage` AS `merMainImage`,`MerchantInfo`.`merAdress` AS `merAdress`,`MerchantInfo`.`merTelphone` AS `merTelphone`,`MerchantInfo`.`merFax` AS `merFax`,`MerchantInfo`.`merURL` AS `merURL`,`MerchantInfo`.`merEmail` AS `merEmail`,`MerchantInfo`.`merPrincipal` AS `merPrincipal`,`MerchantInfo`.`merAppellation` AS `merAppellation`,`MerchantInfo`.`merDuty` AS `merDuty`,`MerchantInfo`.`merPhone` AS `merPhone`,`MerchantInfo`.`merLevel` AS `merLevel`,`MerchantInfo`.`merPostNum` AS `merPostNum`,`MerchantInfo`.`merProvince` AS `merProvince`,`MerchantInfo`.`merCity` AS `merCity`,`MerchantInfo`.`merArea` AS `merArea`,`MerchantInfo`.`merLandmark` AS `merLandmark`,`MerchantInfo`.`merDiscount` AS `merDiscount`,`MerchantInfo`.`merDiscountEvent` AS `merDiscountEvent` from ((`CreditSubmit` join `Merchant` on((`CreditSubmit`.`merID` = `Merchant`.`merID`))) join `MerchantInfo` on((`CreditSubmit`.`merID` = `MerchantInfo`.`merID`))) ;

-- ----------------------------
-- View structure for MemberAndCard
-- ----------------------------
DROP VIEW IF EXISTS `MemberAndCard`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `MemberAndCard` AS select `Member`.`memID` AS `memID`,`Member`.`memCredit` AS `memCredit`,`Member`.`memCer` AS `memCer`,`Member`.`memCerID` AS `memCerID`,`Member`.`memName` AS `memName`,`Member`.`memSex` AS `memSex`,`Member`.`memBirth` AS `memBirth`,`Member`.`memPhone` AS `memPhone`,`Member`.`memAdress` AS `memAdress`,`Member`.`memEmail` AS `memEmail`,`MemberCard`.`mcPKID` AS `mcPKID`,`MemberCard`.`mcID` AS `mcID`,`MemberCard`.`merID` AS `merID`,`MemberCard`.`mcType` AS `mcType`,`MemberCard`.`mcCredit` AS `mcCredit`,`MemberCard`.`mcBalance` AS `mcBalance`,`MemberCard`.`mcEnable` AS `mcEnable` from (`Member` join `MemberCard` on((`Member`.`memID` = `MemberCard`.`memID`))) ;

-- ----------------------------
-- View structure for MembercardDetail
-- ----------------------------
DROP VIEW IF EXISTS `MembercardDetail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `MembercardDetail` AS select `MemberCard`.`merID` AS `merID`,`MemberCard`.`mcPKID` AS `mcPKID`,`MemberCard`.`memID` AS `memID`,`MemberCard`.`mcID` AS `mcID`,`MemberCard`.`mcType` AS `mcType`,`MemberCard`.`mcCredit` AS `mcCredit`,`MemberCard`.`mcBalance` AS `mcBalance`,`MemberCard`.`mcEnable` AS `mcEnable`,`Merchant`.`merType` AS `merType`,`Merchant`.`merName` AS `merName` from (`MemberCard` join `Merchant` on((`MemberCard`.`merID` = `Merchant`.`merID`))) ;

-- ----------------------------
-- View structure for MerchantDetail
-- ----------------------------
DROP VIEW IF EXISTS `MerchantDetail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `MerchantDetail` AS select `Merchant`.`merID` AS `merID`,`Merchant`.`merSubID` AS `merSubID`,`Merchant`.`merTopID` AS `merTopID`,`Merchant`.`merType` AS `merType`,`Merchant`.`merName` AS `merName`,`Merchant`.`merCumPresent` AS `merCumPresent`,`Merchant`.`merDicPresent` AS `merDicPresent`,`Merchant`.`merAppStat` AS `merAppStat`,`Merchant`.`merRecommend` AS `merRecommend`,`Merchant`.`isIndex` AS `isIndex`,`Merchant`.`oweCredit` AS `oweCredit`,`MerchantInfo`.`merIntroduce` AS `merIntroduce`,`MerchantInfo`.`merImage` AS `merImage`,`MerchantInfo`.`merMainImage` AS `merMainImage`,`MerchantInfo`.`merAdress` AS `merAdress`,`MerchantInfo`.`merTelphone` AS `merTelphone`,`MerchantInfo`.`merFax` AS `merFax`,`MerchantInfo`.`merURL` AS `merURL`,`MerchantInfo`.`merEmail` AS `merEmail`,`MerchantInfo`.`merPrincipal` AS `merPrincipal`,`MerchantInfo`.`merAppellation` AS `merAppellation`,`MerchantInfo`.`merDuty` AS `merDuty`,`MerchantInfo`.`merPhone` AS `merPhone`,`MerchantInfo`.`merLevel` AS `merLevel`,`MerchantInfo`.`merPostNum` AS `merPostNum`,`MerchantInfo`.`merProvince` AS `merProvince`,`MerchantInfo`.`merCity` AS `merCity`,`MerchantInfo`.`merArea` AS `merArea`,`MerchantInfo`.`merLandmark` AS `merLandmark`,`MerchantInfo`.`merDiscount` AS `merDiscount`,`MerchantInfo`.`merDiscountEvent` AS `merDiscountEvent` from (`Merchant` join `MerchantInfo` on((`Merchant`.`merID` = `MerchantInfo`.`merID`))) ;

-- ----------------------------
-- View structure for ReissueDetail
-- ----------------------------
DROP VIEW IF EXISTS `ReissueDetail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `ReissueDetail` AS select `Reissue`.`memID` AS `memID`,`Reissue`.`mcPKID` AS `mcPKID`,`Reissue`.`reiID` AS `reiID`,`Reissue`.`reiReason` AS `reiReason`,`Reissue`.`reiTime` AS `reiTime`,`MemberCard`.`mcID` AS `mcID`,`MemberCard`.`merID` AS `merID`,`MemberCard`.`mcType` AS `mcType`,`MemberCard`.`mcCredit` AS `mcCredit`,`MemberCard`.`mcBalance` AS `mcBalance`,`MemberCard`.`mcEnable` AS `mcEnable` from (`Reissue` join `MemberCard` on(((`Reissue`.`memID` = `MemberCard`.`memID`) and (`Reissue`.`mcPKID` = `MemberCard`.`mcPKID`)))) ;
