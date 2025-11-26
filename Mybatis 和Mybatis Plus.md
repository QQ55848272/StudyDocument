# Mybatis 和Mybatis Plus

MyBatis 和 MyBatis Plus 是 Java 领域流行的 ORM 框架，它们的主要区别是：

- **MyBatis**：需要编写 XML 或注解 SQL，提供灵活的 SQL 映射能力。
- **MyBatis Plus**：基于 MyBatis，提供 CRUD 方法的自动实现，减少 SQL 编写，提升开发效率。

### **学习路线**

1. **基础概念**

   - MyBatis 的核心概念（SqlSession、Mapper、ResultMap、动态 SQL）
   - MyBatis Plus 的增强特性（BaseMapper、Service 层、Wrapper、分页、拦截器）

2. **环境搭建**

   - 搭建 MyBatis/MyBatis Plus + MySQL（你用的是 MySQL 8.0）
   - 配置 MyBatis 的 XML 或者注解

3. **核心功能**

   - 基本 CRUD（增删改查）
   - 复杂查询（动态 SQL、关联查询）
   - 分页插件（MyBatis Plus 内置 PageHelper）
   - 乐观锁与分布式 ID（MyBatis Plus 自带支持）

4. **高级功能**

   - 自定义 SQL（XML + 注解）
   - 拦截器（性能分析、审计）
   - 事务管理（与 Spring 结合）

5. **实战**

   - 用 MyBatis Plus 快速开发一个完整的业务模块（例如用户管理）

   - 性能优化（懒加载、批量操作）

     

## **1. MyBatis 基础**

### **1.1 MyBatis 概述**

#### 1.1.1什么是 MyBatis？它和 Hibernate、JPA 的区别？

MyBatis 是一款 **轻量级的持久层框架**，用于简化 Java 应用程序与数据库之间的交互。它基于 **SQL 映射（SQL Mapping）** 的思想，使开发者可以直接编写 SQL 语句，并通过 XML 配置文件或注解的方式，将 SQL 与 Java 对象进行映射。

##### **MyBatis 主要特点**

1. **SQL 自由度高**：开发者可以手写 SQL，方便优化复杂查询。
2. **支持动态 SQL**：通过 `<if>`、`<foreach>` 等标签，实现动态 SQL 组装。
3. **支持 ORM（对象关系映射）**：但不像 Hibernate 那样全自动，而是手动映射字段。
4. **一级、二级缓存**：提高查询性能。
5. **支持 XML 和注解**：可以选择 XML 方式或注解方式配置 SQL。

------

##### **MyBatis vs Hibernate vs JPA**

| 特性         | MyBatis              | Hibernate                       | JPA                            |
| ------------ | -------------------- | ------------------------------- | ------------------------------ |
| **SQL 控制** | 手写 SQL，自由度高   | 生成 SQL，减少 SQL 编写         | 基于 Hibernate，ORM 自动映射   |
| **学习成本** | 低，易上手           | 高，需要理解 HQL、实体关系映射  | 需要学习 JPA 规范              |
| **性能**     | SQL 可控，性能可优化 | 复杂查询可能性能较低            | 依赖 Hibernate，性能依情况而定 |
| **适用场景** | 复杂 SQL 查询        | 业务逻辑复杂，但不依赖 SQL 优化 | 适用于 Spring Boot 快速开发    |
| **缓存机制** | 一级缓存、二级缓存   | 一级缓存、二级缓存              | 依赖 Hibernate 缓存机制        |
| **事务管理** | 需与 Spring 结合     | 内置事务管理                    | 依赖 JPA 事务管理              |

#### **1.1.2什么时候用哪种？**

- **MyBatis**：适用于 **SQL 复杂度高、查询优化要求高** 的项目，如数据分析、报表系统。
- **Hibernate**：适用于 **对象关系映射复杂**，希望 **减少 SQL 编写** 的项目，如标准 Web 应用。
- **JPA**：适用于 **Spring Boot 快速开发**，希望遵循 **JPA 规范** 的企业级应用。

### 1.2 MyBatis 的优缺点

#### **1.2.1 优点**

#### 1.2.1.1 **灵活的 SQL 控制**

- MyBatis 允许开发者完全控制 SQL 语句的编写。你可以根据具体需求定制 SQL，优化查询，避免不必要的性能开销。对于复杂的 SQL 查询，MyBatis 提供了最大的灵活性。

#### 1.2.1.2. **支持动态 SQL**

- MyBatis 提供了强大的动态 SQL 支持。通过 XML 文件中的 `<if>`、`<choose>`、`<foreach>` 等标签，可以根据条件动态生成 SQL 查询语句。这让构建复杂查询变得非常方便。

#### 1.2.1.3. **精确的 SQL 调优**

- 与 Hibernate 等 ORM 框架不同，MyBatis 允许开发者精确控制生成的 SQL。你可以手动编写 SQL 来实现优化，例如使用 `JOIN`、`GROUP BY`、`HAVING` 等语法，或者进行分页查询等优化。

#### 1.2.1.4. **灵活的映射方式**

- MyBatis 提供了 **XML 映射文件** 和 **注解映射** 两种方式，开发者可以根据项目需求选择合适的方式进行 SQL 和 Java 对象之间的映射。

#### 1.2.1..5. **良好的性能**

- 由于开发者直接编写 SQL，可以通过 SQL 索引、查询优化等手段来提升性能。因此，MyBatis 比 Hibernate 和 JPA 更适用于需要高度定制化查询的场景。

#### 1.2.1.6. **支持复杂查询**

- MyBatis 允许复杂查询的自由组合，支持 **多表查询**、**关联查询**，且对 SQL 进行了直接的控制，避免了 ORM 框架中自动生成 SQL 的问题。

------

#### **1.2.2.缺点**

##### 1.2.2.1. **需要编写大量 SQL**

- 与 Hibernate 等 ORM 框架相比，MyBatis 需要开发者手动编写 SQL 语句，特别是在复杂查询时，SQL 文件可能会变得非常庞大和复杂。对于 CRUD 操作较为简单的项目，这可能会增加工作量。

##### 1.2.2.2. **没有自动化的对象关系映射（ORM）**

- MyBatis 并不像 Hibernate 那样自动生成 SQL 和映射关系。虽然它提供了映射机制，但开发者需要手动配置每个字段的映射。这增加了开发和维护的复杂度。

##### 1.2.2.3. **不适合对象-关系映射较复杂的项目**

- 如果项目需要复杂的对象关系映射，例如多层级、多对多关系等，MyBatis 可能不如 Hibernate 或 JPA 灵活且易于管理。需要更多的手动配置和 SQL 语句。

##### 1.2.2.4. **没有内建的查询缓存机制**

- 虽然 MyBatis 提供了一级和二级缓存，但默认没有像 Hibernate 那样的完整缓存机制。需要开发者自己配置缓存策略，对于高并发场景，可能需要额外配置和调优。

##### 1.2.2.5. **不提供自动事务管理**

- MyBatis 本身不提供事务管理，需要与外部框架（如 Spring）结合来管理事务。这意味着 MyBatis 本身并不具备像 JPA 那样自动管理事务的能力。

##### 1.2.2.6. **维护难度**

- 当项目规模增大时，SQL 文件的维护难度会增大，尤其是当业务需求变化频繁时，手写 SQL 需要频繁修改。并且，开发团队需要熟悉 SQL 编写技巧。

------

#### **1.2.3总结**

- **优点**：灵活、性能好、动态 SQL 支持强、可精确控制 SQL、支持复杂查询。
- **缺点**：需要大量手写 SQL、没有自动化 ORM、没有内建的缓存机制、事务管理不内建。

如果你的项目中 SQL 查询复杂且需要优化性能，MyBatis 是一个不错的选择，但如果项目中主要是简单的 CRUD 操作，或者希望减少 SQL 编写量，可能会考虑使用 **Hibernate** 或 **JPA**。

### **1.3  环境搭建**

- 创建 **Maven** 项目，引入 **MyBatis** 依赖
- 配置 MyBatis 与 **MySQL 8.0**（你用的是 MySQL 8.0）
- 配置 MyBatis 的 `mybatis-config.xml`
- 连接数据库，测试 SQL 查询

------

## **2. MyBatis 核心**

### **2.1 基本使用**

#### 2.1.1**SqlSession** 作用

##### **2.1.1.1 SqlSession 作用**

`SqlSession` 是 MyBatis 的 **核心接口**，它代表了与数据库的一次会话（类似于 JDBC 的 `Connection`），主要用于执行 SQL 语句、获取 Mapper 接口、管理事务等。

##### **2.1.1.2 SqlSession 主要功能**

1. 执行 SQL 语句
   - 通过 `selectList()`、`selectOne()`、`insert()`、`update()`、`delete()` 方法执行 SQL 语句。
2. 获取 Mapper
   - 通过 `getMapper(Class<T> type)` 获取对应的 Mapper 接口，实现数据库操作。
3. 事务管理
   - 通过 `commit()` 提交事务，`rollback()` 回滚事务。
4. 管理数据库连接
   - `SqlSession` 底层封装了数据库连接（Connection），但需要手动关闭，避免资源泄露。

------

#### 2.1.2. 如何管理数据库会话（SqlSession）

##### **方式 1：手动管理 SqlSession**

通过 `SqlSessionFactory` 创建 `SqlSession`，需要手动 `close()` 释放资源。

```java
// 1. 获取 SqlSessionFactory
InputStream inputStream = Resources.getResourceAsStream("mybatis-config.xml");
SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

// 2. 获取 SqlSession（需要手动关闭）
SqlSession sqlSession = sqlSessionFactory.openSession();
try {
    // 3. 执行 SQL 语句
    UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
    User user = userMapper.selectUserById(1);
    System.out.println(user);
    
    // 4. 提交事务（如果是 insert/update/delete）
    sqlSession.commit();
} finally {
    // 5. 关闭 SqlSession，防止资源泄露
    sqlSession.close();
}
```

