# Kafka动态模板匹配

## 项目结构

kafka-dynamic-consumer/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com.example.kafka/
│   │   │       ├── KafkaApplication.java          # 主应用程序入口
│   │   │       ├── KafkaConsumerService.java      # 消费消息并调用动态逻辑的服务
│   │   │       ├── KafkaDynamicConsumerManager.java # 动态管理消费者
│   │   │       ├── ScriptManager.java             # 动态加载和管理脚本
│   │   │       └── TopicMappingWatcher.java       # 监听脚本文件变更
│   │   └── resources/
│   │       ├── scripts/                           # 外部脚本存放目录
│   │       │   ├── topic1-logic.groovy
│   │       │   └── topic2-logic.groovy
│   │       └── application.yml                    # 配置文件
└── pom.xml                                        # Maven 配置文件

## **1. `KafkaApplication.java`**

Spring Boot 启动类。

```java


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class KafkaApplication {

    @Autowired
    private TopicMappingWatcher topicMappingWatcher;

    public static void main(String[] args) {
        SpringApplication.run(KafkaApplication.class, args);
    }

    // 启动时自动监听脚本文件变更
    @Autowired
    public void startWatcher() {
        topicMappingWatcher.startWatchingScripts();
    }
}
```

------

## **2. `application.yml`**

配置 Kafka 的连接信息和消费者配置。

```yaml

  kafka:
    bootstrap-servers: localhost:9092
    consumer:
      group-id: dynamic-consumers
      auto-offset-reset: earliest
      key-deserializer: org.apache.kafka.common.serialization.StringDeserializer
      value-deserializer: org.apache.kafka.common.serialization.StringDeserializer
```

------

## **3. `KafkaDynamicConsumerManager.java`**

管理 Kafka 消费者的动态添加、移除和运行时更新。

```java

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.listener.ConcurrentMessageListenerContainer;
import org.springframework.kafka.listener.MessageListener;
import org.springframework.stereotype.Service;

import java.util.concurrent.ConcurrentHashMap;

@Service
public class KafkaDynamicConsumerManager {

    private final ConcurrentHashMap<String, ConcurrentMessageListenerContainer<String, String>> containers = new ConcurrentHashMap<>();

    @Autowired
    private KafkaConsumerFactory consumerFactory;

    @Autowired
    private KafkaConsumerService consumerService;

    public void addListener(String topic) {
        if (containers.containsKey(topic)) {
            return; // 已经有消费者在运行
        }

        ConcurrentMessageListenerContainer<String, String> container =
                consumerFactory.createContainer(topic);

        container.setupMessageListener((MessageListener<String, String>) record -> {
            handleRecord(topic, record);
        });

        container.start();
        containers.put(topic, container);
        System.out.println("Started listener for topic: " + topic);
    }

    public void removeListener(String topic) {
        ConcurrentMessageListenerContainer<String, String> container = containers.remove(topic);
        if (container != null) {
            container.stop();
            System.out.println("Stopped listener for topic: " + topic);
        }
    }

    private void handleRecord(String topic, ConsumerRecord<String, String> record) {
        consumerService.handleMessage(topic, record.value());
    }
}
```

------

## **4. `KafkaConsumerService.java`**

处理 Kafka 消息并调用对应脚本逻辑。

```
java复制编辑package com.example.kafka;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KafkaConsumerService {

    @Autowired
    private ScriptManager scriptManager;

    public void handleMessage(String topic, String message) {
        try {
            System.out.println("Received message for topic: " + topic);
            Object result = scriptManager.executeScript(topic, message);
            System.out.println("Processed result: " + result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

------

## **5. `ScriptManager.java`**

动态加载和执行脚本文件。

```java


