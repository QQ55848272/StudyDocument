# Doris 数据模型

## 特点

1. 键值对特点

Doris中的数据都被分成两列 : 键列和值列。

user_namepv_count数据人3

user_name为键列（可多列）。

pv_count为值列（可多列）。

键（key）列用于快速查找，值（value）列可根据特定的聚合类型用于内部数据聚合。

键列全局有序排列，查询时方便快速定位查找

Key列是全局惟一的，因此对于相同的键值有不同的值，然后随后的数据自动与之前的数据聚合(sum、min、max、replace)，下面会提到。

1. 按列存储特点

- 按列存储的，每一列单独存放。
- 查询时，只访问涉及的列，提高查询效率。
- 数据的列类型一致，统一方便压缩。
- 数据建索引，提高了查询效率。

1. 物化视图特点

什么是物化视图

视图是一个虚拟表，基于它创建时指定的查询语句返回的结果集。每次访问它都会导致这个查询语句被执行一次。为了避免每次访问都执行这个查询，可以将这个查询结果集存储到一个物化视图。

物化视图与普通的视图相比不同的是：物化视图是建立的副本，它类似于一张表，需要占用存储空间。而对一个物化视图查询的执行效率与查询一个表是一样的。

**归纳：** 物化视图是提取特定维度以创建对用户透明但具有真实数据的视图表的组合。

Doris物化视图特点

Doris的物化视图确保用户在更新时直接更新原始表，Doris将确保原始表和物化视图自动生效。查询时，用户只需要指定原始表，Doris将根据查询的具体条件选择适当的物化视图来完成查询。既能对原始明细数据的任意纬度分析，也能快速的对固定纬度进行分析查询。总结几点就是以下:

1. 对于那些经常重复的使用相同的子查询结果的查询性能大幅提升。

1. Doris自动更新物化视图的数据，保证原始表和物化视图表的数据一致性。无需额外的维护成本。

1. 查询的时候也可以自动匹配最优的物化视图。

## 数据模型种类

### aggregate key

key相同时，新旧记录将会进行聚合操作，目前支持sum,min,max,replace。

sum：求和，多行的 value 进行累加。

replace：替代，下一批数据中的 value 会替换之前导入过的行中的 value。

max：保留最大值。

min：保留最小值。

aggregate key模型可以提前聚合数据，适合报表和多维度业务。

举一小例子

CREATE TABLE pv (    user_name    VARCHAR(32),    pv_ccount BIGINT   SUM DEFAULT '0' ) aggregate key(user_name) distributed by hash(user_name) buckets 6; insert into pv values('数据人',1); insert into pv values('数据人',1); insert into pv values('数据人',1); select * from pv；

结果

user_namepv_count数据人3

### unique key

key相同时，新记录覆盖旧记录。目前unique key和aggregate

适用于有更新需求的业务。

举一小例子

CREATE TABLE user (    user_name    VARCHAR(32),    age      BIGINT DEFAULT '0' ) unique key(user_name) distributed by hash(user_name) buckets 6; insert into user values('数据人',1); insert into user values('数据人',2); insert into user values('数据人',3); select * from user；

结果

user_nameage数据人3

### duplicate key

只指定排序列，相同的行并不会合并。

适用于数据无需提前聚合的分析业务。

举一小例子

CREATE TABLE order_info (    order_id     BIGINT,    user_id      BIGINT,    amount       BIGINT DEFAULT '0' ) duplicate key(order_id) DISTRIBUTED BY HASH(order_id) BUCKETS 6; insert into order_info values(1111,1,1000); insert into order_info values(2222,1,1000); insert into order_info values(3333,1,1000); select * from user； 查询当然是全部

# 存储结构

**存储以Segment V2文件存储，为什么是v2呢？** 新版SegmentV2存储格式参考了Parquet的设计思路，引入了基于Page的最小数据存储单元，并将数据文件划分为数据区、索引区和元数据区三个部分。针对不同的列类型、索引格式实现了不同的Page编码方式，显著提升了数据的读写效率，并增强了数据格式的可扩展性。

## Segment V2文件结构