**缺点**：

- 需要手动 `close()`，容易忘记，导致资源泄露。
- 事务管理需要手动 `commit()` 和 `rollback()`，代码较繁琐。

------

##### **方式 2：使用 MyBatis 的 `try-with-resources` 自动管理**

使用 `try-with-resources` 语法，让 `SqlSession` 在使用完成后自动关闭。

```java
try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
    UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
    User user = userMapper.selectUserById(1);
    System.out.println(user);
    sqlSession.commit(); // 提交事务
} // `SqlSession` 会自动关闭
```

**优点**：

- 自动关闭 `SqlSession`，避免资源泄露。
- 代码更简洁。

------

##### **方式 3：结合 Spring 管理 SqlSession**

在 **Spring + MyBatis** 项目中，通常使用 **SqlSessionTemplate** 进行管理，不需要手动创建和关闭 `SqlSession`。

**配置方式**：

```java
@Autowired
private UserMapper userMapper;

public void someMethod() {
    User user = userMapper.selectUserById(1);
    System.out.println(user);
}
```

**优点**：

- `SqlSession` 由 Spring 统一管理，避免手动创建和关闭。
- 事务管理可以交给 Spring 处理。

------

#### ****2.1.3. SqlSession 事务管理**

##### **手动提交事务**

默认情况下，MyBatis 的 `SqlSession` **不会自动提交事务**，需要手动调用 `commit()`。

```java
SqlSession sqlSession = sqlSessionFactory.openSession();
try {
    UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
    userMapper.insertUser(new User(2, "Tom"));
    sqlSession.commit(); // 手动提交
} catch (Exception e) {
    sqlSession.rollback(); // 发生异常回滚
    e.printStackTrace();
} finally {
    sqlSession.close();
}
```

##### **自动提交事务**

可以在 `openSession(true)` 里传入 `true`，让 `SqlSession` 自动提交事务：

```java
SqlSession sqlSession = sqlSessionFactory.openSession(true); // 自动提交
UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
userMapper.insertUser(new User(2, "Tom"));
sqlSession.close();
```

##### **Spring 事务管理**

在 **Spring + MyBatis** 项目中，使用 `@Transactional` 交给 Spring 统一管理：

```java
@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Transactional // 交由 Spring 管理事务
    public void insertUser(User user) {
        userMapper.insertUser(user);
    }
}
```

**优点**：

- 事务管理更方便，不需要手动 `commit()` 或 `rollback()`。
- 适用于大部分 Spring Boot 项目。

------

#### 2.1.4 总结

- `SqlSession` 负责 **执行 SQL、获取 Mapper、管理事务**，类似 JDBC 的 `Connection`。
- 需要手动 **创建和关闭**，避免资源泄露。
- 事务管理：
  - 手动管理：`commit()` 提交，`rollback()` 回滚。
  - 自动提交：`openSession(true)` 直接开启自动提交。
  - Spring 事务管理：`@Transactional` 交给 Spring 处理。

- **Mapper 映射**（使用接口开发）
- **XML 配置 vs. 注解方式**
- 配置 `ResultMap` 处理字段映射



### **2.2 MyBatis 动态 SQL**

动态 SQL 允许我们根据不同的查询条件动态生成 SQL 语句，避免拼接 SQL，提升可读性和灵活性。MyBatis 提供了 **`<if>`、`<choose>`、`<where>`、`<set>`、`<trim>`** 等标签来实现动态 SQL 逻辑。

------

#### **2.2.1. `<if>`：条件判断**

**作用**：根据条件动态添加 SQL 片段。
 **示例**：根据用户名和年龄查询用户（条件可选）

```xml
<select id="findUser" resultType="User">
    SELECT * FROM users
    WHERE 1=1
    <if test="username != null and username != ''">
        AND username = #{username}
    </if>
    <if test="age != null">
        AND age = #{age}
    </if>
</select>

<#if start_time ??>
   -- 这部分会消失，不产生任何输出
   AND lastoperatedate > '#{start_time}'
</#if>

```

| 操作符         | 检查内容                     | 示例                     |
| -------------- | ---------------------------- | ------------------------ |
| `??`           | 变量是否**存在且不为 null**  | `<#if user ??>`          |
| `?has_content` | 变量是否存在、非空且非空集合 | `<#if name?has_content>` |
| `?exists`      | 仅检查变量是否存在（已废弃） | 不推荐使用               |

**解释**：

- `WHERE 1=1` 避免 SQL 语法错误（如果没有其他 `AND` 条件）。
- `if` 语句在 `username` 或 `age` 为空时，SQL 里不会包含相关 `AND` 条件。

**可能生成的 SQL（不同输入情况）**：

```sql
SELECT * FROM users WHERE 1=1;
SELECT * FROM users WHERE 1=1 AND username = 'Tom';
SELECT * FROM users WHERE 1=1 AND username = 'Tom' AND age = 25;
```

------

#### **2.2.2. `<choose>`：类似 Java `switch-case`**

**作用**：多个 `if-else` 判断时，可以用 `<choose>` 来优化，保证只执行一个条件。

```xml
<select id="findUserByStatus" resultType="User">
    SELECT * FROM users
    <where>
        <choose>
            <when test="status == 'active'">
                status = 'ACTIVE'
            </when>
            <when test="status == 'inactive'">
                status = 'INACTIVE'
            </when>
            <otherwise>
                status = 'UNKNOWN'
            </otherwise>
        </choose>
    </where>
</select>
```

**解释**：

- **`<when>`** 作用类似 `if`，当满足某个条件时，执行对应 SQL 片段。
- **`<otherwise>`** 类似 `else`，当所有 `when` 都不满足时执行。

**可能生成的 SQL**：

```sql
sql复制编辑SELECT * FROM users WHERE status = 'ACTIVE';
SELECT * FROM users WHERE status = 'INACTIVE';
SELECT * FROM users WHERE status = 'UNKNOWN';
```

------

#### **2.2.3. `<where>`：智能处理 `AND`、`OR`**

**作用**：自动去除 SQL 语句开头的 `AND` 或 `OR`，避免 SQL 语法错误。

```xml
<select id="findUser" resultType="User">
    SELECT * FROM users
    <where>
        <if test="username != null">
            username = #{username}
        </if>
        <if test="age != null">
            AND age = #{age}
        </if>
    </where>
</select>
```

**解释**：

- **如果 `where` 内部没有内容，则 `WHERE` 关键字不会出现在最终 SQL 中**。
- **自动去除 `AND` 开头**，防止 `WHERE AND age = ?` 这样的错误 SQL。

**可能生成的 SQL**：

```sql
sql复制编辑SELECT * FROM users;
SELECT * FROM users WHERE username = 'Tom';
SELECT * FROM users WHERE username = 'Tom' AND age = 25;
```

------

#### **2.2.4. `<set>`：动态 `UPDATE` 语句**

**作用**：自动去除 `UPDATE` 语句中最后一个 `,`，避免 SQL 语法错误。

```xml
<update id="updateUser">
    UPDATE users
    <set>
        <if test="username != null">
            username = #{username},
        </if>
        <if test="age != null">
            age = #{age},
        </if>
        <if test="email != null">
            email = #{email}
        </if>
    </set>
    WHERE id = #{id}
</update>
```

**解释**：

- **`<set>` 会自动去除 SQL 末尾的逗号 `,`**，防止 `UPDATE users SET username = 'Tom', WHERE id = 1;` 这样的错误 SQL。

**可能生成的 SQL**：

```sql
UPDATE users SET username = 'Tom' WHERE id = 1;
UPDATE users SET username = 'Tom', age = 25 WHERE id = 1;
```

------

#### **2.2.5. `<trim>`：自定义去除字符**

**作用**：

- **`prefix`**：给 SQL 语句添加前缀，如 `WHERE`、`SET`。
- **`suffix`**：给 SQL 语句添加后缀。
- **`prefixOverrides`**：去除前面多余的 `AND` 或 `OR`。
- **`suffixOverrides`**：去除 SQL 末尾的 `,`。

**示例 1：替代 `<where>`**

```xml
<select id="findUser" resultType="User">
    SELECT * FROM users
    <trim prefix="WHERE" prefixOverrides="AND">
        <if test="username != null">
            AND username = #{username}
        </if>
        <if test="age != null">
            AND age = #{age}
        </if>
    </trim>
</select>
```

**作用**：

- **`prefix="WHERE"`**：如果 `trim` 里有内容，会自动添加 `WHERE`。
- **`prefixOverrides="AND"`**：去掉 `WHERE` 后面多余的 `AND`。

**可能生成的 SQL**：

```sql
SELECT * FROM users WHERE username = 'Tom';
SELECT * FROM users WHERE username = 'Tom' AND age = 25;
```

------

**示例 2：替代 `<set>`**

```xml
<update id="updateUser">
    UPDATE users
    <trim  ="SET" suffixOverrides=",">
        <if test="username != null">
            username = #{username},
        </if>
        <if test="age != null">
            age = #{age},
        </if>
        <if test="email != null">
            email = #{email}
        </if>
    </trim>
    WHERE id = #{id}
</update>
```

**作用**：

- **`prefix="SET"`**：如果 `trim` 里有内容，会自动添加 `SET`。
- **`suffixOverrides=','`**：去掉 `SET` 语句最后的 `,`。

**可能生成的 SQL**：

```sql
UPDATE users SET username = 'Tom' WHERE id = 1;
UPDATE users SET username = 'Tom', age = 25 WHERE id = 1;
```

------

#### **2.2.6 总结**

| 标签                                  | 作用                                                        |
| ------------------------------------- | ----------------------------------------------------------- |
| **`<if>`**                            | 根据条件动态拼接 SQL                                        |
| **`<choose>` `<when>` `<otherwise>`** | 类似 `switch-case`，保证只执行一个条件                      |
| **`<where>`**                         | 自动去除无用 `AND`、`OR`，避免 SQL 语法错误                 |
| **`<set>`**                           | 自动去除 `UPDATE` 语句中的逗号 `,`，避免 SQL 语法错误       |
| **`<trim>`**                          | 灵活控制 `prefix`、`suffix`，去除 SQL 头尾的多余 `AND`、`,` |

