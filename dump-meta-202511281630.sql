-- MySQL dump 10.13  Distrib 8.1.0, for Win64 (x86_64)
--
-- Host: 10.190.196.98    Database: meta
-- ------------------------------------------------------
-- Server version	5.7.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_BLOB_TRIGGERS`
--

LOCK TABLES `QRTZ_BLOB_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_CALENDARS` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CALENDARS`
--

LOCK TABLES `QRTZ_CALENDARS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CRON_TRIGGERS`
--

LOCK TABLES `QRTZ_CRON_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) NOT NULL COMMENT '状态',
  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_FIRED_TRIGGERS`
--

LOCK TABLES `QRTZ_FIRED_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) NOT NULL COMMENT '任务组名',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_JOB_DETAILS`
--

LOCK TABLES `QRTZ_JOB_DETAILS` WRITE;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_LOCKS` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_LOCKS`
--

LOCK TABLES `QRTZ_LOCKS` WRITE;
/*!40000 ALTER TABLE `QRTZ_LOCKS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_LOCKS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

LOCK TABLES `QRTZ_PAUSED_TRIGGER_GRPS` WRITE;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SCHEDULER_STATE`
--

LOCK TABLES `QRTZ_SCHEDULER_STATE` WRITE;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPLE_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPLE_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPROP_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPROP_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPROP_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_TRIGGERS`
--

LOCK TABLES `QRTZ_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doris_table_structure_detailes`
--

DROP TABLE IF EXISTS `doris_table_structure_detailes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doris_table_structure_detailes` (
  `table_schema` varchar(20) NOT NULL COMMENT '层级',
  `table_name` varchar(100) NOT NULL COMMENT '表名',
  `mes_table_name` varchar(100) NOT NULL COMMENT '表名',
  `mes_column_name` varchar(50) NOT NULL COMMENT 'mes字段名',
  `column_name` varchar(100) NOT NULL COMMENT 'doris字段名',
  `column_type` varchar(50) NOT NULL COMMENT '字段类型',
  `column_comment` varchar(100) NOT NULL COMMENT '字段注释',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_schema`,`table_name`,`mes_table_name`,`mes_column_name`,`column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='doris表字段详情表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doris_table_structure_detailes`
--

LOCK TABLES `doris_table_structure_detailes` WRITE;
/*!40000 ALTER TABLE `doris_table_structure_detailes` DISABLE KEYS */;
/*!40000 ALTER TABLE `doris_table_structure_detailes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_tables_detailes`
--

DROP TABLE IF EXISTS `schema_tables_detailes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_tables_detailes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `site` varchar(20) NOT NULL COMMENT '厂别',
  `data_schema` varchar(100) NOT NULL COMMENT '用户名',
  `model` varchar(50) NOT NULL COMMENT '厂内机种',
  `data_source` varchar(100) NOT NULL COMMENT '数据源',
  `customer_model` varchar(50) NOT NULL COMMENT '客户机种',
  `table_name` varchar(100) NOT NULL COMMENT '表名',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_schema_detail` (`site`,`data_schema`,`model`,`data_source`,`table_name`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COMMENT='schema下包含表信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_tables_detailes`
--

LOCK TABLES `schema_tables_detailes` WRITE;
/*!40000 ALTER TABLE `schema_tables_detailes` DISABLE KEYS */;
INSERT INTO `schema_tables_detailes` VALUES (1,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_DEFECT',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(2,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_DEMOSN_DRI',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(3,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_FUNCTION',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(4,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_FUNCTION_STATION',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(5,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_FUNC_MAP_STATIONTYPE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(6,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_HOLD_REASON',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(7,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_HOLD_REASON_HT',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(8,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_LABEL_TYPE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(9,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_LINE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(10,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_MES_ERROR_CODE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(11,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_PK_OFFLINE_BASEDATA_SORTING',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(12,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_PRINT_DATA',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(13,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_ROUTE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(14,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_STAGE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(15,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_STATION',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(16,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_STATIONTYPE_LABEL',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(17,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_STATIONTYPE_LABEL_PARAMS',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(18,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_STATION_CLIENT',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(19,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_STATION_TYPE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(20,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','M_WO_BASE_SAP',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(21,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_MES_ERROR_LOG',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(22,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_MOH_HOLD_RULE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(23,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_MOH_HOLD_RULE_HT',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(24,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_PAMI5_SN_REJUDGE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(25,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_PAM_RIM_INPUT_REJUDGE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(26,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_QC_SN',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(27,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_RACKIO_STATUS_HT',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(28,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_SN_BLACK_LIST',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(29,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_SN_CT_SCAN',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(30,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_SN_KEYPARTS_SKD_HT',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(31,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_SN_SBUILD_UNIT',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(32,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_SN_STATUS',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(33,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_SN_TEST_TRAVEL',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(34,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_SN_TRAVEL',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(35,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','P_WO_BASE',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(36,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','S_FILEINFO',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(37,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','S_PROGRAM_FUN_NAME',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL),(38,'LXKS','LZKS_IMES_LZFP1PD','JADE','DW_LXKS_ORACLE.LZKS_IMES_LZFP1PD','B589','T_SKD_NAPASS_SEND_FOX_STATUS',NULL,'2025-03-20 20:31:43',NULL,NULL,NULL);
/*!40000 ALTER TABLE `schema_tables_detailes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2025-03-18 18:54:27','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2025-03-18 18:54:27','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2025-03-18 18:54:27','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','false','Y','admin','2025-03-18 18:54:27','admin','2025-06-02 08:27:53','是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2025-03-18 18:54:28','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2025-03-18 18:54:28','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','若依科技',0,'若依','15888888888','ry@qq.com','0','0','admin','2025-03-18 18:54:11','',NULL),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-03-18 18:54:12','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2025-03-18 18:54:12','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-03-18 18:54:12','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2025-03-18 18:54:12','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2025-03-18 18:54:12','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2025-03-18 18:54:12','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2025-03-18 18:54:12','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-03-18 18:54:12','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2025-03-18 18:54:12','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2025-03-18 18:54:25','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2025-03-18 18:54:25','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2025-03-18 18:54:26','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2025-03-18 18:54:26','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2025-03-18 18:54:26','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2025-03-18 18:54:26','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2025-03-18 18:54:26','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2025-03-18 18:54:26','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2025-03-18 18:54:26','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2025-03-18 18:54:26','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2025-03-18 18:54:26','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2025-03-18 18:54:26','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2025-03-18 18:54:26','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2025-03-18 18:54:26','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2025-03-18 18:54:26','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2025-03-18 18:54:26','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2025-03-18 18:54:26','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2025-03-18 18:54:26','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2025-03-18 18:54:26','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2025-03-18 18:54:27','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2025-03-18 18:54:27','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2025-03-18 18:54:27','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2025-03-18 18:54:27','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2025-03-18 18:54:27','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2025-03-18 18:54:27','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2025-03-18 18:54:27','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2025-03-18 18:54:27','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2025-03-18 18:54:27','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2025-03-18 18:54:27','',NULL,'停用状态');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2025-03-18 18:54:25','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2025-03-18 18:54:25','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2025-03-18 18:54:25','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2025-03-18 18:54:25','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2025-03-18 18:54:25','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2025-03-18 18:54:25','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2025-03-18 18:54:25','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2025-03-18 18:54:25','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2025-03-18 18:54:25','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2025-03-18 18:54:25','',NULL,'登录状态列表');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2025-03-18 18:54:28','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2025-03-18 18:54:28','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2025-03-18 18:54:28','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=816 DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-03-18 19:19:13'),(101,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-03-18 20:02:49'),(102,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-03-18 20:03:09'),(103,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-03-18 20:04:42'),(104,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-03-18 20:05:56'),(105,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-03-19 08:11:55'),(106,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-12 15:15:43'),(107,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-12 15:16:42'),(108,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-13 14:08:41'),(109,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-13 16:25:20'),(110,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-13 18:42:12'),(111,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-19 22:18:53'),(112,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-19 22:44:37'),(113,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-19 22:44:41'),(114,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-20 16:03:49'),(115,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-20 17:05:43'),(116,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-21 08:00:55'),(117,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-21 14:20:01'),(118,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-21 16:54:05'),(119,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-22 08:02:09'),(120,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-22 16:37:04'),(121,'admin','127.0.0.1','内网IP','Unknown','Unknown','1','验证码已失效','2025-04-24 09:10:40'),(122,'admin','127.0.0.1','内网IP','Unknown','Unknown','1','验证码已失效','2025-04-24 09:10:48'),(123,'admin','127.0.0.1','内网IP','Unknown','Unknown','1','验证码已失效','2025-04-24 09:17:45'),(124,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-24 11:37:44'),(125,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-24 13:15:28'),(126,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:36:06'),(127,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:42:39'),(128,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:42:52'),(129,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:43:35'),(130,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:43:40'),(131,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:44:50'),(132,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:44:58'),(133,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:45:18'),(134,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:45:21'),(135,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:46:44'),(136,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:46:53'),(137,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:47:03'),(138,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:47:08'),(139,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:48:11'),(140,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:48:16'),(141,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:48:26'),(142,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:48:31'),(143,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:50:47'),(144,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:50:53'),(145,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:51:10'),(146,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:51:14'),(147,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:52:09'),(148,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-25 14:52:14'),(149,'meta','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-25 14:52:24'),(150,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-25 14:52:35'),(151,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-25 14:52:43'),(152,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-25 14:53:44'),(153,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-25 14:53:54'),(154,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码错误','2025-04-25 14:54:09'),(155,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-25 14:54:12'),(156,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-04-25 14:54:28'),(157,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-04-25 14:54:36'),(158,'ruoyi','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-25 14:56:06'),(159,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-04-25 14:56:16'),(160,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码已失效','2025-04-25 14:59:31'),(161,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-04-25 14:59:36'),(162,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-26 14:52:07'),(163,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-26 17:08:30'),(164,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-27 13:37:35'),(165,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-27 13:37:42'),(166,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-27 13:37:59'),(167,'ruoyi','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-27 13:39:58'),(168,'ruoyi','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-04-27 13:40:07'),(169,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-27 13:41:05'),(170,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-27 13:44:02'),(171,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-27 13:44:12'),(172,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-09 19:10:40'),(173,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-09 19:38:16'),(174,'admin','127.0.0.1','内网IP','Firefox 13','Windows 10','0','登录成功','2025-05-09 19:46:27'),(175,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-11 19:52:42'),(176,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-12 10:00:50'),(177,'admin','127.0.0.1','内网IP','Firefox 13','Windows 10','0','登录成功','2025-05-12 10:57:13'),(178,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-12 11:01:18'),(179,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-12 13:09:55'),(180,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-12 13:28:19'),(181,'admin','127.0.0.1','内网IP','Firefox 13','Windows 10','0','登录成功','2025-05-12 13:29:35'),(182,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-12 14:12:47'),(183,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-12 14:25:04'),(184,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-12 17:02:32'),(185,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-13 10:27:27'),(186,'admin','10.69.32.173','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-05-13 11:02:44'),(187,'75331378','10.69.32.173','内网IP','Chrome 13','Windows 10','1','验证码错误','2025-05-13 11:02:51'),(188,'75331378','10.69.32.173','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-05-13 11:02:55'),(189,'75331378','10.69.32.173','内网IP','Chrome 13','Windows 10','1','验证码错误','2025-05-13 11:03:00'),(190,'75331378','10.69.32.173','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-05-13 11:03:04'),(191,'admin','10.69.32.173','内网IP','Chrome 13','Windows 10','1','验证码错误','2025-05-13 11:03:37'),(192,'admin','10.69.32.173','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-05-13 11:03:51'),(193,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-05-13 11:05:44'),(194,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-05-13 11:05:57'),(195,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码错误','2025-05-13 11:06:06'),(196,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-05-13 11:06:10'),(197,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-13 11:10:17'),(198,'admin','10.69.32.173','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-13 11:10:44'),(199,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-13 11:23:14'),(200,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-05-13 11:23:29'),(201,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码已失效','2025-05-13 11:30:54'),(202,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-13 11:30:57'),(203,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-05-13 11:45:31'),(204,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码已失效','2025-05-13 11:48:34'),(205,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-13 11:48:39'),(206,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-13 13:34:37'),(207,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-13 19:59:54'),(208,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-14 08:36:24'),(209,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-14 09:49:08'),(210,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-15 11:28:16'),(211,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-24 15:02:53'),(212,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-24 19:38:32'),(213,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-24 21:25:11'),(214,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-26 13:22:16'),(215,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-26 14:16:11'),(216,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-26 14:57:23'),(217,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-26 16:21:23'),(218,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-26 16:57:29'),(219,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-27 08:22:11'),(220,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-28 16:22:40'),(221,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-29 09:13:46'),(222,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-29 09:20:00'),(223,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-29 09:46:53'),(224,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-29 09:53:01'),(225,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码错误','2025-05-29 14:06:14'),(226,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-29 14:06:18'),(227,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-29 15:00:42'),(228,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-29 15:38:07'),(229,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-29 16:03:07'),(230,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-06-02 08:13:49'),(231,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-06-02 08:24:40'),(232,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-06-02 08:26:49'),(233,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-06-02 08:26:54'),(234,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-06-02 08:28:04'),(235,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-06-02 08:28:12'),(236,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-06-04 09:04:52'),(237,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码错误','2025-06-04 10:23:02'),(238,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-06-04 10:23:06'),(239,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-06-06 15:18:28'),(240,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-06-21 14:39:11'),(241,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-07-03 08:41:46'),(242,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-08-02 14:01:21'),(243,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-08-11 16:48:49'),(244,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-08-13 13:10:53'),(245,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-08-13 13:35:53'),(246,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-08-13 13:59:57'),(247,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-08-13 14:33:29'),(248,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-08-13 14:44:17'),(249,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-08-13 15:07:03'),(250,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-09-08 18:14:18'),(251,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-09-09 19:29:42'),(252,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-09-12 11:24:28'),(253,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-16 10:55:59'),(254,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-10 08:04:55'),(255,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-10 15:23:48'),(256,'admin','127.0.0.1','内网IP','Firefox 14','Windows 10','0','登录成功','2025-11-10 15:34:05'),(257,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-10 18:20:49'),(258,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 11:25:39'),(259,'admin','10.69.32.51','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-11 13:17:40'),(260,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 13:18:44'),(261,'admin','10.69.32.51','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 13:19:09'),(262,'admin','10.69.32.51','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-11 14:57:04'),(263,'admin','10.69.32.51','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 14:57:18'),(264,'admin','10.69.32.51','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 15:59:09'),(265,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 16:43:38'),(266,'admin','10.69.32.51','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 18:13:11'),(267,'admin','10.69.32.51','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-11 18:17:14'),(268,'admin','10.69.32.51','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 18:30:16'),(269,'admin','10.69.32.51','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 19:34:42'),(270,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 08:12:08'),(271,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 08:16:33'),(272,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-12 08:40:04'),(273,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 08:40:14'),(274,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-12 08:40:25'),(275,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 08:40:27'),(276,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-12 08:41:56'),(277,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 08:42:07'),(278,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-12 08:42:41'),(279,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 08:42:44'),(280,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-12 08:43:11'),(281,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 08:45:57'),(282,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 11:12:43'),(283,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 11:16:34'),(284,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-12 11:26:05'),(285,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 11:26:21'),(286,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-12 11:47:02'),(287,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-12 11:47:04'),(288,'admin','127.0.0.1','内网IP','Safari','Mac OS X','0','登录成功','2025-11-12 11:47:06'),(289,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 11:47:28'),(290,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-12 11:47:41'),(291,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 11:47:48'),(292,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 11:52:59'),(293,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 11:53:05'),(294,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-12 11:54:49'),(295,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 13:01:17'),(296,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 13:01:49'),(297,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-12 13:02:03'),(298,'admin','127.0.0.1','内网IP','Safari','Mac OS X','0','登录成功','2025-11-12 13:06:05'),(299,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 13:35:01'),(300,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-12 13:36:29'),(301,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 13:36:37'),(302,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 13:36:43'),(303,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 13:36:50'),(304,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-12 13:39:50'),(305,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 13:39:54'),(306,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 13:40:25'),(307,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 14:11:14'),(308,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 14:11:27'),(309,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 14:11:40'),(310,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 14:11:53'),(311,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 14:22:00'),(312,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 14:22:12'),(313,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 15:06:04'),(314,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 15:06:11'),(315,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 15:12:55'),(316,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 15:14:20'),(317,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 15:14:22'),(318,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 15:14:36'),(319,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 16:03:15'),(320,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 16:03:24'),(321,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 16:06:05'),(322,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 16:06:24'),(323,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 16:13:09'),(324,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-12 16:48:49'),(325,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-12 16:49:35'),(326,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-12 16:49:40'),(327,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-12 16:52:07'),(328,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-12 16:52:07'),(329,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-12 16:52:10'),(330,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-12 16:52:13'),(331,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-12 16:52:20'),(332,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-12 16:52:32'),(333,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:52:39'),(334,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 16:52:45'),(335,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:52:54'),(336,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-12 16:52:55'),(337,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:52:59'),(338,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:00'),(339,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:01'),(340,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:01'),(341,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:01'),(342,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:01'),(343,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:01'),(344,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:02'),(345,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:02'),(346,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:03'),(347,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:03'),(348,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:03'),(349,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:04'),(350,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:04'),(351,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:04'),(352,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:05'),(353,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:05'),(354,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:05'),(355,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:05'),(356,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:06'),(357,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:06'),(358,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:06'),(359,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:06'),(360,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:07'),(361,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:07'),(362,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:07'),(363,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:07'),(364,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:08'),(365,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:08'),(366,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:09'),(367,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:09'),(368,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:09'),(369,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:09'),(370,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:10'),(371,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:11'),(372,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:11'),(373,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:12'),(374,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:12'),(375,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:12'),(376,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:13'),(377,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:13'),(378,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:14'),(379,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:14'),(380,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:14'),(381,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:14'),(382,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:15'),(383,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:15'),(384,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:15'),(385,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:15'),(386,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:16'),(387,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:23'),(388,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:27'),(389,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:27'),(390,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:27'),(391,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:28'),(392,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:28'),(393,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:28'),(394,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:29'),(395,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:29'),(396,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:29'),(397,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:29'),(398,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:29'),(399,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:30'),(400,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:30'),(401,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:30'),(402,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:30'),(403,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:30'),(404,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:31'),(405,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:31'),(406,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:31'),(407,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:31'),(408,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:32'),(409,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:32'),(410,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:32'),(411,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:32'),(412,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:33'),(413,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:33'),(414,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:33'),(415,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:33'),(416,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:34'),(417,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:34'),(418,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:34'),(419,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:35'),(420,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:35'),(421,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:35'),(422,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:35'),(423,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:35'),(424,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:36'),(425,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:36'),(426,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:36'),(427,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:36'),(428,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:37'),(429,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:37'),(430,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:53:38'),(431,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:56:25'),(432,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 16:56:43'),(433,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-12 17:00:49'),(434,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 17:05:25'),(435,'admin','127.0.0.1','内网IP','Safari','Mac OS X','1','用户不存在/密码错误','2025-11-13 07:52:46'),(436,'Bigdata','127.0.0.1','内网IP','Safari','Mac OS X','0','登录成功','2025-11-13 07:53:22'),(437,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 08:01:35'),(438,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-13 08:02:13'),(439,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-13 08:02:50'),(440,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-13 08:03:52'),(441,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-13 08:03:54'),(442,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-13 08:03:57'),(443,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-13 08:04:00'),(444,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-13 08:06:21'),(445,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 08:11:45'),(446,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-13 08:11:51'),(447,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 08:12:34'),(448,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-13 08:13:46'),(449,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 08:17:39'),(450,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 08:17:41'),(451,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-13 08:17:53'),(452,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 09:41:25'),(453,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 09:41:28'),(454,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-13 09:41:33'),(455,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 10:41:41'),(456,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 10:41:45'),(457,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-13 10:42:09'),(458,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-13 10:43:34'),(459,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-13 11:41:39'),(460,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-13 13:19:59'),(461,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 13:35:04'),(462,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-13 14:07:43'),(463,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-13 14:48:55'),(464,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-13 14:59:28'),(465,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-13 15:58:58'),(466,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-13 16:51:05'),(467,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-13 16:51:12'),(468,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-13 18:24:15'),(469,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-13 18:24:48'),(470,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-14 08:01:43'),(471,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-14 08:01:44'),(472,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-14 08:03:15'),(473,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-14 08:03:37'),(474,'bigadata','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-14 08:03:41'),(475,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-14 08:04:13'),(476,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 08:10:54'),(477,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 08:15:14'),(478,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-14 08:38:03'),(479,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 08:38:17'),(480,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 08:38:25'),(481,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-14 08:41:14'),(482,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 08:46:50'),(483,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-14 09:06:33'),(484,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-14 09:06:44'),(485,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 09:59:51'),(486,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-14 10:01:30'),(487,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 10:01:36'),(488,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 10:06:21'),(489,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-14 10:44:37'),(490,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 10:47:56'),(491,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-14 11:24:58'),(492,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 13:05:38'),(493,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 14:02:19'),(494,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 14:37:17'),(495,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 14:59:03'),(496,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-14 15:19:50'),(497,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-14 15:24:34'),(498,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 15:24:39'),(499,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 15:43:57'),(500,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 16:03:02'),(501,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-14 16:04:02'),(502,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-14 16:11:14'),(503,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-14 16:11:34'),(504,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-11-14 16:31:15'),(505,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 16:31:18'),(506,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-14 16:31:19'),(507,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-14 16:32:28'),(508,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-14 16:32:31'),(509,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-14 16:32:42'),(510,'big_data','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-14 16:32:54'),(511,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-14 16:33:08'),(512,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-11-14 16:33:09'),(513,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-14 16:33:13'),(514,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 16:33:32'),(515,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-14 16:35:41'),(516,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-14 16:35:47'),(517,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-14 16:36:51'),(518,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 16:57:15'),(519,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 16:59:13'),(520,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 17:05:29'),(521,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-14 18:50:23'),(522,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-15 09:58:08'),(523,'bigdata','127.0.0.1','内网IP','Chrome 10','Windows 10','0','登录成功','2025-11-15 10:29:50'),(524,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-15 13:59:52'),(525,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-17 08:01:34'),(526,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-17 08:01:50'),(527,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 08:04:30'),(528,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 08:04:38'),(529,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 08:04:39'),(530,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 08:04:40'),(531,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-17 08:05:36'),(532,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-17 08:06:43'),(533,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 08:06:59'),(534,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 08:11:20'),(535,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 08:17:53'),(536,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 08:19:51'),(537,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 08:43:27'),(538,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 08:43:34'),(539,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-17 09:09:24'),(540,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 09:43:51'),(541,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 09:46:45'),(542,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 10:10:25'),(543,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 10:15:45'),(544,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 11:54:34'),(545,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 11:54:42'),(546,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 11:55:59'),(547,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 13:01:09'),(548,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 13:03:18'),(549,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 13:03:23'),(550,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 13:03:29'),(551,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 13:18:37'),(552,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 13:22:49'),(553,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 13:54:15'),(554,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 14:01:19'),(555,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 15:01:12'),(556,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-17 16:19:28'),(557,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 16:19:34'),(558,'admin','127.0.0.1','内网IP','Safari','Mac OS X','1','用户不存在/密码错误','2025-11-17 16:21:02'),(559,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-17 16:21:29'),(560,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 16:22:18'),(561,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-17 16:24:20'),(562,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 16:25:58'),(563,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-17 16:29:19'),(564,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 16:29:35'),(565,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 16:30:20'),(566,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 16:30:28'),(567,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-17 16:31:49'),(568,'76247306','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 16:32:00'),(569,'76247306','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 16:32:15'),(570,'admn','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 16:32:24'),(571,'admn','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-17 16:32:26'),(572,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 16:32:35'),(573,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 16:33:44'),(574,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-17 16:39:30'),(575,'75254142','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-17 16:39:41'),(576,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-11-17 16:41:40'),(577,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 16:42:07'),(578,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 18:52:33'),(579,'bigdata','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-18 08:02:17'),(580,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 08:02:46'),(581,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-18 08:08:58'),(582,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 08:18:11'),(583,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-18 08:18:18'),(584,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 08:18:47'),(585,'75254142','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 08:20:42'),(586,'75254142','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-18 08:20:46'),(587,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 08:20:51'),(588,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 08:27:32'),(589,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 09:40:01'),(590,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 10:37:02'),(591,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 10:46:58'),(592,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 11:06:58'),(593,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 11:28:47'),(594,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 13:05:34'),(595,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 13:14:28'),(596,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 13:53:23'),(597,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 14:23:00'),(598,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 14:51:30'),(599,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-18 15:00:42'),(600,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 15:00:49'),(601,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 15:16:42'),(602,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 15:20:12'),(603,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 15:28:46'),(604,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 15:33:43'),(605,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 15:53:11'),(606,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 16:06:38'),(607,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-18 16:40:43'),(608,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-18 16:40:55'),(609,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 16:44:07'),(610,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 16:46:36'),(611,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-18 16:50:24'),(612,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 08:19:13'),(613,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 09:05:06'),(614,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 09:07:38'),(615,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 09:13:43'),(616,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 09:23:13'),(617,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 10:05:31'),(618,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 11:32:39'),(619,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 11:45:01'),(620,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 13:01:05'),(621,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 13:04:35'),(622,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 13:07:21'),(623,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 13:09:43'),(624,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 13:40:25'),(625,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 14:26:56'),(626,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 14:26:59'),(627,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 15:03:34'),(628,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 15:15:23'),(629,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 15:46:19'),(630,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-19 15:52:13'),(631,'76247314','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-19 15:53:21'),(632,'76247314','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-19 15:53:47'),(633,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-19 16:17:42'),(634,'75218087','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-19 16:18:10'),(635,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 16:31:10'),(636,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-19 16:48:25'),(637,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-19 16:48:41'),(638,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 16:48:55'),(639,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 17:00:32'),(640,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 17:32:21'),(641,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 18:14:36'),(642,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-19 18:38:12'),(643,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-19 18:43:09'),(644,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-19 18:43:27'),(645,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-19 18:43:34'),(646,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-19 18:43:49'),(647,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-19 18:43:54'),(648,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-19 18:43:57'),(649,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-19 18:44:02'),(650,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-19 18:44:05'),(651,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 18:44:44'),(652,'bigdata','127.0.0.1','内网IP','Chrome 13','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-19 18:45:12'),(653,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 18:46:56'),(654,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-20 08:01:43'),(655,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-20 08:19:54'),(656,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-20 08:21:52'),(657,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-20 08:25:17'),(658,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-20 08:31:42'),(659,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-20 08:32:07'),(660,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-20 08:36:59'),(661,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-20 09:30:15'),(662,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-20 10:24:31'),(663,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-20 13:10:54'),(664,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-20 14:04:16'),(665,'76247314','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-20 14:44:06'),(666,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-20 15:13:13'),(667,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-20 15:28:57'),(668,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-20 16:42:49'),(669,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-20 18:59:28'),(670,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 07:47:45'),(671,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 08:01:20'),(672,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 08:01:25'),(673,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-21 08:17:55'),(674,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 08:18:14'),(675,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 08:37:32'),(676,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-21 08:50:23'),(677,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-21 08:50:35'),(678,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-21 08:50:43'),(679,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-21 08:50:54'),(680,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-21 09:56:55'),(681,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-21 10:15:16'),(682,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 10:15:20'),(683,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 11:04:11'),(684,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-21 11:19:14'),(685,'admin','10.69.32.113','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-21 13:15:13'),(686,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-21 13:26:23'),(687,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-21 13:38:58'),(688,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-21 13:39:23'),(689,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-21 13:45:34'),(690,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-21 13:57:17'),(691,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 14:05:38'),(692,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-21 14:18:30'),(693,'76247314','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-21 14:20:27'),(694,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 15:37:23'),(695,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 16:05:23'),(696,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 16:12:52'),(697,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-21 18:40:24'),(698,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-22 08:23:36'),(699,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-22 08:53:55'),(700,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-22 09:01:07'),(701,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-22 11:16:02'),(702,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-22 13:14:37'),(703,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-22 14:04:54'),(704,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-22 14:17:20'),(705,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-22 15:45:13'),(706,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-22 16:55:10'),(707,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-22 17:47:43'),(708,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-24 08:00:44'),(709,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-24 08:06:35'),(710,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-24 08:06:47'),(711,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-24 08:25:07'),(712,'75218087','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-24 08:25:39'),(713,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-24 09:42:51'),(714,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-24 10:31:46'),(715,'bigdata','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-24 10:32:03'),(716,'76247314','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-24 10:32:14'),(717,'76247314','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-24 10:32:24'),(718,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-24 11:46:40'),(719,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-24 12:37:46'),(720,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-24 13:06:11'),(721,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-24 13:46:19'),(722,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-24 13:57:30'),(723,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-24 15:00:53'),(724,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-24 16:21:46'),(725,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-24 16:41:46'),(726,'76247314','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-25 08:06:44'),(727,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 08:17:27'),(728,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 08:35:23'),(729,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-25 08:40:20'),(730,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-25 08:40:34'),(731,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-25 08:53:42'),(732,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-25 08:54:32'),(733,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-25 08:54:58'),(734,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-25 08:55:09'),(735,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2025-11-25 08:55:22'),(736,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-25 08:55:32'),(737,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','密码输入错误5次，帐户锁定10分钟','2025-11-25 08:56:05'),(738,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 09:05:33'),(739,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 10:19:34'),(740,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 10:44:38'),(741,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 13:01:21'),(742,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 13:57:03'),(743,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 14:04:59'),(744,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 14:14:43'),(745,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 14:19:36'),(746,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-25 15:14:58'),(747,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-25 16:18:24'),(748,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-26 08:02:40'),(749,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 08:04:18'),(750,'76247314','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-26 08:06:52'),(751,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 08:10:38'),(752,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-26 08:12:02'),(753,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 08:13:20'),(754,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 08:52:06'),(755,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 09:16:26'),(756,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 09:35:42'),(757,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 10:41:17'),(758,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 10:48:00'),(759,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 11:40:45'),(760,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 13:03:29'),(761,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 13:19:53'),(762,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 13:49:05'),(763,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 14:49:13'),(764,'75254142','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 14:58:59'),(765,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 16:38:53'),(766,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 16:41:28'),(767,'75165382','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-26 18:59:16'),(768,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-27 08:05:38'),(769,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-27 08:11:07'),(770,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-27 08:32:53'),(771,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-27 08:38:42'),(772,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-27 08:38:44'),(773,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-11-27 08:38:47'),(774,'75307950','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-27 08:38:51'),(775,'admin','127.0.0.1','内网IP','Chrome 14','Mac OS X','1','用户不存在/密码错误','2025-11-27 08:45:55'),(776,'12205995','127.0.0.1','内网IP','Chrome 14','Mac OS X','0','登录成功','2025-11-27 08:46:03'),(777,'admin','127.0.0.1','内网IP','Chrome 10','Windows 10','1','用户不存在/密码错误','2025-11-27 08:46:29'),(778,'12205995','127.0.0.1','内网IP','Chrome 10','Windows 10','0','登录成功','2025-11-27 08:46:39'),(779,'12205995','127.0.0.1','内网IP','Chrome 10','Windows 10','0','登录成功','2025-11-27 08:52:40'),(780,'12205995','127.0.0.1','内网IP','Chrome 10','Windows 10','0','退出成功','2025-11-27 08:53:11'),(781,'75307950','127.0.0.1','内网IP','Chrome 10','Windows 10','0','登录成功','2025-11-27 08:53:20'),(782,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-27 08:59:53'),(783,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-27 09:10:27'),(784,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-27 10:08:52'),(785,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-11-27 10:15:33'),(786,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-27 10:16:23'),(787,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-27 11:09:35'),(788,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-27 11:15:37'),(789,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-27 13:07:17'),(790,'admin','127.0.0.1','内网IP','Chrome 10','Windows 10','1','用户不存在/密码错误','2025-11-27 13:51:58'),(791,'75307950','127.0.0.1','内网IP','Chrome 10','Windows 10','0','登录成功','2025-11-27 13:52:01'),(792,'76247314','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-27 15:13:57'),(793,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-27 15:34:45'),(794,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-27 15:44:41'),(795,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-27 16:31:25'),(796,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-27 16:37:43'),(797,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-27 18:48:34'),(798,'75307950','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-28 08:03:30'),(799,'76247314','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-11-28 08:03:32'),(800,'75307950','127.0.0.1','内网IP','Chrome 10','Windows 10','0','登录成功','2025-11-28 08:03:37'),(801,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-28 08:10:15'),(802,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-28 08:11:31'),(803,'12205995','127.0.0.1','内网IP','Chrome 14','Mac OS X','0','登录成功','2025-11-28 08:13:24'),(804,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-28 08:18:22'),(805,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-28 08:25:00'),(806,'75355304','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-28 08:26:17'),(807,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2025-11-28 08:26:39'),(808,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-28 08:32:06'),(809,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-28 10:12:56'),(810,'75307950','127.0.0.1','内网IP','Chrome 10','Windows 10','0','登录成功','2025-11-28 10:37:26'),(811,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-28 14:16:36'),(812,'76247306','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-28 14:56:10'),(813,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-28 15:33:41'),(814,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-11-28 15:51:33'),(815,'75307950','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-28 15:53:55');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) DEFAULT '' COMMENT '路由名称',
  `is_frame` int(1) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2014 DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2025-03-18 18:54:13','',NULL,'系统管理目录'),(2,'系统监控',0,2,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2025-03-18 18:54:13','',NULL,'系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2025-03-18 18:54:13','',NULL,'系统工具目录'),(4,'若依官网',0,4,'http://ruoyi.vip',NULL,'','',0,0,'M','0','0','','guide','admin','2025-03-18 18:54:13','',NULL,'若依官网地址'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2025-03-18 18:54:13','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2025-03-18 18:54:13','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2025-03-18 18:54:13','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2025-03-18 18:54:14','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2025-03-18 18:54:14','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2025-03-18 18:54:14','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2025-03-18 18:54:14','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2025-03-18 18:54:14','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2025-03-18 18:54:14','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2025-03-18 18:54:14','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2025-03-18 18:54:14','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2025-03-18 18:54:14','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2025-03-18 18:54:14','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2025-03-18 18:54:14','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2025-03-18 18:54:14','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2025-03-18 18:54:14','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2025-03-18 18:54:14','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2025-03-18 18:54:14','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2025-03-18 18:54:14','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2025-03-18 18:54:14','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2025-03-18 18:54:15','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2025-03-18 18:54:15','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2025-03-18 18:54:15','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2025-03-18 18:54:15','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2025-03-18 18:54:15','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2025-03-18 18:54:15','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2025-03-18 18:54:15','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2025-03-18 18:54:15','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2025-03-18 18:54:15','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2025-03-18 18:54:15','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2025-03-18 18:54:15','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2025-03-18 18:54:15','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2025-03-18 18:54:15','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2025-03-18 18:54:15','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2025-03-18 18:54:15','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2025-03-18 18:54:15','',NULL,''),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2025-03-18 18:54:15','',NULL,''),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2025-03-18 18:54:16','',NULL,''),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2025-03-18 18:54:16','',NULL,''),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2025-03-18 18:54:16','',NULL,''),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2025-03-18 18:54:16','',NULL,''),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2025-03-18 18:54:16','',NULL,''),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2025-03-18 18:54:16','',NULL,''),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2025-03-18 18:54:16','',NULL,''),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2025-03-18 18:54:16','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2025-03-18 18:54:16','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2025-03-18 18:54:16','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2025-03-18 18:54:16','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2025-03-18 18:54:16','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2025-03-18 18:54:16','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2025-03-18 18:54:16','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2025-03-18 18:54:16','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2025-03-18 18:54:16','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2025-03-18 18:54:16','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2025-03-18 18:54:17','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2025-03-18 18:54:17','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2025-03-18 18:54:17','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2025-03-18 18:54:17','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2025-03-18 18:54:17','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2025-03-18 18:54:17','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2025-03-18 18:54:17','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2025-03-18 18:54:17','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2025-03-18 18:54:17','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2025-03-18 18:54:17','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2025-03-18 18:54:17','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2025-03-18 18:54:17','',NULL,''),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2025-03-18 18:54:17','',NULL,''),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2025-03-18 18:54:17','',NULL,''),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2025-03-18 18:54:17','',NULL,''),(1049,'任务查询',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2025-03-18 18:54:18','',NULL,''),(1050,'任务新增',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2025-03-18 18:54:18','',NULL,''),(1051,'任务修改',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2025-03-18 18:54:18','',NULL,''),(1052,'任务删除',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2025-03-18 18:54:18','',NULL,''),(1053,'状态修改',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2025-03-18 18:54:18','',NULL,''),(1054,'任务导出',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2025-03-18 18:54:18','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2025-03-18 18:54:18','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2025-03-18 18:54:18','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2025-03-18 18:54:18','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2025-03-18 18:54:18','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2025-03-18 18:54:18','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2025-03-18 18:54:18','',NULL,''),(2000,'数据治理',0,1,'datagrovernance',NULL,NULL,'',1,0,'M','0','0',NULL,'date','admin','2025-04-13 14:10:20','',NULL,''),(2001,'测试',2000,4,'test','governance/test/index',NULL,'',1,0,'C','0','0','grovernance:test:index','example','admin','2025-04-13 14:19:50','admin','2025-05-12 14:14:04',''),(2002,'DSN表查询',2000,2,'dsnTable','dataGovernance/dataGovernance/index',NULL,'',1,0,'C','0','0','dataGovernance:dataGovernance:index','table','admin','2025-04-13 17:05:12','admin','2025-05-12 14:14:14',''),(2004,'Doris查询',2000,3,'doris','governance/doris/index',NULL,'',1,0,'C','0','0','governance:doris:index','list','admin','2025-05-11 19:58:35','admin','2025-05-12 14:14:21',''),(2005,'Doris元数据',2000,1,'doristable','governance/doristable/index',NULL,'',1,0,'C','0','0','governance:doristable:index','search','admin','2025-05-12 10:06:43','admin','2025-05-12 14:13:42',''),(2006,'文档查询',0,2,'filemanagement',NULL,NULL,'',1,0,'M','0','0','','zip','admin','2025-05-24 19:44:22','admin','2025-05-24 19:51:36',''),(2007,'业务文档',2006,1,'file','filemanagement/businessfile/index',NULL,'',1,0,'C','0','0','filemanagement:businessfile:index','excel','admin','2025-05-24 19:53:38','',NULL,''),(2008,'文档上传',2006,2,'filemanagement','filemanagement/uploadfile/index',NULL,'',1,0,'C','0','0','filemanagement:uploadfile:index','upload','admin','2025-05-24 20:06:45','',NULL,''),(2009,'数据底座',0,2,'hdsp',NULL,NULL,'',1,0,'M','0','0','','redis-list','admin','2025-11-11 13:21:24','admin','2025-11-11 13:31:27',''),(2010,'任务告警',2009,1,'taskAlarm','dataMonitor/taskAlarm/index',NULL,'',1,0,'C','0','0','','server','admin','2025-11-11 13:31:15','admin','2025-11-11 13:42:17',''),(2011,'DB监控',0,2,'doris',NULL,NULL,'',1,0,'M','0','0',NULL,'druid','admin','2025-11-13 16:52:23','',NULL,''),(2012,'doris表空间监控',2011,1,'dorisGrowth','dataMonitor/dorisGrowth/index',NULL,'',1,0,'C','0','0',NULL,'druid','admin','2025-11-13 16:53:38','',NULL,''),(2013,'doris慢sql监控',2011,2,'dorisSql','dataMonitor/dorisSql/index','','',1,0,'C','0','0','','druid','admin','2025-11-21 09:01:54','admin','2025-11-21 09:02:22','');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2025-03-18 18:54:28','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2025-03-18 18:54:28','',NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"date\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"数据治理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"datagrovernance\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 14:10:20',64),(101,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"grovernance/test/index\",\"createBy\":\"admin\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"测试\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"test\",\"perms\":\"grovernance:test:index\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 14:19:50',49),(102,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"governance/test/index\",\"createTime\":\"2025-04-13 14:19:50\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"测试\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"test\",\"perms\":\"grovernance:test:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 14:21:06',27),(103,'代码生成',6,'com.MetaApp.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"schema_tables_detailes\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 16:50:22',335),(104,'代码生成',2,'com.MetaApp.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"detailes\",\"className\":\"SchemaTablesDetailes\",\"columns\":[{\"capJavaField\":\"Site\",\"columnComment\":\"厂别\",\"columnId\":1,\"columnName\":\"site\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"site\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DataSchema\",\"columnComment\":\"用户名\",\"columnId\":2,\"columnName\":\"data_schema\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"dataSchema\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Model\",\"columnComment\":\"厂内机种\",\"columnId\":3,\"columnName\":\"model\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"model\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DataSource\",\"columnComment\":\"数据源\",\"columnId\":4,\"columnName\":\"data_source\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"dataSource\",\"javaType\":\"Stri','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 16:53:01',1468),(105,'代码生成',8,'com.MetaApp.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"schema_tables_detailes\"}',NULL,0,NULL,'2025-04-13 16:53:04',197),(106,'代码生成',2,'com.MetaApp.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"datagovernance\",\"className\":\"SchemaTablesDetailes\",\"columns\":[{\"capJavaField\":\"Site\",\"columnComment\":\"厂别\",\"columnId\":1,\"columnName\":\"site\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"site\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-13 16:53:00\",\"usableColumn\":false},{\"capJavaField\":\"DataSchema\",\"columnComment\":\"用户名\",\"columnId\":2,\"columnName\":\"data_schema\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"dataSchema\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-13 16:53:00\",\"usableColumn\":false},{\"capJavaField\":\"Model\",\"columnComment\":\"厂内机种\",\"columnId\":3,\"columnName\":\"model\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"model\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-13 16:53:00\",\"usableColumn\":false},{\"capJavaField\":\"DataSource\",\"columnComment\":\"数据源\",\"columnId\":4,\"columnName\":\"data_source\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIn','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 16:54:10',215),(107,'代码生成',8,'com.MetaApp.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"schema_tables_detailes\"}',NULL,0,NULL,'2025-04-13 16:55:24',60),(108,'代码生成',2,'com.MetaApp.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"datagovernance\",\"className\":\"SchemaTablesDetailes\",\"columns\":[{\"capJavaField\":\"Site\",\"columnComment\":\"厂别\",\"columnId\":1,\"columnName\":\"site\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"site\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-13 16:54:10\",\"usableColumn\":false},{\"capJavaField\":\"DataSchema\",\"columnComment\":\"用户名\",\"columnId\":2,\"columnName\":\"data_schema\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"dataSchema\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-13 16:54:10\",\"usableColumn\":false},{\"capJavaField\":\"Model\",\"columnComment\":\"厂内机种\",\"columnId\":3,\"columnName\":\"model\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"model\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-13 16:54:10\",\"usableColumn\":false},{\"capJavaField\":\"DataSource\",\"columnComment\":\"数据源\",\"columnId\":4,\"columnName\":\"data_source\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 16:50:21\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIn','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 16:59:00',215),(109,'代码生成',8,'com.MetaApp.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"schema_tables_detailes\"}',NULL,0,NULL,'2025-04-13 16:59:27',48),(110,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"DSN表查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"dsnTable\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 17:05:13',53),(111,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"MetaApp-dataGovernance/datagovernance/index\",\"createTime\":\"2025-04-13 17:05:12\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"DSN表查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"dsnTable\",\"perms\":\"MetaApp-dataGovernance:datagovernance:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 17:06:21',43),(112,'代码生成',3,'com.MetaApp.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/1','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 19:02:22',165),(113,'代码生成',6,'com.MetaApp.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"schema_tables_detailes\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 19:02:28',322),(114,'代码生成',2,'com.MetaApp.generator.controller.GenController.synchDb()','GET',1,'admin','研发部门','/tool/gen/synchDb/schema_tables_detailes','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 19:02:51',294),(115,'代码生成',3,'com.MetaApp.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/2','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 19:03:29',79),(116,'代码生成',6,'com.MetaApp.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"schema_tables_detailes\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 19:03:35',275),(117,'代码生成',2,'com.MetaApp.generator.controller.GenController.synchDb()','GET',1,'admin','研发部门','/tool/gen/synchDb/schema_tables_detailes','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 19:03:58',284),(118,'代码生成',8,'com.MetaApp.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"schema_tables_detailes\"}',NULL,0,NULL,'2025-04-13 19:04:35',45),(119,'代码生成',2,'com.MetaApp.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"dataGovernance\",\"className\":\"SchemaTablesDetailes\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":24,\"columnName\":\"id\",\"columnType\":\"bigint(20) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 19:03:35\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-04-13 19:03:58\",\"usableColumn\":false},{\"capJavaField\":\"Site\",\"columnComment\":\"厂别\",\"columnId\":25,\"columnName\":\"site\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 19:03:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"site\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-04-13 19:03:58\",\"usableColumn\":false},{\"capJavaField\":\"DataSchema\",\"columnComment\":\"用户名\",\"columnId\":26,\"columnName\":\"data_schema\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 19:03:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"dataSchema\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-04-13 19:03:58\",\"usableColumn\":false},{\"capJavaField\":\"Model\",\"columnComment\":\"厂内机种\",\"columnId\":27,\"columnName\":\"model\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-13 19:03:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increme','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 19:08:59',295),(120,'代码生成',8,'com.MetaApp.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"schema_tables_detailes\"}',NULL,0,NULL,'2025-04-13 19:09:03',42),(121,'代码生成',8,'com.MetaApp.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"schema_tables_detailes\"}',NULL,0,NULL,'2025-04-13 19:10:01',42),(122,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"dataGovernance/datagovernance/index\",\"createTime\":\"2025-04-13 17:05:12\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"DSN表查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"dsnTable\",\"perms\":\"dataGovernance:datagovernance:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 19:15:15',44),(123,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"dataGovernance/dataovernance/index\",\"createTime\":\"2025-04-13 17:05:12\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"DSN表查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"dsnTable\",\"perms\":\"dataGovernance:dataGovernance:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 19:16:29',33),(124,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"dataGovernance/dataGovernance/index\",\"createTime\":\"2025-04-13 17:05:12\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"DSN表查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"dsnTable\",\"perms\":\"dataGovernance:dataGovernance:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-13 19:19:12',64),(125,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"柳坤\",\"params\":{},\"phonenumber\":\"18158862981\",\"postIds\":[4],\"roleIds\":[],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"meta\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-25 14:41:03',135),(126,'用户管理',4,'com.MetaApp.web.controller.system.SysUserController.insertAuthRole()','PUT',1,'admin','研发部门','/system/user/authRole','127.0.0.1','内网IP','{\"roleIds\":\"2\",\"userId\":\"100\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-25 14:41:55',13),(127,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2002],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-25 14:42:29',24),(128,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2000,2001,2002],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-25 14:44:27',28),(129,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2000,2001,2002],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-25 14:46:15',26),(130,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.dataScope()','PUT',1,'admin','研发部门','/system/role/dataScope','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[100,101,103,104,105,106,107,102,108,109],\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-25 14:47:28',19),(131,'用户管理',2,'com.MetaApp.web.controller.system.SysUserController.edit()','PUT',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-04-25 14:41:03\",\"delFlag\":\"0\",\"deptId\":100,\"email\":\"\",\"loginDate\":\"2025-04-25 14:48:16\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"柳坤\",\"params\":{},\"phonenumber\":\"18158862981\",\"postIds\":[4],\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"meta\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-25 14:50:29',25),(132,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.dataScope()','PUT',1,'admin','研发部门','/system/role/dataScope','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-25 14:52:05',14),(133,'代码生成',6,'com.MetaApp.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"doris_table_structure_detailes\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 13:44:38',342),(134,'代码生成',3,'com.MetaApp.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/3','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 13:45:11',75),(135,'代码生成',3,'com.MetaApp.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/4','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 13:45:13',64),(136,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"governance/doris/index\",\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Doris元数据\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"governance:doris\",\"perms\":\"governance:doris\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-11 19:56:20',71),(137,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"governance/doris/index\",\"createTime\":\"2025-05-11 19:56:20\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"Doris元数据\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"doris\",\"perms\":\"governance:doris:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-11 19:57:20',29),(138,'菜单管理',3,'com.MetaApp.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2003','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-11 19:57:53',35),(139,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"governance/doris/index\",\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Doris元数据\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"doris\",\"perms\":\"governance:doris:index\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-11 19:58:35',27),(140,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"search\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Doris表查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"doristable\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-12 10:06:43',49),(141,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"governance/doristable/index\",\"createTime\":\"2025-05-12 10:06:43\",\"icon\":\"search\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"Doris表查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"doristable\",\"perms\":\"governance:doristable:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-12 10:07:21',64),(142,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"governance/doris/index\",\"createTime\":\"2025-05-11 19:58:35\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"Doris表查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"doris\",\"perms\":\"governance:doris:index\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"修改菜单\'Doris表查询\'失败，菜单名称已存在\",\"code\":500}',0,NULL,'2025-05-12 14:13:19',16),(143,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"governance/doris/index\",\"createTime\":\"2025-05-11 19:58:35\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"Doris查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"doris\",\"perms\":\"governance:doris:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-12 14:13:29',13),(144,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"governance/doristable/index\",\"createTime\":\"2025-05-12 10:06:43\",\"icon\":\"search\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"Doris元数据\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"doristable\",\"perms\":\"governance:doristable:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-12 14:13:42',12),(145,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"governance/test/index\",\"createTime\":\"2025-04-13 14:19:50\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"测试\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2000,\"path\":\"test\",\"perms\":\"grovernance:test:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-12 14:14:04',13),(146,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"dataGovernance/dataGovernance/index\",\"createTime\":\"2025-04-13 17:05:12\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"DSN表查询\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"dsnTable\",\"perms\":\"dataGovernance:dataGovernance:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-12 14:14:14',58),(147,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"governance/doris/index\",\"createTime\":\"2025-05-11 19:58:35\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"Doris查询\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"doris\",\"perms\":\"governance:doris:index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-12 14:14:21',12),(148,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"zip\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"文档查询\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"views/filemanagement\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-24 19:44:22',65),(149,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-05-24 19:44:22\",\"icon\":\"zip\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"文档查询\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"filemanagement\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-24 19:45:04',37),(150,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-05-24 19:44:22\",\"icon\":\"zip\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"文档查询\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"filemanagement\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-24 19:51:36',31),(151,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"filemanagement/businessfile/index\",\"createBy\":\"admin\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"业务文档\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"file\",\"perms\":\"filemanagement:businessfile:index\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-24 19:53:38',39),(152,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"filemanagement/uploadfile/index\",\"createBy\":\"admin\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"文档上传\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2006,\"path\":\"filemanagement\",\"perms\":\"filemanagement:uploadfile:index\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-24 20:06:45',35),(153,'参数管理',2,'com.MetaApp.web.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','127.0.0.1','内网IP','{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"N\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2025-03-18 18:54:27\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-06-02 08:26:18',24),(154,'参数管理',2,'com.MetaApp.web.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','127.0.0.1','内网IP','{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2025-03-18 18:54:27\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2025-06-02 08:26:18\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-06-02 08:27:53',16),(155,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','10.69.32.51','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"redis-list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"数据监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"hdsp\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-11 13:21:24',28),(156,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','10.69.32.51','内网IP','{\"children\":[],\"component\":\"dataMonitor/taskAlarm/index\",\"createBy\":\"admin\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"任务告警\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2009,\"path\":\"taskAlarm\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-11 13:31:15',16),(157,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','10.69.32.51','内网IP','{\"children\":[],\"createTime\":\"2025-11-11 13:21:24\",\"icon\":\"redis-list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2009,\"menuName\":\"数据底座\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"hdsp\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-11 13:31:27',14),(158,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"dataMonitor/taskAlarm/index\",\"createTime\":\"2025-11-11 13:31:15\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"任务告警\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2009,\"path\":\"taskAlarm\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-11 13:42:17',14),(159,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"bigdata\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":101,\"userName\":\"bigdata\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-12 08:38:38',125),(160,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2009],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-12 08:39:49',28),(161,'角色管理',4,'com.MetaApp.web.controller.system.SysRoleController.selectAuthUserAll()','PUT',1,'admin','研发部门','/system/role/authUser/selectAll','127.0.0.1','内网IP','{\"roleId\":\"2\",\"userIds\":\"101\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-12 08:41:38',10),(162,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2009],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-12 08:41:52',20),(163,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2009,2010],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-12 08:43:01',23),(164,'个人信息',2,'com.MetaApp.web.controller.system.SysProfileController.updatePwd()','PUT',1,'admin','研发部门','/system/user/profile/updatePwd','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-12 13:36:23',294),(165,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','10.69.32.113','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"DB监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"doris\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-13 16:52:23',25),(166,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','10.69.32.113','内网IP','{\"children\":[],\"component\":\"dataMonitor/dorisGrowth/index\",\"createBy\":\"admin\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"doris表空间监控\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2011,\"path\":\"dorisGrowth\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-13 16:53:38',18),(167,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2009,2010,2011],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-14 15:25:05',47),(168,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2009,2010,2011,2012],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-14 16:33:06',46),(169,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"76247306\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":102,\"userName\":\"文雪\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:27:01',132),(170,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"76247306\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":103,\"userName\":\"历平\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:27:34',107),(171,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"75218087\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":104,\"userName\":\"庆飞\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:28:07',112),(172,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"75355304\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":105,\"userName\":\"秉宇\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:28:37',102),(173,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"76247314\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":106,\"userName\":\"安星\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:29:01',113),(174,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"75165382\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":107,\"userName\":\"清杰\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:29:32',103),(175,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"75254142\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":108,\"userName\":\"泓磊\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:30:30',102),(176,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"K17082150\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":109,\"userName\":\"K17082150\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:30:50',103),(177,'用户管理',2,'com.MetaApp.web.controller.system.SysUserController.resetPwd()','PUT',1,'admin','研发部门','/system/user/resetPwd','127.0.0.1','内网IP','{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":101}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:31:41',98),(178,'用户管理',3,'com.MetaApp.web.controller.system.SysUserController.remove()','DELETE',1,'admin','研发部门','/system/user/102','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:33:43',59),(179,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"76247306\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":110,\"userName\":\"76247306\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:33:56',106),(180,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"nickName\":\"76247306\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userName\":\"76247306\"}','{\"msg\":\"新增用户\'76247306\'失败，登录账号已存在\",\"code\":500}',0,NULL,'2025-11-17 16:34:13',5),(181,'用户管理',3,'com.MetaApp.web.controller.system.SysUserController.remove()','DELETE',1,'admin','研发部门','/system/user/103','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:34:34',12),(182,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"nickName\":\"76247306\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userName\":\"76247306\"}','{\"msg\":\"新增用户\'76247306\'失败，登录账号已存在\",\"code\":500}',0,NULL,'2025-11-17 16:34:46',6),(183,'用户管理',3,'com.MetaApp.web.controller.system.SysUserController.remove()','DELETE',1,'admin','研发部门','/system/user/104','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:35:23',14),(184,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"75218087\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":111,\"userName\":\"75218087\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:35:37',107),(185,'用户管理',3,'com.MetaApp.web.controller.system.SysUserController.remove()','DELETE',1,'admin','研发部门','/system/user/105','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:35:47',28),(186,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"75355304\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":112,\"userName\":\"75355304\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:36:05',103),(187,'用户管理',3,'com.MetaApp.web.controller.system.SysUserController.remove()','DELETE',1,'admin','研发部门','/system/user/106','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:36:22',16),(188,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"76247314\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":113,\"userName\":\"76247314\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:36:43',102),(189,'用户管理',3,'com.MetaApp.web.controller.system.SysUserController.remove()','DELETE',1,'admin','研发部门','/system/user/107','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:36:57',13),(190,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"75165382\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":114,\"userName\":\"75165382\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:39:01',112),(191,'用户管理',3,'com.MetaApp.web.controller.system.SysUserController.remove()','DELETE',1,'admin','研发部门','/system/user/108','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:39:06',15),(192,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"75254142\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":115,\"userName\":\"75254142\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-17 16:39:20',104),(193,'菜单管理',1,'com.MetaApp.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','10.69.32.113','内网IP','{\"children\":[],\"component\":\"dorisSql\",\"createBy\":\"admin\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"doris慢sql监控\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2011,\"path\":\"dorisSql\",\"query\":\"dataMonitor/dorisSql/index\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-21 09:01:54',26),(194,'菜单管理',2,'com.MetaApp.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','10.69.32.113','内网IP','{\"children\":[],\"component\":\"dataMonitor/dorisSql/index\",\"createTime\":\"2025-11-21 09:01:54\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"doris慢sql监控\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2011,\"path\":\"dorisSql\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-21 09:02:22',15),(195,'角色管理',2,'com.MetaApp.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-03-18 18:54:13\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2009,2010,2011,2012,2013],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-21 14:20:32',44),(196,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"12205995\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":116,\"userName\":\"12205995\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-27 08:38:05',148),(197,'用户管理',1,'com.MetaApp.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"75307950\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":117,\"userName\":\"75307950\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-11-27 08:38:36',128);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2025-03-18 18:54:12','',NULL,''),(2,'se','项目经理',2,'0','admin','2025-03-18 18:54:13','',NULL,''),(3,'hr','人力资源',3,'0','admin','2025-03-18 18:54:13','',NULL,''),(4,'user','普通员工',4,'0','admin','2025-03-18 18:54:13','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2025-03-18 18:54:13','',NULL,'超级管理员'),(2,'普通角色','common',2,'1',0,1,'0','0','admin','2025-03-18 18:54:13','admin','2025-11-21 14:20:32','普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,2009),(2,2010),(2,2011),(2,2012),(2,2013);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','若依','00','ry@163.com','15888888888','1','','$2a$10$Hsl/YI38c8h.cVEm4U2I2eaf3DHcTG56963IaQWboCs.YRdpJkhHa','0','0','127.0.0.1','2025-11-28 15:33:42','admin','2025-03-18 18:54:12','','2025-11-28 15:33:41','管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-03-18 18:54:12','admin','2025-03-18 18:54:12','',NULL,'测试员'),(100,100,'meta','柳坤','00','','18158862981','0','','$2a$10$6Gwrb5UoIOfY42A1wo.uk.uiAUdSGwrTixdO8Vt9gb2HCWfJDo/Ne','0','0','127.0.0.1','2025-04-25 14:52:15','admin','2025-04-25 14:41:03','admin','2025-04-25 14:52:14',NULL),(101,NULL,'bigdata','bigdata','00','','','0','','$2a$10$Ncnnyd4a0PgftXt9uLws8.L0b3gqBdinl4Yxp7xIbgn5tlRLoNsNi','0','0','127.0.0.1','2025-11-17 16:29:36','admin','2025-11-12 08:38:38','admin','2025-11-17 16:31:41',NULL),(102,NULL,'文雪','76247306','00','','','0','','$2a$10$b0P0IZqWUA2nn4JseGw1oePbjGAQr3MoupxlY/Y9/qhRSMRcJENUK','0','2','',NULL,'admin','2025-11-17 16:27:01','',NULL,NULL),(103,NULL,'历平','76247306','00','','','0','','$2a$10$7LNuEIIOZhbKXNvyS8IRWe3orzdTD457T/ax784H20wMBPiW4iJ9m','0','2','',NULL,'admin','2025-11-17 16:27:34','',NULL,NULL),(104,NULL,'庆飞','75218087','00','','','0','','$2a$10$ipPfbxQTc.Q5RQ6cY84O1eHyQQQ/wWioi4MrYWjQye3VntmuumKii','0','2','',NULL,'admin','2025-11-17 16:28:07','',NULL,NULL),(105,NULL,'秉宇','75355304','00','','','0','','$2a$10$aMWjS0l5CgX06ytz6IxXyuGpURa.lJlPy0v4Sc9AVpbuokiweYzBm','0','2','',NULL,'admin','2025-11-17 16:28:37','',NULL,NULL),(106,NULL,'安星','76247314','00','','','0','','$2a$10$Z/vcAAwMN5FSI8iqpLywYe/DXUQBWdLO/vfp2of8AiP8Fa/YmCJda','0','2','',NULL,'admin','2025-11-17 16:29:01','',NULL,NULL),(107,NULL,'清杰','75165382','00','','','0','','$2a$10$uNFeYULNhe2MwX4nFpUyse5fSBp89FqSpdmccds2/b1zZTCjrzBMu','0','2','',NULL,'admin','2025-11-17 16:29:32','',NULL,NULL),(108,NULL,'泓磊','75254142','00','','','0','','$2a$10$k3d8qT00fGdydSlE.Eyyde8CWEjj1iVjVvb0MycwB4LYgorQAS1GO','0','2','',NULL,'admin','2025-11-17 16:30:30','',NULL,NULL),(109,NULL,'K17082150','K17082150','00','','','0','','$2a$10$UsM2jtm8RWiE5ONi/xNrXujBrxXaMRpveP5xkzmHIpt8.IaqXtfNi','0','0','',NULL,'admin','2025-11-17 16:30:50','',NULL,NULL),(110,NULL,'76247306','76247306','00','','','0','','$2a$10$R/gBUkPJLDMgH/3KwO7ydeczK5FcrKpdIPdYqIpSg2PdikzGM4k2W','0','0','127.0.0.1','2025-11-28 14:56:11','admin','2025-11-17 16:33:56','','2025-11-28 14:56:10',NULL),(111,NULL,'75218087','75218087','00','','','0','','$2a$10$O9jpcfhKsSYunKCfI1e9s.pmU/kmUAqL4BzYahPEQDUxCAqNTkXVa','0','0','127.0.0.1','2025-11-24 08:25:39','admin','2025-11-17 16:35:36','','2025-11-24 08:25:39',NULL),(112,NULL,'75355304','75355304','00','','','0','','$2a$10$a8eNbu/YE6m9H8F2Ojv.cea5fRSo8MLgrzsuOx8ulqBU4GW5nnoK.','0','0','127.0.0.1','2025-11-28 08:26:17','admin','2025-11-17 16:36:05','','2025-11-28 08:26:17',NULL),(113,NULL,'76247314','76247314','00','','','0','','$2a$10$ITVFTJeal/MQqtKxJaNA3.tAn0oF08D8zEpX3xS91U0MwyTneWQci','0','0','127.0.0.1','2025-11-28 08:03:32','admin','2025-11-17 16:36:43','','2025-11-28 08:03:31',NULL),(114,NULL,'75165382','75165382','00','','','0','','$2a$10$lJ0vj2asJ3xMlGfEQ3GIsefLOsRBsdqmYuHyJg5Lk8D0qCepuJlv2','0','0','127.0.0.1','2025-11-26 18:59:17','admin','2025-11-17 16:39:01','','2025-11-26 18:59:16',NULL),(115,NULL,'75254142','75254142','00','','','0','','$2a$10$CzH4RvhixYHUM1cZ2CK.q.aEVIKs5CFygmdqufvM./VpxiBMR4qBy','0','0','127.0.0.1','2025-11-26 14:58:59','admin','2025-11-17 16:39:20','','2025-11-26 14:58:59',NULL),(116,NULL,'12205995','12205995','00','','','0','','$2a$10$gl3kFDwYrTb59TnMF3hwruPyuNKYsJWBOiueTXJTkAvj3sdYSvrtK','0','0','127.0.0.1','2025-11-28 08:13:24','admin','2025-11-27 08:38:05','','2025-11-28 08:13:24',NULL),(117,NULL,'75307950','75307950','00','','','0','','$2a$10$QDAn0XtmEs17v8ZAzpY33eAXUFbuSjYkcwNvdr6dX7.DkHbjJ3hzO','0','0','127.0.0.1','2025-11-28 15:53:55','admin','2025-11-27 08:38:36','','2025-11-28 15:53:55',NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2),(100,4);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2),(100,2),(101,2),(109,2),(110,2),(111,2),(112,2),(113,2),(114,2),(115,2),(116,2),(117,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'meta'
--

--
-- Dumping routines for database 'meta'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-28 16:30:50