import groovy.lang.GroovyShell;
import groovy.lang.Script;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class ScriptManager {

    private final ConcurrentHashMap<String, Script> scriptCache = new ConcurrentHashMap<>();
    private final GroovyShell groovyShell = new GroovyShell();
    private final String scriptDirectory = "src/main/resources/scripts";

    public Script loadScript(String topic) throws Exception {
        String scriptPath = scriptDirectory + "/" + topic + "-logic.groovy";
        File scriptFile = new File(scriptPath);
        if (!scriptFile.exists()) {
            throw new RuntimeException("Script file not found: " + scriptPath);
        }
        Script script = groovyShell.parse(scriptFile);
        scriptCache.put(topic, script);
        return script;
    }

    public Script getScript(String topic) throws Exception {
        if (scriptCache.containsKey(topic)) {
            return scriptCache.get(topic);
        }
        return loadScript(topic);
    }

    public Object executeScript(String topic, String message) throws Exception {
        Script script = getScript(topic);
        return script.invokeMethod("processMessage", message);
    }

    public void clearCache(String topic) {
        scriptCache.remove(topic);
    }
}
```

------

## **6. `TopicMappingWatcher.java`**

监听脚本文件变更，动态更新逻辑。

```java


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.nio.file.*;

@Component
public class TopicMappingWatcher {

    @Autowired
    private ScriptManager scriptManager;

    @Autowired
    private KafkaDynamicConsumerManager consumerManager;