MyBatis 动态 SQL 使用的是 **OGNL 表达式**（Object-Graph Navigation Language）。

### 2.3OGNL

#### **2.3.1. 什么是 OGNL？**

OGNL (object graph navigation language)（对象图导航语言）是一种 **表达式语言（EL，Expression Language）**，用于在 MyBatis 的 `<if>`、`<choose>` 等动态 SQL 标签中 **解析和计算变量值**。

#### **2.3.2. MyBatis 中常见的 OGNL 表达式**

在 MyBatis XML 配置中的 `test` 属性里，我们通常会写：

```
复制编辑<if test="username != null and username != ''">
    AND username = #{username}
</if>
```

这里的 **`username != null and username != ''`** 就是 **OGNL 表达式**。

------

#### **2.3.3. 常见 OGNL 表达式语法**

| 表达式                               | 作用                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| `username != null`                   | 判断 `username` 是否不为空                                   |
| `age > 18`                           | 判断 `age` 是否大于 18                                       |
| `name eq 'Tom'`                      | 判断 `name` 是否等于 `'Tom'`（`eq` 也可以写成 `==`）         |
| `status != 'active'`                 | 判断 `status` 是否不等于 `'active'`                          |
| `list != null and list.size() > 0`   | 判断 `list` 是否不为空并且有数据                             |
| `array != null and array.length > 0` | 判断数组是否不为空                                           |
| `user != null and user.age > 18`     | 访问对象 `user` 的 `age` 属性                                |
| `"admin".equals(role)`               | 判断 `role` 是否等于 `"admin"`                               |
| `!(flag)`                            | 逻辑取反，相当于 `NOT flag`                                  |
| `id in (1,2,3)`                      | **错误** ❌（MyBatis 不支持 `in` 关键字，需要使用 `foreach`） |

------

#### **2.3.4. 复杂对象的 OGNL 访问**

##### **(1) 访问对象属性**

```xml
<if test="user != null and user.age > 18">
    AND age = #{user.age}
</if>
```

**等价于 Java：**

```java
if (user != null && user.getAge() > 18) {
    sql += " AND age = " + user.getAge();
}
```

##### **(2) 访问 List / 数组**

```xml
<if test="list != null and list.size() > 0">
    <!-- list.size() 用于判断集合是否为空 -->
</if>
```

##### **(3) 访问 Map**

```xml
<if test="params['key'] != null">
    AND column = #{params.key}
</if>
```

等价于：

```java
params.get("key") != null
```

------

#### **2.3.5. OGNL 进阶技巧**

##### **(1) 三元运算**

```
xml复制编辑<if test="username != null ? username : 'defaultUser'">
    AND username = #{username}
</if>
```

> 这个表达式表示：如果 `username` 为空，则默认值为 `"defaultUser"`。

##### **(2) 字符串匹配**

```
xml复制编辑<if test="role.startsWith('admin')">
    AND role = #{role}
</if>
```

> 判断 `role` 是否以 `"admin"` 开头。

##### **(3) 逻辑取反**

```
xml复制编辑<if test="!flag">
    AND active = 0
</if>
```

> `!flag` 表示 **如果 flag 为 false，则添加 `AND active = 0`**。

------

#### **2.3.6. 需要注意的 OGNL 限制**

1. **`in` 关键字不能直接使用**

   ```
   xml复制编辑<if test="ids != null">
       AND id IN (#{ids})
   </if>
   ```

   ❌ **错误**：MyBatis 不支持 `IN (#{ids})`，需要使用 `<foreach>` 遍历：

   ```
   xml复制编辑<if test="ids != null and ids.size() > 0">
       AND id IN
       <foreach collection="ids" item="id" open="(" separator="," close=")">
           #{id}
       </foreach>
   </if>
   ```

2. **无法直接使用 Java 方法**

   ```
   xml复制编辑<if test="Math.max(a, b) > 10">
       AND value = #{a}
   </if>
   ```

   ❌ **错误**：MyBatis **不支持直接调用 `Math.max()` 这种 Java 方法**。

------

#### **2.3.7. 总结**

| **OGNL 表达式**                       | **作用**               |
| ------------------------------------- | ---------------------- |
| `age > 18`                            | 判断 `age` 是否大于 18 |
| `username != null and username != ''` | 判断字符串是否不为空   |
| `list != null and list.size() > 0`    | 判断集合是否有数据     |
| `user != null and user.age > 18`      | 访问对象属性           |
| `"admin".equals(role)`                | 判断字符串相等         |
| `!flag`                               | 取反                   |
| `params['key']`                       | 访问 Map               |

**MyBatis 主要使用 OGNL 来解析 `<if>`、`<choose>` 等动态 SQL 语句，帮助开发者更灵活地生成 SQL。**

###  **2.4 复杂查询**

在 MyBatis 中，复杂查询主要涉及 **多表查询**、**嵌套查询 vs. 关联查询**、**延迟加载 vs. 主动加载**。下面详细讲解这些内容。

------

#### ****2.4.1. 多表查询（多对一 / 一对多 / 多对多）**

##### **(1) 多对一（Many-to-One）**

**场景**：

- 一个 **订单（Order）** 属于一个 **用户（User）**。
- 订单表（`orders`）中有 `user_id` 字段，表示订单属于哪个用户。

###### **① 方式 1：使用联表查询**

```xml
<select id="getOrderWithUser" resultType="Order">
    SELECT o.id, o.order_no, o.user_id, u.id AS 'user.id', u.name AS 'user.name'
    FROM orders o
    LEFT JOIN users u
    ON o.user_id = u.id
    WHERE o.id = #{orderId}
</select>
```

**解释**：

- 通过 **`LEFT JOIN`** 关联 `orders` 和 `users` 表。
- `user.id` 和 `user.name` 直接映射到 `Order` 类中的 `User` 对象。

###### **② 方式 2：使用嵌套查询**

```xml
<select id="getOrderById" resultMap="OrderResultMap">
    SELECT * FROM orders WHERE id = #{id}
</select>

<select id="getUserById" resultType="User">
    SELECT * FROM users WHERE id = #{id}
</select>

<resultMap id="OrderResultMap" type="Order">
    <id property="id" column="id"/>
    <result property="orderNo" column="order_no"/>
    <association property="user" column="user_id" select="getUserById"/>
</resultMap>
```

**解释**：

- **`<association>`** 表示多对一关系，`column="user_id"` 作为 `getUserById` 方法的参数。

- <resultMap> 是 **MyBatis 用于结果映射（Result Mapping）** 的标签，主要用于 **自定义查询结果如何映射到 Java 对象**。

  当 SQL 查询返回的字段名 **与 Java 对象属性不匹配**，或者涉及 **复杂对象（多对一、一对多、多对多）** 时，就需要使用 `<resultMap>` 进行 **手动配置映射关系**。

------

##### **(2) 一对多（One-to-Many）**

**场景**：

- 一个 **用户（User）** 有多个 **订单（Order）**。
- 订单表（`orders`）中有 `user_id` 字段，表示订单属于哪个用户。

###### **① 方式 1：使用联表查询**

```xml
<select id="getUserWithOrders" resultMap="UserResultMap">
    SELECT u.id, u.name, o.id AS 'orders.id', o.order_no AS 'orders.orderNo'
    FROM users u
    LEFT JOIN orders o ON u.id = o.user_id
    WHERE u.id = #{userId}
</select>
```

**解释**：

- `orders.id` 和 `orders.orderNo` 会映射到 `User` 的 `List<Order> orders` 中。

###### **② 方式 2：使用嵌套查询**

```xml
<select id="getUserById" resultMap="UserResultMap">
    SELECT * FROM users WHERE id = #{id}
</select>

<select id="getOrdersByUserId" resultType="Order">
    SELECT * FROM orders WHERE user_id = #{userId}
</select>

<resultMap id="UserResultMap" type="User">
    <id property="id" column="id"/>
    <result property="name" column="name"/>
    <collection property="orders" column="id" select="getOrdersByUserId"/>
</resultMap>
```

**解释**：

- **`<collection>`** 处理 **一对多** 关系。
- `column="id"` 作为 `getOrdersByUserId` 的参数，查询该用户的订单列表。

------

##### **(3) 多对多（Many-to-Many）**

**场景**：

- **学生（Student）** 和 **课程（Course）** 是多对多关系。
- `student_course` 关联表记录学生和课程的关系。

###### **① 方式 1：联表查询**

```xml
<select id="getStudentWithCourses" resultMap="StudentResultMap">
    SELECT s.id, s.name, c.id AS 'courses.id', c.name AS 'courses.name'
    FROM students s
    LEFT JOIN student_course sc ON s.id = sc.student_id
    LEFT JOIN courses c ON sc.course_id = c.id
    WHERE s.id = #{studentId}
</select>
```

**解释**：

- 通过 `LEFT JOIN` 查询学生的所有课程。

###### **② 方式 2：嵌套查询**

```
xml复制编辑<select id="getStudentById" resultMap="StudentResultMap">
    SELECT * FROM students WHERE id = #{id}
</select>

<select id="getCoursesByStudentId" resultType="Course">
    SELECT c.* FROM courses c
    JOIN student_course sc ON c.id = sc.course_id
    WHERE sc.student_id = #{studentId}
</select>

<resultMap id="StudentResultMap" type="Student">
    <id property="id" column="id"/>
    <result property="name" column="name"/>
    <collection property="courses" column="id" select="getCoursesByStudentId"/>
</resultMap>
```

**解释**：

- **`<collection>`** 处理 **多对多** 关系。
- `column="id"` 作为 `getCoursesByStudentId` 的参数。

------

#### **2.4.2. 嵌套查询 vs. 关联查询**

