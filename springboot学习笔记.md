# SpringBoot2核心技术和响应式编程

## 自动装配原理

### @Bean、@Component、@Controller、@Service、@Repository

@Component, @Service, @Repository, @Controller，它们都是spring提供的模式化注解（stereotype annotation），位于org.springframework.stereotype包下，它们之间的继承关系如下：

![img](D:\技能学习\springboot\img\注解关系.jpg)

Spring在启动过程中会自动加载标记了这些注解的类，并将它们的实例注册到ApplicationContext中。

它们的主要区别在于它们使用在不同的分类中：

| 注解        | 描述                                                         |
| ----------- | ------------------------------------------------------------ |
| @Component  | 是一种通用的模式，可以用在由Spring管理的所有组件上           |
| @Service    | 主要用在业务逻辑层组件上                                     |
| @Repository | 主要用在数据访问层组件上，当捕获到持久化层特定的异常后，会包装成Spring统一的unckeck异常，并向外抛出 |
| @Controller | 主要用在展示层组件上                                         |


@Bean位于org.springframework.context.annotation下，以下是@Bean与@Component的比较：

|      | Key             | @Bean                                         | @Component                                              |
| ---- | --------------- | --------------------------------------------- | ------------------------------------------------------- |
| 1    | 自动侦测        | 需要明确声明为单例bean，Spring不会自动初始化  | 只要类声明了注解@Component， classpath扫描将自动侦测到. |
| 2    | Spring容器      | 甚至是Spring容器外的类也能被创建为bean        | Spring容器外的类不能被创建                              |
| 3    | 类级/方法级注解 | 方法级注解                                    | 类级注解                                                |
| 4    | @Configuration  | 只能与带@Configuration注解的类一起使用        | 不需要与@Configuration一起使用                          |
| 5    | 用例            | 如果想要基于动态条件的特定实现，应该使用@Bean | 无法实现基于动态条件的特定实现                          |

Spring @Component, @Service, @Repository, @Controller Difference
https://javapapers.com/spring/spring-component-service-repository-controller-difference/

@Component vs @Repository and @Service in Spring
https://www.baeldung.com/spring-component-repository-service

Spring Bean Annotations
https://www.baeldung.com/spring-bean-annotations

Difference between @Bean and @Component annotation in Spring
https://www.tutorialspoint.com/difference-between-bean-and-component-annotation-in-spring

------

### @Configuration

Spring Boot推荐使用JAVA配置来完全代替XML 配置，JAVA配置就是通过 @Configuration和 @Bean两个注解实现的

也就是说：@Configuration+@Bean可以达到在Spring中使用XML配置文件的作用

@Configuration可理解为使用Spring框架时的XML文件中的<beans/>

@Bean可理解为使用Spring框架时XML里面的<bean/>标签。

#### 使用目的

@Configuration用于定义配置类，可替换xml配置文件，被注解的类内部包含有一个或多个被@Bean注解的方法

这些方法将会被AnnotationConfigWebApplicationContext或AnnotationConfigApplicationContext类进行扫描，并构建Bean定义，初始化Spring容器。



#### 使用约束

- @Configuration注解作用在类、接口（包含注解）上
- @Configuration用于定义配置类，可替换XML配置文件，相当于XML形式的Spring配置
- @Configuration注解类中可以声明一个或多个 @Bean 注解的方法
- @Configuration注解作用的类不能是 final 类型
- @Configuration不可以是匿名类；
- 嵌套的 @Configuration类必须是 static 的

#### 代码示例

```java
package com.hadoopx.mallx.data.config.redis;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisPassword;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceClientConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.connection.lettuce.LettucePoolingClientConfiguration;
import org.springframework.data.redis.core.StringRedisTemplate;
import java.time.Duration;
@Configuration
public class RedisAutoConfig {
    @Bean
    public LettuceConnectionFactory defaultLettuceConnectionFactory(RedisStandaloneConfiguration defaultRedisConfig, GenericObjectPoolConfig defaultPoolConfig) {
        LettuceClientConfiguration clientConfig =
                LettucePoolingClientConfiguration.builder().commandTimeout(Duration.ofMillis(5000))
                        .poolConfig(defaultPoolConfig).build();
        return new LettuceConnectionFactory(defaultRedisConfig, clientConfig);
    }
    @Bean
    public StringRedisTemplate stringRedisTemplate(LettuceConnectionFactory defaultLettuceConnectionFactory) {
        StringRedisTemplate stringRedisTemplate = new StringRedisTemplate();
        stringRedisTemplate.setConnectionFactory(defaultLettuceConnectionFactory);
        return stringRedisTemplate;
    }
    @Configuration
    public static class DefaultRedisConfig {
        /**
         * 获取配置文件中spring.redis.host的值, 如果没有则使用默认值: 127.0.0.1
         * 使用如下:
         * @Value("${YML-KEY:DEFAULT-VALUE}")
         */
        @Value("${spring.redis.host:127.0.0.1}")
        private String host;
        @Value("${spring.redis.port:6379}")
        private Integer port;
        @Value("${spring.redis.password:}")
        private String password;
        @Value("${spring.redis.database:0}")
        private Integer database;
        @Value("${spring.redis.lettuce.pool.max-active:8}")
        private Integer maxActive;
        @Value("${spring.redis.lettuce.pool.max-idle:8}")
        private Integer maxIdle;
        @Value("${spring.redis.lettuce.pool.max-wait:-1}")
        private Long maxWait;
        @Value("${spring.redis.lettuce.pool.min-idle:0}")
        private Integer minIdle;
        @Bean
        public GenericObjectPoolConfig defaultPoolConfig() {
            GenericObjectPoolConfig config = new GenericObjectPoolConfig();
            config.setMaxTotal(maxActive);
            config.setMaxIdle(maxIdle);
            config.setMinIdle(minIdle);
            config.setMaxWaitMillis(maxWait);
            return config;
        }
        @Bean
        public RedisStandaloneConfiguration defaultRedisConfig() {
            RedisStandaloneConfiguration config = new RedisStandaloneConfiguration();
            config.setHostName(host);
            config.setPassword(RedisPassword.of(password));
            config.setPort(port);
            config.setDatabase(database);
            return config;
        }
    }
}
```