    public void startWatchingScripts() {
        Thread thread = new Thread(() -> {
            try {
                Path path = Paths.get("src/main/resources/scripts");
                WatchService watchService = FileSystems.getDefault().newWatchService();
                path.register(watchService, StandardWatchEventKinds.ENTRY_CREATE, StandardWatchEventKinds.ENTRY_MODIFY, StandardWatchEventKinds.ENTRY_DELETE);

                while (true) {
                    WatchKey key = watchService.take();
                    for (WatchEvent<?> event : key.pollEvents()) {
                        String fileName = event.context().toString();
                        if (fileName.endsWith("-logic.groovy")) {
                            String topic = fileName.replace("-logic.groovy", "");
                            if (event.kind() == StandardWatchEventKinds.ENTRY_CREATE || event.kind() == StandardWatchEventKinds.ENTRY_MODIFY) {
                                scriptManager.clearCache(topic);
                                scriptManager.loadScript(topic);
                                consumerManager.addListener(topic);
                                System.out.println("Reloaded script and added listener for topic: " + topic);
                            } else if (event.kind() == StandardWatchEventKinds.ENTRY_DELETE) {
                                consumerManager.removeListener(topic);
                                System.out.println("Removed listener for topic: " + topic);
                            }
                        }
                    }
                    key.reset();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        thread.setDaemon(true);
        thread.start();
    }
}
```

------

## **7. `pom.xml`**

确保项目依赖 Groovy 和 Kafka。

```xml
xml复制编辑<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.kafka</groupId>
        <artifactId>spring-kafka</artifactId>
    </dependency>
    <dependency>
        <groupId>org.codehaus.groovy</groupId>
        <artifactId>groovy</artifactId>
        <version>3.0.17</version>
    </dependency>
</dependencies>
```

------

## **8.运行步骤**

1. **启动 Kafka**：确保 Kafka 服务运行，创建测试的 `topic1` 和 `topic2`。

2. **运行工程**：启动 Spring Boot 服务。

3. 测试脚本

   ：

   - 在 `scripts` 文件夹添加、修改或删除逻辑文件。
   - 向 Kafka Topic 发布测试消息，验证逻辑是否生效。

你的这个工程设计是合理的，并且充分考虑到了**动态性**和**可维护性**，能够很好地满足以下需求：

## **9.优点**

1. **动态扩展能力**
   - 通过脚本文件动态绑定逻辑，无需重启应用即可实现新功能（如新 Topic 的消费者逻辑）。
   - 逻辑更新无需手动改动 Java 代码，直接通过脚本文件完成。
2. **模块化设计**
   - 消费者逻辑与业务逻辑解耦，便于管理和维护。
   - 使用 `ScriptManager` 实现脚本缓存和动态加载，降低重复加载开销。
   - `KafkaDynamicConsumerManager` 将消费者的动态增删独立封装，职责清晰。
3. **低成本维护**
   - 逻辑文件独立于代码，业务人员或开发者无需深入代码即可直接修改逻辑。
   - 当业务需求复杂化时，可以通过调整 Groovy 脚本灵活应对。
4. **动态文件监听**
   - 自动监听逻辑文件的变化（新增、修改或删除），极大地降低了维护成本。
5. **扩展性强**
   - 支持多 Topic、多消费者，并可以轻松扩展到其他动态逻辑（例如，基于文件的其他事件驱动逻辑）。

------

### **不足或改进点**

虽然这个工程已经很合理，但仍有一些可以优化和改进的地方：

1. **脚本文件的安全性**

   - Groovy 脚本的动态加载存在一定安全风险（例如恶意代码注入）。
   - **改进**：对脚本文件的来源进行严格校验，限制动态脚本的执行权限，确保 Groovy 环境只允许加载受信任的脚本。

2. **脚本异常处理**

   - 如果脚本文件中存在语法错误或运行时错误，可能会导致消费者处理失败。
   - **改进**：在 `ScriptManager` 中增加脚本文件语法校验，并在调用脚本时增加异常捕获机制，确保消费者不会因为脚本错误崩溃。

3. **配置文件路径的硬编码**

   - 脚本目录的路径被硬编码到 `src/main/resources/scripts`。

   - 改进

     ：通过配置文件 (

     ```
     application.yml
     ```

     ) 将路径设置为可配置项。

     ```
     yaml复制编辑script:
       directory: /path/to/scripts
     ```

4. **消费者的管理粒度**

   - 当前的消费者管理是基于 Topic 的，但有些场景可能需要更细粒度的分区管理。
   - **改进**：支持基于 Kafka Partition 的更细粒度动态管理。

5. **性能问题**

   - 当 Topic 很多时，每个 Topic 独立一个消费者容器可能会增加系统的开销。
   - **改进**：使用共享线程池来优化 Kafka 消费者的并发处理能力。

6. **监控和运维能力**

   - 缺乏对消费者的监控，比如消费延迟、消费错误等指标。
   - **改进**：使用 Spring Kafka 自带的监控功能，或者集成 Prometheus 和 Grafana 来实现监控。

------

### **合理性分析**

- **应用场景**：这个设计特别适合需要灵活扩展业务逻辑的场景，比如动态数据处理、规则引擎等。Kafka 的动态消费者结合 Groovy 脚本的方式，可以让不同的业务逻辑独立管理，符合实际需求。
- **架构简洁性**：从架构层面上看，模块划分清晰，Kafka 消费者和逻辑的解耦也避免了代码膨胀，符合常见设计模式。
- **生产环境适用性**：虽然功能齐全，但在生产环境中，仍需重点关注脚本安全性、消费者性能优化和监控。

------

### **推荐补充功能**

1. **集成监控**

   - 使用 `Micrometer` 集成 Kafka 消费的监控指标，例如消费速率、失败次数等。

2. **脚本执行的性能优化**

   - 在 `ScriptManager` 中缓存已经加载的脚本，避免每次执行时重新编译。

   - 示例改进

     ：

     ```
     java复制编辑public Script getScript(String topic) throws Exception {
         if (scriptCache.containsKey(topic)) {
             return scriptCache.get(topic);
         }
         synchronized (this) {
             return loadScript(topic);
         }
     }
     ```

3. **消费者容器的自动平衡**

   - 当有多个消费者同时订阅同一个 Topic 时，确保 Kafka 的分区分配能够动态平衡（Spring Kafka 支持 Consumer Rebalance Listener）。

4. **错误隔离机制**

   - 如果某个 Topic 的脚本执行失败，避免影响其他 Topic 的正常消费。
   - 可在脚本执行中添加失败重试或隔离逻辑。

------

### **总结**

这个工程的设计思路清晰，满足了动态逻辑管理和 Kafka 消费者动态扩展的需求，非常适合对灵活性要求较高的场景。只需稍作优化（如监控、脚本安全性和性能增强），即可适配生产环境，成为一个可靠的动态规则驱动的 Kafka 消费系统。





# 优化

针对你的需求，可以采取以下措施来处理 **Topic 脚本执行失败** 的问题，确保其他 Topic 的消费不受影响，同时在失败时实现重试或隔离逻辑。

------

### 1. **为每个 Topic 创建独立的消费实例**

确保每个 Topic 的消费逻辑互不干扰。为每个 Topic 分配一个单独的消费者实例或线程组，避免因某一 Topic 的问题阻塞其他 Topic 的处理。

**示例：**

```
java复制编辑// 独立消费者示例
KafkaConsumer<String, String> consumer1 = createConsumer("topic1");
KafkaConsumer<String, String> consumer2 = createConsumer("topic2");

// 分别启动线程处理
new Thread(() -> consumeMessages(consumer1)).start();
new Thread(() -> consumeMessages(consumer2)).start();
```

------

### 2. **添加失败重试机制**

在脚本执行失败时，增加重试逻辑以应对临时性问题。可以使用重试次数和间隔时间进行控制，避免无限重试导致资源浪费。

**实现方式：**

- **直接代码重试：** 使用循环或递归重试固定次数。

  ```
  private void executeWithRetry(Runnable task, int maxRetries, long retryIntervalMs) {
      int retries = 0;
      while (retries < maxRetries) {
          try {
              task.run();
              return; // 成功则退出
          } catch (Exception e) {
              retries++;
              System.err.println("任务失败，重试次数: " + retries);
              if (retries >= maxRetries) {
                  System.err.println("已达到最大重试次数，任务失败");
                  break;
              }
              try {
                  Thread.sleep(retryIntervalMs); // 等待后重试
              } catch (InterruptedException ignored) {}
          }
      }
  }
  ```

- **集成框架重试：** 使用 Spring Retry 或 Resilience4j 等库提供的自动重试功能。

  **Spring Retry 示例：**

  ```
  java复制编辑@Retryable(value = Exception.class, maxAttempts = 3, backoff = @Backoff(delay = 1000))
  public void executeTask() {
      // 执行业务逻辑
  }
  ```

------

### 3. **隔离失败任务**

可以在消费时将失败的消息发送到一个 "失败队列"（Dead Letter Queue, DLQ），这样主队列的处理不会被阻塞。

**实现步骤：**

1. **配置 Kafka 的 DLQ:** 通过 Kafka Streams 或 Kafka Connect 配置自动发送失败消息到 DLQ。

2. **代码手动处理:** 如果任务失败，将消息重新写入一个特定的失败 Topic。

   ```
   java复制编辑private void handleFailedMessage(String topic, String message, Exception e) {
       System.err.println("处理失败，发送到失败队列：" + topic + "-failed");
       producer.send(new ProducerRecord<>(topic + "-failed", message));
   }
   ```

------

### 4. **分区隔离**

通过分区将任务隔离，确保某些分区出现问题时，不影响其他分区。例如：

- 将某些高风险任务放入单独的分区。
- 增加消费线程池，每个分区一个线程独立消费。

**配置消费：**

```
java复制编辑props.put(ConsumerConfig.MAX_POLL_RECORDS_CONFIG, "10"); // 限制每次批量拉取数量
consumer.assign(Arrays.asList(new TopicPartition("topic", 0))); // 指定分区消费
```

------

### 5. **监控和报警**

- **Kafka Metrics**：监控消费的 Lag 和失败情况。
- **报警系统**：当失败率过高时发送报警。

### 6. **结合实际业务实现灵活隔离**

有些场景可以通过状态存储的方式，比如 Redis 或数据库，记录失败消息和重试次数，针对失败任务单独处理。