| 方式                   | 优点                             | 缺点                                  |
| ---------------------- | -------------------------------- | ------------------------------------- |
| **关联查询（JOIN）**   | 一次查询获取完整数据，性能较高   | 如果数据量大，可能会产生 **数据冗余** |
| **嵌套查询（子查询）** | 数据更加整洁，每个子查询单独执行 | 需要多次查询数据库，**增加查询次数**  |

------

#### **2.4.3. 延迟加载（Lazy Loading） vs. 主动加载（Eager Loading）**

MyBatis 默认是 **主动加载**，但可以手动配置 **延迟加载**。

##### **(1) 延迟加载（Lazy Loading）**

**特性**：

- 只有 **访问** 关联对象（如 `User.orders`）时，才会去查询数据库。
- **减少查询数据量，提高查询速度**，但可能会有 **N+1 查询问题**。

**配置 MyBatis 开启延迟加载**

```xml
<settings>
    <setting name="lazyLoadingEnabled" value="true"/>
    <setting name="aggressiveLazyLoading" value="false"/>
</settings>
```

**示例**

```xml
<resultMap id="UserResultMap" type="User">
    <id property="id" column="id"/>
    <result property="name" column="name"/>
    <collection property="orders" column="id" select="getOrdersByUserId" lazy="true"/>
</resultMap>
```

**解释**：

- `lazy="true"` 表示 **访问 `orders` 时才执行 `getOrdersByUserId`**。

------

##### **(2) 主动加载（Eager Loading）**

**特性**：

- **查询时立即加载所有数据**，避免 N+1 查询问题。
- 适用于 **数据量小，且需要所有数据的场景**。

**示例**

```xml
<resultMap id="UserResultMap" type="User">
    <id property="id" column="id"/>
    <result property="name" column="name"/>
    <collection property="orders" column="id" select="getOrdersByUserId" fetchType="eager"/>
</resultMap>
```

**解释**：

- `fetchType="eager"` 表示 **查询 `User` 时立刻加载 `orders`**。

------

#### **2.4.4总结**

- **多对一**：`<association>` 处理，查询用户时加载订单的 `user_id`。
- **一对多**：`<collection>` 处理，查询用户时加载 `orders` 列表。
- **多对多**：`<collection>` 处理，先查关联表，再查关联数据。
- 嵌套查询 vs. 关联查询：
  - **关联查询（JOIN）**：减少 SQL 查询次数，适用于大数据量。
  - **嵌套查询（子查询）**：避免数据冗余，但 SQL 查询次数多。
- 延迟加载 vs. 主动加载：
  - **延迟加载**（Lazy）：访问数据时才查询。
  - **主动加载**（Eager）：一次查询所有数据。

------

## **3. 进阶优化**

### **3.1 分页**

#### **1. 使用 RowBounds 进行分页**

`RowBounds` 是 MyBatis 提供的 **内存分页** 方式，它会先查询所有数据，然后在内存中截取指定的页数。

##### **示例**

```java
List<User> getUsers(RowBounds rowBounds);
```

对应的 Mapper XML：

```xml
<select id="getUsers" resultType="User">
    SELECT * FROM users
</select>
```

Java 代码：

```java
int offset = (pageNum - 1) * pageSize;
int limit = pageSize;
RowBounds rowBounds = new RowBounds(offset, limit);

List<User> users = sqlSession.selectList("getUsers", null, rowBounds);
```

##### **缺点**

❌ **效率低**：会查询 **所有数据** 后再进行分页，数据量大时 **严重影响性能**，**不推荐** 在大数据集上使用。

------

#### **2. 使用 PageHelper 进行分页（推荐）**

`PageHelper` 是一个 MyBatis 分页插件，它通过 **修改 SQL 语句，直接在数据库层面进行分页**，比 `RowBounds` 性能更优。

##### **2.1 安装 PageHelper**

Maven 依赖：

```xml
<dependency>
    <groupId>com.github.pagehelper</groupId>
    <artifactId>pagehelper</artifactId>
    <version>5.3.0</version>
</dependency>
```

##### **2.2 使用 PageHelper**

在查询前调用 `PageHelper.startPage(pageNum, pageSize)`：

```java
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

public List<User> getUsers(int pageNum, int pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    List<User> users = userMapper.getUsers();  // 执行查询
    return new PageInfo<>(users).getList();    // 返回分页结果
}
```

Mapper 接口：

```java
List<User> getUsers();
```

Mapper XML：

```xml
<select id="getUsers" resultType="User">
    SELECT * FROM users
</select>
```

##### **2.3 分页结果**

`PageHelper` 返回的是 **PageInfo** 对象，它包含：

- `getList()`：当前页的数据
- `getTotal()`：总记录数
- `getPages()`：总页数
- `getPageNum()`：当前页号

获取分页结果：

```java
PageInfo<User> pageInfo = new PageInfo<>(users);
System.out.println("总记录数：" + pageInfo.getTotal());
System.out.println("总页数：" + pageInfo.getPages());
System.out.println("当前页数据：" + pageInfo.getList());
```

------

#### **3. RowBounds vs. PageHelper**

| 对比项       | RowBounds（不推荐）                  | PageHelper（推荐）              |
| ------------ | ------------------------------------ | ------------------------------- |
| **分页方式** | 内存分页                             | **数据库物理分页**              |
| **性能**     | **查询所有数据后分页**，大数据量时慢 | **直接在 SQL 层分页，性能更优** |
| **适用场景** | 小数据集                             | **大数据集**                    |
| **实现方式** | MyBatis 自带                         | **需引入 PageHelper 插件**      |

------

#### 4.**总结**

✅ **推荐** 使用 **PageHelper** 进行分页，它会在 SQL 语句中 **自动添加 LIMIT**，提高查询性能。
 ❌ **不推荐** 使用 **RowBounds**，因为它会 **查询所有数据**，然后在内存中分页，效率低下。



### **3.2 批量操作**

在 MyBatis 中，批量操作（插入、更新、删除）可以提高数据库操作的效率，减少 SQL 执行次数和网络开销。常见的方式包括：

1. **批量插入**
2. **批量更新**
3. **使用 `foreach` 进行批量操作**

#### **3.2.1  批量插入**

**场景**：需要一次性插入多条数据，而不是一条一条地插入。

##### **3.2.1.1 MyBatis 批量插入（`foreach` 实现）**

```
xml复制编辑<insert id="batchInsertUsers">
    INSERT INTO users (name, email) VALUES
    <foreach collection="users" item="user" separator=",">
        (#{user.name}, #{user.email})
    </foreach>
</insert>
```

**Mapper 接口：**

```
java


复制编辑
void batchInsertUsers(@Param("users") List<User> users);
```

**Java 代码：**

```
java复制编辑List<User> users = new ArrayList<>();
users.add(new User("Tom", "tom@example.com"));
users.add(new User("Jerry", "jerry@example.com"));

userMapper.batchInsertUsers(users);
```

**⚡ 优势**：多个 `VALUES` 一次性插入，减少 SQL 交互次数，提高性能。

------

##### **3.2.1.2 MyBatis Plus 批量插入（推荐）**

如果使用 **MyBatis Plus**，可以直接使用 `saveBatch` 方法：

```
java


复制编辑
userService.saveBatch(users);
```

它会自动生成 **高效的批量 SQL**，底层使用 **批量事务**，比 MyBatis 原生 `foreach` 更高效。

------

#### **3.2.2. 批量更新**

**场景**：一次性更新多条数据，避免循环执行 SQL。

##### **3.2.2.1 MyBatis 批量更新（`foreach` 实现）**

```
xml复制编辑<update id="batchUpdateUsers">
    <foreach collection="users" item="user" open="BEGIN" separator=";" close="END">
        UPDATE users
        SET email = #{user.email}
        WHERE id = #{user.id}
    </foreach>
</update>
```

**Mapper 接口：**

```
复制编辑
void batchUpdateUsers(@Param("users") List<User> users);
```

**Java 代码：**

```
java复制编辑List<User> users = new ArrayList<>();
users.add(new User(1, "Tom", "tom_new@example.com"));
users.add(new User(2, "Jerry", "jerry_new@example.com"));

userMapper.batchUpdateUsers(users);
```

**⚠️ 注意**：`foreach` 方式会拼接多个 **单条 `UPDATE` 语句**，SQL 过多时可能影响性能。

------

#### **3.2.3 MyBatis Plus 批量更新（推荐）**

如果使用 **MyBatis Plus**，可以直接用 `updateBatchById`：

```
java


复制编辑
userService.updateBatchById(users);
```

它会 **自动优化 SQL**，避免 `foreach` 生成的大量 `UPDATE` 语句。

------

#### **3.2.4. 批量删除**

```
xml复制编辑<delete id="batchDeleteUsers">
    DELETE FROM users WHERE id IN
    <foreach collection="userIds" item="id" open="(" separator="," close=")">
        #{id}
    </foreach>
</delete>
```

**Mapper 接口：**

```
java


复制编辑
void batchDeleteUsers(@Param("userIds") List<Integer> userIds);
```

**Java 代码：**

```
java复制编辑List<Integer> userIds = Arrays.asList(1, 2, 3);
userMapper.batchDeleteUsers(userIds);
```

**⚡ 优势**：使用 `IN (...)` 语法，减少 SQL 交互次数，提高性能。

------

#### **3.2.5 MyBatis `ExecutorType.BATCH`（批量提交事务，适用于大批量数据）**

如果需要执行 **成百上千条 SQL 语句**（如批量插入、更新），可以使用 **批量执行模式** `ExecutorType.BATCH`：

```
java复制编辑SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH);
UserMapper userMapper = sqlSession.getMapper(UserMapper.class);

try {
    for (User user : users) {
        userMapper.insertUser(user);
    }
    sqlSession.commit();  // 一次性提交事务
} catch (Exception e) {
    sqlSession.rollback();
} finally {
    sqlSession.close();
}
```

**⚡ 优势**：