#### 基础运用

@Configuration注解最常见的搭配使用有两个：@Bean和@Scope

- @Bean：等价于Spring中的bean标签用于注册bean对象的，给容器中添加组件，一般以方法名作为组件的id，配置类里面使用@Bean标注在方法上给容器注册组件，默认是单实例的。

```java
@Configuration(proxyBeanMethods = true) //告诉springboot这是一个配置类 == 配置文件
public class Myconfig {
    @Bean//给容器中添加组件，以方法名作为组件的id。
    // 返回类型为组件类型，返回的值，就是组件在容器中的实例
    public User user01(){
        User wangcai = new User("wangcai",23);
        //user组件依赖了pet组件
        wangcai.setPet(pet01());
        return wangcai;
    }
    @Bean
    public Pet pet01(){
        return new Pet("旺财");
    }
}
```

@Scope：用于声明该bean的作用域，作用域有singleton、prototype、request、session

```java
@Configuration
public class MyConfig {
    @Bean("user")
    @Scope(SCOPE_PROTOTYPE)         //多例
    public User getUser(){
        System.out.println("User对象进行创建!");
        return new User("用户", 22, getDog());
    }
    @Bean("dog")
    @Scope(SCOPE_SINGLETON)         //单例
    public Dog getDog(){
        System.out.println("Dog对象进行创建!");
        return new Dog("金毛", 3);
    }
}
```

#### @Configuration注解的属性

- @Configuration注解中有@Component注解的加持，因此它自己本身也是一个bean对象，可以通过Context的进行获取。
- @Configuration中的属性proxyBeanMethods是及其重要的，设置true/false会得到不同的效果。
  - proxyBeanMethods = true的情况下，保持单实例对象
  - proxyBeanMethods = false的情况下，不进行检查IOC容器中是否存在，而是简单的调用方法进行创建对象，无法保持单实例
  - 简单来说，就相当于true只调用一次，而false会调用多次。

------

### @ComponentScan、@Import  @ImportResource注解

#### @Import注解

##### 优缺点/场景

- 优点：使用方便
- 缺点：不能定制化属性值等；需要提供无参构造器

##### 使用

- 在容器组件类上使用@Import注解
- 注册组件名全类名

##### 示例

- 待注册对象

```sql
package com.ultra.config;

public class User {
}


```

- 注册类

```sql
package com.ultra.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@Import({User.class})
public class UserConfig {
}
```

- 测试

```sql
package com.ultra;

import com.ultra.config.User;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

/**
 * @author admin
 */
@SpringBootApplication
public class SpringbootWebApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext applicationContext = SpringApplication.run(SpringbootWebApplication.class, args);
        String[] names = applicationContext.getBeanNamesForType(User.class);
        System.out.println("user:" + names[0]);
    }
}

```

#### @ImportResource注解

##### 优缺点/场景

- 优点：已存在spring bean配置文件，可以一次性注册

##### 使用

- 在容器组件类上使用@ImportResource注解

##### 示例

- 待注册对象

```
package com.ultra.config;

public class User {
}

```

- 注册类

```sql
package com.ultra.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.ImportResource;

@Configuration
@Import({User.class})
@ImportResource("classpath:spring-bean.xml")
public class UserConfig {
}

```

- spring bean配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="userFromXml" class="com.ultra.config.User"/>
</beans>

```

- 测试

```java
package com.ultra;

import com.ultra.config.User;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

/**
 * @author admin
 */
@SpringBootApplication
public class SpringbootWebApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext applicationContext = SpringApplication.run(SpringbootWebApplication.class, args);
        String[] names = applicationContext.getBeanNamesForType(User.class);
        System.out.println("user:" + Arrays.toString(names));
    }
}

```

#### @ComponentScan注解

##### 优缺点/场景

- 优点：非默认扫描包使用了spring注解注册组件，可以一次性注册
- 默认扫描包：SpringBoot启动类同级及其子级是默认扫描包路径

##### 使用

- 在容器组件类上使用@ComponentScan注解

##### 示例

- 待扫描注册对象

```java
package com.other;

import org.springframework.stereotype.Component;

@Component
public class OtherUser {
}


```

- 启动类及测试

```java
package com.ultra;

import com.other.OtherUser;
import com.ultra.config.User;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ComponentScan;

import java.util.Arrays;

/**
 * @author admin
 */
@SpringBootApplication
@ComponentScan(basePackages = {"com.ultra", "com.other"})
public class SpringbootWebApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext applicationContext = SpringApplication.run(SpringbootWebApplication.class, args);

        String[] names = applicationContext.getBeanNamesForType(User.class);
        System.out.println("user:" + Arrays.toString(names));
        String[] names1 = applicationContext.getBeanNamesForType(OtherUser.class);
        System.out.println("user:" + names1[0]);

    }

}

```