![img](https://iauokx5g5i8.feishu.cn/space/api/box/stream/download/asynccode/?code=MzYzMTc2YWU3OTRiNzZhZmVjMzg0MzQ0YmQ3MGYxMjZfYzl2akttZU1JajdQdHJzMHpER2hvUGRIbjFCWW1oZlVfVG9rZW46T2tmUWIyUUtnb2ROUW54WnF1d2M4ZHZnblBiXzE3MjEzNTgzMzc6MTcyMTM2MTkzN19WNA)

### 介绍一下，后面单个细说

Data Region

用于存储各个列的数据信息，这里的数据是按需分page加载的。

Index Region

Doris中将各个列的index数据统一存储在Index Region，这里的数据会按照列粒度进行加载，所以跟列的数据信息分开存储。

Footer信息

- SegmentFooterPB:定义文件的元数据信息
- 4个字节的FooterPB内容的checksum
- 4个字节的FileFooterPB消息长度，用于读取FileFooterPB
- 8个字节的MAGIC CODE，之所以在末位存储，是方便不同的场景进行文件类型的识别

## Data Region

### Data Page结构

![img](https://iauokx5g5i8.feishu.cn/space/api/box/stream/download/asynccode/?code=N2EyNTM0MmE2MzRlMDU3NmJmNTM4OGU3YWFjMzQ3NmFfb2JONHBHYXJCbkNjRkszSGNrS3gxWDRybjF5c0o5QXdfVG9rZW46Um9nbWI5MGtZb2ZuZW94MngwR2NJNUxTbmtoXzE3MjEzNTgzMzc6MTcyMTM2MTkzN19WNA)

压缩与编码

针对不同的字段类型采用了不同的编码,默认采用LZ4F格式对数据进行压缩。

数据类型编码tinyint/smallint/int/bigint/largeintbit_shufflefloat/double/decimalbit_shufflechar/varchardictboolrledate/datetimebit_shufflehll/objectplain

## Index Region

### Ordinal Index（一级索引）

功能

Ordinal Index索引提供了通过行号来查找Column Data Page数据页的物理地址。

Ordinal Index能够将按列存储数据按行对齐，可以形象理解为所谓的一级索引。

Column Data Page是由Ordinal index进行管理，Ordinal index记录了每个Column Data Page的位置offset、大小size和第一个数据项行号信息，即Ordinal。这样每个列具有按行信息进行快速扫描的能力。

生成规则与查询

![img](https://iauokx5g5i8.feishu.cn/space/api/box/stream/download/asynccode/?code=MWRhY2Q2MTNjM2IxMTgyNzY4MGI2MGE2ZTBjYTMyYmNfRnBJSFhLUzVPTG9VNXhIVzhFa21yV3NYOG9hTHVWekVfVG9rZW46QmhHbWJlR2pnb0lrTFd4SHU0ZWN1eUlKbmNjXzE3MjEzNTgzMzc6MTcyMTM2MTkzN19WNA)

### Short Key Index（前缀索引）

功能

数据查询时，会打开Segment文件，从footer中获取Short Key Page的offset以及大小，然后从Segment文件中读取Short Key Page中的索引数据，并解析出每一条前缀索引项。

如果查询过滤条件包含前缀字段时，就可以使用前缀索引进行快速地行过滤。

前缀索引又是稀疏索引，不能精确定位到key所在的行，只能粗粒度地定位出key可能存在的范围，然后使用二分查找算法精确地定位key的位置。

生成规则与查询

![img](https://iauokx5g5i8.feishu.cn/space/api/box/stream/download/asynccode/?code=ZjI3NDFiMzZkZmE1NWM2NTBlZTcxNzUwYTBjOWQxNzdfNENweUlZTjRiUTBaa2NPb0RqT2xhRVNKMGpOR09CMlJfVG9rZW46WHRwamJMdXZlb3FoUFB4MWdUamN6RFlsbjQ5XzE3MjEzNTgzMzc6MTcyMTM2MTkzN19WNA)

### ZoneMap Index

功能

ZoneMap索引存储了Segment和每个列对应每个Page的统计信息。这些统计信息可以帮助在查询时提速，减少扫描数据量，统计信息包括了Min最大值、Max最小值、HashNull空值、HasNotNull不全为空的信息。

生成规则与查询

![img](https://iauokx5g5i8.feishu.cn/space/api/box/stream/download/asynccode/?code=YTQ2Y2U0ZWRjNjM5NmM1MTk5ODM1NTI3YmVlYTlmZDZfVlJBcFg3N1JBdkNvdElQVk5vVlNPSk8wdmV5VzBlMnhfVG9rZW46S2NYUWJiSjBmbzJEcEh4UExMQWNTQk8wbkdoXzE3MjEzNTgzMzc6MTcyMTM2MTkzN19WNA)

### Bloom Filte Index

功能

Doris支持对取值区分度比较大的字段添加Bloom Filter索引。数据查询时，查询条件在设置有Bloom Filter索引的字段进行过滤，当某个Data Page的Bloom Filter没有命中时，表示该Data Page中没有需要的数据，这样可以对Data Page进行快速过滤，减少不必要的数据读取。

生成规则与查询

![img](https://iauokx5g5i8.feishu.cn/space/api/box/stream/download/asynccode/?code=NDg5NDFlM2Y0YzRhZTk3OThiODI2OGY2OTcyZGQyNTdfSzNpVUd5NmhacVFldEUwdmJQYkx1aWlJazc1bmtGYXVfVG9rZW46VnNYeGJ4WHFIb3o2Zkp4M2lKaWNRbWlUbjluXzE3MjEzNTgzMzc6MTcyMTM2MTkzN19WNA)

### BitMap Index

功能

为了加速数据查询，Doris可以为某些字段添加Bitmap索引。

- 有序字典：有序保存一列中所有的不同取值。
- 字典值的位图：保存有序字典中每一个取值的位图，表示字典值在列中的行号。

生成规则与查询

![img](https://iauokx5g5i8.feishu.cn/space/api/box/stream/download/asynccode/?code=NTcwZDQ2NmQxMzAwZjVmYWI4MTkyMDg1MTAyNGMwODFfREozbzVCVXhIMHlCZGlFcEhvUXV5d2NGa29va0pNWGNfVG9rZW46T21qZ2JlUmRXb3ZicmZ4SzNLTmMycTJMbmVlXzE3MjEzNTgzMzc6MTcyMTM2MTkzN19WNA)

## Footer

### 结构

![img](https://iauokx5g5i8.feishu.cn/space/api/box/stream/download/asynccode/?code=M2RmNzBhNWUyZGFjOTE4MDZmYzMxM2JmZTJhNmFlNGZfcmcxdUdheDRpYWFOb0puTXJGajFKZDlKOFlrN3JmcTdfVG9rZW46UWJMaWJkS2Nsb0I2ZE54UnZySmNKQ2tjbkdjXzE3MjEzNTgzMzc6MTcyMTM2MTkzN19WNA)

Footer信息段在文件的尾部，存储了文件的整体结构，包括数据域的位置，索引域的位置等信息。

其中FooterPB主要包含了column meta信息、index meta信息，short key index信息、总行数。