- **减少事务提交次数**，提升批量操作性能。
- **适用于大量数据（如 1W+ 条记录）**。

------

#### **3.2.6总结**

| **方式**                       | **适用场景**             | **优点**                             | **缺点**                                       |
| ------------------------------ | ------------------------ | ------------------------------------ | ---------------------------------------------- |
| `foreach` 批量插入             | 插入 100~1000 条数据以内 | 减少 SQL 执行次数                    | **性能一般**                                   |
| `foreach` 批量更新             | 更新 100~1000 条数据以内 | 代码简单，灵活性强                   | **每条数据都执行一次 SQL，SQL 过多时影响性能** |
| `IN` 批量删除                  | 删除 100~1000 条数据以内 | 批量 SQL 语句，减少交互              | **不适合超大数据集**                           |
| `ExecutorType.BATCH` 事务提交  | **大规模数据（1W+ 条）** | **一次性提交事务，提升性能**         | **代码复杂**                                   |
| MyBatis Plus `saveBatch`       | 插入 1000+ 数据          | **自动优化 SQL，性能优**             | 需使用 MyBatis Plus                            |
| MyBatis Plus `updateBatchById` | 批量更新 1000+ 数据      | **自动优化 SQL，减少 `UPDATE` 语句** | 需使用 MyBatis Plus                            |

✅ **最佳实践**

- **小批量数据（100~1000 条）**：`foreach` 批量插入、更新、删除。
- **大批量数据（1W+ 条）**：使用 `ExecutorType.BATCH` **批量事务提交** 或 MyBatis Plus **`saveBatch`** / **`updateBatchById`**。

###  **3.3**MyBatis 缓存机制****

MyBatis 提供了 **一级缓存** 和 **二级缓存**，用于 **减少数据库查询次数，提高查询性能**。

- **一级缓存（SqlSession 级别，默认开启）**：同一个 `SqlSession` 多次查询相同的数据时，第二次查询会直接从缓存中获取，而不会再查询数据库。
- **二级缓存（Mapper 级别，需要手动开启）**：多个 `SqlSession` 共享缓存，提高缓存复用率，但需要额外配置。

------

#### **3.3.1. 一级缓存（SqlSession 级别，默认开启）**

**特点**

- 作用范围：**一个 `SqlSession` 生命周期内**。
- **默认开启**，不需要额外配置。
- **同一个 `SqlSession` 内重复查询相同数据，第二次查询会从缓存读取，而不会去数据库。**
- **`SqlSession.close()` 或 `commit()` 后，一级缓存失效。**

**示例**

##### **3.3.1.1 代码示例**

```
java复制编辑SqlSession sqlSession = sqlSessionFactory.openSession();
UserMapper userMapper = sqlSession.getMapper(UserMapper.class);

// 第一次查询，从数据库获取
User user1 = userMapper.getUserById(1);
System.out.println(user1);

// 第二次查询，相同的 SQL 和参数，会从缓存中获取
User user2 = userMapper.getUserById(1);
System.out.println(user2);

sqlSession.close(); // 关闭后缓存失效
```

##### **3.3.1.2 SQL 执行情况**

- 第一次查询

  （会查询数据库）：

  ```
  sql
  
  
  复制编辑
  SELECT * FROM users WHERE id = 1;
  ```

- **第二次查询**（直接从缓存获取，不查询数据库）

#### 3.3.2 一级缓存失效的情况

| 失效条件                              | 说明                                                         |
| ------------------------------------- | ------------------------------------------------------------ |
| **不同 `SqlSession`**                 | 一级缓存仅限于单个 `SqlSession`，如果 `SqlSession` 关闭，新 `SqlSession` 就不会复用缓存。 |
| **执行 `insert`、`update`、`delete`** | 执行增删改操作后，一级缓存会被清空，保证数据一致性。         |
| **手动清除缓存**                      | 调用 `sqlSession.clearCache()` 手动清除缓存。                |
| **执行 `commit()`**                   | 提交事务后，一级缓存会被清空。                               |

##### 3.3.2.1 手动清除一级缓存**

```java
sqlSession.clearCache(); // 清空缓存
```

------

#### **3.3.3 二级缓存（Mapper 级别，需要手动开启）**

**✅ 特点**

- **作用范围：同一个 Mapper 共享（跨 `SqlSession`）**
- **默认关闭**，需要手动配置。
- **同一个 Mapper 执行相同的 SQL，多个 `SqlSession` 可以复用缓存**。
- **二级缓存存储在 MyBatis 的 `Cache` 结构中，默认使用 `PerpetualCache`，基于 HashMap**。

------

##### **3.3.3.1二级缓存配置步骤**

##### **① 在 `mybatis-config.xml` 开启二级缓存**

```xml
<settings>
    <setting name="cacheEnabled" value="true"/>  <!-- 开启缓存 -->
</settings>
```

##### **② 在 Mapper XML 中开启二级缓存**

在 `UserMapper.xml` 文件中，**添加 `<cache/>` 标签**：

```
xml复制编辑<mapper namespace="com.example.mapper.UserMapper">
    <!-- 开启二级缓存 -->
    <cache/>

    <select id="getUserById" resultType="User">
        SELECT * FROM users WHERE id = #{id}
    </select>
</mapper>
```

**说明**：

- **`<cache/>`** 作用是告诉 MyBatis **当前 Mapper 支持二级缓存**。
- **多个 `SqlSession` 可以共享该缓存**。

------

##### **③ 代码测试**

```java
// 第一次查询（会查询数据库，并写入二级缓存）
SqlSession sqlSession1 = sqlSessionFactory.openSession();
UserMapper userMapper1 = sqlSession1.getMapper(UserMapper.class);
User user1 = userMapper1.getUserById(1);
System.out.println(user1);
sqlSession1.close(); // 关闭 `SqlSession`，数据写入二级缓存

// 第二次查询（会从二级缓存读取，不查询数据库）
SqlSession sqlSession2 = sqlSessionFactory.openSession();
UserMapper userMapper2 = sqlSession2.getMapper(UserMapper.class);
User user2 = userMapper2.getUserById(1);
System.out.println(user2);
sqlSession2.close();
```

**SQL 执行情况**

| 查询次数   | 执行 SQL                            | 说明                       |
| ---------- | ----------------------------------- | -------------------------- |
| 第一次查询 | `SELECT * FROM users WHERE id = 1;` | 查询数据库，并写入二级缓存 |
| 第二次查询 | **不执行 SQL**                      | **从二级缓存读取**         |

##### ④ 二级缓存的失效条件

| 失效条件                                   | 说明                                              |
| ------------------------------------------ | ------------------------------------------------- |
| **执行 `insert`、`update`、`delete` 操作** | 增删改操作会清除该 Mapper 的二级缓存。            |
| **手动清除缓存**                           | 可以调用 `sqlSession.clearCache()` 手动清除缓存。 |
| **Mapper 没有 `<cache/>`**                 | 只有开启 `<cache/>` 的 Mapper 才会使用二级缓存。  |

------

##### **3.3.3.2 一级缓存 vs. 二级缓存**

| 对比项       | 一级缓存（默认开启）             | 二级缓存（需手动开启）                      |
| ------------ | -------------------------------- | ------------------------------------------- |
| **作用范围** | **同一个 `SqlSession`**          | **跨 `SqlSession`，同 Mapper 共享**         |
| **默认状态** | **默认开启**                     | **默认关闭，需要手动开启**                  |
| **缓存位置** | **SqlSession 内存**              | **MyBatis 内部 Cache 结构（默认 HashMap）** |
| **失效条件** | `SqlSession.close()`、增删改操作 | 增删改操作、手动清除缓存                    |
| **适用场景** | **单次查询优化**                 | **多个 `SqlSession` 共享缓存，提高性能**    |

------

#### **3.3.4. MyBatis 二级缓存进阶**

##### 3.3.4.1 配置 LRU（最近最少使用）缓存策略

MyBatis 默认使用 `PerpetualCache`，我们可以指定 **LRU（Least Recently Used）** 策略：

```
xml


复制编辑
<cache eviction="LRU" flushInterval="60000" size="512" readOnly="true"/>
```

| 配置项                  | 作用                                          |
| ----------------------- | --------------------------------------------- |
| `eviction="LRU"`        | 使用 **最近最少使用（LRU）** 作为缓存淘汰策略 |
| `flushInterval="60000"` | **60 秒** 自动清除缓存                        |
| `size="512"`            | **缓存最大存储 512 条数据**                   |
| `readOnly="true"`       | **缓存数据只读（不能修改），提升性能**        |

------

##### **3.3.4.2 配置 Redis 作为 MyBatis 缓存**

**MyBatis 默认缓存基于 HashMap，不支持分布式。**
 如果想要 **分布式缓存**，可以使用 **Redis 作为二级缓存**：

```xml
<cache type="org.mybatis.caches.redis.RedisCache"/>
```

> 需要引入 `mybatis-redis` 依赖。

------

#### **3.3.5总结**

- **一级缓存（默认开启）**：作用于 **SqlSession**，提高单个 `SqlSession` 的查询性能，`SqlSession.close()` 后缓存失效。
- **二级缓存（默认关闭，需要手动开启）**：作用于 **Mapper 级别（跨 `SqlSession`）**，多个 `SqlSession` 共享，提高缓存复用率。
- **二级缓存适用于查询频繁但不常变化的数据**，如 **商品、用户信息**。
- **分布式环境下，建议使用 Redis 作为 MyBatis 的二级缓存**。

### **3.4 MyBatis 事务管理**

事务管理保证了一组 SQL 操作要么全部成功，要么全部失败（回滚），确保数据一致性。MyBatis 事务管理主要有两种方式：

1. **MyBatis 自带事务管理**（手动提交/回滚）
2. **Spring 事务管理**（推荐，使用 `@Transactional` 进行声明式事务管理）

------

#### 3.4.1. MyBatis 自带事务管理（手动提交/回滚）

**✅ 适用场景**：

