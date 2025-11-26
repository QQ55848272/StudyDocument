# Doris DML语法

## 1.添加字段

```sql
ALTER TABLE test.meta_data_flow_log ADD COLUMN frequency VARCHAR(255) COMMENT '厂别';
```

## 2.修改字段注释

```sql
ALTER TABLE users MODIFY COLUMN age INT COMMENT '修改后的用户年龄注释';
```

## 3.删除字段

```sql
ALTER TABLE test.meta_data_flow_log DROP COLUMN crrent_time;
```

