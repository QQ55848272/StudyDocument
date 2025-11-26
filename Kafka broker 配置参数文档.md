# Kafka broker 配置参数文档

| 参数名称                                  | 默认值                | 作用                                                         | 建议                                           |
| ----------------------------------------- | --------------------- | ------------------------------------------------------------ | ---------------------------------------------- |
| `compression.type`                        | `producer`            | 消息的压缩类型，可选 `none`、`gzip`、`snappy`、`lz4`、`zstd` | 生产者端控制，可使用 `gzip` 或 `lz4` 提升吞吐  |
| `leader.replication.throttled.replicas`   | 无                    | 限制 Leader 副本的复制速率，防止过载                         | 默认即可，若有流量控制需求可设置               |
| `message.downconversion.enable`           | `true`                | 允许 Kafka 降级转换消息格式，支持旧客户端                    | 若无旧客户端，可设为 `false` 提高效率          |
| `min.insync.replicas`                     | `1`                   | 生产者 `acks=all` 时，最小副本确认数                         | **高可靠性**：设为 `2` 或 `3`                  |
| `segment.jitter.ms`                       | `0`                   | 随机化日志段滚动时间，防止集群同时创建段                     | 默认即可                                       |
| `cleanup.policy`                          | `delete`              | 日志清理策略，可选 `delete` 或 `compact`                     | 若需要日志压缩，改为 `compact`                 |
| `flush.ms`                                | `9223372036854775807` | 数据刷盘间隔，默认交由 OS 控制                               | 保持默认                                       |
| `follower.replication.throttled.replicas` | 无                    | 限制 Follower 副本复制速率                                   | 默认即可                                       |
| `segment.bytes`                           | `1073741824` (1GB)    | 单个日志段最大大小                                           | 可根据吞吐量调整，如 `512MB` 或 `2GB`          |
| `retention.ms`                            | `604800000` (7 天)    | 消息最大保留时间                                             | 可缩短减少存储占用，如 `3 天`                  |
| `flush.messages`                          | `9223372036854775807` | 多少条消息后强制 flush                                       | 默认交由 OS 控制                               |
| `message.format.version`                  | `3.0-IV1`             | 消息存储格式版本                                             | 若无旧客户端，保持最新版本                     |
| `file.delete.delay.ms`                    | `60000` (60 秒)       | Kafka 删除日志前的等待时间                                   | 默认即可                                       |
| `max.compaction.lag.ms`                   | `9223372036854775807` | 日志压缩策略下，最长未压缩时间                               | 默认即可                                       |
| `max.message.bytes`                       | `1048588` (~1MB)      | 单条消息最大大小                                             | 若消息较大，可适当增加                         |
| `min.compaction.lag.ms`                   | `0`                   | 日志压缩模式下，消息最短保留时间                             | 默认即可                                       |
| `message.timestamp.type`                  | `CreateTime`          | 消息的时间戳类型 (`CreateTime` 或 `LogAppendTime`)           | **数据一致性高** 可用 `LogAppendTime`          |
| `preallocate`                             | `false`               | 预分配日志文件空间，减少磁盘碎片                             | **高吞吐场景** 可设为 `true`                   |
| `min.cleanable.dirty.ratio`               | `0.5`                 | 日志压缩 (`compact`) 模式下的清理比例                        | 默认适中                                       |
| `index.interval.bytes`                    | `4096` (4KB)          | 索引条目间隔，影响查找性能                                   | 默认即可                                       |
| `unclean.leader.election.enable`          | `false`               | 允许未同步 Follower 直接成为 Leader，可能导致数据丢失        | 建议保持 `false`                               |
| `retention.bytes`                         | `-1`                  | Kafka 主题最大存储空间（字节）                               | 受 `retention.ms` 控制，需限制磁盘使用时可设值 |
| `delete.retention.ms`                     | `86400000` (24 小时)  | `compact` 模式下，标记删除的消息保留时间                     | 默认适中                                       |
| `segment.ms`                              | `604800000` (7 天)    | 每个日志段的最长存活时间                                     | 可根据需求调整                                 |
| `message.timestamp.difference.max.ms`     | `9223372036854775807` | 允许的最大消息时间戳偏差                                     | 默认即可                                       |
| `segment.index.bytes`                     | `10485760` (10MB)     | 日志段的索引文件最大大小                                     | 默认即可                                       |