- 适用于 **单独使用 MyBatis，不依赖 Spring**
- **手动控制事务提交和回滚**
- 事务默认是 **自动提交的**，需要手动关闭自动提交模式

##### **3.4.1.1 事务提交**

在 MyBatis 中，通过 `SqlSession` 进行事务控制：

```
java复制编辑SqlSession sqlSession = sqlSessionFactory.openSession(false); // 关闭自动提交
try {
    UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
    
    // 插入用户
    userMapper.insertUser(new User(1, "Tom"));

    // 提交事务
    sqlSession.commit();
} catch (Exception e) {
    sqlSession.rollback(); // 发生异常回滚
    e.printStackTrace();
} finally {
    sqlSession.close();
}
```

##### **3.4.1.2 事务回滚**

如果中途抛出异常，MyBatis 事务会回滚：

```
java复制编辑try {
    userMapper.updateUser(new User(1, "Jerry")); // 更新用户
    int error = 1 / 0; // 模拟异常
    sqlSession.commit(); 
} catch (Exception e) {
    sqlSession.rollback(); // 事务回滚
}
```

##### **3.4.1.3 自动提交事务**

- **默认 `SqlSession` 是自动提交的**（`openSession(true)`）。
- 如果 `openSession(false)`，就必须手动调用 `commit()` 提交事务。

```
java


复制编辑
SqlSession sqlSession = sqlSessionFactory.openSession(true); // 自动提交
```

------

#### **3.4.2. 与 Spring 整合（使用 `@Transactional`）**

**✅ 适用场景**：

- **推荐**：适用于 **Spring 项目**，避免手写事务控制
- **Spring 统一管理事务**，MyBatis 只执行 SQL
- **支持声明式事务**，简化代码

##### **3.4.2.1 Spring 配置 MyBatis 事务**

在 `spring.xml` 中配置事务管理：

```
xml复制编辑<!-- 配置数据源 -->
<bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource">
    <property name="jdbcUrl" value="jdbc:mysql://localhost:3306/testdb"/>
    <property name="username" value="root"/>
    <property name="password" value="root"/>
</bean>

<!-- 配置 MyBatis SqlSessionFactory -->
<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
    <property name="dataSource" ref="dataSource"/>
</bean>

<!-- 配置事务管理器 -->
<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <property name="dataSource" ref="dataSource"/>
</bean>

<!-- 启用 Spring 声明式事务 -->
<tx:annotation-driven transaction-manager="transactionManager"/>
```

------

##### **3.4.2.2 `@Transactional` 注解事务管理**

在 Service 层使用 `@Transactional`：

```
java复制编辑@Service
public class UserService {
    
    @Autowired
    private UserMapper userMapper;

    @Transactional // 开启事务
    public void addUser() {
        userMapper.insertUser(new User(1, "Alice"));
        int error = 1 / 0; // 模拟异常
        userMapper.insertUser(new User(2, "Bob")); // 这一行不会执行
    }
}
```

**💡 事务规则**

- **如果 `@Transactional` 方法抛出 `RuntimeException` 或 `Error`，事务会回滚**
- **默认事务传播方式为 `REQUIRED`（如果当前没有事务，则创建新事务）**

------

#### **3.4.3. 事务传播机制**

Spring 事务支持 7 种传播机制：

| 传播机制             | 说明                                                 |
| -------------------- | ---------------------------------------------------- |
| **REQUIRED（默认）** | 如果有事务，就加入当前事务；否则创建新事务           |
| **REQUIRES_NEW**     | **每次都新建事务**，原事务挂起                       |
| **SUPPORTS**         | 如果有事务，就加入事务；没有事务，就以非事务方式运行 |
| **NOT_SUPPORTED**    | **强制以非事务方式运行**，如果有事务，则挂起         |
| **MANDATORY**        | **必须在已有事务中运行，否则抛异常**                 |
| **NEVER**            | 不能在事务环境中运行，否则抛异常                     |
| **NESTED**           | **嵌套事务**，子事务可以回滚，主事务不受影响         |

------

#### **3.4.4. 手动回滚事务**

在 `@Transactional` 方法中，**可以手动回滚**：

```
java复制编辑@Transactional
public void addUser() {
    try {
        userMapper.insertUser(new User(1, "David"));
    } catch (Exception e) {
        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); // 手动回滚
    }
}
```

------

#### **3.4.5. `@Transactional` 失效的情况**

| 失效情况                                   | 解决方案                                                     |
| ------------------------------------------ | ------------------------------------------------------------ |
| **`@Transactional` 作用于 `private` 方法** | 只能用于 **`public` 方法**                                   |
| **同类方法内部调用**                       | **需要通过代理调用**，不能直接 `this.method()`               |
| **异常被 `catch` 捕获**                    | 需要 `throw new RuntimeException()` 让 Spring 事务感知       |
| **Spring AOP 代理模式不正确**              | 确保 `@Transactional` 生效（默认使用 `JDK 动态代理`，接口方法生效） |

------

#### **3.4.6总结**

- **MyBatis 自带事务**：适用于 **MyBatis 独立使用**，需要手动 `commit()` 或 `rollback()`。
- **Spring 事务管理（推荐）**：适用于 **Spring 整合 MyBatis**，使用 `@Transactional` 自动管理事务。
- **事务传播机制**：`REQUIRED`（默认），`REQUIRES_NEW`（新事务），`NESTED`（嵌套事务）等。
- **`@Transactional` 失效**：私有方法、内部调用、异常被 `catch` 捕获等情况。

## 

## **4. MyBatis + Spring Boot 集成**

**目标**：

1. **集成 MyBatis + Spring Boot + MySQL**，实现基本 CRUD
2. **使用 Druid 连接池** 进行数据库优化
3. **使用 PageHelper 进行分页查询**

------

### **4.1. Spring Boot 项目依赖**

在 `pom.xml` 中添加 MyBatis 相关依赖：

```xml
<dependencies>
    <!-- Spring Boot Web -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>

    <!-- MyBatis + MySQL -->
    <dependency>
        <groupId>org.mybatis.spring.boot</groupId>
        <artifactId>mybatis-spring-boot-starter</artifactId>
        <version>3.0.3</version>
    </dependency>
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <scope>runtime</scope>
    </dependency>

    <!-- Druid 连接池 -->
    <dependency>
        <groupId>com.alibaba</groupId>
        <artifactId>druid-spring-boot-starter</artifactId>
        <version>1.2.13</version>
    </dependency>

    <!-- Lombok（简化代码） -->
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
        <scope>provided</scope>
    </dependency>

    <!-- PageHelper 分页插件 -->
    <dependency>
        <groupId>com.github.pagehelper</groupId>
        <artifactId>pagehelper-spring-boot-starter</artifactId>
        <version>1.4.6</version>
    </dependency>
</dependencies>
```

------

### **4.2. 配置数据库（`application.yml`）**

```
yaml复制编辑spring:
  datasource:
    url: jdbc:mysql://localhost:3306/testdb?useSSL=false&serverTimezone=UTC
    username: root
    password: root
    driver-class-name: com.mysql.cj.jdbc.Driver
    type: com.alibaba.druid.pool.DruidDataSource
    druid:
      initial-size: 5
      max-active: 20
      min-idle: 5
      max-wait: 60000
      validation-query: SELECT 1 FROM DUAL
      test-on-borrow: false
      test-on-return: false
      test-while-idle: true
      time-between-eviction-runs-millis: 60000
      min-evictable-idle-time-millis: 300000

mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.example.mybatis.entity
```

------

### **4.3. 实体类（`User.java`）**

```
java复制编辑package com.example.mybatis.entity;

import lombok.Data;

@Data
public class User {
    private Integer id;
    private String name;
    private String email;
}
```

------

### **4.4. Mapper（`UserMapper.java`）**

```java
package com.example.mybatis.mapper;

import com.example.mybatis.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserMapper {
    @Insert("INSERT INTO user (name, email) VALUES (#{name}, #{email})")
    int insertUser(User user);

    @Delete("DELETE FROM user WHERE id = #{id}")
    int deleteUser(int id);

    @Update("UPDATE user SET name = #{name}, email = #{email} WHERE id = #{id}")
    int updateUser(User user);

    @Select("SELECT * FROM user WHERE id = #{id}")
    User findUserById(int id);

    @Select("SELECT * FROM user")
    List<User> findAllUsers();
}
```

------

### **4.5. Service 层（`UserService.java`）**

```java
package com.example.mybatis.service;

import com.example.mybatis.entity.User;
import com.example.mybatis.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    @Transactional
    public int addUser(User user) {
        return userMapper.insertUser(user);
    }

    @Transactional
    public int deleteUser(int id) {
        return userMapper.deleteUser(id);
    }

    @Transactional
    public int updateUser(User user) {
        return userMapper.updateUser(user);
    }

    public User findUserById(int id) {
        return userMapper.findUserById(id);
    }

    public List<User> findAllUsers() {
        return userMapper.findAllUsers();
    }
}
```

------

### **4.6. Controller 层（`UserController.java`）**

```
java复制编辑package com.example.mybatis.controller;

import com.example.mybatis.entity.User;
import com.example.mybatis.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping
    public String addUser(@RequestBody User user) {
        userService.addUser(user);
        return "User added successfully!";
    }

    @DeleteMapping("/{id}")
    public String deleteUser(@PathVariable int id) {
        userService.deleteUser(id);
        return "User deleted successfully!";
    }

    @PutMapping
    public String updateUser(@RequestBody User user) {
        userService.updateUser(user);
        return "User updated successfully!";
    }

    @GetMapping("/{id}")
    public User getUserById(@PathVariable int id) {
        return userService.findUserById(id);
    }

    @GetMapping
    public List<User> getAllUsers() {
        return userService.findAllUsers();
    }
}
```

------

### **4.7. 分页查询（`PageHelper`）**

**修改 `UserMapper` 添加分页查询：**

```java
@Select("SELECT * FROM user")
List<User> findAllUsers();
```

**修改 `UserService`：**

```java
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

public PageInfo<User> getUsersByPage(int pageNum, int pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    List<User> users = userMapper.findAllUsers();
    return new PageInfo<>(users);
}
```

**修改 `UserController`：**

```java
@GetMapping("/page")
public PageInfo<User> getUsersByPage(@RequestParam int pageNum, @RequestParam int pageSize) {
    return userService.getUsersByPage(pageNum, pageSize);
}
```

**测试分页接口：**

```bash

GET http://localhost:8080/users/page?pageNum=1&pageSize=5
```

------

### **4.8. 启动 Spring Boot**

```java
package com.example.mybatis;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MyBatisApplication {
    public static void main(String[] args) {
        SpringApplication.run(MyBatisApplication.class, args);
    }
}
```

------

### **4.9. 测试接口**

启动 Spring Boot 之后，可以使用 Postman 或 cURL 测试：

```
bash复制编辑# 添加用户
curl -X POST "http://localhost:8080/users" -H "Content-Type: application/json" -d '{"name":"Alice", "email":"alice@example.com"}'

# 查询所有用户
curl -X GET "http://localhost:8080/users"

# 分页查询
curl -X GET "http://localhost:8080/users/page?pageNum=1&pageSize=5"

# 更新用户
curl -X PUT "http://localhost:8080/users" -H "Content-Type: application/json" -d '{"id":1, "name":"Alice Updated", "email":"alice@example.com"}'

# 删除用户
curl -X DELETE "http://localhost:8080/users/1"
```

------

### **总结**

**Spring Boot + MyBatis** 快速集成
**Druid 连接池优化数据库连接**
**PageHelper 实现分页查询**
**基于 RESTful API 进行 CRUD 操作**

------

## 5. MyBatis 的执行流程

MyBatis 的执行流程可以分为 **5 个主要阶段**：**加载配置、创建 SqlSessionFactory、获取 SqlSession、执行 SQL 语句、释放资源**。

------

### **5.1  MyBatis 执行流程总览**

```txt
1. 读取 MyBatis 配置文件（mybatis-config.xml）
2. 创建 SqlSessionFactory
3. 获取 SqlSession（相当于一个数据库会话）
4. 执行 SQL 语句（增、删、改、查）
5. 释放 SqlSession 资源
```

------

### **5.2. MyBatis 执行流程详解**

#### **5. 2.1 读取 MyBatis 配置**

- MyBatis 需要加载全局配置文件（`mybatis-config.xml`）和 Mapper 文件（`UserMapper.xml`）。
- 配置数据库连接信息、别名、插件等。

```xml
<configuration>
    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC"/>
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.cj.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://localhost:3306/testdb"/>
                <property name="username" value="root"/>
                <property name="password" value="root"/>
            </dataSource>
        </environment>
    </environments>
    <mappers>
        <mapper resource="mapper/UserMapper.xml"/>
    </mappers>
</configuration>
```

------

#### **5.2.2 创建 `SqlSessionFactory`**

- `SqlSessionFactory` 负责创建 `SqlSession`。
- `SqlSessionFactoryBuilder` 读取 MyBatis 配置文件并解析成 Java 对象。

```java
// 1. 读取 MyBatis 配置文件
InputStream inputStream = Resources.getResourceAsStream("mybatis-config.xml");

// 2. 创建 SqlSessionFactory
SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
```

------

#### **5. 2.3 获取 `SqlSession`**

- `SqlSession` 相当于数据库的会话，执行 SQL 需要通过 `SqlSession`。

```java
// 3. 获取 SqlSession
SqlSession sqlSession = sqlSessionFactory.openSession();
```

**注意**：

- `openSession(true)` 表示自动提交事务。
- `openSession(false)` 需要手动 `commit()` 事务。

------

#### 5.2.4 执行 SQL 语句

MyBatis 通过 **Mapper 代理模式** 执行 SQL：

#### **方法 1：使用 SqlSession 直接执行**

```java
User user = sqlSession.selectOne("com.example.mapper.UserMapper.findUserById", 1);
```

#### **方法 2：使用 Mapper 接口**

```
java复制编辑UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
User user = userMapper.findUserById(1);
```

**底层原理：**

- MyBatis **创建 Mapper 的代理对象**，调用 `selectOne()`，然后映射到 SQL 语句执行。

------

#### **5.2.5 释放 `SqlSession`**

使用完成后，需要关闭 `SqlSession`，防止数据库连接泄漏：

```xml
sqlSession.close();
```

------

### **5.3. MyBatis 执行流程图**

```sql

| 1. 读取 mybatis-config.xml  |
+-----------------------------+
                ↓
+-----------------------------+
| 2. 创建 SqlSessionFactory   |
+-----------------------------+
                ↓
+-----------------------------+
| 3. 获取 SqlSession         |
+-----------------------------+
                ↓
+-----------------------------+
| 4. 执行 SQL 语句            |
|   - 增删改查               |
|   - Mapper 代理模式       |
+-----------------------------+
                ↓
+-----------------------------+
| 5. 释放 SqlSession 资源     |
+-----------------------------+
```

------

### **5.4. 事务管理**

#### **MyBatis 默认事务管理**

MyBatis 事务默认是 **手动提交**，如果 `openSession(false)`，需要手动 `commit()`：

```java
SqlSession sqlSession = sqlSessionFactory.openSession(false);
try {
    UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
    userMapper.insertUser(new User("Alice", "alice@example.com"));
    
    sqlSession.commit();  // 手动提交事务
} catch (Exception e) {
    sqlSession.rollback(); // 出错回滚
} finally {
    sqlSession.close();
}
```

#### **Spring + MyBatis 事务管理**

在 `UserService` 中使用 `@Transactional` 让 Spring 处理事务：

```java
@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    @Transactional
    public void addUser(User user) {
        userMapper.insertUser(user);
    }
}
```

**Spring 事务的底层原理**：

- `@Transactional` 由 Spring AOP 代理，拦截方法并管理事务提交或回滚。

------

### 5.5. MyBatis 底层工作机制

#### **5.5.1 MyBatis 如何执行 SQL？**

1. 解析 SQL
   - MyBatis 读取 `UserMapper.xml`，解析 SQL 语句，存入 `MappedStatement`。
2. 动态 SQL 解析
   - 解析 `<if>`、`<where>` 等动态 SQL，拼接最终 SQL 语句。
3. 调用 JDBC 执行 SQL
   - `JdbcExecutor.execute()` 方法执行 SQL，并返回结果。
4. 映射结果
   - MyBatis **通过 `ResultMap` 处理字段映射**，转换成 Java 对象。

------

### 5.6. 重点总结

####  **5.6.1MyBatis 执行流程**：

1. **加载 MyBatis 配置**，解析 `mybatis-config.xml` 和 `Mapper.xml`
2. **创建 SqlSessionFactory**
3. **获取 SqlSession**
4. **执行 SQL 语句**
5. **释放 SqlSession**

#### 5.6.2**事务管理**：

- MyBatis **默认手动提交事务**
- `openSession(false)` 需要 `commit()`
- Spring 集成使用 `@Transactional`

#### 5.6.3 **底层原理**：

- **Mapper 代理模式**
- **动态 SQL 解析**
- **JdbcExecutor 执行 SQL**
- **ResultMap 进行结果映射**

MyBatis 和 Hibernate 都是持久层框架，但它们的设计理念和使用方式有很大不同。

------

## 6 MyBatis 和 Hibernate 区别

MyBatis 和 Hibernate 都是持久层框架，但它们的设计理念和使用方式有很大不同。

### 6.1. MyBatis vs Hibernate 概述

| 特性             | MyBatis                      | Hibernate                                        |
| ---------------- | ---------------------------- | ------------------------------------------------ |
| **类型**         | SQL 映射框架                 | 全功能 ORM 框架                                  |
| **SQL 控制**     | 需要手写 SQL，灵活度高       | 自动生成 SQL，减少手写 SQL                       |
| **对象关系映射** | 轻量级，映射灵活             | 复杂 ORM 映射，自动管理对象                      |
| **缓存机制**     | 一级缓存、二级缓存（可扩展） | 强大的一级、二级缓存                             |
| **事务管理**     | 依赖 Spring 或 JDBC          | 内置事务管理，支持 JTA                           |
| **性能优化**     | SQL 可控，性能可调优         | 适合大数据量，但 SQL 可控性较弱                  |
| **学习成本**     | SQL 熟悉即可，学习成本低     | 需要理解 ORM 映射和 Hibernate 机制，学习曲线较陡 |
| **适用场景**     | 高度自定义 SQL、复杂查询     | 业务逻辑复杂、对象映射需求高                     |

------

### 6.2. MyBatis 和 Hibernate 主要区别

#### **6. 2.1 SQL 处理方式**

- **MyBatis**：手写 SQL，开发者可以完全控制 SQL 语句和优化执行计划。
- **Hibernate**：自动生成 SQL，不需要手写 SQL，但 SQL 可能不够优化。

📌 **示例对比（查询用户）**

**MyBatis：手写 SQL**

```
xml复制编辑<select id="getUserById" resultType="User">
    SELECT * FROM user WHERE id = #{id}
</select>
java


复制编辑
User user = userMapper.getUserById(1);
```

**Hibernate：自动生成 SQL**

```
java


复制编辑
User user = session.get(User.class, 1);
```

Hibernate 通过 **HQL（Hibernate Query Language）** 或 **Criteria API** 进行查询：

```
java复制编辑Query query = session.createQuery("FROM User WHERE id = :id");
query.setParameter("id", 1);
User user = (User) query.uniqueResult();
```

👉 **对比**：

- **MyBatis 需要手写 SQL**，但可以进行深度优化。
- **Hibernate 生成 SQL**，不需要写 SQL，但有时 SQL 可能不够高效。

------

#### **6.2.2 对象关系映射（ORM）**

- **MyBatis** 仅支持 **半 ORM**，需要手动映射 SQL 结果。
- **Hibernate** 是 **全 ORM**，可以直接将对象与数据库表关联。

📌 **Hibernate 示例（自动映射 User 类到数据库）**

```
java复制编辑@Entity
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String email;
}
```

👉 Hibernate **自动映射** User 类，无需手动编写 SQL。

------

#### **6.2.3 事务管理**

- **MyBatis** 依赖 **Spring 事务管理** 或 **JDBC 事务**，默认需要手动提交事务。
- **Hibernate** 自带事务管理，支持 **JTA**、**JDBC 事务**，并与 Spring 无缝集成。

📌 **MyBatis 手动事务**

```
java复制编辑SqlSession sqlSession = sqlSessionFactory.openSession(false);
try {
    userMapper.insertUser(new User("Alice", "alice@example.com"));
    sqlSession.commit();
} catch (Exception e) {
    sqlSession.rollback();
} finally {
    sqlSession.close();
}
```

📌 **Hibernate 自动事务**

```
java复制编辑Session session = sessionFactory.openSession();
Transaction transaction = session.beginTransaction();
try {
    session.save(new User("Alice", "alice@example.com"));
    transaction.commit();
} catch (Exception e) {
    transaction.rollback();
} finally {
    session.close();
}
```

👉 **对比**：

- **MyBatis 事务默认手动提交**，需要 `commit()`。
- **Hibernate 事务自动管理**，事务管理更加便捷。

------

####  6.2.4 缓存机制

| 缓存级别     | MyBatis                     | Hibernate                       |
| ------------ | --------------------------- | ------------------------------- |
| **一级缓存** | 默认开启（SqlSession 级别） | 默认开启（Session 级别）        |
| **二级缓存** | 需手动配置（Mapper 级别）   | 默认开启（SessionFactory 级别） |
| **查询缓存** | 需手动配置                  | 支持 Query Cache                |

📌 **MyBatis 需要手动开启二级缓存**

```
xml


复制编辑
<cache />
```

📌 **Hibernate 默认开启二级缓存**

```
xml复制编辑<hibernate-configuration>
    <session-factory>
        <property name="hibernate.cache.use_second_level_cache">true</property>
    </session-factory>
</hibernate-configuration>
```

👉 **对比**：

- **MyBatis** 需要手动开启二级缓存，而 **Hibernate 默认支持** 二级缓存，适用于数据复用场景。

------

### 6.3. MyBatis vs Hibernate 适用场景

| 需求类型                        | 选择            |
| ------------------------------- | --------------- |
| **手写 SQL，优化查询**          | ✅ **MyBatis**   |
| **简单 CRUD 操作，多表关联**    | ✅ **Hibernate** |
| **数据量大，需要 SQL 可控**     | ✅ **MyBatis**   |
| **对象关系复杂，适合 ORM 映射** | ✅ **Hibernate** |
| **Spring Boot 轻量级整合**      | ✅ **MyBatis**   |

------

### **6.4. 总结**

#### ****6.4.1何时选择 MyBatis？**

- 需要手写 SQL，**对 SQL 有完全控制**。
- 复杂查询、多表关联、存储过程。
- 适用于 **高并发、性能要求高** 的场景。

#### **6.4.2何时选择 Hibernate？**

- **对象关系复杂**，不想手写 SQL，想要自动映射。
- 需要**强大的缓存支持**，减少数据库查询次数。
- 业务逻辑复杂，想要减少 SQL 代码。

------

### **6.5. MyBatis vs Hibernate 代码对比**

| 功能     | **MyBatis**                               | **Hibernate**                 |
| -------- | ----------------------------------------- | ----------------------------- |
| **查询** | `sqlSession.selectOne("getUserById", 1);` | `session.get(User.class, 1);` |
| **插入** | `userMapper.insertUser(user);`            | `session.save(user);`         |
| **更新** | `userMapper.updateUser(user);`            | `session.update(user);`       |
| **删除** | `userMapper.deleteUser(id);`              | `session.delete(user);`       |
| **事务** | `sqlSession.commit();`                    | `transaction.commit();`       |
| **缓存** | 需要手动配置二级缓存                      | **默认支持二级缓存**          |

## 7 封装 MyBatis 通用 Mapper

封装 **MyBatis 通用 Mapper** 可以减少重复的 SQL 代码，提高开发效率，使 CRUD 操作更加简洁。通常有以下几种方式来封装 MyBatis 通用 Mapper：

### **7.1. 直接使用 MyBatis-Plus**（推荐）

**[MyBatis-Plus](https://baomidou.com/)** 是一个增强版的 MyBatis，提供了通用 Mapper，支持 CRUD、分页、代码生成等功能。

#### **7. 1.1 添加依赖**

```
xml复制编辑<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.5.3</version>
</dependency>
```

#### 7.1.2 定义实体类

```
java复制编辑@Data
@TableName("user")
public class User {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String name;
    private Integer age;
}
```

####  7.1.3 继承 `BaseMapper<T>`

```java
@Mapper
public interface UserMapper extends BaseMapper<User> {
}
```

####  7.1.4 直接调用

```java
@Autowired
private UserMapper userMapper;

public void test() {
    // 插入数据
    User user = new User();
    user.setName("Alice");
    user.setAge(25);
    userMapper.insert(user);

    // 查询数据
    User result = userMapper.selectById(user.getId());
}
```

**👉 优势**：

- **无需手写 SQL**，自动提供 `insert`、`delete`、`update`、`select` 方法。
- **支持 Lambda 语法**，避免硬编码字段名。
- **支持分页、动态查询、乐观锁、填充策略等**。

------

### **7. 2. 使用 MyBatis 通用 Mapper（Mapper 插件）**

如果不想使用 MyBatis-Plus，可以使用 **通用 Mapper** 插件 **(Mapper + Example)**。

#### **7.2.1 添加依赖**

```xml
<dependency>
    <groupId>tk.mybatis</groupId>
    <artifactId>mapper-spring-boot-starter</artifactId>
    <version>2.1.5</version>
</dependency>
```

#### 7.2.2 配置 `MapperScannerConfigurer`

```
@Configuration
@MapperScan(basePackages = "com.example.mapper", markerInterface = MyMapper.class)
public class MyBatisConfig {
}
```

#### **7.2.3 定义通用 Mapper**

```
java复制编辑public interface MyMapper<T> extends Mapper<T>, MySqlMapper<T> {
}
```

> ⚠ **注意**：不要在 `MyMapper` 上加 `@Mapper` 注解，否则会报错。

#### **7.2.4 继承 `MyMapper`**

```
java复制编辑public interface UserMapper extends MyMapper<User> {
}
```

#### **7.2.5 直接调用**

```
java复制编辑@Autowired
private UserMapper userMapper;

public void test() {
    // 插入
    User user = new User();
    user.setName("Bob");
    user.setAge(30);
    userMapper.insert(user);

    // 查询
    User result = userMapper.selectByPrimaryKey(user.getId());
}
```

**👉 优势**：

- **通用 CRUD 方法**，无需手写 `insert`, `update`, `delete`, `select`。
- **支持 Example 查询**，可以实现动态 SQL 查询。

------

### **7.3. 手写 BaseMapper 封装**

如果不想使用 **MyBatis-Plus** 或 **通用 Mapper 插件**，可以自己封装一个 `BaseMapper<T>`。

#### **7.3.1 定义 `BaseMapper<T>`**

```
java复制编辑public interface BaseMapper<T> {
    void insert(T entity);
    void deleteById(Serializable id);
    void update(T entity);
    T selectById(Serializable id);
    List<T> selectAll();
}
```

#### **7.3.2 提供 `BaseMapper.xml`**

```
xml复制编辑<insert id="insert" parameterType="T">
    INSERT INTO ${table} (${fields}) VALUES (${values})
</insert>

<delete id="deleteById">
    DELETE FROM ${table} WHERE id = #{id}
</delete>

<select id="selectById" resultType="T">
    SELECT * FROM ${table} WHERE id = #{id}
</select>

<select id="selectAll" resultType="T">
    SELECT * FROM ${table}
</select>
```

#### **7.3.3 继承 `BaseMapper<T>`**

```
java复制编辑@Mapper
public interface UserMapper extends BaseMapper<User> {
}
```

#### **7.3.4 直接调用**

```
java复制编辑@Autowired
private UserMapper userMapper;

public void test() {
    userMapper.insert(new User(1L, "Charlie", 28));
    User user = userMapper.selectById(1L);
}
```

**👉 优势**：

- **完全自定义 SQL 逻辑**，适用于复杂场景。
- **轻量级，不依赖第三方库**。
- **适用于大项目，便于扩展**。

------

###  7.4. 总结

| 方式                | 适用场景             | 优点                         | 缺点         |
| ------------------- | -------------------- | ---------------------------- | ------------ |
| **MyBatis-Plus**    | **推荐，大部分项目** | 自动 CRUD、分页、Lambda 查询 | 需要学习 API |
| **通用 Mapper**     | 传统 MyBatis 项目    | 提供 `Example` 方式查询      | 需要额外配置 |
| **手写 BaseMapper** | 自定义复杂 SQL       | 轻量级，可控性强             | 需要维护 SQL |

**💡 结论**：

- **小项目/标准业务**：选 **MyBatis-Plus**，快速开发，功能丰富。
- **已有 MyBatis 代码**：选 **通用 Mapper**，适配老项目。
- **复杂 SQL / 高度定制**：手写 `BaseMapper<T>`。

------

## **6. 过渡到 MyBatis Plus**

- MyBatis Plus 如何简化开发？
- MyBatis Plus 内置 CRUD 如何实现？
- MyBatis Plus 分页、乐观锁、拦截器使用

------

### **👉 建议的学习顺序**

1. 先掌握 **基本 CRUD**
2. 理解 **动态 SQL 和多表查询**
3. 掌握 **分页、缓存、批量操作**
4. 深入 **事务管理、整合 Spring Boot**
5. 最后再学习 **MyBatis Plus**













